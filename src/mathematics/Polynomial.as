package mathematics 
{
	import mathematics.Complex;
	/**
	 * ...
	 * @author Arthur
	 */
	public class Polynomial 
	{
		public static var SQRT3 : Number = Math.sqrt(3);
		public function Polynomial() 
		{	
		}
		
		public static function calcF(p : Vector.<Number>, x : Number):Number
		{
			var i : int = 0;
			var sum : Number = 0;
			for (i = 0; i < p.length; i++)
				sum += p[i] * Math.pow(x, i);
			return sum;
		}
		
		public static function add(p : Vector.<Number>, q : Vector.<Number>):Vector.<Number>
		{
			var i : int = 0;
			var longPoly 	: Vector.<Number> = (p.length >= q.length)? p : q;
			var shortPoly	: Vector.<Number> = (p.length <  q.length)? p : q;
			var resultPoly 	: Vector.<Number> = new Vector.<Number>(longPoly.length, true);
			for (i = 0; i < shortPoly.length; i++)
			{
				resultPoly[i] = shortPoly[i] + longPoly[i];
			}
			for (i = shortPoly.length; i < longPoly.length; i++)
			{
				resultPoly[i] = longPoly[i];
			}
			return resultPoly;
		}
		
		public static function multiply(p : Vector.<Number>, q : Vector.<Number>):Vector.<Number>
		{
			var i : int = 0, j : int = 0;
			var resultPoly 	: Vector.<Number> = new Vector.<Number>(p.length + q.length - 1, true);
			for (i = 0; i < resultPoly.length; i++)
			{
				resultPoly[i] = 0;
			}
			for (i = 0; i < p.length; i++)
			{
				for (j = 0; j < q.length; j++)
				{
					resultPoly[i + j] += p[i] * q[j];
				}
			}
			
			return resultPoly;
		}
		
		public static function divide(p : Vector.<Number>, q : Vector.<Number>):Vector.<Number>
		{
			var result 	: Vector.<Number> = new Vector.<Number>(1 + p.length - q.length, true),
					i	: int = polyDeg(p),
					j	: int = polyDeg(q),
					k 	: int = 0,
					r	: Number = 0;
					
			trace("i : " , i, " j : ", j, " k : ", k, " r : ", r);
			while (i >= j)
			{
				r = p[i] / q[j];
				trace("r : ", r); 
				trace("i - j : ", (i - j)); 
				result[i - j] = r;
				for (k = 1; k < j+1; k++)
				{
					p[i - k] -= r * q[j - k];
				}
				trace("p : ", p);
				p[i--] = 0;
			}
			return result;
		}
		
		public static function derivative(p : Vector.<Number>):Vector.<Number>
		{
			var i : int = 0;
			var result : Vector.<Number> = new Vector.<Number>(p.length - 1, true);
			for (i = 0; i < result.length; i++)
			{
				result[i] = (i + 1) * p[i + 1];
			}
			return result;
		}
		
		public static function polyDeg(p : Vector.<Number>):int
		{
			var i : int = 0;
			for (i = p.length - 1; i >= 0; i--)
			{
				if (p[i] != 0) return i;
			}
			return -1;
		}
		
		public static function solvePoly(p : Vector.<Number>):Vector.<Complex>
		{
			var a : Number, b : Number, c : Number, d : Number, 
				A : Number, B : Complex, Cp : Complex, Cn : Complex,
				Zp: Complex, Zn : Complex, max : Number;
			
			var deg : int = polyDeg(p);
			trace("DEGREE" , deg);
			switch(deg)
			{
				case 1:
					return new <Complex> [new Complex(p[0] / (- p[1]))];
				break;
				
			case 2:
					trace("Starting to solve Quadratic Polynomial");
					a = p[2];
					b = p[1];
					c = p[0];
					var sq : Complex = Complex.rRoot(b * b - 4 * a * c);
					sq.x 	/= (2 * a);
					sq.y	/= (2 * a);
					b 		/= (2 * a);
					return new <Complex> [	new Complex(- b - sq.x, -sq.y), 
											new Complex(- b + sq.x,  sq.y)];
				break;
				
			case 3:
					
					Zp = new Complex(1, SQRT3).rMul(0.5);
					Zn = new Complex(1, - SQRT3).rMul(0.5);
					max = Math.max(p[0], p[1], p[2], p[3]);
					a = p[3]; // max;
					b = p[2]; // max;
					c = p[1]; // max;
					d = p[0]; // max;
					
					trace(p);
					trace(a, "* x^3 +", b, "* x^2 +", c, "* x +", d);
					//trace("new <Number> [", d, ",", c, ",", b, ",", a,"]");
					A = 2 * b*b*b - 9 * a*b*c + 27 * a*a*d;
					trace("A : ")
					trace( A);
					//trace("B : ");
					//trace((A*A - 4 * Math.pow(b*b - 3 * a*c, 3)));
					B = Complex.rRoot(A * A - 4 * Math.pow(b * b - 3 * a * c, 3));
					trace('B');
					trace(B);
					Cp = Complex.root(B.rAdd(A).rMul(0.5), 3);
					trace("CpIn : " , B.rAdd(A).rMul(0.5));
					trace("Cp : ", Cp);
					Cn = Complex.root(B.rAdd( -A).rMul( -0.5), 3);
					trace("CnIn : " , B.rAdd( -A).rMul( -0.5));
					trace("Cn : ", Cn);
					//var result : Complex = Complex.sum(Cp, Cn).rAdd(b).rMul(-1 / (3 * a));
					return new 	<Complex>[	Complex.sum(Cp, Cn).rAdd(b).rMul(-1.0 / (3.0 * a)),
											 Complex.sum(Complex.multiply(Zp, Cp), Complex.multiply(Zn, Cn)).rAdd( -b).rMul(1.0 / (3.0 * a)),
											  Complex.sum(Complex.multiply(Zp, Cn), Complex.multiply(Zn, Cp)).rAdd( -b).rMul(1.0 / (3.0 * a))];
				break;
			}
			return null;
		}
		
		
		public static function newton(p : Vector.<Number>, guess : Number = 0.5, epsilon : Number = 0.000001, steps : int = 32):Vector.<Complex>
		{
			var d : Vector.<Number> = derivative(p),
				q : Vector.<Number> = null,
				r : Vector.<Complex> = null;
			while (Math.abs(calcF(p, guess)) > epsilon && steps > 0)
			{
				guess -= calcF(p, guess) / calcF(d, guess);
			}
			q = divide(p, new <Number> [-guess, 1]);
			r = solvePoly(q);
			r.push(new Complex(guess));
			return r;
		}
		
	}
	
}