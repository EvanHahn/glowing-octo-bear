MAX_RADIUS = 10
MAX_AGE = 5000
TWOPI = 2 * Math.PI

class Droplet

  constructor: (@x, @y) ->
    @age = 0

  tick: (dt) ->
    @age += dt
    @pool.leave() if @age >= MAX_AGE

  draw: (ctx) ->
    return if @age >= MAX_AGE # this is a hack sorry
    scale = (MAX_AGE - @age) / MAX_AGE
    ctx.fillStyle = 'red'
    ctx.beginPath()
    ctx.arc(@x, @y, MAX_RADIUS * scale, 0, TWOPI)
    ctx.fill()

@Droplet = Droplet
