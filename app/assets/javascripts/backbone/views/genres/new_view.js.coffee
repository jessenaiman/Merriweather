MusicStore.Views.Genres ||= {}

class MusicStore.Views.Genres.NewView extends Backbone.View
  template: JST["backbone/templates/genres/new"]

  events:
    "submit #new-genre": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (genre) =>
        @model = genre
        window.location.hash = "/#{@model.id}"

      error: (genre, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
