require 'test_helper'

describe CanvasBagDecorator do
  let(:canvas_bag)           { CanvasBag.new }
  let(:canvas_bag_decorator) { CanvasBagDecorator.new(canvas_bag) }

  it "has a method #css_classes that returns 'bird'" do
    canvas_bag_decorator.css_classes.must_equal 'bird'
  end

  it "responds to the methods of the decorated object" do
    canvas_bag_decorator.respond_to?(:color).must_equal true
  end

  it "sends missing methods to its decorated object" do
    canvas_bag_decorator.color.must_equal 'white'
  end

  it "has an object attribute that is the decorated object" do
    canvas_bag_decorator.object.must_equal canvas_bag
  end
end
