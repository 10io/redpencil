#application wide exceptions
module Exceptions
  class TokenGenerationError < StandardError; end  
  class TokenAlreadyConsumed < StandardError; end
  class TokenExpired < StandardError; end
end