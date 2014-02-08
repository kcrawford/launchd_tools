require 'rexml/document'
include REXML
module LaunchdTools
  class EnvironmentParser
    attr_reader :xml_doc, :element
    def initialize(xml_doc)
      @xml_doc = xml_doc
    end

    def element
      @element ||= REXML::XPath.first(xml_doc, "plist/dict/key[text()='EnvironmentVariables']/following-sibling::dict")
    end

    def extract_env
      env = {}
      REXML::XPath.match(element, 'key').each do |environment_key|
        env[environment_key.text] = environment_key.next_sibling.next_sibling.text
      end
      env
    end

    def parse
      if element
        extract_env
      else
        {}
      end
    end

  end
end
