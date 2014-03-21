require 'test_helper'

describe BirdOnIt do
  class ToteBag
    include BirdOnIt

    def color
      'red'
    end
  end

  class ToteBagDecorator
    include BirdOnIt::Decorator

    def color_description
      if object.color
        "This bag is #{color}"
      else
        "Unknown color"
      end
    end
  end

  let(:tote_bag)           { ToteBag.new }
  let(:tote_bag_decorator) { tote_bag.decorate }

  describe "when BirdOnIt is included" do
    it "adds a method #decorate that returns a decorator" do
      tote_bag.decorate.class.must_equal ToteBagDecorator
    end

    it "adds a class method #decorate_collection that decorates a collection" do
      collection = ToteBag.decorate_collection [ToteBag.new, ToteBag.new]
      collection.map(&:class).must_equal [ToteBagDecorator, ToteBagDecorator]
    end

    it "adds a class method #decorator_class that returns the decorator class" do
      ToteBag.decorator_class.must_equal ToteBagDecorator
    end
  end

  describe ToteBagDecorator do
    it "responds to its own instance methods" do
      tote_bag_decorator.respond_to?(:color_description).must_equal true
      tote_bag_decorator.color_description.must_equal 'This bag is red'
    end

    it "sends missing methods to its decorated object" do
      tote_bag_decorator.color.must_equal 'red'
    end

    it "responds to the methods of the decorated object" do
      tote_bag_decorator.respond_to?(:color).must_equal true
    end

    it "has an object attribute that is the decorated object" do
      tote_bag_decorator.object.must_equal tote_bag
    end
  end
end

