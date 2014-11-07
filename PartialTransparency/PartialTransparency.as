package
{
    import flash.display.Stage;
    import flash.display.Sprite;
    import flash.display.BitmapData;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;


    public class PartialTransparency extends Sprite
    {
        public function PartialTransparency()
        {
            var fmt:TextFormat = new TextFormat();
            var txt:TextField = new TextField();

            fmt.size = 32;
            txt.text = stage.loaderInfo.parameters["text"];
            txt.setTextFormat(fmt);
            txt.autoSize = TextFieldAutoSize.LEFT;
            txt.x = (stage.stageWidth - txt.width) / 2;
            txt.y = (stage.stageHeight - txt.height) / 2;

            addChild(txt);

            // make background white
            this.graphics.beginFill(0xffffff);
            this.graphics.drawEllipse(0, 0, stage.stageWidth, stage.stageHeight);
        }
    }
}
