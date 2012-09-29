package  
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Graphics;
	import flash.text.TextField;
	import mathematics.Bezier;
	/**
	 * ...
	 * @author Arthur Wulf White
	 */
	public class Check_random_bezier_closest_point_1 extends BaseTest
	{
		private const 	RADIUS 	: int = 37;
		private var		textF	: TextField = new TextField();
		public function Check_random_bezier_closest_point_1() 
		{
		
		}
		
		override protected function init(e:Event = null):void 
		{
			var pointVector : Vector.<Point> = new Vector.<Point>(4, true),
				result : Point = null	,
				radius : Number = (0.5 + Math.random()) *	RADIUS	,
				i : int = 0				,
				g : Graphics = this.graphics;
			textF.width = stage.stageWidth;
			addChild(textF);
			textF.text = "testing...";
			for (i = 4; i--; )
			{
				pointVector[i] = new Point(Math.random() * stage.stageWidth, Math.random() * stage.stageHeight);
			}
			if (Math.random() < 0.5)
			{
				pointVector[3] = Bezier.getPoint(pointVector[0], pointVector[1], pointVector[2], Math.random());
				pointVector[3].x += Math.random() * radius;
				pointVector[3].y += Math.random() * radius;
				trace("tick");
			}
			g.clear();
			g.lineStyle(1, 0xff);
			g.moveTo(pointVector[0].x, pointVector[0].y);
			g.curveTo(pointVector[1].x, pointVector[1].y, pointVector[2].x, pointVector[2].y);
			result = Bezier.getPoint(pointVector[0], pointVector[1], pointVector[2], Bezier.getClosestTValue(pointVector[0], pointVector[1], pointVector[2], pointVector[3]));
			if (Point.distance(pointVector[3], result) <= radius)
			{
				textF.text = "Collision detected";
				g.lineStyle(1, 0xff0000);
			}
			else
			{
				textF.text = "No collisions detected";
				g.lineStyle(1, 0xff00);
			}
			g.drawCircle(pointVector[3].x, pointVector[3].y, radius);
			g.drawCircle(result.x, result.y, 3);
			super.init(e);
			stage.addEventListener(MouseEvent.CLICK, init);
		}
	}

}