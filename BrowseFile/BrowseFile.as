package
{
    import flash.display.Sprite;
    import flash.display.Loader;
    import flash.net.FileFilter;
    import flash.net.FileReference;
    import flash.net.FileReferenceList;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import ftccommon.CustomSimpleButton;

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
            frl.browse(getFileTypes());
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

        private function getFileTypes():Array {
            var types:Array = new Array();

            types.push(new FileFilter("Images (*.jpg, *.jpeg, *.gif, *.png)",
                                      "*.jpg;*.jpeg;*.gif;*.png"));
            types.push(new FileFilter("Text Files (*.txt, *.rtf)", "*.txt;*.rtf"));
            types.push(new FileFilter("All Files (*)", "*"));

            return types;
        }
   }
}
