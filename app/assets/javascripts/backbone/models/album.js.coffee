class Merriweather.Models.Album extends Backbone.Model
  paramRoot: 'album'

  defaults:
    name: null
    image: null
    gemm: null
    content: null
    release_date: null
    band_id: null
    genre_id: null
    heading: null

class Merriweather.Collections.AlbumsCollection extends Backbone.Collection
  model: Merriweather.Models.Album
  url: '/albums'
