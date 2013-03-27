#application wide exceptions
module Exceptions
  class CodeGenerationError < StandardError; end  
  class CodeAlreadyActivated < StandardError; end
  class CodeExpired < StandardError; end
end