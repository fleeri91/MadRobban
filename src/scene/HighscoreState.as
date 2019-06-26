package scene {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import asset.HighscoreAnimationGFX;
	
	import component.highscore.Highscore;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	public class HighscoreState extends DisplayState {
		
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _backgroundLayer:DisplayStateLayer;
		private var _highscoreLayer:DisplayStateLayer;
		
		private var _background:HighscoreAnimationGFX;
		
		private var _highscoreTableSingleplayer:Highscore;
		private var _highscoreTableCoop:Highscore;
		
		private var _controls:EvertronControls = new EvertronControls;
		private var _canControl:Boolean = true;
		
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------
		private static const LAYER_BACKGROUND:String = "background";
		private static const LAYER_HIGHSCORE:String = "highscore";
		
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function HighscoreState() {

		}
		
		// --------------------------------------------------------
		// Override Public Methods
		// --------------------------------------------------------
		override public function init():void {
			this.initLayers();
			this.initBackground();
			this.initHighscoreSingleplayer();
			this.initHighscoreCoop();
		}
		
		override public function update():void {
			this.updateControls();
		}
		
		override public function dispose():void {
			this._controls = null;
			this._highscoreLayer = null;
			this._background = null;
			
			this._highscoreTableCoop.dispose();
			this._highscoreTableCoop = null;
			
			this._highscoreTableSingleplayer.dispose();
			this._highscoreTableSingleplayer = null;
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 *	Initialiserar layers
		 * 
		 *	@return void
		 */
		private function initLayers():void {
			this._backgroundLayer = this.layers.add(LAYER_BACKGROUND);
			this._highscoreLayer = this.layers.add(LAYER_HIGHSCORE);
		}
		
		private function initBackground():void {
			this._background = new HighscoreAnimationGFX();
			this._background.x = (Session.application.size.x >> 1) -10.5;
			this._background.y = (Session.application.size.y >> 1);
			this._backgroundLayer.addChild(_background);
		}
		
		/**
		 *	Initialiserar highscore tabell för singleplayer mode
		 * 
		 *	@return void
		 */
		private function initHighscoreSingleplayer():void {			
			this._highscoreTableSingleplayer = new Highscore("singleplayer");				
			this._highscoreTableSingleplayer.x = (Session.application.size.x >> 1) - (this._highscoreTableSingleplayer.width >> 1);
			this._highscoreTableSingleplayer.y = 100;
			this._highscoreLayer.addChild(_highscoreTableSingleplayer);
		}
		
		/**
		 *	Initialiserar highscore tabell för co-op mode
		 * 
		 *	@return void
		 */
		private function initHighscoreCoop():void {			
			this._highscoreTableCoop = new Highscore("coop");				
			this._highscoreTableCoop.x = (Session.application.size.x >> 1) - (this._highscoreTableSingleplayer.width >> 1);//(Session.application.size.x >> 1) + ((this._highscoreTableCoop.width >> 1) * 2) ;
			this._highscoreTableCoop.y = -200;
			this._highscoreTableCoop.alpha = 0;
			this._highscoreLayer.addChild(_highscoreTableCoop);
		}
		
		/**
		 *	Animerar highscore tabellen uppåt
		 * 
		 *	@return void
		 */
		private function animateHighscoreUp():void {
			
			this._canControl = false;
			Session.timer.create(500, activateControls);
			
			Session.tweener.add(_highscoreTableSingleplayer, {
				duration: 500,
				alpha: 0,
				y: -200
			})
				
			Session.tweener.add(_highscoreTableCoop, {
				duration: 500,
				alpha: 1,
				y: 100
			})
		}
		
		/**
		 *	Animerar highscore tabellen nedåt
		 * 
		 *	@return void
		 */
		private function animateHighscoreDown():void {
			
			this._canControl = false;
			Session.timer.create(400, activateControls);
			
			Session.tweener.add(_highscoreTableSingleplayer, {
				duration: 500,
				alpha: 1,
				y: 100
			})
			
			Session.tweener.add(_highscoreTableCoop, {
				duration: 500,
				alpha: 0,
				y: -200
			})
		}
		
		/**
		 *	Aktiverar spelarens kontroller
		 * 
		 *	@return void
		 */
		private function activateControls():void {
			this._canControl = true;
		}
		
		/**
		 *	Uppdaterar spelarens kontroller
		 * 
		 * 	@return void
		 */
		private function updateControls():void {
			
			if(!this._canControl)
				return;
			
			if(Input.keyboard.justPressed(this._controls.PLAYER_BUTTON_1))
				Session.application.displayState = new MenuState();
			
			if(Input.keyboard.justPressed(this._controls.PLAYER_UP))
				animateHighscoreUp();
			
			if(Input.keyboard.justPressed(this._controls.PLAYER_DOWN))
				animateHighscoreDown();
		}
	}
}