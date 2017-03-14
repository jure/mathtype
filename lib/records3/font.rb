require_relative "snapshot"

module Mathtype3
  class RecordFont < BinData::Record
    include Snapshot
    EXPOSED_IN_SNAPSHOT = %i(tag_options name typeface style)

    endian :little

    mandatory_parameter :options

    virtual :_options, :value => lambda{ options }

    int8 :_typeface

    int8 :style

    stringz :name
    def typeface
      _typeface + 128
    end

    def tag_options
      _options
    end
  end
end
