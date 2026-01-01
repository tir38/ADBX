# frozen_string_literal: true

require "minitest/autorun"
require "tmpdir"
require "fileutils"
require "pathname"

require_relative "../find_config"

# tests for find_config's getPackage() function
class GetPackageTest < Minitest::Test
  #
  # Helper: write an adbx.config file with given contents
  #
  def write_config(dir, content)
    Pathname.new(dir).join(CONFIG_FILENAME).write(content)
  end

  #
  # CLI-provided package should always take precedence over config
  #
  def test_get_package_prefers_cli_value
    Dir.mktmpdir do |tmp|
      write_config(tmp, "package = from-config\n")

      Dir.chdir(tmp) do
        assert_equal "from-cli", get_package("from-cli")
      end
    end
  end

  #
  # Package can be read from adbx.config in the current working directory
  #
  def test_find_package_in_config_in_cwd
    Dir.mktmpdir do |tmp|
      write_config(tmp, "package=hello\n")

      Dir.chdir(tmp) do
        assert_equal "hello", find_package_in_config
      end
    end
  end

  #
  # Config discovery walks upward from the current directory
  #
  def test_find_package_in_config_in_parent_directory
    Dir.mktmpdir do |tmp|
      parent = Pathname.new(tmp)

      # Create a nested directory structure under the repo root:
      # tmp/a/b/c
      child = parent.join("a", "b", "c")
      child.mkpath

      # Write adbx.config at the repo root (not in the working directory)
      write_config(parent, "package = parent-pkg\n")

      Dir.chdir(child) do
        assert_equal "parent-pkg", find_package_in_config
      end
    end
  end

  #
  # Missing config file should result in an empty string (non-failing behavior)
  #
  def test_find_package_in_config_returns_empty_string_when_no_config_found
    Dir.mktmpdir do |tmp|
      # Create a directory with no adbx.config anywhere above it
      nested = Pathname.new(tmp).join("nested")
      nested.mkpath

      Dir.chdir(nested) do
        assert_equal "", find_package_in_config
      end
    end
  end

  #
  # Config file without a "package" entry should return an empty string
  #
  def test_find_package_in_config_returns_empty_string_when_package_missing
    Dir.mktmpdir do |tmp|
      write_config(tmp, "something_else = value\n")

      Dir.chdir(tmp) do
        assert_equal "", find_package_in_config
      end
    end
  end

  #
  # Config parsing ignores comments, blank lines, and trims whitespace
  #
  def test_parse_config_ignores_comments_blank_lines_and_trims
    Dir.mktmpdir do |tmp|
      path = Pathname.new(tmp).join(CONFIG_FILENAME)
      path.write(<<~CFG)
        # comment
        package =   spaced


        other = x
      CFG

      parsed = parse_config(path)
      assert_equal "spaced", parsed["package"]
      assert_equal "x", parsed["other"]
    end
  end

  #
  # Malformed config lines are ignored instead of raising errors
  #
  def test_parse_config_skips_malformed_lines
    Dir.mktmpdir do |tmp|
      path = Pathname.new(tmp).join(CONFIG_FILENAME)
      path.write(<<~CFG)
        package=ok
        this is not valid
        also_not_valid:
        = missing_key
      CFG

      parsed = parse_config(path)
      assert_equal "ok", parsed["package"]
      refute parsed.key?("")
    end
  end

  #
  # get_package falls back to config when CLI value is nil or empty
  #
  def test_get_package_falls_back_to_config_when_cli_missing
    Dir.mktmpdir do |tmp|
      write_config(tmp, "package=config-pkg\n")

      Dir.chdir(tmp) do
        assert_equal "config-pkg", get_package(nil)
        assert_equal "config-pkg", get_package("")
      end
    end
  end

  #
  # If neither CLI nor config provide a package, an empty string is returned
  #
  def test_get_package_returns_empty_when_cli_and_config_missing
    Dir.mktmpdir do |tmp|
      Dir.chdir(tmp) do
        assert_equal "", get_package(nil)
        assert_equal "", get_package("")
      end
    end
  end
end
