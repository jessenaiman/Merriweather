class MusicStore.Routers.AlbumsRouter extends Backbone.Router
  initialize: (options) ->
    @albums = new MusicStore.Collections.AlbumsCollection()
    @albums.reset options.albums

    @genres = new MusicStore.Collections.GenresCollection()
    @genres.reset options.genres

  routes:
    "new"      : "newAlbum"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newAlbum: ->
    @view = new MusicStore.Views.Albums.NewView(collection: @albums)
    $("#albums").html(@view.render().el)

  index: ->
    @view = new MusicStore.Views.Albums.IndexView(albums: @albums)
    $("#albums").html(@view.render().el)
    @view = new MusicStore.Views.Genres.IndexView(genres: @genres)
    $("#genres").html(@view.render().el)

  show: (id) ->
    album = @albums.get(id)

    @view = new MusicStore.Views.Albums.ShowView(model: album)
    $("#albums").html(@view.render().el)

  edit: (id) ->
    album = @albums.get(id)
    @view = new MusicStore.Views.Albums.EditView(model: album)
    $("#albums").html(@view.render().el)
    @genres = new MusicStore.Views.Genres.IndexView(genres: @genres)
    $("#genres").html(@view.render().el)
