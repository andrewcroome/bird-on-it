# Bird On It: Simple decorators for your Rails models

Model need decorating in your Rails view? Put a bird on it!

## What is Bird On It?

_Bird On It_ is a simple way to decorate models in your Rails application.

Decorators allow you to move view- and presentation-related logic out of your active record models and view helpers and into decorator classes. Doing this cleans up your view code and reduces the number of responsibilities your active record objects have.

Here's how it works. Let's say you have a ToteBag model, with colour, size and straps attributes. In your view, you want to describe whether or not the bag has straps. You also want to add some css classes, depending on what properties the bag has. You put the first of these methods on the model, and the second in a helper, like so:

```ruby
# app/models/tote_bag.rb
class ToteBag < ActiveRecord::Base
  def straps_description
    if straps?
      'This bag has straps'
    else
      'This bag does not have straps'
    end
  end
end
```

```ruby
# app/helpers/tote_bags_helper.rb
module ToteBagHelper
  def tote_bag_css_classes(tote_bag)
    tote_bag_css_classes = %w{tote-bag}
    tote_bag_css_classes << 'straps' if tote_bag.straps?
    tote_bag_css_classes.join(' ')
  end
end
```

In your view, you would use both the helper and model:

```erb
<div class="<%= tote_bag_css_classes(@tote_bag) %>">
  <h2>Straps:</h2>
  <p><%= @tote_bag.straps_description %></p>
</div>
```

Instead of the above, however, using a tote bag decorator allows both these methods to exist in the one place. The decorator sends any method that it doesn't itself respond to the decorated object. Using _Bird On It_:

```ruby
# app/models/tote_bag.rb
class ToteBag < ActiveRecord::Base
  include BirdOnIt
end
```

```ruby
# app/decorators/tote_bag_decorator.rb
class ToteBagDecorator
  include BirdOnIt::Decorator

  def straps_description
    if object.straps?
      'This bag has straps'
    else
      'This bag does not have straps'
    end
  end

  def css_classes
    css_classes = %w{tote-bag}
    css_classes << 'straps' if object.straps?
    css_classes.join(' ')
  end
end
```

In your view:

```erb
<div class="<%= @tote_bag.css_classes %>">
  <h2>Straps:</h2>
  <p><%= @tote_bag.straps_description %></p>
</div>
```

Now your view-related code can reside in the decorator, eliminating the need for helper methods and giving your tote bag class one less responsibility.

## Installation

Add _Bird On It_ to your Gemfile

```ruby
  gem 'bird_on_it'
```

Run `bundle install`.

## Usage

### Model

To decorate a model, first include _Bird On It_:

```ruby
# app/models/post.rb
class Post < ActiveRecord::Base
  include BirdOnIt
end
```

Then create a decorator either in `app/views/decorators` or `app/models` with the name matching your model and include `BirdOnIt::Decorator`.

```ruby
# app/decorators/post_decorator.rb
class PostDecorator < ActiveRecord::Base
  include BirdOnIt::Decorator

  def display_title
    object.title.humanize
  end
end
```

In the decorator, your decorated object is available via the `object` variable. If you prefer, you can also access it simply by calling methods to which your decorator does not respond:

```ruby
def display_title
  title.humanize
end
```

### Controller

_Bird On It_ adds a `decorate` method you can call on your objects in your controller before they are passed to the view.

```ruby
# app/controllers/posts_controller.rb
def show
  @post = Post.find(params[:id]).decorate
end
```
There is also a `decorate_collection` class method for decorating collections.

```ruby
# app/controllers/posts_controller.rb
def index
  @posts = Post.decorate_collection(Post.all)
end
```

### View

Use your decorated objects in the view as usual.

```erb
<div class="post">
  <h1><%= @post.display_title %></h2>
  <p><%= @post.body %></p>
</div>
```

Some Rails helpers, such as the edit_path helper, do not work well with decorated objects. If you encounter one of these, you can work around this by passing the helper the decorated object, instead of the decorator. For example:

```ruby
<%= link_to 'Edit', edit_post_path(@post.object) %>
```

Other features, such as linking to the show page, or using the object with `form_for`, should continue to work as usual.

```ruby
<%= link_to 'Show', @post %>
```

```ruby
<%= form_for(@post) do |f| %>
  <%= f.text_field :material %>
  <%= f.submit %>
<% end %>
```

This project uses MIT-LICENSE.
