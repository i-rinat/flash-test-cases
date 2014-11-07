package
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;

    public class HelloWorld extends Sprite
    {
        public function HelloWorld()
        {
            var fmt:TextFormat = new TextFormat();
            var txt:TextField = new TextField();

            fmt.size = 32;
            txt.text = 'Hello, world!';
            txt.setTextFormat(fmt);
            txt.autoSize = TextFieldAutoSize.LEFT;

            addChild(txt);
        }
    }
}
