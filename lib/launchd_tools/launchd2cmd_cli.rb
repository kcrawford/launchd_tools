require 'launchd_tools/path'
require 'optparse'
module LaunchdTools
  class Launchd2CmdCli
    attr_reader :paths, :args
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
        @args = args
        @paths = Dir.glob(args)
      end
    end

    def run
      errors = 0
      if paths
        if paths.length > 0
          errors = process_each_path
        else
          args.each {|arg| puts "No launchd job found at '#{arg}'" }
          exit 1
        end
      end
      exit 2 if errors > 0
    end

    def process_path(path_string)
      error_count = 0
      begin
        path = Path.new(path_string).validate
        puts "# #{path.expanded}"
        puts path.parse.to_s
      rescue LaunchdTools::Path::UnparsablePlist
        puts "Error: unable to parse launchd job\n"
        error_count = 1
      rescue LaunchdTools::Path::PermissionsError
        require 'etc'
        username = Etc.getpwuid(Process.euid).name
        puts "Error: user #{username} does not have access to read launchd job\n"
        error_count = 1
      end
      return error_count
    end

    def process_each_path
      error_count = 0
      puts
      paths.each do |path_string|
        error_count += process_path(path_string)
      end
      return error_count
    end
  end
end
