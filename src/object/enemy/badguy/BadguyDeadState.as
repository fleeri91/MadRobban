package object.enemy.badguy {
		

	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import manager.GameManager;
	
	import object.enemy.Enemy;
	import object.enemy.EnemyHandler;
	import object.pickup.PickupHandler;
	
	import se.lnu.stickossdk.state.State;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	
	/**
	 * 	Fiendets state när fiendet dödats
	 */
	public class BadguyDeadState extends State {
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------	
		private var _enemy:Enemy;
		private var _enemyHandler:EnemyHandler;
		private var _pickupHandler:PickupHandler;
		private var _gameManager:GameManager;
		private var _timerRemoveEnemy:Timer;
				
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------	
		public function BadguyDeadState(enemy:Enemy, gameManager:GameManager) {
			this._gameManager = gameManager;
			this._enemy = enemy;
			this._enemy._isDead = true;
			this._enemy._skin.gotoAndStop("dead");

			this._timerRemoveEnemy = Session.timer.create(750, removeEnemy);
		}
				
		override public function dispose():void {
			super.dispose();
			
			this._enemy = null;
			this._enemyHandler = null;
			this._pickupHandler = null;
			this._gameManager = null;
			this._timerRemoveEnemy = null;
		}
				
		/**
		 *	Tar bort fiendet från spelplanen
		 * 
		 * 	@return void
		 */
		private function removeEnemy():void {	
			this._gameManager.spawnItem(_enemy.x, _enemy.y);
			this._gameManager.enemyhandler.remove(_enemy);
			
			Session.timer.remove(_timerRemoveEnemy);
		}
	}
}