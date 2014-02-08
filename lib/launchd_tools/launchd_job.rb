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
      puts (environment_variables + program_arguments).join(" ")
    end
  end
end

