class Dashing.Fitbit extends Dashing.Widget

  ready: ->
    @firstView().fadeIn()
    @startAnimation()

  onData: (data) ->
    @index = 0
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
