#!/usr/bin/env python3
"""Model-free checks for packaged references, hook execution and bb cleanup."""
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
START = '<!-- split-orchestrator:start -->'
END = '<!-- split-orchestrator:end -->'


class PackagingChecks(unittest.TestCase):
    def test_local_document_links(self):
        for path in ROOT.rglob('*.md'):
            if any(part in {'.git', 'artifacts', 'node_modules'} for part in path.parts):
                continue
            # Code examples can contain angle-bracket placeholders, not real links.
            body = re.sub(r'```.*?```', '', path.read_text(), flags=re.S)
            for link in re.findall(r'\]\(([^)]+)\)', body):
                if '://' in link or link.startswith('mailto:'):
                    continue
                relative, _, fragment = link.partition('#')
                target = (path.parent / relative).resolve() if relative else path
                with self.subTest(document=str(path.relative_to(ROOT)), link=link):
                    self.assertTrue(target.exists(), f'Missing {target}')
                    if fragment and target.suffix == '.md':
                        headings = re.findall(r'^#+ (.+)$', target.read_text(), re.M)
                        anchors = [re.sub(r'[^\w\- ]', '', h.lower()).replace(' ', '-') for h in headings]
                        self.assertIn(fragment, anchors)

    def test_session_hook_emits_rules_from_installed_path(self):
        with tempfile.TemporaryDirectory() as tmp:
            plugin = Path(tmp) / "plugin path with spaces $literal's"
            shutil.copytree(ROOT / 'plugin', plugin)
            settings = json.loads((plugin / 'hooks/hooks.json').read_text())
            expected = (plugin / 'rules/coordinator.md').read_text()
            for event in ['startup', 'resume', 'clear', 'compact']:
                matched = [entry for entry in settings['hooks']['SessionStart']
                           if re.fullmatch(entry['matcher'], event)]
                self.assertTrue(matched, event)
                for entry in matched:
                    for hook in entry['hooks']:
                        # Claude's documented exec-form placeholder substitution.
                        argv = [hook['command'], *hook['args']]
                        argv = [arg.replace('${CLAUDE_PLUGIN_ROOT}', str(plugin)) for arg in argv]
                        result = subprocess.run(argv, input=json.dumps({'source': event}),
                                                text=True, capture_output=True, check=True,
                                                cwd=tmp, timeout=hook['timeout'])
                        self.assertEqual(result.stdout, expected)


class LegacyCleanupChecks(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.path = Path(self.tmp.name)
        self.state = self.path / 'instructions.txt'
        self.log = self.path / 'commands.txt'
        fake = self.path / 'bb'
        fake.write_text('''#!/usr/bin/env python3
import os, sys
from pathlib import Path
state = Path(os.environ['BB_FAKE_STATE'])
with Path(os.environ['BB_FAKE_LOG']).open('a') as log:
    log.write(' '.join(sys.argv[1:3]) + '\\n')
assert sys.argv[1] == 'instructions'
if sys.argv[2] == 'get':
    print(state.read_text(), end='')
elif sys.argv[2] == 'set':
    state.write_text(sys.argv[3])
elif sys.argv[2] == 'clear':
    state.write_text('')
else:
    raise SystemExit(2)
''')
        fake.chmod(0o755)
        self.env = {**os.environ, 'PATH': str(self.path) + os.pathsep + os.environ['PATH'],
                    'BB_FAKE_STATE': str(self.state), 'BB_FAKE_LOG': str(self.log)}

    def invoke(self, *args):
        return subprocess.run(['bash', str(ROOT / 'hosts/bb/install.sh'), *args],
                              env=self.env, text=True, capture_output=True, timeout=10)

    def test_dry_run_preserves_host(self):
        original = f'Before\n{START}\nold rules\n{END}\nAfter\n'
        self.state.write_text(original)
        result = self.invoke()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stdout, 'Before\nAfter\n')
        self.assertEqual(self.state.read_text(), original)
        self.assertEqual(self.log.read_text(), 'instructions get\n')

    def test_apply_preserves_unrelated_instructions_and_is_idempotent(self):
        self.state.write_text(f'Before $literal\n{START}\nold rules\n{END}\nAfter `literal`\n')
        result = self.invoke('--apply')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.state.read_text(), 'Before $literal\nAfter `literal`')
        self.log.write_text('')
        self.assertEqual(self.invoke('--apply').returncode, 0)
        self.assertEqual(self.log.read_text(), 'instructions get\n')

    def test_only_legacy_block_clears_instructions(self):
        self.state.write_text(f'{START}\nold rules\n{END}\n')
        self.assertEqual(self.invoke('--apply').returncode, 0)
        self.assertEqual(self.state.read_text(), '')
        self.assertIn('instructions clear', self.log.read_text())

    def test_missing_block_does_not_write(self):
        self.state.write_text('Unrelated instructions\n')
        self.assertEqual(self.invoke('--apply').returncode, 0)
        self.assertEqual(self.state.read_text(), 'Unrelated instructions\n')
        self.assertEqual(self.log.read_text(), 'instructions get\n')

    def test_malformed_markers_fail_without_writing(self):
        for original in [f'Before\n{START}\nAfter', f'{END}\nAfter',
                         f'{START}\n{START}\n{END}\nAfter']:
            with self.subTest(original=original):
                self.state.write_text(original)
                self.log.write_text('')
                self.assertNotEqual(self.invoke('--apply').returncode, 0)
                self.assertEqual(self.state.read_text(), original)
                self.assertEqual(self.log.read_text(), 'instructions get\n')

    def test_invalid_option_fails_before_reading_host(self):
        result = self.invoke('--install')
        self.assertEqual(result.returncode, 2)
        self.assertFalse(self.log.exists())


if __name__ == '__main__':
    unittest.main(verbosity=2)
