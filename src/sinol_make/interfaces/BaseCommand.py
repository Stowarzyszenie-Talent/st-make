from sinol_make import contest_types, util
from sinol_make.interfaces.Errors import UnknownContestType


class BaseCommand:
    """
    Base class for command
    """

    def __init__(self):
        try:
            self.contest = contest_types.get_contest_type()
        except UnknownContestType as e:
            util.exit_with_error(str(e))

    def get_name(self):
        """
        Get name of command
        """
        pass

    def configure_subparser(self, subparser):
        """
        Configure subparser for command
        """
        pass

    def run(self, args):
        """
        Run command
        """
        pass
