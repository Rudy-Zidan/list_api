# frozen_string_literal: true

module Concerns
  module Errors
    def pretty_validation_errors
      {
        errors: errors.each_with_object([]) do |(field, message), errors_array|
          errors_array << {
            field: field,
            message: :invalid,
            detailed_message: message
          }
        end
      }
    end
  end
end
