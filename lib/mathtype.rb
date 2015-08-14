require "mathtype/version"
require "bindata"
require "ole/storage"
require "nokogiri"
require_relative "records/mtef.rb"

module Mathtype
  class Converter
    attr_reader :xml
    attr_reader :builder
    def initialize(equation)
      ole = Ole::Storage.open(equation, "rb+")
      eq = ole.file.read("Equation Native")[28..-1]

      data = Mathtype::Equation.read(eq).snapshot

      @builder = Nokogiri::XML::Builder.new do |xml|
        @xml = xml
        xml.root do
          process(object: data)
        end
      end
    end

    def to_xml
      @builder.to_xml
    end

    def process(element: "mtef", object:)
      if object.is_a? Hash
        name = Mathtype::RECORD_NAMES[object[:record_type]]
        if name
          xml.send(name) do
            (object[:payload] || {}).each do |k, v|
              process(element: k, object: v)
            end
          end
        else
          xml.send(element) do
            object.each do |k, v|
              process(element: k, object: v)
            end
          end
        end
      elsif object.is_a? Array
        object.each do |a|
          process(element: element, object: a)
        end
      else
        process_final_element(element, object)
      end
    end

    def process_final_element(element, object)
      if object.is_a? Hash
        xml.send(element, object)
      else
        xml.send(element) { xml.text object }
      end
    end
  end
end
