require.config
  shim:
    easel:
      exports: 'createjs'
  baseUrl: '/js'
  paths:
    jquery: 'lib/jquery'
    easel: 'lib/easel'


require ['jquery', 'easel'], ($, easel) ->
  $(document).ready ->
    stage = new createjs.Stage('editCanvas')
    stage.addChild(new createjs.Shape()).setTransform(100,100).graphics.f("red").dc(0,0,50)
    stage.update()

