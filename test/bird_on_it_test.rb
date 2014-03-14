require 'test_helper'

describe BirdOnIt do
  class Decoratable
    include BirdOnIt

    def decoratable_instance_method
      'hello from decoratable'
    end
  end

  class DecoratableDecorator
    include BirdOnIt::Decorator

    def decorator_method
      'hello from decorator'
    end
  end

  let(:decoratable) { Decoratable.new }
  let(:decorated)   { decoratable.decorate }

  describe "when included" do
    it "adds a class method #decorator_class that returns the decorator class" do
      Decoratable.decorator_class.must_equal DecoratableDecorator
    end

    it "adds a method #decorate that returns a decorator" do
      decoratable.decorate.class.must_equal DecoratableDecorator
    end

    it "adds a class method #decorate_collection that decorates a collection" do
      collection = Decoratable.decorate_collection [Decoratable.new, Decoratable.new]
      collection.map(&:class).must_equal [DecoratableDecorator, DecoratableDecorator]
    end
  end

  describe DecoratableDecorator do
    it "responds to its own instance methods" do
      decorated.respond_to?(:decorator_method).must_equal true
      decorated.decorator_method.must_equal 'hello from decorator'
    end

    it "responds to the methods of the decorated object" do
      decorated.respond_to?(:decoratable_instance_method).must_equal true
    end

    it "sends missing methods to its decorated object" do
      decorated.decoratable_instance_method.must_equal 'hello from decoratable'
    end

    it "has an object attribute that is the decorated object" do
      decorated.object.must_equal decoratable
    end
  end
end

