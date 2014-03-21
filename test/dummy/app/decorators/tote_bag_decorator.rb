class ToteBagDecorator
  include BirdOnIt::Decorator

  def css_classes
    css_classes = %w{tote-bag}

    css_classes << 'straps' if object.straps?

    css_classes.join(' ')
  end

  def colour_description
    object.colour.present? ? object.colour : 'Has no colour'
  end

  def material_description
    object.material.present? ? object.material : 'Unknown material'
  end

  def straps_description
    object.straps? ? 'Has straps' : 'Strapless'
  end
end
