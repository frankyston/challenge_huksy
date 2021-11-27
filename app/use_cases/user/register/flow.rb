# frozen_string_literal: true

class User
  module Register
    class Flow < Micro::Case
      flow NormalizeParams,
           FindRecord,
           CreateRecord
    end
  end
end
