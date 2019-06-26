package object.player {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import se.lnu.stickossdk.fx.Flicker;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
	import component.Character;
	
	import object.platform.Ground;
		
		
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 *	Public klass som ligger till grund för alla spelare
	 * 	Klassen ärver funktionalitet från klassen Character
	 */
	public class Player extends Character {
	
		// --------------------------------------------------------
		// Public Properties
		// --------------------------------------------------------				
		public var _isAttacking:Boolean = false;
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------	
		private var _weaponHitbox:Sprite = new Sprite();
		private var _controls:EvertronControls = new EvertronControls();
		
		private var _canAttack:Boolean = true;
		
		private var _timerIgnorePlatform:Timer;
		private var _timerTakenDamage:Timer;
		
		private var _weaponSound:SoundObject;
		private var _damageSound:SoundObject;
		
		private var _beer:Bitmap;
		private var _cup:Bitmap;
		private var _pizza:Bitmap;
		private var _football:Bitmap;
		private var _snus:Bitmap;
		
		// --------------------------------------------------------
		// Protected Properties
		// --------------------------------------------------------	
		protected var _holdingItem:String = "";
		protected var _holdingItemData:BitmapData;
		protected var _holdingItemPlaceholder:Bitmap;
		
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------
		private static const DEFAULT_IGNOREPLATFORMTIME:uint = 200;
		private static const DEFAULT_IMMUNETIMER:int = 1000;
		private static const DEFAULT_PENALTY_SLOWDOWN:Number = 2;
		
		// ------------------------------
		// Embedded Classes
		// ------------------------------
		[Embed(source ="../../../asset/sound/Weapon.mp3")]
		private static const WEAPON:Class;
		
		[Embed(source ="../../../asset/sound/Damage.mp3")]
		private static const TAKEDAMAGE:Class;

		[Embed(source="../../../asset/png/Beer.png")]
		private static const BEER:Class;
		
		[Embed(source="../../../asset/png/Cup.png")]
		private static const CUP:Class;
		
		[Embed(source="../../../asset/png/Pizza.png")]
		private static const PIZZA:Class;
		
		[Embed(source="../../../asset/png/Football.png")]
		private static const FOOTBALL:Class;
		
		[Embed(source="../../../asset/png/Snus.png")]
		private static const SNUS:Class;
		
		// --------------------------------------------------------
		// Public Getter & Setter
		// --------------------------------------------------------
				
		/**
		 *	Getter som returnerar strängen för det föremål spelaren håller i
		 * 
		 * 	@return String
		 */
		public function get holdingItem():String {
			return _holdingItem;
		}
		
		/**
		 *	Setter för det föremål spelaren håller i
		 * 
		 * 	@param	String
		 * 	@return void
		 */
		public function set holdingItem(item:String):void {
			this._holdingItem = item;
			this.setHoldingItem(_holdingItem);
		}
		
		/**
		 *	Setter för spelarens riktning
		 * 
		 * 	@param	int
		 * 	@return void
		 */
		public function set direction(direction:int):void {
			this._skin.scaleX = direction;
		}
		
		/**
		 *	Getter som returnerar vapnets träffyta
		 * 
		 * 	@return Sprite
		 */
		public function get weaponhitbox():Sprite {
			return _weaponHitbox;
		}
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function Player(hitbox:Rectangle, hitboxFeet:Rectangle, startPosition:Point, runSpeed:int, jumpForce:Number, controls:int = 0) {		
			super(hitbox, hitboxFeet, runSpeed, jumpForce);
			
			this._controls.player = controls;
		}
		
		// --------------------------------------------------------
		// Override Public Methods
		// --------------------------------------------------------	
		override public function init():void {
			this.createWeaponHitbox();
			this.initSound();
			this.initItems();
		}
		
		override public function update():void {
			super.update();
					
			this.updateControls();	
			this.updateAnimation();
			this.screenWrapAround();
		}
		
		override public function dispose():void {
			super.dispose();
			
			this._controls = null;
			this._weaponHitbox = null;
			this._weaponSound = null;
			
			this._holdingItemPlaceholder = null;
			this._holdingItemData = null;
			this._cup = null;
			this._beer = null;
			this._pizza = null;
			this._snus = null;
			this._football = null;
		}
						
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------		
		
		/**
		 * 	Initialiserar ljud
		 * 
		 * 	@return void
		 */
		private function initSound():void {
			Session.sound.soundChannel.sources.add("weapon", WEAPON);
			this._weaponSound = Session.sound.soundChannel.get("weapon");
			
			Session.sound.soundChannel.sources.add("damage", TAKEDAMAGE);
			this._damageSound = Session.sound.soundChannel.get("damage");
		}
		
		/**
		 * 	Initialiserar förmål
		 * 
		 * 	@return void
		 */
		private function initItems():void {
			this._beer = new BEER();
			this._cup = new CUP();
			this._pizza = new PIZZA();
			this._football = new FOOTBALL();
			this._snus = new SNUS();
		}
		
		/**
		 * 	Skapar träffytan för vapnet
		 * 
		 * 	@return void
		 */
		private function createWeaponHitbox():void {
			this._weaponHitbox.graphics.drawRect(20, 16, 24, 10);
			this.addChild(this._weaponHitbox);
		}
		
		/**
		 * 	Uppdaterar spelarens animationer
		 * 
		 * 	@return void
		 */
		private function updateAnimation():void {
			
			if(this._velocity.x == 0 && !this._isAttacking)
				this._skin.gotoAndStop("idle");
			
			if(!this._velocity.x == 0 && !this._isAttacking)
				this._skin.gotoAndStop("run");
			
			if(!this._isGrounded && !this._isAttacking)
				this._skin.gotoAndStop("jump");
			
			if(this._isAttacking) {
				this._skin.gotoAndStop("attack");
				var child:MovieClip = this._skin.getChildAt(0) as MovieClip;
				if(child.currentFrame == child.totalFrames)
					this._isAttacking = false;
			}
			
			if(this._skin.scaleX == 1) this._weaponHitbox.scaleX = 1;
			if(this._skin.scaleX == -1) this._weaponHitbox.scaleX = -1;
		}
								
		/**
		 * 	Uppdaterar spelarens kontroller
		 * 
		 * 	@return void
		 */
		private function updateControls():void {
			if (Input.keyboard.justPressed (_controls.PLAYER_BUTTON_2))			
				this.m_jump();
			
			if (Input.keyboard.justPressed (_controls.PLAYER_BUTTON_1) && !this._isAttacking && this._canAttack)
				this.m_attack();
			
			if (Input.keyboard.pressed (_controls.PLAYER_RIGHT)) 	
				this.m_moveRight();
			
			if (Input.keyboard.pressed (_controls.PLAYER_LEFT))  	
				this.m_moveLeft();
			
			if (Input.keyboard.justPressed (_controls.PLAYER_DOWN) && !this._isIgnoringPlatform && this._isGrounded)  	
				this.ignorePlatform();
		}
		
		/**
		 *	Hanterar så att spelaren kan komma ut på andra sidan av skärmen när spelaren befinner sig utanför spelplanen
		 * 
		 *	@return	void
		 */
		private function screenWrapAround():void {
			
			if (this.x >= (800 + this._hitbox.width)) 	this.x = 0 - this._hitbox.width;
			else if (this.x <= (0 - _hitbox.width))		this.x = 800 + this._hitbox.width;
		}
											
		/**
		 * 	Spelare attackerar
		 * 
		 * 	@return void
		 */
		private function m_attack():void {
			this._isAttacking = true;
			this._weaponSound.play();
		}
				
		/**
		 *	Spelare ignorera plattform genom att applicera en timer där spelare ej kan kollidera
		 * 	med plattform, gäller ej marken (ground)
		 * 
		 *	@return void
		 */
		private function ignorePlatform():void {
			
			if(this._currentPlatform is Ground)
				return;
			
			this._isIgnoringPlatform = true;
			this._timerIgnorePlatform = Session.timer.create(DEFAULT_IGNOREPLATFORMTIME, stopIgnoringPlatform);
		}
		
		/**
		 *	Stoppar och nollställer timern för att ignorera plattform
		 * 
		 *	@return void
		 */
		private function stopIgnoringPlatform():void {
			this._isIgnoringPlatform = false;
			Session.timer.remove(_timerIgnorePlatform);
		}
		
		/**
		 *	Spelare tar skada
		 * 	Spelaren blir immun mot skada och kan inte attackera tills blink-effekten försvinner
		 * 
		 * 	@return	void
		 */
		public function takeDamage():void {
			
			if(this._isImmune)
				return;
			
			this._damageSound.play();
			this._canAttack = false;
			this._runSpeed = DEFAULT_PENALTY_SLOWDOWN;
			this._isImmune = true;
			this._timerTakenDamage = Session.timer.create(DEFAULT_IMMUNETIMER, stopImmuneTimer);
			Session.effects.add(new Flicker(this._skin, DEFAULT_IMMUNETIMER, 36, true));
		}
		
		/**
		 *	Stoppar och nollställer timern så att spelaren kan ta skada igen
		 * 
		 * 	@return void
		 */
		private function stopImmuneTimer():void {
			this._canAttack = true;
			this._isImmune = false;
			this._runSpeed = 5;
			
			Session.timer.remove(_timerTakenDamage);
		}
		
		// --------------------------------------------------------
		// Protected Methods
		// --------------------------------------------------------		
		
		/**
		 *	Applicerar föremål för placeholdern ovanför spelaren
		 * 
		 * 	@param	String
		 * 	@return	void
		 */
		protected function setHoldingItem(item:String):void {
			
			this._holdingItem = item;
			
			switch(item) {
				case item = "beer":
					_holdingItemPlaceholder.bitmapData = _beer.bitmapData;
					break;
				case item = "cup":
					_holdingItemPlaceholder.bitmapData = _cup.bitmapData;
					break;
				case item = "pizza":
					_holdingItemPlaceholder.bitmapData = _pizza.bitmapData;
					break;
				case item = "football":
					_holdingItemPlaceholder.bitmapData = _football.bitmapData;
					break;
				case item = "snus":
					_holdingItemPlaceholder.bitmapData = _snus.bitmapData;
					break;
				case item = "":
					_holdingItemPlaceholder.bitmapData = null;
					break;
			}
		}
	}
}