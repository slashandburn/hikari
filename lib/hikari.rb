require 'hikari/version'
require 'hikari/parser'

module Hikari
end

if defined?(::Rails::Railtie)
  require 'hikari/railtie'
end
