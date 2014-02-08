require 'rexml/document'
include REXML
module LaunchdTools
  class ProgramArgsParser
    attr_reader :xml_doc, :element
    def initialize(xml_doc)
      @xml_doc = xml_doc
    end

    def parse
      element = REXML::XPath.first(xml_doc, "plist/dict/key[text()='ProgramArguments']/following-sibling::array")
      if element
        args_strings = XPath.match(element, 'string')
        args_strings.map {|e| e.text }
      else
        program_string_element = REXML::XPath.first(xml_doc, "plist/dict/key[text()='Program']/following-sibling::string")
        [program_string_element.text]
      end
    end
  end
end
