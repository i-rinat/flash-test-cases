package
{
    import flash.display.Sprite;
    import flash.display.Loader;
    import flash.net.FileReference;
    import flash.net.FileReferenceList;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;

    public class BrowseFile extends Sprite
    {
        private var txt:TextField;
        private var fr:FileReference;
        private var frl:FileReferenceList;

        public function BrowseFile() {
            var btn:CustomSimpleButton;
            btn = new CustomSimpleButton();
            btn.label = "Open file...";
            btn.x = 20;
            btn.y = 20;
            btn.addEventListener(MouseEvent.CLICK, handleClickOpenSingle);
            addChild(btn);

            btn = new CustomSimpleButton();
            btn.label = "Open multiple files...";
            btn.x = 120;
            btn.y = 20;
            btn.addEventListener(MouseEvent.CLICK, handleClickOpenMultiple);
            addChild(btn);

            var fmt:TextFormat = new TextFormat();
            fmt.size = 12;
            txt = new TextField();
            txt.defaultTextFormat = fmt;
            txt.multiline = true;
            txt.border = true;
            txt.width = stage.stageWidth - 40;
            txt.height = stage.stageHeight - 70 - 40;
            txt.x = 20;
            txt.y = 70;
            txt.text = "";
            addChild(txt);
        }

        // open single file
        private function handleClickOpenSingle(event:MouseEvent):void {
            fr = new FileReference;
            fr.addEventListener(Event.SELECT, onSingleFileSelected);
            fr.browse();
            txt.appendText("dialog create for single select open\n");
        }

        private function onSingleFileSelected(event:Event):void {
            var fr:FileReference = FileReference(event.target);
            fr.addEventListener(Event.COMPLETE, onFileLoaded);
            fr.addEventListener(Event.CANCEL, onCancel);
            fr.load();
            txt.appendText("file selected\n");
        }

        // open multiple files
        private function handleClickOpenMultiple(event:MouseEvent):void {
            frl = new FileReferenceList;
            frl.addEventListener(Event.SELECT, onMultipleFilesSelected);
            frl.browse();
            txt.appendText("dialog create for multiple select open\n");
        }

        private function onMultipleFilesSelected(event:Event):void {
            var frl:FileReferenceList = FileReferenceList(event.target);

            for (var k:uint; k < frl.fileList.length; k++) {
                var fr:FileReference = frl.fileList[k];
                fr.addEventListener(Event.COMPLETE, onFileLoaded);
                fr.addEventListener(Event.CANCEL, onCancel);
                fr.load();
            }

            txt.appendText("multiple files selected\n");
        }

        private function onFileLoaded(event:Event):void {
            var fr:FileReference = FileReference(event.target);
            txt.appendText("file name: " + fr.name + "\n");
            txt.appendText("file size: " + fr.size + " bytes\n");
        }

        private function onCancel(event:Event):void {
            txt.appendText("cancel\n");
        }
   }
}

import flash.display.Sprite;
import flash.display.SimpleButton;
import flash.display.Shape;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;

class CustomSimpleButton extends SimpleButton {
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
}

class ButtonDisplayState extends Sprite {
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
