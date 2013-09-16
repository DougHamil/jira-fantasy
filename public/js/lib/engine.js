// Generated by CoffeeScript 1.6.3
(function() {
  define(['pixi'], function() {
    var animate, engine, renderer, stage;
    stage = new PIXI.Stage(0x66FF99);
    renderer = new PIXI.autoDetectRenderer(400, 300);
    document.body.appendChild(renderer.view);
    engine = {
      stage: stage,
      renderer: renderer,
      updateCallbacks: []
    };
    requestAnimFrame(animate);
    animate = function() {
      var callback, _i, _len, _ref;
      requestAnimFrame(animate);
      _ref = engine.updateCallbacks;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        callback = _ref[_i];
        callback();
      }
      return engine.renderer.render(engine.stage);
    };
    return engine;
  });

}).call(this);