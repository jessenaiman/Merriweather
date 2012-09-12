class Merriweather.Routers.GenresRouter extends Backbone.Router
  initialize: (options) ->
    @genres = new Merriweather.Collections.GenresCollection()
    @genres.reset options.genres

  routes:
    "new"      : "newGenre"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newGenre: ->
    @view = new Merriweather.Views.Genres.NewView(collection: @genres)
    $("#genres").html(@view.render().el)

  index: ->
    @view = new Merriweather.Views.Genres.IndexView(genres: @genres)
    $("#genres").html(@view.render().el)

  show: (id) ->
    genre = @genres.get(id)

    @view = new Merriweather.Views.Genres.ShowView(model: genre)
    $("#genres").html(@view.render().el)

  edit: (id) ->
    genre = @genres.get(id)

    @view = new Merriweather.Views.Genres.EditView(model: genre)
    $("#genres").html(@view.render().el)
