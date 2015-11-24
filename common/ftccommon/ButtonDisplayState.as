package ftccommon {
    import flash.display.Sprite;
    import flash.display.SimpleButton;
    import flash.display.Shape;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;

    internal class ButtonDisplayState extends Sprite {
        private var bgColor:uint;
        private var _label:String;
        private var _w:uint;
        private var _h:uint;

        public function ButtonDisplayState(bgColor:uint, w:uint, h:uint, _label:String) {
            this.bgColor = bgColor;
            this._w      = w;
            this._h      = h;
            this._label  = _label;
            draw();
        }

        private function draw():void {
            var fmt:TextFormat = new TextFormat();
            fmt.size = 12;

            var t:TextField = new TextField();
            t.text = this._label;
            t.setTextFormat(fmt);
            t.autoSize = TextFieldAutoSize.LEFT;
            t.width = t.textWidth;
            t.height = t.textHeight;

            if (this._w < t.width + 6)
                this._w = t.width + 6;
            if (this._h < t.height + 6)
                this._h = t.height + 6;

            t.x = (this._w - t.width) / 2;
            t.y = (this._h - t.height) / 2;
            this.addChild(t);

            graphics.beginFill(bgColor);
            graphics.drawRect(0, 0, _w, _h);
            graphics.endFill();
        }
    }
}
