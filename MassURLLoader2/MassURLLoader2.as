package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    public class MassURLLoader2 extends Sprite
    {
        private var txt:TextField;
        private var got:int = 0;
        private var sent:int = 0;

        public function MassURLLoader2() {
            var fmt:TextFormat = new TextFormat();

            txt = new TextField();

            fmt.size = 32;
            txt.text = '';
            txt.setTextFormat(fmt);
            txt.autoSize = TextFieldAutoSize.LEFT;

            addChild(txt);
            txt.appendText("starting\n");

            make_request();
        }

        private function make_request():void {
                var loader:URLLoader = new URLLoader();
                var request:URLRequest = new URLRequest("../common/big.data?id=" + sent);

                loader.addEventListener(Event.COMPLETE, completeHandler);
                try {
                    loader.load(request);
                } catch (error:Error) {
                    txt.appendText("Unable to load URL" + error + "\n");
                }
                sent++;
                txt.text = 'Sent ' + sent + '\nGot ' + got;
        }

        private function completeHandler(event:Event):void {
            got++;
            txt.text = 'Sent ' + sent + '\nGot ' + got;
            make_request();
        }
    }
}
