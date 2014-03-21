require 'bird_on_it/decorator'

module BirdOnIt
  extend ActiveSupport::Concern

  included do
    def decorate
      self.class.decorator_class.new(self)
    end
  end

  module ClassMethods
    def decorate_collection(collection)
      Array(collection).map { |item| decorator_class.new(item) }
    end

    def decorator_class
      Object.const_get "#{name}Decorator"
    end
  end
end
