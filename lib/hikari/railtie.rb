require 'hikari'

module Hikari
  class Railtie < Rails::Railtie
    initializer "hikari.configure" do |app|
      if defined? ::ActiveRecord
        ActiveSupport.on_load :active_record do
          require 'hikari/active_record'
          include Hikari::ActiveRecord
        end
      end

      ActiveSupport.on_load :action_view do
        require 'hikari/view_helpers/action_view'
        include Hikari::ViewHelpers::ActionView
      end
    end
  end
end
