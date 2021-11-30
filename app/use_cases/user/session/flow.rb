# frozen_string_literal: true

class User
  module Session
    class Flow < Micro::Case
      flow FindRecord
    end
  end
end
