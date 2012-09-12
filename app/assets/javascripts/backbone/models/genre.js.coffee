class Merriweather.Models.Genre extends Backbone.Model
  paramRoot: 'genre'

  defaults:
    name: null
    abbr: null

class Merriweather.Collections.GenresCollection extends Backbone.Collection
  model: Merriweather.Models.Genre
  url: '/genres'
