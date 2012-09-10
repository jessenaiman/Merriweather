class MusicStore.Models.Post extends Backbone.Model
  paramRoot: 'post'

  defaults:
    title: null
    content: null

class MusicStore.Collections.PostsCollection extends Backbone.Collection
  model: MusicStore.Models.Post
  url: '/posts'
