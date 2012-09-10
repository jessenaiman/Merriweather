MusicStore.Views.Albums ||= {}

class MusicStore.Views.Albums.AlbumView extends Backbone.View
  template: JST["backbone/templates/albums/album"]

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
