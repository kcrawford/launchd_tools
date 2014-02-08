module LaunchdTools
  class PathContent
    attr_reader :path
    def initialize(path)
      @path = path
    end

    def to_s
      if binary?
        `plutil -convert xml1 -o /dev/stdout '#{path}'`
      else
        File.read(path)
      end
    end

    def binary?
      f = File.open(path, "r")
      f.read(6) == "bplist"
    ensure
      f.close
    end
  end
end
