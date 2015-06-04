package {
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.StageVideoEvent;
    import flash.events.StageVideoAvailabilityEvent;
    import flash.media.Video;
    import flash.media.StageVideoAvailability;
    import flash.net.NetConnection;
    import flash.net.NetStream;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.utils.setInterval;


    public class VideoPlayer extends Sprite {
        private var videoURL:String = "60fps.mp4";
        private var connection:NetConnection;
        private var stream:NetStream;
        private var video:Video;
        private var txt:TextField;
        private var txt_fps:TextField;

        private function createTextField():void {
            var fmt:TextFormat = new TextFormat();
            txt = new TextField();

            fmt.size = 32;
            txt.setTextFormat(fmt);
            txt.autoSize = TextFieldAutoSize.LEFT;

            txt_fps = new TextField();
            txt_fps.setTextFormat(fmt);
            txt_fps.autoSize = TextFieldAutoSize.LEFT;

            txt.y = 30;
            addChild(txt);
            txt_fps.y = 0;
            addChild(txt_fps);
        }

        public function VideoPlayer() {
            createTextField();

            txt.text = "StageVideo player\n";

            connection = new NetConnection();
            connection.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
            connection.connect(null);

            stream = new NetStream(connection);
            stream.client = this;

            stage.addEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY,
                                   onStageVideoState);
            setInterval(showFPS, 1000);
        }

        private function onNetStatus(event:NetStatusEvent): void {
        }

        private function stageVideoStateChange(event:StageVideoEvent):void {
            var status:String = event.status;
            txt.appendText("status: " + status + "\n");
        }

        private function onStageVideoState(event:StageVideoAvailabilityEvent):void {
            var available:Boolean = (event.availability == StageVideoAvailability.AVAILABLE);
            txt.appendText("available: " + available + "\n");

            stage.stageVideos[0].viewPort = new Rectangle(200, 0, 320, 240);
            stage.stageVideos[0].attachNetStream(stream);
            stage.stageVideos[0].addEventListener(StageVideoEvent.RENDER_STATE, stageVideoStateChange);

            stream.play(videoURL);
        }

        private function showFPS():void {
            txt_fps.text = "fps: " + stream.currentFPS;
        }
    }
}
