package  
{
	import flash.events.Event;
	import mathematics.Polynomial;
	/**
	 * ...
	 * @author Arthur Wulf White
	 */
	public class Check_Poly_Divide_1 extends BaseTest
	{
		
		public function Check_Poly_Divide_1() 
		{
			
		}
		
		override protected function init(e:Event = null):void 
		{
			var q : Vector.<Number> = new <Number>[Math.random() * 10, Math.random() * 10, Math.random() * 10, Math.random() * 10],
				p : Vector.<Number> = new <Number>[Math.random() * 10, Math.random() * 10, Math.random() * 10],
				r : Vector.<Number> = null,
				d : Vector.<Number> = null;
			
			r = Polynomial.multiply(p, q);
			d = Polynomial.divide(r, q);
			trace(p);
			trace(d);
			super.init(e);
		}
		
	}

}