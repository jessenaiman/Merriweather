module ProductsHelper
	def comma_seperated_links_for(list)

    raise TypeError, "parameter must be an array" unless list.is_a? Array 
    return if list.count == 0

    list.collect do |item| 
      #raise TypeError, "items must respond to 'name'" unless last_item.respond_to? :name
      link_to(item.name, url_for(item)) 
     end.join(", ").html_safe
  end

  # returns the formatted change in price (from the master price) for the specified variant (or simply return
  # the variant price if no master price was supplied)
  def variant_price_diff(variant)
    diff = variant.price - variant.product.price
    return nil if diff == 0
    if diff > 0
      "(#{t(:add)}: #{Merriweather::Money.new(diff.abs)})"
    else
      "(#{t(:subtract)}: #{Merriweather::Money.new(diff.abs)})"
    end
  end

  # converts line breaks in product description into <p> tags (for html display purposes)
  def product_description(product)
    raw(product.description.gsub(/(.*?)\r?\n\r?\n/m, '<p>\1</p>'))
  end

  def line_item_description(variant)
    description = variant.product.description
    if description.present?
      truncate(strip_tags(description.gsub('&nbsp;', ' ')), :length => 100)
    else
      t(:product_has_no_description)
    end
  end

  def get_taxonomies
    @taxonomies ||= Merriweather::Taxonomy.includes(:root => :children)
  end
end
