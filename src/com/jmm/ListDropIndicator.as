package com.jmm
{
	
	import flash.display.Graphics;
	import mx.skins.ProgrammaticSkin;
	
	/**
	 *  The skin for the drop indicator of a list-based control.
	 */
	public class ListDropIndicator extends ProgrammaticSkin
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 */
		public function ListDropIndicator()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override protected function updateDisplayList(w:Number, h:Number):void
		{	
			super.updateDisplayList(w, h);
			
			var g:Graphics = graphics;
			
			g.clear();
			g.beginFill(0x11ff11, 0.5);
			g.drawRect(-5, -1, w, 27);
		}
	}
}