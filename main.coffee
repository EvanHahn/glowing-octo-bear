body = document.body

canvas = bigOlCanvas()
context = canvas.getContext "2d"
body.appendChild canvas

pool = new Poolboy()

mouseDown = no
$(body).on "mousedown", -> mouseDown = yes
$(body).on "mouseup", -> mouseDown = no
$(body).on "mousemove", (event) ->
  if mouseDown
    pool.create(Droplet, event.clientX, event.clientY)

new Ticker (dt) ->

  context.clearRect(0, 0, canvas.width, canvas.height)

  pool.each (swimmer) ->
    swimmer.tick(dt)
    swimmer.draw(context)
