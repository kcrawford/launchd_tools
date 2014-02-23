require 'launchd_tools/launchd_plist'

module LaunchdTools
  class Cmd2LaunchdCli

    attr_reader :args
    def initialize(args)
      if args.empty?
        show_usage
        exit 0
      elsif args.length == 1
        case args.first
        when "--help"
          show_usage
          exit 0
        when "-h"
          show_usage
          exit 0
        when "--version"
          puts LaunchdTools::VERSION
          exit 0
        end
      end
      @args = args
    end

    def show_usage
      puts "Usage: #{$0} command [arg1] [arg2]"
    end

    def run
      plist = LaunchdPlist.new
      plist.add_program_args(args)
      puts plist.to_s
    end
  end
end

