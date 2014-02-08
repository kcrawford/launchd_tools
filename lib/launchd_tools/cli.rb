require 'launchd_tools/path'
module LaunchdTools
  class Cli
    attr_reader :paths
    def initialize(args)
      @paths = Dir.glob(args)
    end

    def run
      process_each_path
    end

    def process_each_path
      paths.each do |path|
        print Path.new(path).validate.parse.to_s
      end
    end
  end
end
