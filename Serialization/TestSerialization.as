package
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.utils.ByteArray;

    public class TestSerialization extends Sprite
    {
        private static function hexstr(array:ByteArray, colons:Boolean = true):String
        {
            var s:String = "";
            for (var i:uint = 0; i < array.length; i ++) {
                s += ("0" + array[i].toString(16)).substr(-2, 2);
                    if (colons) {
                        if (i < array.length - 1)
                            s += ":";
                    }
            }
            return s;
        }

        public function TestSerialization()
        {
            var fmt:TextFormat = new TextFormat();
            var txt:TextField = new TextField();

            fmt.size = 24;
            txt.text = '';
            txt.setTextFormat(fmt);
            txt.type = TextFieldType.INPUT;
            txt.multiline = true;
            txt.wordWrap = true;
            txt.border = true;
            txt.x = 5; txt.y = 5;
            txt.width = stage.stageWidth - 10; txt.height = stage.stageHeight - 10;

            addChild(txt);
            txt.type = "dynamic"; // make read-only

            // test serialization
            var person:Person = new Person();
            person.name = "John";
            var address:Address = new Address();
            address.planet = "Earth";
            address.city = "New Delhi";
            person.address = address;
            person.fav_double = 123.456;
            person.fav_integer = 5;

            person.fav_array = new Array("abc", 55, 9.0, new Array("d", "e", "f"), new Array());

            var bytes:ByteArray = new ByteArray();
            bytes.writeObject(person);

            txt.text = hexstr(bytes);
        }
    }
}
