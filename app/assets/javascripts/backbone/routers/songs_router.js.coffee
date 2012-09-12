class Merriweather.Routers.SongsRouter extends Backbone.Router
  initialize: (options) ->
    @songs = new Merriweather.Collections.SongsCollection()
    @songs.reset options.songs

  routes:
    "new"      : "newSong"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newSong: ->
    @view = new Merriweather.Views.Songs.NewView(collection: @songs)
    $("#songs").html(@view.render().el)

  index: ->
    @view = new Merriweather.Views.Songs.IndexView(songs: @songs)
    $("#songs").html(@view.render().el)

  show: (id) ->
    song = @songs.get(id)

    @view = new Merriweather.Views.Songs.ShowView(model: song)
    $("#songs").html(@view.render().el)

  edit: (id) ->
    song = @songs.get(id)

    @view = new Merriweather.Views.Songs.EditView(model: song)
    $("#songs").html(@view.render().el)
