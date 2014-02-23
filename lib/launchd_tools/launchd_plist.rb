require 'rexml/document'
include REXML
module LaunchdTools
  class LaunchdPlist
    attr_reader :doc, :program_args_array_element

    def initialize
      base = %q[<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">]
      @doc = Document.new(base)
      plist_element = Element.new('plist')
      doc.add_element(plist_element, {"version" => "1.0"})
      base_dictionary = Element.new('dict')
      plist_element.add_element(base_dictionary)
      program_args_key_element = Element.new('key')
      program_args_key_element.text = 'ProgramArguments'
      base_dictionary.add_element(program_args_key_element)
      @program_args_array_element = Element.new "array"
      base_dictionary.add_element(program_args_array_element)
    end


    def add_program_arg(arg)
      string_element = Element.new "string"
      string_element.text = arg
      program_args_array_element << string_element
    end

    def add_program_args(args)
      args.each do |arg|
        add_program_arg(arg)
      end
    end

    def to_s
      formatter = REXML::Formatters::Pretty.new # (2)
      formatter.compact = true
      xml_string = String.new
      formatter.write(doc, xml_string)
      xml_string
    end
  end
end

