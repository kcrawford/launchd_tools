require 'launchd_tools/path_parser'
require 'launchd_tools/path_content'

module LaunchdTools
  class Path

    class PathMissingError < Exception
      def exit_status; 1 ; end
    end

    class UnparsablePlist < Exception
      def exit_status; 2 ; end
    end

    attr_reader :path

    def initialize(path)
      @path = path
    end

    def validate
      raise PathMissingError unless File.exist?(path)
      self
    end

    def content
      PathContent.new(path).to_s
    end

    def parse
      begin
        path_parser.parse
      rescue
        raise UnparsablePlist.new
      end
    end

    def path_parser
      PathParser.new(self)
    end

    def expanded
      File.expand_path(path)
    end

  end
end
