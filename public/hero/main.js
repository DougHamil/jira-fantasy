(function() {

  require.config({
    shim: {
      pixi: {
        exports: 'PIXI'
      }
    },
    baseUrl: '/js',
    paths: {
      jquery: 'lib/jquery',
      pixi: 'lib/pixi'
    }
  });

  require(['game/hero', 'jquery', 'pixi'], function(Hero, $) {
    return $(document).ready(function() {
      var hero, renderer, stage;
      stage = new PIXI.Stage(0x66FF99);
      renderer = PIXI.autoDetectRenderer(400, 300);
      document.body.appendChild(renderer.view);
      hero = new Hero({
        skincolor: "#CCC",
        shirtcolor: "#0C0"
      });
      hero = stage.addChild();
      requestAnimFrame(animate);
      return animate(function() {
        requestAnimFrame(animate);
        return renderer.render(stage);
      });
    });
  });

}).call(this);
