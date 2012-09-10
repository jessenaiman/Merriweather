MusicStore.Views.Genres ||= {}

class MusicStore.Views.Genres.ShowView extends Backbone.View
  template: JST["backbone/templates/genres/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
