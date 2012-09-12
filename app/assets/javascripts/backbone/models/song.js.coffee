class Merriweather.Models.Song extends Backbone.Model
  paramRoot: 'song'

  defaults:
    name: null
    mp3: null
    ogg: null

class Merriweather.Collections.SongsCollection extends Backbone.Collection
  model: Merriweather.Models.Song
  url: '/songs'
