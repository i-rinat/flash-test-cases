package
{
    import flash.display.Sprite;
    import flash.media.Camera;
    import flash.media.Video;

    public class CameraView extends Sprite
    {
        public function CameraView()
        {
            var cam:Camera = Camera.getCamera();

            if (cam != null) {
                cam.setMode(stage.stageWidth, stage.stageHeight, 15, true);

                var vid:Video = new Video(cam.width, cam.height);
                vid.x = 0;
                vid.y = 0;
                vid.width = stage.stageWidth;
                vid.height = stage.stageHeight;

                vid.attachCamera(cam);
                addChild(vid);
            }
        }
    }
}
