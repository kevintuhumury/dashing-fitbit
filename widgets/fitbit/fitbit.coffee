class Dashing.Fitbit extends Dashing.Widget

  ready: ->
    @visible = true
    @determineView()
    @transformMeters()

  onData: (data) ->
    @currentView(@index).fadeOut() if @index
    clearInterval @interval if @interval

    if data.error
      @error = data.error
    else
      @error = null
      @index = 0

    @determineView() if @visible

  transformMeters: ->
    meter = $(@node).find(".meter")
    meter.attr "data-bgcolor", "#16b5b5"
    meter.attr "data-fgcolor", "#fff"
    meter.attr "data-width", "125"
    meter.attr "data-height", "120"
    meter.attr "data-thickness", ".3"
    meter.attr "data-angleArc", "250"
    meter.attr "data-angleOffset", "-125"
    meter.attr "data-displayInput", "false"
    meter.attr "data-readOnly", "true"
    meter.knob()

  determineView: ->
    if @error
      @dataView().hide()
      @errorView().show()
    else
      @errorView().hide()
      @dataView().show()

      @firstView().fadeIn @animationLength()
      @startAnimation()

  startAnimation: ->
    @interval = setInterval @animateView, 6000

  animateView: =>
    @hideCurrentView() and @showNextView()

  hideCurrentView: ->
    @currentView(@index).fadeOut @animationLength()

  showNextView: ->
    @findNextIndex()
    @currentView(@index).fadeIn @animationLength()

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

  animationLength: ->
    1000
