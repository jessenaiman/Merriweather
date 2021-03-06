Merriweather.Views.Genres ||= {}

class Merriweather.Views.Genres.IndexView extends Backbone.View
  template: JST["backbone/templates/genres/index"]

  initialize: () ->
    @options.genres.bind('reset', @addAll)

  addAll: () =>
    @options.genres.each(@addOne)

  addOne: (genre) =>
    view = new Merriweather.Views.Genres.GenreView({model : genre})
    @$(".genres tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(genres: @options.genres.toJSON() ))
    @addAll()

    return this
