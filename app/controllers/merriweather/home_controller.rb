class HomeController < ApplicationController
  def index
  	@users = User.all
    @posts = Post.all
    @recentAlbums = Product.order("created_at")
  end
end
