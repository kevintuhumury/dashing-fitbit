class Dashing.Fitbit extends Dashing.Widget

  ready: ->
    @visible = true
    @determineView()

  onData: (data) ->
    @currentView(@index).fadeOut() if @index
    clearInterval @interval if @interval

    if data.error
      @error = data.error
    else
      @error = null
      @index = 0

    @determineView() if @visible

  determineView: ->
    if @error
      @dataView().hide()
      @errorView().show()
    else
      @errorView().hide()
      @dataView().show()

      @firstView().fadeIn()
      @startAnimation()

  startAnimation: ->
    @interval = setInterval @animateView, 6000

  animateView: =>
    @hideCurrentView() and @showNextView()

  hideCurrentView: ->
    @currentView(@index).fadeOut()

  showNextView: ->
    @findNextIndex()
    @currentView(@index).fadeIn()

  findNextIndex: ->
    @index = (@index + 1)
    @index = 0 if @index > @lastIndex()

  lastIndex: ->
    @views().length - 1

  firstView: ->
    $(@views()[0])

  currentView: (index) ->
    $(@views()[index])

  views: ->
    $(@node).find(".views li")

  dataView: ->
    $(@node).find("#data")

  errorView: ->
    $(@node).find("#error")
