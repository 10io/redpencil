module PasswordlessConfig
  def config
    @@config ||= {}
  end

  def config=(hash)
    @@config = hash
  end
  
  # see http://www.emersonlackey.com/article/rails-3-application-variables
  module_function :config=, :config
  
end