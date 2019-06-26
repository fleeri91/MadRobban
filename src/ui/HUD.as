package ui {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------		
	import flash.text.TextFormatAlign;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.system.Session;
	
	import ui.counter.Counter;
	import ui.timer.RageTimer;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 * 	Klass för spelets HUD
	 * 
	 */
	public class HUD extends DisplayStateLayerSprite {
		
		// --------------------------------------------------------
		// Public Properties
		// --------------------------------------------------------
		public var scoreCounter:Counter;
		public var highscoreCounter:Counter;
		public var rageTimer:RageTimer;
				
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function HUD() {

		}
		
		// --------------------------------------------------------
		// Override Public Methods
		// --------------------------------------------------------
		override public function init():void {
			//this.initTopBar();
			this.initScoreCounter();
			this.initHighscoreCounter();
			this.initRageTimer();
		}
				
		override public function dispose():void {
			this.rageTimer = null;
			this.scoreCounter = null;
		}
	
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------		
		private function initHighscoreCounter():void {
			this.highscoreCounter = new Counter("HIGHSCORE", TextFormatAlign.RIGHT);
			this.highscoreCounter.initScoreCounter();
			
			highscoreCounter.x = Session.application.size.x - (highscoreCounter.width + 10);
			highscoreCounter.y = 15;
			
			this.addChild(highscoreCounter);
		}
		
		/**
		 * 	Skapar en ny instans av ScoreCounter
		 * 
		 *	@return void
		 */
		private function initScoreCounter():void {
			this.scoreCounter = new Counter("SCORE", TextFormatAlign.LEFT);
			this.scoreCounter.initScoreCounter();
			
			scoreCounter.x = 10;
			scoreCounter.y = 15;
			
			this.addChild(scoreCounter);
		}
				
		/**
		 * 	Skapar en ny instans av RageTimer
		 * 
		 *	@return void
		 */
		private function initRageTimer():void {
			this.rageTimer = new RageTimer();
			this.addChild(rageTimer);
		}
	}
}