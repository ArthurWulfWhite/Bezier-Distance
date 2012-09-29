package  
{
	import flash.display.Sprite;
	import flash.events.Event
	/**
	 * ...
	 * @author Arthur Wulf White
	 */
	public class BaseTest extends Sprite
	{
		
		public function BaseTest() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

}