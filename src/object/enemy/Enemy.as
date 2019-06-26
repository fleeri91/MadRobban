package object.enemy {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import component.Character;
	
	import manager.GameManager;
	
	import object.GameArea;
	import object.enemy.badguy.BadguyDeadState;
	import object.platform.Platform;
	
	import scene.game.GameState;

	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 *	Publik klass som ligger till grund för alla fienden
	 * 	Klassen ärver funktionalitet från klassen Character
	 */
	public class Enemy extends Character {
		
		public var _isVulnerable:Boolean = false;
		// --------------------------------------------------------
		// Protecetd properites
		// --------------------------------------------------------	
		protected var _point:int;
				
		/**
		 * 	Getter för poäng
		 * 
		 *	@return int
		 */
		public function get point():int {
			return _point;
		}
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Enemy(startPosition:Point, runSpeed) {
			
			var hitbox:Rectangle = new Rectangle(-10, 0, 26, 60);
			var hitboxFeet:Rectangle = new Rectangle(-10, 61, 26, 5);
			
			this.x = startPosition.x;
			this.y = startPosition.y;
			
			super(hitbox, hitboxFeet, runSpeed, 0);
		}
		
		// --------------------------------------------------------
		// Override Public Methods
		// --------------------------------------------------------
		override public function init():void {
			
			this._dir = this.randDir();
		}
		
		override public function update():void {
			
			if(!this._isActive || this._isDead)
				return;
						
			super.update();
		
			this.enemyAI();
			this.updateAnimation();
		}
		
		override public function dispose():void {
			super.dispose();
		}
		
		// --------------------------------------------------------
		// Override Protected Method
		// --------------------------------------------------------
		override protected function checkCollision():void {
			
			super.checkCollision();
			
			var rect:Rectangle = this._hitboxFeet.getRect(GameState._gameObjectLayer);
			
			for each(var plat:Platform in GameArea.platforms) {
				
				var platformRect:Rectangle = plat.getRect(GameState._gameObjectLayer);
				
				if(rect.intersects(platformRect)) {
					
					if((rect.x < 800 - rect.width) && (rect.x > 0 + rect.width)) {
											
						this._isVulnerable = true;
						
						if(rect.x > (770 - rect.width))
							this._dir = -1;
						
						if(rect.x < (20 + rect.width))
							this._dir = 1;
					}
					
					if(rect.x > platformRect.x + (platformRect.width - rect.width)) 	
						this._dir = -1;
					
					if(rect.x < platformRect.x)
						this._dir = 1;
				}
			}
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------	
		private function updateAnimation():void {
						
			if(!this._velocity.x == 0 && !this._isDead)
				this._skin.gotoAndStop("run");
		}
		
		private function enemyAI():void {
			
			if(!_isGrounded)
				return;
			
			if(this._dir == 1) {
				this.m_moveRight();	
			}
			
			if(this._dir == -1) {
				this.m_moveLeft();	
			}
		}
				
		private function randDir():int {
			
			return Math.floor(Math.random()*2) == 1 ? 1 : -1;
		}
				
		public function dead(manager:GameManager):void {
			this._isDead = true;
			this._stateMachine.currentState = new BadguyDeadState(this, manager);
		}
	}
}