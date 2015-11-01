package
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.events.Event;
    import flash.events.MouseEvent;


    public class DoubleClick extends Sprite
    {
        private var txt:TextField;

        public function DoubleClick()
        {
            stage.doubleClickEnabled = true;

            stage.addEventListener(MouseEvent.CLICK, onClick);
            stage.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
            stage.addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);

            var fmt:TextFormat = new TextFormat();
            txt = new TextField();

            fmt.size = 16;
            txt.text = 'click anywhere\n';
            txt.setTextFormat(fmt);
            txt.autoSize = TextFieldAutoSize.LEFT;

            addChild(txt);
        }

        private function onClick(e:MouseEvent):void {
            txt.appendText("left click\n");
        }

        private function onDoubleClick(e:MouseEvent):void {
            txt.appendText("left double click\n");
        }

        private function onRightClick(e:MouseEvent):void {
            txt.appendText("right click\n");
        }
    }
}
