define ['pixi'], () ->
  stage = new PIXI.Stage 0x66FF99
  renderer = new PIXI.autoDetectRenderer 400, 300
  document.body.appendChild renderer.view

  engine =
    stage:stage
    renderer:renderer
    updateCallbacks:[]

  requestAnimFrame animate

  animate = ->
    requestAnimFrame animate
    for callback in engine.updateCallbacks
      callback()
    engine.renderer.render engine.stage

  return engine
