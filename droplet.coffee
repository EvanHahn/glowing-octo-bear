MAX_RADIUS = 15
MAX_AGE = 5000
SPEED = 100
DECEL = 3
TWOPI = 2 * Math.PI

class Droplet

  constructor: (@x, @y) ->
    console.log "new droplet. #{@x}, #{@y}"
    @direction = Math.random() * TWOPI
    @speed = SPEED
    @age = 0
    @color = Spectra.random()

  tick: (dt) ->

    @age += dt
    if @age >= MAX_AGE
      @pool.leave()
      return

    @speed = Math.max(@speed - DECEL, 0)
    @x += Math.cos(@direction) * (@speed * (dt / 1000))
    @y += Math.sin(@direction) * (@speed * (dt / 1000))

  draw: (ctx) ->

    return if @age >= MAX_AGE # this is a hack sorry

    scale = (MAX_AGE - @age) / MAX_AGE
    radius = MAX_RADIUS * scale

    if scale > 0.5
      ctx.shadowBlur = radius * radius
      ctx.shadowOffsetX = 0
      ctx.shadowOffsetY = 0
      ctx.shadowColor = @color.hex()
    else
      ctx.shadowBlur = 0
    ctx.fillStyle = @color.hex()

    ctx.beginPath()
    ctx.arc(@x, @y, radius, 0, TWOPI)
    ctx.fill()

@Droplet = Droplet
