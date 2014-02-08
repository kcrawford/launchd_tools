module LaunchdTools
  class EnvironmentVariables
    attr_reader :variables
    def initialize(variables = {})
      @variables = variables
    end

    def to_a
      env_items = []
      variables.each do |key,value|
        env_items << "#{key}=#{value}"
      end
      env_items
    end
  end
end

