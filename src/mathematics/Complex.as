package mathematics 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Arthur
	 */
	public class Complex extends Point
	{
		private static var EPSILON : Number = 0.001;
		public function Complex(real : Number = 0, imag : Number = 0) 
		{
			super(real, imag);
		}
		
		public function isReal():Boolean
		{
			return Math.abs(y) < EPSILON;
		}
		
		public function rAdd(val : Number):Complex
		{
			return new Complex(x + val, y);
		}
		
		public function rMul(val : Number):Complex
		{
			return new Complex(val * x, val * y);
		}
		
		public static function rRoot(val : Number, pow : int = 2):Complex
		{
			var root	: Number	= 0;
			if (pow == 2) root = Math.sqrt(Math.abs(val));
			else root = Math.pow(Math.abs(val), 1.0 / pow);
			return (val >= 0)? new Complex(root) : new Complex(0, root);
		}
		
		public static function multiply(r : Complex, q : Complex):Complex
		{
			return new Complex(r.x * q.x - r.y * q.y, r.x * q.y + r.y * q.x);
		}
		
		public static function sum(r : Complex, q : Complex):Complex
		{
			var point : Point = r.add(q);
			return new Complex(point.x, point.y);
		}
		
		public static function sub(r : Complex, q : Complex):Complex
		{
			var point : Point = r.subtract(q);
			return new Complex(point.x, point.y);
		}
		
		public function get real():Number
		{
			return this.x;
		}
		
		public function get imaginary():Number
		{
			return this.y;
		}
		
		public function get angle():Number
		{
			var result : Number = Math.atan2(y, x);
			return (result > 0)? result : result + 2 * Math.PI; 
		}
		
		public function get absolute():Number
		{
			return this.length;
		}
		
		public static function root(z : Complex, pow : int = 2):Complex
		{
			//trace("Length : ", z.length, " Angle : ", z.angle, " Angle / pow ", z.angle / pow);
			if (pow % 2 == 1 && z.y == 0)
				return new Complex((z.x > 0 ? 1 : -1 ) * Math.pow(Math.abs(z.x), 1.0 / pow));
			else
			var point : Point = Point.polar(Math.pow(z.length, 1.0 / pow), z.angle / pow);
			return new Complex(point.x, point.y);
		}
		
	}

}