class MusicStore.Routers.GenresRouter extends Backbone.Router
  initialize: (options) ->
    @genres = new MusicStore.Collections.GenresCollection()
    @genres.reset options.genres

  routes:
    "new"      : "newGenre"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newGenre: ->
    @view = new MusicStore.Views.Genres.NewView(collection: @genres)
    $("#genres").html(@view.render().el)

  index: ->
    @view = new MusicStore.Views.Genres.IndexView(genres: @genres)
    $("#genres").html(@view.render().el)

  show: (id) ->
    genre = @genres.get(id)

    @view = new MusicStore.Views.Genres.ShowView(model: genre)
    $("#genres").html(@view.render().el)

  edit: (id) ->
    genre = @genres.get(id)

    @view = new MusicStore.Views.Genres.EditView(model: genre)
    $("#genres").html(@view.render().el)
