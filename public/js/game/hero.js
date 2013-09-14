(function() {

  define(['pixi'], function() {
    var Hero;
    return Hero = (function() {

      function Hero(stage, data) {
        this.initGraphics(data);
      }

      Hero.prototype.initGraphics = function(data) {
        var bodyshape;
        this.head = new createjs.Shape();
        this.body = new createjs.Container();
        bodyshape = new createjs.Shape();
        this.lefthand = new createjs.Shape();
        this.righthand = new createjs.Shape();
        this.head.graphics.beginFill(data.skincolor).drawCircle(0, 0, 16);
        bodyshape.graphics.beginFill(data.shirtcolor).drawRoundRect(0, 0, 30, 50, 10);
        this.lefthand.graphics.beginFill(data.skincolor).drawCircle(0, 0, 10);
        this.righthand.graphics.beginFill(data.skincolor).drawCircle(0, 0, 10);
        bodyshape.regX = 15;
        bodyshape.regy = 25;
        this.head.y = -8;
        this.body.addChild(bodyshape);
        this.body.addChild(this.head, this.lefthand, this.righthand);
        this.addChild(this.body);
        this.body.x = 100;
        return this.body.y = 100;
      };

      return Hero;

    })();
  });

}).call(this);
