Merriweather.Views.Genres ||= {}

class Merriweather.Views.Genres.EditView extends Backbone.View
  template : JST["backbone/templates/genres/edit"]

  events :
    "submit #edit-genre" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (genre) =>
        @model = genre
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
