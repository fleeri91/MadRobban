package scene.game {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.geom.Rectangle;
	
	import object.enemy.Enemy;
	import object.pickup.Pickup;
	import object.player.Player;
	import object.player.PlayerOne;
	import object.player.PlayerTwo;
		
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	
	/**
	 *	Tillstånd för co-op mode
	 */
	public class CoopState extends GameState {
		
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------	
		private var _playerOneDelivering:Boolean;
		private var _playerTwoDelivering:Boolean;
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------	
		public function CoopState(numOfPlayers:int) {
			this._numOfPlayers = numOfPlayers;
		}
		
		// --------------------------------------------------------
		// Override Public Methods
		// --------------------------------------------------------	
		override public function init():void {
			
			super.init();
			
			this.initCoopMode();
			this.initPlayer();
		}
		
		override public function update():void {
			
			for(var i:int = 0; i < this.playerHandler.players.length; i++) {
				this.checkCollision(this.playerHandler.players[i]);
			}
			
			gameManager.update();
		}
		
		override public function dispose():void {
			super.dispose();
		}
		
		// --------------------------------------------------------
		// Override Protected Methods
		// --------------------------------------------------------	
		
		/**
		 *	Kollisionshantering
		 * 
		 * 	@param	Player
		 * 	@return	void
		 */
		override protected function checkCollision(player:Player):void {
			
			super.checkCollision(player);
			
			var playerBox:Rectangle = player.hitbox.getRect(_playerLayer);
			var weaponBox:Rectangle = player.weaponhitbox.getRect(_playerLayer);
			
			for each (var enemy:Enemy in enemyHandler.enemies) {
				var enemyBox:Rectangle = enemy.hitbox.getRect(_gameObjectLayer);
				
				if(playerBox.intersects(enemyBox) && !player._isImmune && !enemy._isDead)
					player.takeDamage();
				
				if(weaponBox.intersects(enemyBox) && player._isAttacking && !enemy._isDead) {
					this.enemyCollision(enemy, enemyBox);
				}
			}
			
			for each (var pickup:Pickup in pickupHandler.pickups) {
				var pickupBox:Rectangle = pickup.hitbox.getRect(_gameObjectLayer);
				
				if(playerBox.intersects(pickupBox) && player.holdingItem == "") {
					this.pickupCollision(pickup, player);
				}
			}
			
			var angrynerdBox:Rectangle = angryNerdHandler.angrynerd.hitbox.getRect(_gameObjectLayer);
			if(playerBox.intersects(angrynerdBox)) {
				
				this.angryNerdCollision(player);
								
				if(player is PlayerOne) this._playerOneDelivering = true;
				if(player is PlayerTwo) this._playerTwoDelivering = true;
			} else if(!playerBox.intersects(angrynerdBox)) {
				if(player is PlayerOne) this._playerOneDelivering = false;
				if(player is PlayerTwo) this._playerTwoDelivering = false;
			}
		}
		
		/**
		 *	Kollisionshantering mellan spelare och fiende
		 * 
		 * 	@param	Enemy
		 * 	@param	Rectangle
		 * 	@return	void
		 */
		override protected function enemyCollision(enemy:Enemy, enemyBox:Rectangle):void {
			super.enemyCollision(enemy, enemyBox);
		}
		
		/**
		 *	Kollisionshantering mellan spelare och föremål
		 * 
		 * 	@param	Pickup
		 * 	@param	Player
		 * 	@return	void
		 */
		override protected function pickupCollision(item:Pickup, player:Player):void {
			super.pickupCollision(item, player);
		}
		
		/**
		 *	Kollisionshantering mellan spelare och angrynerd
		 * 
		 * 	@param	Player
		 * 	@return	void
		 */
		override protected function angryNerdCollision(player:Player):void {
			
			if(_playerOneDelivering && _playerTwoDelivering) {
				
				if(playerHandler.players[0].holdingItem != "" &&
				   playerHandler.players[1].holdingItem != "") {
				
					this.resetHoldingItems();				
					this.pickupHandler.resetItems();
					
					this.gameManager.deliverItem();
					this.angryNerdHandler.playAnimation();
					
					this.angryNerdHandler.generateRandomItem(2);
					this.pickupHandler.wantedItems = angryNerdHandler.wanteditem;
				}
			}	
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------	
		
		/**
		 *	Initialiserar spelare
		 * 
		 * 	@return	void
		 */
		private function initPlayer():void {
			
			for(var i:int = 0; i < this._numOfPlayers; i++) {
				this.playerHandler.add();
			}
			
			playerHandler.players[1].direction = -1;
		}
	}
}