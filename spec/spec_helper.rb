$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'bundler/setup'
Bundler.require

require 'hikari'
require 'hikari/active_record'
require 'hikari/view_helpers/action_view'
require 'rspec'

require 'schema'

ActiveRecord::Base.send(:include, Hikari::ActiveRecord)
