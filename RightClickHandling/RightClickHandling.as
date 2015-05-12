package {
    import flash.display.Sprite;
    import flash.display.Shape;
    import flash.events.Event;
    import flash.events.MouseEvent;


    public class RightClickHandling extends Sprite {
        private var rightClickDot:Shape;
        private var leftClickDot:Shape;

        public function RightClickHandling():void {
            prepareShapes();

            addChild(leftClickDot);
            addChild(rightClickDot);

            stage.addEventListener(MouseEvent.CLICK, onClick);
            stage.addEventListener(MouseEvent.RIGHT_CLICK, onClick);
        }

        public function onClick(e:MouseEvent):void {
            if (e.type == MouseEvent.CLICK) {
                leftClickDot.x = e.localX;
                leftClickDot.y = e.localY;
            }

            if (e.type == MouseEvent.RIGHT_CLICK) {
                rightClickDot.x = e.localX;
                rightClickDot.y = e.localY;
            }
        }

        private function createColoredDot(color:int, radius:int):Shape {
            var dot:Shape = new Shape();
            dot.graphics.beginFill(color);
            dot.graphics.drawCircle(0, 0, radius);
            dot.graphics.endFill();
            return dot;
        }

        private function prepareShapes():void {
            leftClickDot =  createColoredDot(0x2FCC73, 20);   // green
            rightClickDot = createColoredDot(0xCC2F88, 20);   // purple

            leftClickDot.x = 20;
            leftClickDot.y = 20;

            rightClickDot.x = 20;
            rightClickDot.y = 60;
        }
    }
}

