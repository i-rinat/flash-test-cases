package {
    import flash.display.Sprite;
    import flash.events.ActivityEvent;
    import flash.events.SampleDataEvent;
    import flash.events.StatusEvent;
    import flash.media.Microphone;
    import flash.utils.ByteArray;


    public class Oscilloscope extends Sprite {
        private var mic:Microphone;
        private var scale_y:Number = 2 * stage.stageHeight;
        private var soundBufTargetLen:int = 4000;
        private var soundBuf:Vector.<Number> = new Vector.<Number>(soundBufTargetLen);

        public function Oscilloscope():void
        {
            mic = Microphone.getMicrophone();
            mic.setSilenceLevel(0);
            mic.gain = 100;
            mic.rate = 44;
            mic.addEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
        }

        private function micSampleDataHandler(event:SampleDataEvent):void
        {
            var cnt:int = 0;
            var idx:int = 0;

            while (event.data.bytesAvailable) {
                var sample:Number = event.data.readFloat();
                if (idx % 40 == 0) {
                    soundBuf.push(sample);
                    cnt += 1;
                }
                idx += 1;
            }
            soundBuf.splice(0, cnt);
            draw();
        }

        private function draw():void
        {
            var scale_x:Number = stage.stageWidth / soundBuf.length;
            graphics.clear();
            graphics.lineStyle(0, 0x000000);
            graphics.moveTo(0, stage.stageHeight / 2);

            for (var idx:int = 0; idx < soundBuf.length; idx ++) {
                var nx:Number = idx * scale_x;
                var ny:Number = soundBuf[idx] * this.scale_y + stage.stageHeight / 2;

                graphics.lineTo(nx, ny);
            }
        }
    }
}
