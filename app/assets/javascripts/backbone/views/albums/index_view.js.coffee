MusicStore.Views.Albums ||= {}

class MusicStore.Views.Albums.IndexView extends Backbone.View
  template: JST["backbone/templates/albums/index"]

  initialize: () ->
    @options.albums.bind('reset', @addAll)

  addAll: () =>
    @options.albums.each(@addOne)

  addOne: (album) =>
    view = new MusicStore.Views.Albums.AlbumView({model : album})
    @$(".albums tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(albums: @options.albums.toJSON() ))
    @addAll()

    return this
