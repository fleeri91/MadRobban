package manager {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import object.enemy.EnemyHandler;
	import object.pickup.PickupHandler;
	import object.player.PlayerHandler;
	
	import scene.game.GameOverState;
	
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	import ui.HUD;
	
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	
	/**
	 *	Publik klass som hanterar spelets logik och poängräkning 
	 */
	public class GameManager {
					
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _mode:String;
		
		private var _enemyHandler:EnemyHandler;
		private var _pickupHandler:PickupHandler;
		private var _playerHandler:PlayerHandler;
		private var _hud:HUD;
				
		private var _amountOfEnemies:int;
		private var _maxAmountOfEnemies:int;
		
		private var _amountKillsToSpawnItem:int = 4;
		private var _currentCombo:int = 1;
		private var _maxCombo:int = 5;
		
		private var _killCount:int;
		private var _deliveries:int;
		private var _deliveringPoints:int;
		
		private var _dropSound:SoundObject;
		
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------
		private static const DEFAULT_DELIVERING_POINTS:int = 100;
		private static const DEFAULT_MAX_ENEMIES:int = 8;
		private static const DEFAULT_AMOUNT_OF_ENEMIES:int = 4;
		
		private static const DEFAULT_MAX_RAGE_SINGLEPLAYER:int = 20;
		private static const DEFAULT_MAX_RAGE_COOP:int = 25;
		
		// --------------------------------------------------------
		// Embedded Class
		// --------------------------------------------------------
		[Embed(source ="../../asset/sound/Drop.mp3")]
		private static const DROP:Class;
		
		// --------------------------------------------------------
		// Public Getters & Setters
		// --------------------------------------------------------
				
		/**
		 * 	Getter för fiendehanterare
		 * 
		 *	@return EnemyHandler
		 */		
		public function get enemyhandler():EnemyHandler {
			return _enemyHandler;
		}
		
		/**
		 * 	Getter för föremålhanterare
		 * 
		 *	@return PickupHandler
		 */	
		public function get pickuphandler():PickupHandler {
			return _pickupHandler;
		}
		
		
		/**
		 * 	Getter för antalet fiende som dödats
		 * 
		 *	@return int
		 */	
		public function get kills():int {
			return _killCount;
		}
		
		/**
		 *  Setter för antalet fiende som dödats
		 * 
		 * 	@param	int
		 *	@return void
		 */		
		public function set kills(value:int):void {
			_killCount = value;
		}
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function GameManager(hud:HUD, playerHandler:PlayerHandler, enemyHandler:EnemyHandler, pickupHandler:PickupHandler) {
			this._hud = hud;
			this._playerHandler = playerHandler;
			this._enemyHandler = enemyHandler;
			this._pickupHandler = pickupHandler;
		}
		
		// --------------------------------------------------------
		// Public Methods
		// --------------------------------------------------------		
		public function init(mode:String):void {
			this._mode = mode;
			
			if(_mode === "singleplayer") this.initSingleplayerMode();
			if(_mode === "coop") 		 this.initCoopMode();
			
			this.initSound();
		}
		
		public function update():void {
			if(_enemyHandler.enemies.length < this._amountOfEnemies)
				_enemyHandler.add();
						
			if(_hud.rageTimer.rage > _hud.rageTimer.maxRage) {
				Session.application.displayState = new GameOverState(_mode, _hud.scoreCounter.score);
			}	
		}
		
		// --------------------------------------------------------
		// Public Methods
		// --------------------------------------------------------
		
		/**
		 * 	Räknar ut poäng när ett fiende dödats
		 * 
		 * 	@param	int
		 * 	@return	void
		 */
		public function calculateScore(value:int):void {
			
			var comboScore:int = value;
									
			this._hud.scoreCounter.score += comboScore * _currentCombo;

			if(this._currentCombo <= this._maxCombo) 
				this._currentCombo += 1;
				
			Session.timer.create(1000, resetCombo);
		}
		
		/**
		 * 	Räknar ut poäng när föremål levererats
		 * 
		 * 	@param	Number
		 * 	@return	void
		 */
		public function calculateDeliverScore(value:Number):void {

			var deliverPoints:int = _deliveringPoints;
			deliverPoints = deliverPoints / value;
						
			this._hud.scoreCounter.score += Math.round(deliverPoints / 10) * 10;
		}
		
		/**
		 * 	Skapar ett föremål
		 * 	Kollar om antal fiende som dödats är uppnåt och att spelaren inte har ett föremål
		 * 
		 * 	@param	int
		 * 	@param	int
		 * 	@return	void
		 */
		public function spawnItem(xPos:int, yPos:int):void {
			for(var i:int = 0; i < _playerHandler.players.length; i++) {
				if(this._killCount >= this._amountKillsToSpawnItem && _playerHandler.players[i].holdingItem == "" && _pickupHandler.pickups.length == 0) {
					this._pickupHandler.add(xPos, yPos);
					this._dropSound.play();
					this._killCount = 0;
				}
			}
		}
		
		/**
		 * 	Levererar ett föremål och ökar svårighetsgraf efter tre inlämningar
		 * 
		 * 	@return	void
		 */
		public function deliverItem():void {
			this._deliveries++;
			this._killCount = 0;
			
			this.calculateDeliverScore(this._hud.rageTimer.ragePercentage);
			
			this._hud.rageTimer.rage -= 20;
			
			if(this._deliveries == 3) this.increaseDifficulty();
		}
						
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 * 	Initialiserar singleplayer mode
		 * 
		 * 	@return	void
		 */
		private function initSingleplayerMode():void {
			this._amountOfEnemies = DEFAULT_AMOUNT_OF_ENEMIES;
			this._maxAmountOfEnemies = DEFAULT_MAX_ENEMIES;
			this._deliveringPoints = DEFAULT_DELIVERING_POINTS;
			this._hud.rageTimer.maxRage = DEFAULT_MAX_RAGE_SINGLEPLAYER;
			
			this._amountKillsToSpawnItem = 4;
			this._deliveries = 0;
			this._killCount = 0;
		}
		
		/**
		 * 	Initialiserar coop mode
		 * 
		 * 	@return	void
		 */
		private function initCoopMode():void {
			this._amountOfEnemies = DEFAULT_AMOUNT_OF_ENEMIES;
			this._maxAmountOfEnemies = DEFAULT_MAX_ENEMIES;
			this._deliveringPoints = DEFAULT_DELIVERING_POINTS;
			this._hud.rageTimer.maxRage = DEFAULT_MAX_RAGE_COOP;
			
			this._amountKillsToSpawnItem = 3;
			this._deliveries = 0;
			this._killCount = 0;
		}
		
		/**
		 * 	Initialiserar ljud
		 * 
		 * 	@return	void
		 */
		private function initSound():void {
			Session.sound.soundChannel.sources.add("drop", DROP);
			this._dropSound = Session.sound.soundChannel.get("drop");
		}
		
		/**
		 * 	Ställer om kombo-räknare
		 * 
		 * 	@return	void
		 */
		private function resetCombo():void {
			this._currentCombo = 1;
		}
		
		/**
		 * 	Ökar spelets svårighetsgrad
		 * 	---------------------------
		 * 	Ökar antalet fiende på planen med ett (max antal på 8)
		 * 	Ökar poäng vid inlämning med 50
		 * 	Ökar antaet fienden som måste dödas för att ett föremål ska droppas
		 * 	Minskar ragetimer med en sekund
		 * 
		 * 	@return	void
		 */
		private function increaseDifficulty():void {
			
			this._amountKillsToSpawnItem++;
			this._amountOfEnemies++;
			this._hud.rageTimer.maxRage--;
			this._deliveringPoints += 50;
			
			if(_amountOfEnemies >= _maxAmountOfEnemies)
				_amountOfEnemies = _maxAmountOfEnemies;
			
			this._deliveries = 0;
		}
	}
}