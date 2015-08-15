package
{
    import flash.display.Sprite;
    import flash.display.StageScaleMode;

    public class Box extends Sprite
    {
        public function Box()
        {
            stage.scaleMode = StageScaleMode.EXACT_FIT;
            this.graphics.beginFill(0x338533);
            this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            this.graphics.endFill();
        }
    }
}
