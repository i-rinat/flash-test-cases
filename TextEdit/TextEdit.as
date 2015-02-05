package
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;

    public class TextEdit extends Sprite
    {
        public function TextEdit()
        {
            var fmt:TextFormat = new TextFormat();
            var txt:TextField = new TextField();

            fmt.size = 24;
            txt.text = 'Edit...';
            txt.setTextFormat(fmt);
            txt.type = TextFieldType.INPUT;
            txt.multiline = true;
            txt.wordWrap = true;
            txt.border = true;
            txt.x = 5; txt.y = 5;
            txt.width = stage.stageWidth - 10; txt.height = stage.stageHeight - 10;

            addChild(txt);
        }
    }
}
