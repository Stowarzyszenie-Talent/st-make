from sinol_make import contest_types, util
from sinol_make.interfaces.Errors import UnknownContestType


class BaseCommand:
    """
    Base class for command
    """

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
