MusicStore.Views.Albums ||= {}

class MusicStore.Views.Albums.ShowView extends Backbone.View
  template: JST["backbone/templates/albums/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
