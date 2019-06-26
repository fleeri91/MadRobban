package scene.game {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.geom.Rectangle;
	
	import manager.GameManager;
	
	import object.GameArea;
	import object.angrynerd.AngryNerdHandler;
	import object.background.Background;
	import object.enemy.Enemy;
	import object.enemy.EnemyHandler;
	import object.pickup.Beer;
	import object.pickup.Cup;
	import object.pickup.Football;
	import object.pickup.Pickup;
	import object.pickup.PickupHandler;
	import object.pickup.Pizza;
	import object.pickup.Snus;
	import object.player.Player;
	import object.player.PlayerHandler;
	import object.player.PlayerOne;
	import object.player.PlayerTwo;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	import ui.HUD;

	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	public class GameState extends DisplayState {
		
		// --------------------------------------------------------
		// Public Statics
		// --------------------------------------------------------
		public static var _backgroundLayer:DisplayStateLayer;
		public static var _hudLayer:DisplayStateLayer;
		public static var _gameObjectLayer:DisplayStateLayer;
		public static var _pickupLayer:DisplayStateLayer;
		public static var _playerLayer:DisplayStateLayer;
		
		// --------------------------------------------------------
		// Internal Properties
		// --------------------------------------------------------
		internal var enemyHandler:EnemyHandler;
		internal var playerHandler:PlayerHandler;
		internal var pickupHandler:PickupHandler;
		internal var angryNerdHandler:AngryNerdHandler;
		internal var gameManager:GameManager;
		internal var hud:HUD;
		
		// --------------------------------------------------------
		// Protected Properties
		// --------------------------------------------------------
		protected var _numOfPlayers:int;
		protected var _inGameMusic:SoundObject;
		protected var _pickupSound:SoundObject;
		
		// --------------------------------------------------------
		// Protected Static Constant
		// --------------------------------------------------------
		protected static const DEFAULT_AMOUNT_OF_ENEMIES:int = 4;		
		
		[Embed(source ="../../../asset/sound/InGame.mp3")]
		private static const INGAMEMUSIC:Class;
		
		[Embed(source ="../../../asset/sound/Pickup.mp3")]
		private static const PICKUPSOUND:Class;
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _background:Background;
		private var _gameArea:GameArea;
		
		private var _highscoreList:Vector.<int> = new Vector.<int>();
						
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------
		private static const GAMEMODE_SINGLEPLAYER:String = "singleplayer";
		private static const GAMEMODE_COOP:String = "coop";
		
		private static const LAYER_GAME:String = "game";
		private static const LAYER_PLAYER:String = "player";
		private static const LAYER_BACKGROUND:String = "background";
		private static const LAYER_PICKUP:String = "pickup";
		private static const LAYER_HUD:String = "hud";
		
		// --------------------------------------------------------
		// Constructor method
		// --------------------------------------------------------
		public function GameState() {

		}
		
		// --------------------------------------------------------
		// Override Public Methods
		// --------------------------------------------------------
		override public function init():void {								
			this.initLayers();
			this.initBackground();
			this.initHUD();
			this.initGameArea();
			this.initAngryNerd();
			this.initEnemies();
			this.initPlayers();
			this.initPickups();
			this.initGameManager();
			this.initMusic();
		}
		
		override public function update():void {
			
		}
		
		override public function dispose():void {
			this._gameArea.dispose();
			this._gameArea = null;
				
			this._background.dispose();
			this._background = null;

			this.hud.dispose();			
			this.hud = null;
			
			this.enemyHandler.dispose();
			this.enemyHandler = null;
			
			this.playerHandler.dispose();
			this.playerHandler = null;
			
			this.pickupHandler.dispose();
			this.pickupHandler = null;
			
			this.angryNerdHandler.dispose();
			this.angryNerdHandler = null;
						
			this._inGameMusic.dispose();
			this._inGameMusic = null;
			
			this.gameManager = null;
			
			_backgroundLayer = null;
			_hudLayer = null;
			_gameObjectLayer = null;
			_pickupLayer = null;
			_playerLayer = null;
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
		protected function checkCollision(player:Player):void {
			
		}
		
		/**
		 *	Kollisionshantering mellan spelare och fiende
		 * 
		 * 	@param	Enemy
		 * 	@param	Rectangle
		 * 	@return	void
		 */
		protected function enemyCollision(enemy:Enemy, enemyBox:Rectangle):void {
			if(!enemy._isDead && enemy._isVulnerable) {				
				enemy.dead(gameManager);
				
				gameManager.calculateScore(enemy.point);
				gameManager.kills++;
			}
		}
		
		/**
		 *	Kollisionshantering mellan spelare och föremål
		 * 
		 * 	@param	Pickup
		 * 	@param	Player
		 * 	@return	void
		 */
		protected function pickupCollision(pickup:Pickup, player:Player):void {
			this._pickupSound.play();
			this.pickupHandler.remove(pickup);
			this.setHoldingItems(pickup, player);
		}
		
		/**
		 *	Kollisionshantering mellan spelare och angrynerd
		 * 
		 * 	@param	Player
		 * 	@return	void
		 */
		protected function angryNerdCollision(player:Player):void {
			
		}
		
		// -------------------------------------------------------
		// Protected Methods
		// -------------------------------------------------------
		
		/**
		 *	Initialiserar singleplayer mode
		 * 
		 * 	@return	void
		 */
		protected function initSingleplayerMode():void {
			this.gameManager.init(GAMEMODE_SINGLEPLAYER);
			this.angryNerdHandler.initSingleplayer();
			this.initHighscoreText(GAMEMODE_SINGLEPLAYER);
			
			pickupHandler.wantedItems = angryNerdHandler.wanteditem;
		}
		
		/**
		 *	Initialiserar coop mode
		 * 
		 * 	@return	void
		 */
		protected function initCoopMode():void {
			this.gameManager.init(GAMEMODE_COOP);
			this.angryNerdHandler.initCoop();
			this.initHighscoreText(GAMEMODE_COOP);
			
			pickupHandler.wantedItems = angryNerdHandler.wanteditem;
		}
		
		/**
		 *	Återställer spelarens föremål
		 * 
		 * 	@return	void
		 */
		protected function resetHoldingItems():void {
			for(var i:int = 0; i < playerHandler.players.length; i++) {
				playerHandler.players[i].holdingItem = "";
			}
		}
		
		/**
		 *	Applicerar föremål på spelaren
		 * 	
		 * 	@param	Pickup
		 * 	@param	Player
		 * 	@return	void
		 */
		private function setHoldingItems(pickup:Pickup, player:Player):void {
			
			switch(pickup) {
				case pickup as Beer:
					if (player is PlayerOne) player.holdingItem = "beer";
					if (player is PlayerTwo) player.holdingItem = "beer";
					break;
				case pickup as Cup:
					if (player is PlayerOne) player.holdingItem = "cup";
					if (player is PlayerTwo) player.holdingItem = "cup";
					break;
				case pickup as Pizza:
					if (player is PlayerOne) player.holdingItem = "pizza";
					if (player is PlayerTwo) player.holdingItem = "pizza";
					break;
				case pickup as Football:
					if (player is PlayerOne) player.holdingItem = "football";
					if (player is PlayerTwo) player.holdingItem = "football";
					break;
				case pickup as Snus:
					if (player is PlayerOne) player.holdingItem = "snus";
					if (player is PlayerTwo) player.holdingItem = "snus";
					break;
				default:
					//player.holdingItem = "";
					break;
			}
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
				
		/**
		 * 	Initialiserar lager
		 * 
		 * 	@return void
		 */
		private function initLayers():void {
			_backgroundLayer = layers.add(LAYER_BACKGROUND);
			_hudLayer = layers.add(LAYER_HUD);
			_gameObjectLayer = layers.add(LAYER_GAME);
			_pickupLayer = layers.add(LAYER_PICKUP);
			_playerLayer = layers.add(LAYER_PLAYER);
		}
		
		/**
		 * 	Skapar bakgrund och lägger till på skärmen
		 * 
		 * 	@return void
		 */
		private function initBackground():void {
			this._background = new Background();
			_backgroundLayer.addChild(this._background);
		}
		
		/**
		 * 	Skapar spelbana och lägger på skärmen
		 * 
		 * 	@return void
		 */
		private function initHUD():void {
			this.hud = new HUD();
			_hudLayer.addChild(this.hud);
		}
		
		/**
		 *	Initialiserar spelplan
		 * 
		 * 	@return	void
		 */
		private function initGameArea():void {
			this._gameArea = new GameArea();
			_gameObjectLayer.addChild(this._gameArea);
		}
				
		/**
		 *	Initialiserar hanterare för spelare
		 * 
		 * 	@return	void
		 */
		private function initPlayers():void {
			this.playerHandler = new PlayerHandler(_playerLayer);
		}
		
		/**
		 *	Initialiserar fiendehanterare
		 * 
		 * 	@return	void
		 */
		private function initEnemies():void {
			this.enemyHandler = new EnemyHandler(_gameObjectLayer);
		}
		
		/**
		 *	Initialiserar föremålshanterare
		 * 
		 * 	@return	void
		 */
		private function initPickups():void {
			this.pickupHandler = new PickupHandler(_pickupLayer);
			this.pickupHandler.init();
		}
		
		/**
		 *	Initialiserar hanterare för angrynerd
		 * 
		 * 	@return	void
		 */
		private function initAngryNerd():void {
			this.angryNerdHandler = new AngryNerdHandler(_gameObjectLayer);
		}
		
		/**
		 *	Initialiserar gamemanager
		 * 
		 * 	@return	void
		 */
		private function initGameManager():void {
			this.gameManager = new GameManager(hud, playerHandler, enemyHandler, pickupHandler);
		}
		
		/**
		 *	Initialiserar ljud
		 * 
		 * 	@return	void
		 */
		private function initMusic():void {
			Session.sound.musicChannel.sources.add("ingame", INGAMEMUSIC);
			this._inGameMusic = Session.sound.musicChannel.get("ingame");
			this._inGameMusic.play(999);
			
			Session.sound.soundChannel.sources.add("pickup", PICKUPSOUND);
			this._pickupSound = Session.sound.soundChannel.get("pickup");
		}
		
		/**
		 *	Hömtar det högsta värdet av highscore-listan från server
		 * 
		 * 	@param	String
		 * 	@return	void
		 */
		private function initHighscoreText(_mode:String):void {
			if(_mode == "singleplayer") Session.highscore.receive(0, 1, onHighscoreReceiveComplete);
			if(_mode == "coop")			Session.highscore.receive(1, 1, onHighscoreReceiveComplete);
		}
		
		/**
		 *	Callback-funktion som aktiveras när data hämtats från server
		 * 	Lägger till highscore-vördet till highscore-räknaren
		 * 
		 * 	@param	XML
		 * 	@return	void
		 */
		private function onHighscoreReceiveComplete(data:XML):void {
			this.hud.highscoreCounter.score = data.child("items").child("item").child("score");
		}
	}
}