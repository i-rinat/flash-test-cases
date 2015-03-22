package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    public class MassURLLoader extends Sprite
    {
        private var txt:TextField;
        private var got:int = 0;

        public function MassURLLoader() {
            var fmt:TextFormat = new TextFormat();
            var sent:int = 0;

            txt = new TextField();

            fmt.size = 32;
            txt.text = '';
            txt.setTextFormat(fmt);
            txt.autoSize = TextFieldAutoSize.LEFT;

            addChild(txt);
            txt.appendText("starting\n");

            for (var k:int = 0; k < 1000; k ++) {
                var loader:URLLoader = new URLLoader();
                var request:URLRequest = new URLRequest("../common/bg.jpeg?id=" + k);

                loader.addEventListener(Event.COMPLETE, completeHandler);
                try {
                    loader.load(request);
                } catch (error:Error) {
                    txt.appendText("Unable to load URL" + error + "\n");
                }
                sent = sent + 1;
                txt.text = 'Sent ' + sent;
            }
        }

        private function completeHandler(event:Event):void {
            got++;
            txt.text = 'Got ' + got;
            var loader:URLLoader = URLLoader(event.target);
        }
    }
}
