class Merriweather.Routers.AlbumsRouter extends Backbone.Router
  initialize: (options) ->
    @albums = new Merriweather.Collections.AlbumsCollection()
    @albums.reset options.albums

    @genres = new Merriweather.Collections.GenresCollection()
    @genres.reset options.genres

  routes:
    "new"      : "newAlbum"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newAlbum: ->
    @view = new Merriweather.Views.Albums.NewView(collection: @albums)
    $("#albums").html(@view.render().el)

  index: ->
    @view = new Merriweather.Views.Albums.IndexView(albums: @albums)
    $("#albums").html(@view.render().el)
    @view = new Merriweather.Views.Genres.IndexView(genres: @genres)
    $("#genres").html(@view.render().el)

  show: (id) ->
    album = @albums.get(id)

    @view = new Merriweather.Views.Albums.ShowView(model: album)
    $("#albums").html(@view.render().el)

  edit: (id) ->
    album = @albums.get(id)
    @view = new Merriweather.Views.Albums.EditView(model: album)
    $("#albums").html(@view.render().el)
    @genres = new Merriweather.Views.Genres.IndexView(genres: @genres)
    $("#genres").html(@view.render().el)
