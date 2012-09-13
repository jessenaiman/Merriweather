module Merriweather
  module ApplicationHelper
  	def active_menu?(path, path_right=request.path)
    	(URI::parse(path).path == path_right) rescue false
  	end 

    def artists_menu
      Artist.all.map{|p|[p.name, artist_path(p)]}.map do |name, path|
        content_tag(:li, link_to(name, path), :class => (active_menu?(path) ? "active_page" : ""))
        end.join('').html_safe
    end
    
    def albums_menu
      Product.all.map{|p|[p.name, product_path(p)]}.map do |name, path|
        content_tag(:li, link_to(name, path))
      end.join('').html_safe
    end
    
    def bands_menu
      Band.all.map{|p|[p.name, band_path(p)]}.map do |name, path|
        content_tag(:li, link_to(name, path))
      end.join('').html_safe
    end
  end
end
