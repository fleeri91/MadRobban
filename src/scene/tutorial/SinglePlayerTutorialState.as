package scene.tutorial {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	import asset.TutorialAnimationGFX;
	import scene.game.IntroState;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	
	/**
	 *	Tillstånd för singleplayer tutorial
	 */
	public class SinglePlayerTutorialState extends DisplayState {
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _controls:EvertronControls = new EvertronControls;
		private var _introAnimation:TutorialAnimationGFX;
		
		private var _canControl:Boolean;
		private var _finishedPlaying:Boolean;
		
		private var _tutorialLayer:DisplayStateLayer;
		
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------
		private static const LAYER_TUTORIAL:String = "tutorial";
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function SinglePlayerTutorialState() {
			this.initLayers();
			this.initTutorialAnimation();
		}
		
		// --------------------------------------------------------
		// Override Public Method
		// --------------------------------------------------------
		override public function update():void {
			updateControls();
			updateAnimation();
		}
		
		override public function dispose():void {
			this._controls = null;
			this._introAnimation = null;
			this._tutorialLayer = null
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 *	Uppdaterar kontroller
		 * 
		 * 	@return	void	
		 */
		private function updateControls():void {
			if(Input.keyboard.justPressed(this._controls.PLAYER_BUTTON_1) && this._canControl) {
				Session.application.displayState = new IntroState("singleplayer");
			}	
		}
		
		/**
		 *	Initialiserar animation
		 * 
		 * 	@return	void	
		 */
		private function initTutorialAnimation():void {
			this._introAnimation = new TutorialAnimationGFX();
			this._introAnimation.x = (Session.application.size.x >> 1);
			this._introAnimation.y = (Session.application.size.y >> 1);			
			this._tutorialLayer.addChild(_introAnimation);
		}
		
		/**
		 *	Initialiserar lager
		 * 
		 * 	@return	void	
		 */
		private function initLayers():void {
			this._tutorialLayer = layers.add(LAYER_TUTORIAL);
		}
		
		/**
		 *	Uppdaterar animation
		 * 
		 * 	@return	void	
		 */
		private function updateAnimation():void {
			var child:MovieClip = _introAnimation.getChildAt(1) as MovieClip;
			if(child.currentFrame == child.totalFrames && !this._finishedPlaying) {
				this._finishedPlaying = true;
				this._canControl = true;
				this._introAnimation.gotoAndStop(2);
			}	
		}
	}
}