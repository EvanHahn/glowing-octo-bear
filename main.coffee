$body = $(document.body)

canvas = bigOlCanvas()
context = canvas.getContext "2d"
$body.append canvas

black = Spectra "black"
white = Spectra "white"
pool = new Poolboy()
mouse = mouseTracker()

makeDroplet = ->
  pool.create(Droplet, mouse.x, mouse.y)

mouseDown = no
$body.on "mousedown", -> mouseDown = yes
$body.on "mouseup", -> mouseDown = no

new Ticker (dt) ->

  makeDroplet() if mouseDown

  context.clearRect(0, 0, canvas.width, canvas.height)

  pool.each (swimmer) ->
    swimmer.tick(dt)
    swimmer.draw(context)
