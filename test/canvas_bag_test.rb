require 'test_helper'

describe CanvasBag do
  let(:canvas_bag) { CanvasBag.new }

  it "has a method #color that returns white" do
    canvas_bag.color.must_equal 'white'
  end

  it "does not have a #css_classes method" do
    lambda { canvas_bag.css_classes }.must_raise NoMethodError
  end

  it "has a method #decorate that returns a CanvasBagDecorator" do
    canvas_bag.decorate.class.must_equal CanvasBagDecorator
  end

  it "has a class method #decorator_class that returns its decorator class" do
    CanvasBag.decorator_class.must_equal CanvasBagDecorator
  end

  it "has a class method #decorate_collection that decorates a collection" do
    collection = CanvasBag.decorate_collection [CanvasBag.new, CanvasBag.new]
    collection.map(&:class).must_equal [CanvasBagDecorator, CanvasBagDecorator]
  end
end
