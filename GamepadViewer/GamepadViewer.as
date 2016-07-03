package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.GameInputEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.ui.GameInput;
    import flash.ui.GameInputControl;
    import flash.ui.GameInputDevice;

    public class GamepadViewer extends Sprite
    {
        private var gi:GameInput;
        private var txt:TextField;
        private var controls:Array;
        private var control_names:Array;

        public function GamepadViewer():void
        {
            gi = new GameInput();
            gi.addEventListener(GameInputEvent.DEVICE_ADDED, deviceAdded);
            gi.addEventListener(GameInputEvent.DEVICE_REMOVED, deviceRemoved);

            var fmt:TextFormat = new TextFormat();
            fmt.size = 10;
            txt = new TextField();
            txt.defaultTextFormat = fmt;
            txt.multiline = true;
            txt.border = true;
            txt.width = stage.stageWidth - 20;
            txt.height = stage.stageHeight - 20;
            txt.x = 10;
            txt.y = 10;
            txt.text = "";
            addChild(txt);
        }

        private function deviceAdded(e:GameInputEvent):void
        {
            var device:GameInputDevice = e.device;

            device.enabled = true;
            txt.appendText("added device\n");
            txt.appendText("    name = " + device.name + "\n");
            txt.appendText("    id = " + device.id + "\n");
            txt.appendText("    numControls = " + device.numControls + "\n");

            controls = new Array();
            control_names = new Array();
            for (var k:int = 0; k < device.numControls; k ++) {
                var control:GameInputControl = device.getControlAt(k);
                control.addEventListener(Event.CHANGE, controlChange);
                controls[control.id] = 0;
                control_names.push(control.id);
            }

            control_names.sort();
        }

        private function deviceRemoved(e:GameInputEvent):void
        {
            var device:GameInputDevice = e.device;

            txt.appendText("removed device\n    id = " + device.id + "\n");
        }

        private function controlChange(e:Event):void
        {
            var control:GameInputControl = GameInputControl(e.target);
            var s:String = "";

            controls[control.id] = control.value;
            for (var k:String in control_names) {
                var name:String = control_names[k];
                s += name + ": " + controls[name] + "\n";
            }

            txt.text = s;
        }
    }

}
