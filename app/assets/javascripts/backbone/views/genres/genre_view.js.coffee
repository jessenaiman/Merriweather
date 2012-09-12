Merriweather.Views.Genres ||= {}

class Merriweather.Views.Genres.GenreView extends Backbone.View
  template: JST["backbone/templates/genres/genre"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
