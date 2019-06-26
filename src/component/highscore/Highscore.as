package component.highscore {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.display.Sprite;
	
	import se.lnu.stickossdk.system.Session;
		
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 *	Publik klass för spelets highscore.
	 */
	public class Highscore extends Sprite {
		
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _highscoreTable:HighscoreTable = new HighscoreTable();
		private var _mode:String;
		
		// --------------------------------------------------------
		// Private Statics
		// --------------------------------------------------------
		private static const HEADER_LABEL_SINGLEPLAYER:String = "SINGLEPLAYER";
		private static const HEADER_LABEL_COOP:String = "COOP";
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Highscore(mode:String) {
			this._mode = mode;
			this.init();
		}
		
		// --------------------------------------------------------
		// Public Methods
		// --------------------------------------------------------
		public function init():void {
			initTable();
			initData();
		}
						
		public function update():void {
			initData();
		}
				
		public function dispose():void {
			_highscoreTable.dispose();
			_highscoreTable = null;
		}
						
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------	
		
		/**
		 *	Initialiserar highscore tabellen
		 * 	Tabellens rubrik ändras beroende på vilket spelets mode är
		 * 
		 * 	@return void
		 */
		private function initTable():void {
			_highscoreTable = new HighscoreTable();
			if(_mode == "singleplayer") _highscoreTable.header = HEADER_LABEL_SINGLEPLAYER;
			if(_mode == "coop") _highscoreTable.header = HEADER_LABEL_COOP;
			addChild(_highscoreTable);
		}
		
		/**
		 *	Initialiserar tabellens data beroende på vilket spelets mode är
		 * 
		 * 	@return void
		 */
		private function initData():void {
			if(_mode == "singleplayer") Session.highscore.receive(0, 10, function(data:XML):void { setData(data, _highscoreTable) });
			if(_mode == "coop") Session.highscore.receive(1, 10, function(data:XML):void { setData(data, _highscoreTable) });
		}
		
		/**
		 *	Applicerar ny data till tabellen
		 * 
		 * 	@param	XML
		 * 	@param	HighscoreTable
		 * 	@return void
		 */
		private function setData(data:XML, table:HighscoreTable):void {
			table.data = data;
		}
	}
}