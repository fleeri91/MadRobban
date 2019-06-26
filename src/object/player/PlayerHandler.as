package object.player {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	import object.player.PlayerOne;
	import object.player.PlayerTwo;
	
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	
	/**
	 * 	Publik klass som hanterar spelare
	 */
	public class PlayerHandler {
		
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _target:DisplayObjectContainer;
		private var _players:Vector.<Player> = new Vector.<Player>();
		
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------	
		private static const PLAYER_ONE_POS:Point = new Point(162, 512);
		private static const PLAYER_TWO_POS:Point = new Point (622, 506);	
		
		private static const DEFAULT_RUNSPEED:int = 5;
		private static const DEFAULT_JUMPFORCE:Number = 13.5;
			
		// --------------------------------------------------------
		// Public Getter
		// --------------------------------------------------------
		
		/**
		 *	Getter som returnerar spelare
		 * 
		 * 	@return Vector.<Player>
		 */
		public function get players():Vector.<Player> {
			return _players;
		}
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function PlayerHandler(displayTarget:DisplayObjectContainer) {
			this._target = displayTarget;
		}
		
		// --------------------------------------------------------
		// Public Methods
		// --------------------------------------------------------
		
		/**
		 *	Lägger till spelare
		 * 
		 * 	@return void
		 */
		public function add():void {
			if (_players.length < 2) {
				attatchToSpawnPoint(GetPlayers());
			}
		}
		
		/**
		 *	Disponering
		 * 
		 * 	@return	void
		 */
		public function dispose():void {
			this.disposePlayers();
			this._players = null;
			this._target = null;
		}
				
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 *	Hämtar en ny spelare, returnerar spelare 2 om spelare 1 redan är aktiv
		 * 
		 *	@return Player
		 */
		private function GetPlayers():Player {
			if (_players.length == 0) return new PlayerOne(PLAYER_ONE_POS, DEFAULT_RUNSPEED, DEFAULT_JUMPFORCE);
			else return new PlayerTwo(PLAYER_TWO_POS, DEFAULT_RUNSPEED, DEFAULT_JUMPFORCE);
		}
		
		/**
		 *	...
		 * 
		 *	@param 	Player
		 * 	@return	void
		 */
		private function attatchToSpawnPoint(player:Player):void {
			_players.push(player);			
			_target.addChild(player);
		}
		
		/**
		 *	Disponerar spelare
		 * 
		 *	@return void
		 */
		private function disposePlayers():void {
			for(var i:int = 0; i < _players.length; i++) {
				this._players[i].dispose();
				this._players[i] = null;
			}
		}
	}
}