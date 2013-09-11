require.config
  shim:
    pixi:
      exports: 'PIXI'
  baseUrl: '/js'
  paths:
    jquery: 'lib/jquery'
    pixi: 'lib/pixi'

require ['game/hero', 'jquery', 'pixi'], (Hero, $) ->
  $(document).ready ->
    stage = new PIXI.Stage(0x66FF99)
    renderer = PIXI.autoDetectRenderer(400, 300)
    document.body.appendChild(renderer.view)

    hero = new Hero
      skincolor: "#CCC"
      shirtcolor: "#0C0"

    hero = stage.addChild()

    requestAnimFrame( animate )
    animate ->
      requestAnimFrame(animate)
      renderer.render(stage)
