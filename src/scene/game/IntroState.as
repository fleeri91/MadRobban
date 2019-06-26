package scene.game {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import asset.IntroAnimationGFX;
	
	import object.background.Background;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.fx.Shake;
	import se.lnu.stickossdk.system.Session;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	public class IntroState extends DisplayState {
				
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _backgroundLayer:DisplayStateLayer;
		
		private var _background:Background;
		private var _angryNerdIntro:IntroAnimationGFX;
		private var _mode:String;
		private var _animationChild:MovieClip;
		
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------
		private static const LAYER_BACKGROUND:String = "background";
		
		private static const DEFAULT_TEXT_SIZE:int = 32;
		private static const DEFAULT_TEXT_COLOR:uint = 0xFFFFFF;
		private static const DEFAULT_TEXT_FONT:String = "8-Bit Madness";
		private static const DEFAULT_BACKGROUND_COLOR:uint = 0x000000;
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function IntroState(mode:String) {
			this._mode = mode;
		}
		
		// --------------------------------------------------------
		// Override Public Methods
		// --------------------------------------------------------
		override public function init():void {
			this.initLayers();
			this.initAngryNerdIntro();
			
			Session.effects.add(new Shake(_backgroundLayer, 1000, new Point(3, 3), new Point(0, 0)));
		}
		
		override public function update():void {
			this.updateAnimation();
		}
		
		override public function dispose():void {
			this._angryNerdIntro = null;
			this._background = null;
			this._animationChild = null;
			this._backgroundLayer = null;
		}
				
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 *	Initialiserar layers
		 * 
		 * 	@return void
		 */
		private function initLayers():void {
			_backgroundLayer = layers.add(LAYER_BACKGROUND);
		}
		
		/**
		 *	Initialiserar angrynerd
		 * 
		 * 	@return void
		 */
		private function initAngryNerdIntro():void {
			this._angryNerdIntro = new IntroAnimationGFX();
			this._angryNerdIntro.x = (Session.application.size.x >> 1);
			this._angryNerdIntro.y = (Session.application.size.y >> 1);	
			this._backgroundLayer.addChild(this._angryNerdIntro);
			
			if(_mode == "singleplayer") this._angryNerdIntro.gotoAndStop(_mode);
			if(_mode == "coop") 		this._angryNerdIntro.gotoAndStop(_mode);
			
			this._animationChild = _angryNerdIntro.getChildAt(0) as MovieClip;
		}
		
		/**
		 *	Uppdaterar animation
		 * 
		 * 	@return void
		 */
		private function updateAnimation():void {
			var child:MovieClip = this._animationChild.getChildAt(1) as MovieClip;
			if(child.currentFrame == child.totalFrames) {
				child.stop();
				if(_mode == "singleplayer") Session.application.displayState = new SinglePlayerState(1);
				if(_mode == "coop") Session.application.displayState = new CoopState(2);
			}
		}
	}
}