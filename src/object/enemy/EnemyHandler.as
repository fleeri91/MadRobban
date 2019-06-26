package object.enemy {

		
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	import object.enemy.badguy.Badguy;
		
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	
	/**
	 * 	Publik klass som hanterar fienden
	 */
	public class EnemyHandler {
		
		
		// ------------------------------------------------------------
		// Private Properties
		// ------------------------------------------------------------	
		private var _enemies:Vector.<Enemy> = new Vector.<Enemy>();
		private var _enemyPool:Vector.<Enemy> = new Vector.<Enemy>();
		
		private var _maximumAmount:int = 10;
		private var _target:DisplayObjectContainer;
		private var _inactivePos:Point = new Point(-200, -200);
		private var _randPos:Point = new Point();
		private var _randPosIndex:int = 0;
		
		
		// ------------------------------------------------------------
		// Private Static Constants
		// ------------------------------------------------------------	
		private static const ENEMY_SPAWNPOSITION:Vector.<Point> = new Vector.<Point>;
						
		ENEMY_SPAWNPOSITION.push(new Point(-100, 185));
		ENEMY_SPAWNPOSITION.push(new Point(900, 185));
		
		ENEMY_SPAWNPOSITION.push(new Point(-100, 335));
		ENEMY_SPAWNPOSITION.push(new Point(900, 335));
		
		ENEMY_SPAWNPOSITION.push(new Point(-100, 485));
		ENEMY_SPAWNPOSITION.push(new Point(900, 485)); 
		
		
		// ------------------------------------------------------------
		// Public Getter & Setter
		// ------------------------------------------------------------	
		
		/**
		 *	Getter som returnerar fienden
		 * 
		 * 	@return	Vector.<Enemy>
		 */
		public function get enemies():Vector.<Enemy> {
			return _enemies;
		}
		
		// ------------------------------------------------------------
		// Constructor Method
		// ------------------------------------------------------------	
		public function EnemyHandler(displayTarget:DisplayObjectContainer) {
			this._target = displayTarget;
			this.initPool();
		}
		
		// ------------------------------------------------------------
		// Public Methods
		// ------------------------------------------------------------	
		
		/**
		 *	Skapar ett fiende
		 * 
		 * 	@return Enemy
		 */
		public function add():Enemy {
			return createEnemy();
		}
		
		/**
		 * 	Tar bort ett fiende från spelplanen och lägger tillbaka det i objekt-poolen
		 * 	
		 * 	@param	Enemy
		 *	@return void
		 */
		public function remove(enemy:Enemy):void {
			
			enemy._isActive = false;
						
			var index:int = this._enemies.indexOf(enemy);
			
			this._enemies.splice(index, 1);
			this._target.removeChild(enemy);
			this.setEnemy(enemy);
		}
		
		public function dispose():void {
			this.disposeEnemies();
			this.disposePool();
			
			this._enemies = null;
			this._enemyPool = null;
			this._inactivePos = null;
			this._target = null;
		}
		
		// ------------------------------------------------------------
		// Private Methods
		// ------------------------------------------------------------	
		
		/**
		 *	Disponerar alla fienden
		 * 
		 * 	@return	void
		 */
		private function disposeEnemies():void {
			for(var i:int = 0; i < this._enemies.length; i++) {
				this._enemies[i].dispose();
				this._enemies[i] = null;
			}
		}
		
		/**
		 * 	Disponerar fiende-poolen
		 * 
		 * 	@return	void
		 */
		private function disposePool():void {
			for(var i:int = 0; i < this._enemyPool.length; i++) {
				this._enemyPool[i].dispose();
				this._enemyPool[i] = null;
			}
		}
		
		/**
		 * 	initialiserar objekt-poolen för fienden
		 * 
		 *	@return void
		 */
		private function initPool():void {
					
			for(var i:int = 0; i < _maximumAmount; i++) {
				
				var randVal:int = getRandomValue(2, 4);
				
				var enemy:Enemy = new Badguy(_inactivePos, randVal);
				this._target.addChild(enemy);
				this._enemyPool.push(enemy);
			}
		}
		
		/**
		 * 	Skapar ett fiende
		 * 	Lägger till det i listan för fienden och tar bort det från objekt-poolen
		 * 	Om maxantalet för poolen överskrider så skapas ett nytt fiende
		 * 
		 *	@return Enemy
		 */
		private function createEnemy():Enemy {
			
			if(_maximumAmount > 0) {
				
				for(var i:int = 0; i < _enemyPool.length; i++) {
					
					this._randPos  = this.getRandomPos();
					
					var enemy:Enemy = this._enemyPool[i];
					enemy.x = _randPos.x;
					enemy.y = _randPos.y;
					enemy._isActive = true;
					
					this._target.addChild(enemy);
					this._enemies.push(enemy);
					
					this._enemyPool.splice(i, 1);
					this._maximumAmount -= 1;
					break;
				}
				return enemy;
			}
			trace("Pool is empty, created a new enemy");
			this._randPos = getRandomPos();
			
			var randVal:int = getRandomValue(2, 4);
			
			var newEnemy:Enemy = new Badguy(_randPos, randVal);
			this._target.addChild(newEnemy);
			return newEnemy;
		}
		
		/**
		 * 	Lägger tillbaka ett fiende i objekt-poolen
		 * 
		 * 	@param	Enemy
		 *	@return void
		 */
		private function setEnemy(enemy:Enemy):void {
		
			enemy._isActive = false;
			enemy._isDead = false;
			enemy._isVulnerable = false;
			enemy.x = _inactivePos.x;
			enemy.y = _inactivePos.y;
			
			this._enemyPool.push(enemy);
			this._maximumAmount += 1;
			this._target.addChild(enemy);
		}
												
		/**
		 * 	Hämtar en slumpad position
		 * 
		 *	@return Point
		 */
		private function getRandomPos():Point {
			
			var randPos:Point;
			
			if(_randPosIndex == ENEMY_SPAWNPOSITION.length)
				_randPosIndex = 0;
			
			randPos = ENEMY_SPAWNPOSITION[_randPosIndex];
						
			_randPosIndex++;
			return randPos;
		}
		
		/**
		 * 	Hämtar ett slumpat värde
		 * 
		 * 	@param	int
		 * 	@param	int
		 *	@return int
		 */
		private function getRandomValue(min:int, max:int):int {
			var value:int = Math.floor(Math.random() * (max - min + 1)) + min;
			return value;
		}
		
	}
}