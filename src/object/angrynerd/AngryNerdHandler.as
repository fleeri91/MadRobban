package object.angrynerd {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import object.angrynerd.Bubble;
	
	import se.lnu.stickossdk.fx.Flicker;
	import se.lnu.stickossdk.system.Session;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 * 	Publik klass som hanterar AngryNerds logik
	 */
	public class AngryNerdHandler {
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _target:DisplayObjectContainer;
		
		private var _angryNerd:AngryNerd;
		
		private var _bubble:Bubble;
		private var _beer:Bitmap;
		private var _cup:Bitmap;
		private var _pizza:Bitmap;
		private var _football:Bitmap;
		private var _snus:Bitmap;
		
		private var _itemHolder:Vector.<Bitmap> = new Vector.<Bitmap>();
		private var _wantedItem:Vector.<String> = new Vector.<String>();
		private var itemList:Vector.<String> = new Vector.<String>();
		
		private static const DEAFULT_ITEM_PADDING:int = 50;
		
		// --------------------------------------------------------
		// Embedded Class
		// --------------------------------------------------------		
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
		 * 	Getter som returnerar angrynerd
		 * 
		 *	@return String
		 */
		public function get angrynerd():AngryNerd {
			return _angryNerd;
		}
		
		/**
		 * 	Getter som returnerar det begärda föremålet
		 * 
		 *	@return Vector.<String>
		 */
		public function get wanteditem():Vector.<String> {
			return _wantedItem;
		}
					
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function AngryNerdHandler(target:DisplayObjectContainer) {
			this._target = target;
		}
		
		// --------------------------------------------------------
		// Public Methods
		// --------------------------------------------------------		
		
		/**
		 *	Initialiserar singpleyer mode
		 * 
		 * 	@return	void
		 */
		public function initSingleplayer():void {
			this.initNerd();
			this.initBubble();
			this.initItems();
			this.initItemHolder();
			this.generateRandomItem(1);
			
			this._bubble.initSingleplayer();
		}
		
		/**
		 *	Initialiserar coop mode
		 * 
		 * 	@return	void
		 */
		public function initCoop():void {
			this.initNerd();
			this.initBubble();
			this.initItems();
			this.initItemHolders(2);
			this.generateRandomItem(2);
			
			this._bubble.initCoop();
		}
		
		/**
		 *	Spelar upp animation och gömmer tankebubbla
		 * 
		 * 	@return	void
		 */
		public function playAnimation():void {
			
			Session.timer.create(2100, setToIdle);
			this.hideBubble();
			
			var item:String;
			item = this._wantedItem[Math.floor(Math.random()*_wantedItem.length)];
			
			switch(item) {
				case item = "beer":
					this._angryNerd._skin.gotoAndPlay(item);
					break;
				case item = "cup":
					this._angryNerd._skin.gotoAndPlay(item);
					break;
				case item = "pizza":
					this._angryNerd._skin.gotoAndPlay(item);
					break;
				case item = "football":
					this._angryNerd._skin.gotoAndPlay(item);
					break;
				case item = "snus":
					this._angryNerd._skin.gotoAndPlay(item);
					break;
				default:
					break;	
			}
		}
		
		/**
		 *	Genererar ett nytt föremål
		 * 
		 * 	@param	int
		 * 	@return void
		 */
		public function generateRandomItem(amount:int):void {
			
			var index:int;
			this.itemList.length = 0;
			this.itemList.push("beer", "cup", "pizza", "football", "snus");
			
			for(var i:int = 0; i < amount; i++) {
				
				this._wantedItem.splice(i, 2);
				
				var item:String = itemList[Math.floor(Math.random()*itemList.length)];
				index = itemList.indexOf(item);
				itemList.splice(index, 1);
				this._wantedItem.push(item);
			}		
			this.setItem(this._wantedItem);
		}
		
		/**
		 *	Disponerar
		 * 
		 * 	@return void
		 */
		public function dispose():void {
			
			this._angryNerd.dispose();
			this._angryNerd = null;
			
			this._beer = null;
			this._bubble = null;
			this._football = null;
			this._itemHolder = null;
			this._cup = null;
			this._pizza = null;
			this._snus = null;
			this._target = null;
			this._wantedItem = null;
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 *	Initialiserar angrynerd och lägger till det som child-objekt
		 * 
		 * 	@return	void
		 */
		private function initNerd():void {
			this._angryNerd = new AngryNerd();
			this._angryNerd.x = 410 - (this._angryNerd.hitbox.width / 2);
			this._angryNerd.y = 155;
			this._target.addChild(_angryNerd);
		}
		
		/**
		 *	Initialiserar angrynerds tankebubbla och lägger till det som child-objekt
		 * 
		 * 	@return	void
		 */
		private function initBubble():void {
			this._bubble = new Bubble();
			this._bubble.x = 420;
			this._bubble.y = 120;
			this._target.addChild(_bubble);
		}
		
		/**
		 *	Initialiserar föremål
		 * 
		 * 	@return	void
		 */
		private function initItems():void {
			this._beer = new BEER();
			this._cup = new CUP();
			this._pizza = new PIZZA();
			this._football = new FOOTBALL();
			this._snus = new SNUS();
		}
		
		/**
		 *	Initialiserar föremålens placeholders och lägger till dem som child-objekt
		 * 
		 * 	@param	int
		 * 	@return	void
		 */
		private function initItemHolders(mode:int):void {
			
			for(var i:int = 0; i < mode; i++) {
				var bitmap:Bitmap = new Bitmap();
				bitmap.x = 430 - (i*DEAFULT_ITEM_PADDING);
				bitmap.y = 102;
				
				_target.addChild(bitmap);
				_itemHolder.push(bitmap);
			}
		}
		
		/**
		 *	Initialiserar föremålets placeholder för singleplayer
		 * 
		 * 	@return	void
		 */
		private function initItemHolder():void {
			
			var bitmap:Bitmap = new Bitmap();
			bitmap.x = 408;
			bitmap.y = 102;
			
			_target.addChild(bitmap);
			_itemHolder.push(bitmap);
		}
		
		/**
		 *	Applicerar föremål till tankebubblans placeholder
		 * 
		 * 	@return	void
		 */
		private function setItem(items:Vector.<String>):void {
				
			var index:int = 0;
			
			for each(var item:String in items) {
						
				switch(item) {
					case item = "beer":
						_itemHolder[index].bitmapData = this._beer.bitmapData;
						index++;
						break;
					case item = "cup":
						_itemHolder[index].bitmapData = this._cup.bitmapData;
						index++;
						break;
					case item = "pizza":
						_itemHolder[index].bitmapData = this._pizza.bitmapData;
						index++;
						break;
					case item = "football":
						_itemHolder[index].bitmapData = this._football.bitmapData;
						index++;
						break;
					case item = "snus":
						_itemHolder[index].bitmapData = this._snus.bitmapData;
						index++;
						break;
					default:
						_itemHolder[index].bitmapData = null;
						break;	
				}
			}
		}
		
		/**
		 *	Sätter angrynerd till idle-läge och visar tankebubbla
		 * 
		 * 	@return	void
		 */
		private function setToIdle():void {
			this._angryNerd._skin.gotoAndPlay(1);
			this.showBubble();
		}
				
		/**
		 *	Gömmer tankebubbla
		 * 
		 * 	@return	void
		 */
		private function hideBubble():void {
			this._bubble.visible = false;
			
			for(var i:int = 0; i < this._itemHolder.length; i++) {
				this._itemHolder[i].visible = false;
			}
		}
		
		/**
		 *	Visar tankebubbla
		 * 
		 * 	@return	void
		 */
		private function showBubble():void {
			this._bubble.visible = true;
			
			for(var i:int = 0; i < this._itemHolder.length; i++) {
				this._itemHolder[i].visible = true;
			}
		}
	}
}