import yaml
import glob
import pytest
import tarfile
import tempfile

from sinol_make import configure_parsers
from tests import util
from tests.fixtures import create_package
from .util import *


def _test_archive(package_path, out, tar):
    task_id = package_util.get_task_id()
    assert os.path.exists(tar)
    assert f'{tar}' in out

    with tempfile.TemporaryDirectory() as tmpdir:
        with tarfile.open(tar, "r") as tar:
            tar.extractall(tmpdir)

        extracted = os.path.join(tmpdir, task_id)
        assert os.path.exists(extracted)
        assert_configs_equal(package_path, extracted)
        assert_progs_equal(package_path, extracted)

        with open(os.path.join(package_path, "config.yml"), "r") as config_file:
            config = yaml.load(config_file, Loader=yaml.FullLoader)
        with open(os.path.join(extracted, "makefile.in"), "r") as makefile:
            lines = makefile.readlines()
            assert_makefile_in(lines, task_id, config)

        if os.path.basename(package_path) == os.path.basename(util.get_handwritten_package_path()):
            for ext in ["in", "out"]:
                tests = [os.path.basename(f) for f in glob.glob(os.path.join(extracted, ext, f'*.{ext}'))]
                assert set(tests) == {f'hwr0.{ext}', f'hwr0a.{ext}'}
        else:
            assert glob.glob(os.path.join(extracted, "in", "*")) == []
            assert glob.glob(os.path.join(extracted, "out", "*")) == []


@pytest.mark.parametrize("create_package", [util.get_simple_package_path(), util.get_library_package_path(),
                                            util.get_library_string_args_package_path(),
                                            util.get_shell_ingen_pack_path(), util.get_handwritten_package_path()],
                         indirect=True)
def test_simple(create_package, capsys):
    """
    Test exporting to archive.
    """
    package_path = create_package
    parser = configure_parsers()
    args = parser.parse_args(["export"])
    command = Command()
    command.run(args)

    task_id = package_util.get_task_id()
    out = capsys.readouterr().out
    _test_archive(package_path, out, f'{task_id}.tgz')