require 'action_view'
require 'hikari'

module Hikari
  module ViewHelpers
    module ActionView
      class HikariViewHelper
        attr_reader :params

        def initialize(field, params = {})
          sort = params[:sort]
          @params = params
          @field_parse = ::Hikari::Parser.new(field)
          if sort
            @sort_param_parser = ::Hikari::Parser.new(sort)

            if @field_parse.field == @sort_param_parser.field
              @params[:sort] = @sort_param_parser.swap_order!.to_s
            else
              @params[:sort] = @field_parse.to_s
            end
          else
            @params[:sort] = @field_parse.to_s
          end
        end

        def css(current_field)
          if current_field.is_a?(Hash) || current_field.is_a?(Array)
            current_field = current_field.flatten.first
          end
          if @sort_param_parser.try(:field) == current_field.to_s
            "sorted-#{@field_parse.order.downcase}"
          else
            "sortable"
          end
        end
      end

      # Public: Create a sorted link
      #
      # args - link_to style arguments accepted
      #
      # Examples
      #
      #   link_to_sorted "Title", :title
      #   # => <a href="/posts?sort=title_asc" class="sortable">Title</a>
      #
      #   link_to_sorted :title do
      #     <strong>Title</strong>
      #   end
      #   # => <a href="/posts?sort=title_asc" class="sortable"><strong>Title</strong></a>
      #
      #   link_to_sorted "Created At", {created_at: :desc}
      #   # => <a href="/posts?sort=created_at_desc" class="sortable">Created At</a>
      #
      def link_to_sorted(*args, &block)
        if block_given?
          field        = args[0]
          options      = args[1] || {}
          html_options = args[2] || {}
        else
          block        = proc { args[0].to_s }
          field        = args[1]
          options      = args[2] || {}
          html_options = args[3] || {}
        end

        sorter          = HikariViewHelper.new(field, ((request.try(:get?) && !params.nil?) ? params.dup : {}))
        options[:class] = [options[:class], sorter.css(field)].join(' ').strip
        link_to(url_for(sorter.params), options, html_options, &block)
      end
    end
  end
end
