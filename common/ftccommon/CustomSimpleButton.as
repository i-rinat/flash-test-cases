package ftccommon {
    import flash.display.Sprite;
    import flash.display.SimpleButton;
    import flash.display.Shape;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;

    public class CustomSimpleButton extends SimpleButton {
        private var upColor:uint   = 0xCCCCCC;
        private var overColor:uint = 0xDFDFDF;
        private var downColor:uint = 0x808080;
        private var _label:String = "";
        private var _w:uint = 80;
        private var _h:uint = 30;

        public function CustomSimpleButton() {
            recreateStates();
        }

        public function set label(s:String):void {
            this._label = s;
            recreateStates();
        }

        public function get label():String {
            return this._label;
        }

        public function set w(value:uint): void {
            this._w = value;
            recreateStates();
        }

        public function get w():uint {
            return this._w;
        }

        public function set h(value:uint):void {
            this._h = value;
            recreateStates();
        }

        public function get h():uint {
            return this._h;
        }

        private function recreateStates():void {
            downState      = new ButtonDisplayState(downColor, _w, _h, _label);
            overState      = new ButtonDisplayState(overColor, _w, _h, _label);
            upState        = new ButtonDisplayState(upColor, _w, _h, _label);
            hitTestState   = new ButtonDisplayState(upColor, _w, _h, _label);
            useHandCursor  = true;
        }

        override public function set enabled(value:Boolean):void {
            super.enabled = value;
            this.mouseEnabled = value;
        }
    }
}
