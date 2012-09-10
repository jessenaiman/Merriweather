class MusicStore.Models.Genre extends Backbone.Model
  paramRoot: 'genre'

  defaults:
    name: null
    abbr: null

class MusicStore.Collections.GenresCollection extends Backbone.Collection
  model: MusicStore.Models.Genre
  url: '/genres'
