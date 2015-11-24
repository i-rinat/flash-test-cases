package {
    import flash.display.Sprite;
    import flash.events.ActivityEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.SampleDataEvent;
    import flash.events.StatusEvent;
    import flash.events.TimerEvent;
    import flash.media.Microphone;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.utils.ByteArray;
    import flash.utils.Timer;
    import ftccommon.CustomSimpleButton;


    public class RecordAudio extends Sprite {
        private var DELAY_LENGTH:int;
        private var mic:Microphone;
        private var timer:Timer;
        private var soundBytes:ByteArray = new ByteArray();
        private var sound:Sound;
        private var channel:SoundChannel;
        private var record_btn:CustomSimpleButton;
        private var textarea:TextField;

        public function RecordAudio() {
            record_btn = new CustomSimpleButton();
            record_btn.x = 5;
            record_btn.y = 5;
            record_btn.addEventListener(MouseEvent.CLICK, startRecording);
            addChild(record_btn);

            textarea = new TextField();
            var fmt:TextFormat = new TextFormat();
            fmt.size = 16;
            textarea.setTextFormat(fmt);
            textarea.x = 5;
            textarea.y = 35;
            textarea.height = stage.stageHeight - 35 - 5;;
            textarea.width = stage.stageWidth - 5 - 5;
            textarea.border = true;
            addChild(textarea);

            DELAY_LENGTH = 5000;
            mic = Microphone.getMicrophone();
            mic.setSilenceLevel(0, DELAY_LENGTH);
            mic.gain = 100;
            mic.rate = 44;

            timer = new Timer(DELAY_LENGTH);
            timer.addEventListener(TimerEvent.TIMER, timerHandler);

            record_btn.label = "Record for " + DELAY_LENGTH/1000 + " sec";
        }

        public function startRecording(event:MouseEvent):void {
            record_btn.enabled = false;
            soundBytes.clear();
            timer.start();
            mic.addEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
            textarea.appendText("Recording ... ");
        }

        private function micSampleDataHandler(event:SampleDataEvent):void
        {
            while(event.data.bytesAvailable)
            {
                var sample:Number = event.data.readFloat();
                soundBytes.writeFloat(sample);
            }
        }

        private function timerHandler(event:TimerEvent):void
        {
            mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
            timer.stop();
            timer.reset();
            soundBytes.position = 0;
            sound = new Sound();
            sound.addEventListener(SampleDataEvent.SAMPLE_DATA, playbackSampleHandler);
            channel = new SoundChannel();
            channel = sound.play();
            textarea.appendText("done.\nPlaying ... ");
        }

        private function playbackSampleHandler(event:SampleDataEvent):void
        {
            for (var i:int = 0; i < 8192 && soundBytes.bytesAvailable > 0; i ++) {
                var sample:Number = soundBytes.readFloat();
                event.data.writeFloat(sample);
                event.data.writeFloat(sample);
            }

            if (soundBytes.bytesAvailable == 0)
                playbackComplete();
        }

        private function playbackComplete():void
        {
            channel.stop();
            textarea.appendText("done.\n");
            record_btn.enabled = true;
        }
    }
}
