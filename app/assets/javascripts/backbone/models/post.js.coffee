class Merriweather.Models.Post extends Backbone.Model
  paramRoot: 'post'

  defaults:
    title: null
    content: null

class Merriweather.Collections.PostsCollection extends Backbone.Collection
  model: Merriweather.Models.Post
  url: '/posts'
