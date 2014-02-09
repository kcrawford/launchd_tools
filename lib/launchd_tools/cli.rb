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
      puts
      paths.each do |path_string|
        path = Path.new(path_string).validate
        puts "# #{path.expanded}"
        puts path.parse.to_s
      end
    end
  end
end
