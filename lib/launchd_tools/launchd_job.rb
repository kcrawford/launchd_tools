module LaunchdTools
  class LaunchdJob
    attr_reader :attributes
    def initialize(attributes = {})
      @attributes = attributes
    end

    def environment_variables
      attributes.fetch('EnvironmentVariables', {})
    end

    def program_arguments
      attributes.fetch('ProgramArguments', [])
    end

    def to_s
      escaped_args = program_arguments.map {|arg| shellescape(arg) }
      puts (environment_variables + escaped_args).join(" ")
    end

    # from ruby's shellescape
    def shellescape(str)
      str = str.to_s

      # An empty argument will be skipped, so return empty quotes.
      return "''" if str.empty?

      str = str.dup

      # Treat multibyte characters as is.  It is caller's responsibility
      # to encode the string in the right encoding for the shell
      # environment.
      str.gsub!(/([^A-Za-z0-9_\-.,:\/@\n])/, "\\\\\\1")

      # A LF cannot be escaped with a backslash because a backslash + LF
      # combo is regarded as line continuation and simply ignored.
      str.gsub!(/\n/, "'\n'")

      return str
    end

  end
end

