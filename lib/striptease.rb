module Striptease
  def self.extended(base)
    base.class_eval do
      class << self
        attr_accessor :strippable_attributes
      end

      include InstanceMethods
    end
  end

  def strip_whitespace(*attributes)
    self.strippable_attributes = attributes
    before_validation :_strip_whitespace
  end

  module InstanceMethods
    private

    def _strip_whitespace
      Array(self.class.strippable_attributes).each do |attribute|
        public_send "#{attribute}=", public_send(attribute).try(:strip)
      end
    end
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Striptease
end
