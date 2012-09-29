package  
{
	import flash.events.Event;
	import mathematics.Polynomial;
	/**
	 * ...
	 * @author Arthur Wulf White
	 */
	public class Check_Q_Poly_Solver_1 extends BaseTest
	{
		
		public function Check_Q_Poly_Solver_1() 
		{
			
		}
		
		override protected function init(e:Event = null):void 
		{
			var 	q : Vector.<Number> = new <Number>[Math.random() * 10 - 5, 1],
					p : Vector.<Number> = new <Number>[Math.random() * 10 - 5, 1],
					r : Vector.<Number> = null;
			r = Polynomial.multiply(p, q);
			trace(q[0], p[0]);
			trace(Polynomial.solvePoly(r));
			super.init(e);
		}
		
	}

}