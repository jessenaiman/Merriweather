class MusicStore.Models.Song extends Backbone.Model
  paramRoot: 'song'

  defaults:
    name: null
    mp3: null
    ogg: null

class MusicStore.Collections.SongsCollection extends Backbone.Collection
  model: MusicStore.Models.Song
  url: '/songs'
