package mathematics 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Arthur Wulf White
	 */
	public class Bezier 
	{
		
		public function Bezier() 
		{
			
		}
		
		public static function getClosestTValue(pointStart : Point, pointControl : Point, pointEnd : Point, otherPoint : Point):Number
		{
			var i : int = 0;
			var qdx : Vector.<Number> = new <Number>[- 1.0 * otherPoint.x + pointStart.x ,- 2.0 * pointStart.x + 2.0 * pointControl.x ,pointStart.x - 2.0 * pointControl.x + pointEnd.x];
			var qdy : Vector.<Number> = new <Number>[- 1.0 * otherPoint.y + pointStart.y ,- 2.0 * pointStart.y + 2.0 * pointControl.y ,pointStart.y - 2.0 * pointControl.y + pointEnd.y];
			var times : Number = 12;
			var poly : Vector.<Number> = Polynomial.derivative(Polynomial.add(Polynomial.multiply(qdx, qdx), Polynomial.multiply(qdy, qdy)));
			var result : Vector.<Complex> = null;// Polynomial.solvePoly(poly).concat(new <Complex> [new Complex(1)]); 
			var dist : Number = Point.distance(getPoint(pointStart, pointControl, pointEnd, 0), otherPoint);
			var tmpDist : Number = 0;
			var roots : Vector.<Complex>= Polynomial.newton(poly);
			var best : Number = 0;
			result = roots;//result.concat(roots);
			result.push(new Complex(1));
			for (i = 0; i < result.length; i++)
			{
				if (result[i].isReal() && 0 <= result[i].x  && result[i].x <= 1 && (tmpDist = Point.distance(getPoint(pointStart, pointControl, pointEnd, result[i].x), otherPoint)) < dist)
				{
					best = result[i].x;
					dist = tmpDist;
				}
			}
			return best;
		}
		
		public static function getPoint(pointStart : Point, pointControl : Point, pointEnd : Point, t : Number):Point
		{
			return new Point(
				(1 - t) * ((1 - t) * pointStart.x + t * pointControl.x) + t * ((1 - t) * pointControl.x + t * pointEnd.x),
				(1 - t) * ((1 - t) * pointStart.y + t * pointControl.y) + t * ((1 - t) * pointControl.y + t * pointEnd.y)
			);
		}
		
	}

}