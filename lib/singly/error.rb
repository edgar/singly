module Singly
  # Custom error class for rescuing from all Singly errors
  class Error < StandardError; end

  # Raised when Sinlgy returns the HTTP status code 404
  class NotFound < Error; end
end