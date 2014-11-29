module Hikari
  class Parser
    attr_reader :field, :order
    ASC = 'ASC'.freeze
    DESC = 'DESC'.freeze

    # Regex for safety
    PARAMS_REGEX  = /([a-zA-Z0-9._]+)_(asc|desc)$/

    def initialize(sort_param, default = nil)
      if sort_param.is_a?(Hash) || sort_param.is_a?(Array)
        self.field = sort_param.flatten.first.to_s
        self.order = sort_param.flatten.last
      else
        sort_param ||= ''
        match = sort_param.match(PARAMS_REGEX)
        if match
          self.field = match[1]
          self.order = match[2]
        elsif default.present?
          default = default.split(' ')
          self.order = default.pop
          self.field = default.join('')
        else
          self.field = sort_param
          self.order = ASC
        end
      end
    end

    def field=(f)
      @field = f.to_s.downcase
    end

    def order=(o)
      if :desc == o.downcase.to_sym
        @order = DESC
      else
        @order = ASC
      end
    end

    def asc?
      ASC == @order
    end

    def desc?
      DESC == @order
    end

    def swap_order!
      asc? ? @order = DESC : @order = ASC
      self
    end

    def to_s
      "#{@field}_#{@order}".downcase
    end
  end
end
