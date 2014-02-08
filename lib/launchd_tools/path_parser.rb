require 'rexml/document'
require 'launchd_tools/launchd_job'
require 'launchd_tools/environment_parser'
require 'launchd_tools/environment_variables'
require 'launchd_tools/program_args_parser'

include REXML
module LaunchdTools
  class PathParser
    attr_reader :path, :xml_doc
    def initialize(path)
      @path = path
    end

    # returns a parsed launchd job
    def parse
      LaunchdJob.new({ 'EnvironmentVariables' => parse_env, 'ProgramArguments' => parse_program_args })
    end

    def parse_env
      variables = EnvironmentParser.new(xml_doc).parse
      EnvironmentVariables.new(variables).to_a
    end

    def parse_program_args
      ProgramArgsParser.new(xml_doc).parse
    end

    def xml_doc
      @xml_doc ||= Document.new(path.content)
    end

  end
end
