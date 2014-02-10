require 'launchd_tools/path'
require 'optparse'
module LaunchdTools
  class Cli
    attr_reader :paths
    def initialize(args)
      showing_help = false
      opt_parser = OptionParser.new do |opt|
        opt.banner = "Usage: #{$0} path/to/launchd.plist"
        opt.separator ""
        opt.separator "Options"
        opt.on("--help", "-h", "Displays this help message") do
          showing_help = true
        end
        opt.on("--version", "outputs version information for this tool") do 
          puts LaunchdTools::VERSION
        end
        opt.separator ""
      end

      opt_parser.parse!(args)

      if args.empty? || showing_help
        puts opt_parser
      else
        @paths = Dir.glob(args)
      end
    end

    def run
      process_each_path if paths
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
