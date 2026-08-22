import os
import sys
from ranger.core.loader import CommandLoader
from ranger.api.commands import Command


class RangerChoose(Command):
    """use ranger as file chooser"""

    def execute(self):
        """ Extract copied files to current directory """
        filename = self.arg(1)
        cwd = self.fm.thisdir
        if filename == '.':
            with open('/tmp/ranger-chosen', 'w') as chosen_file:
                chosen_file.write(cwd.path + '/')
            sys.exit(0)

        with open('/tmp/ranger-chosen', 'w') as chosen_file:
            chosen_file.write(os.path.join(cwd.path, filename))
        sys.exit(0)
