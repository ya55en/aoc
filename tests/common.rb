#: Common constants for the Day 1 problems tests

require 'pathname'
require 'stringio'

SRC_DIR = Pathname.new(File.expand_path(File.dirname(__FILE__)) + '/../src/').cleanpath

module TestHelpers

  #: Replace STDOUT, temporarily, with a `StringIO`, then restore it. Return
  #: the captured output as a string.
  def TestHelpers.with_captured_stdout
    stdout_orig = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = stdout_orig
  end
end
