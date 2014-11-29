require 'hikari'
require 'active_support/concern'


module Hikari
  module ActiveRecord
    extend ActiveSupport::Concern

    included do
      def self.sort(sort_param, default_order = nil)
        parser = ::Hikari::Parser.new(sort_param, default_order)
        if self.column_names.include?(parser.field)
          if parser.asc?
            order( parser.field )
          else
            order( parser.field ).reverse_order
          end
        elsif self.respond_to?(parser.field)
          if parser.asc?
            self.send(parser.field)
          else
            self.send(parser.field).reverse_order
          end
        else
          # do nothing, log error
          all
        end
      end

    end
  end
end
