class MusicStore.Models.Album extends Backbone.Model
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

class MusicStore.Collections.AlbumsCollection extends Backbone.Collection
  model: MusicStore.Models.Album
  url: '/albums'
