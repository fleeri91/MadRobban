package object.pickup {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	import object.pickup.Beer;
	import object.pickup.Cup;
	import object.pickup.Football;
	import object.pickup.Pizza;
	import object.pickup.Snus;
	
	import se.lnu.stickossdk.system.Session;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	
	/**
	 * 	Publik klass som hanterar alla föremål
	 */
	public class PickupHandler {
		
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _target:DisplayObjectContainer;	
		private var _pickupItems:Vector.<Pickup> = new Vector.<Pickup>();	
		private var _itemPool:Vector.<Pickup> = new Vector.<Pickup>();
		private var _inactivePos:Point = new Point(-200, -200);
		
		private var _angryNerdItems:Vector.<String> = new Vector.<String>();
		
		private var cup:Pickup = new Cup();
		private var beer:Pickup = new Beer();
		private var pizza:Pickup = new Pizza();
		private var football:Pickup = new Football();
		private var snus:Pickup = new Snus();
		
		
		// ------------------------------------------------------------
		// Public Getter & Setter
		// ------------------------------------------------------------	
		
		/**
		 * 	Getter som returnerar föremål
		 * 
		 * 	@return Vector.<Pickup>
		 */
		public function get pickups():Vector.<Pickup> {
			return _pickupItems;
		}
		
		/**
		 *	Setter för begärda föremål
		 * 
		 * 	@param	Vector.<Strin>
		 * 	@return	void
		 */
		public function set wantedItems(items:Vector.<String>):void {
			for(var i:int = 0; i < items.length; i++) {
				this._angryNerdItems.push(items[i]);
			}
		}
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function PickupHandler(displayTarget:DisplayObjectContainer) {
			this._target = displayTarget;
		}
		
		// --------------------------------------------------------
		// Public Methods
		// --------------------------------------------------------
		
		/**
		 * 	Initialiserar föremålshanteraren
		 * 
		 * 	@return void
		 */
		public function init():void {
					
			this._itemPool.push(cup, beer, pizza, football, snus);
			
			for each(var item:Pickup in _itemPool) {
				
				item.x = this._inactivePos.x;
				item.y = this._inactivePos.y;
				item.scaleX = 0;
				item.scaleY = 0;
				
				this._target.addChild(item);
			}
		}
		
		/**
		 * 	Skapar ett föremål
		 * 
		 * 	@param	int
		 * 	@param	int
		 * 	@return	Pickup
		 */
		public function add(xPos:int, yPos:int):Pickup {
			return createItem(xPos, yPos);
		}
		
		/**
		 * 	Tar bort ett föremål och lägger tillbaka det i poolen för föremål
		 * 
		 * 	@param 	Pickup
		 * 	@return	void
		 */
		public function remove(item:Pickup):void {
			
			item._isActive = false;
			
			var index:int = this._pickupItems.indexOf(item);
			
			this._pickupItems.splice(index, 1);
			this._target.removeChild(item);
			this.setItem(item);
		}
		
		/**
		 * 	Återställer föremål
		 * 
		 * 	@return void
		 */
		public function resetItems():void {
			for(var i:int = 0; i < _itemPool.length; i++) {
				_itemPool[i]._isActive = false;
			}
		}
		
		/**
		 * 	Disponering
		 * 
		 * 	@return	void
		 */
		public function dispose():void {
			this.disposeItems();
			this.disposePool();
			
			this._inactivePos = null;
			this._itemPool = null;
			this._pickupItems = null;
			this._target = null;
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 *	Disponerar alla föremål
		 * 
		 * 	@return void
		 */
		private function disposeItems():void {
			for(var i:int = 0; i < this._pickupItems.length; i++) {
				this._pickupItems[i] = null;
			}
		}
		
		/**
		 * 	Disponerar poolen för föremål
		 * 
		 * 	@return	void
		 */
		private function disposePool():void {
			for(var i:int = 0; i < this._itemPool.length; i++) {
				this._itemPool[i] = null;
			}
		}
				
		/**
		 * 	Skapar ett föremål vid en position och lägger till det i poolen för föremål
		 * 
		 * 	@param	int
		 * 	@param	int
		 * 	@return	Pickup
		 */
		private function createItem(xPos:int, yPos:int):Pickup {
				
			var item:Pickup;		
			var index:int = 0;
			var wantedItemIndex:int = 0;
			
			if(_angryNerdItems.length == 0)
				return null;
						
			var randomItem:String; 
			randomItem = _angryNerdItems[Math.floor(Math.random() * _angryNerdItems.length)];
			
			switch(randomItem) {
				case randomItem = "beer":
					index = _itemPool.indexOf(beer);
					item = _itemPool[index];
					break;
				case randomItem = "cup":
					index = _itemPool.indexOf(cup);
					item = _itemPool[index];
					break;
				case randomItem = "pizza":
					index = _itemPool.indexOf(pizza);
					item = _itemPool[index];
					break;
				case randomItem = "football":
					index = _itemPool.indexOf(football);
					item = _itemPool[index];
					break;
				case randomItem = "snus":
					index = _itemPool.indexOf(snus);
					item = _itemPool[index];
					break;
				default:
					item = null;
					break;
			}
			
			if(item._isActive)
				return null;
			
			item.x = xPos;
			item.y = yPos + 50;
			item._isActive = true;
			
			Session.tweener.add(item, {
				duration: 200,
				scaleX: 1,
				scaleY: 1
			})
						
			this._pickupItems.push(item);
			
			wantedItemIndex = _angryNerdItems.indexOf(randomItem);
			this._angryNerdItems.splice(wantedItemIndex, 1);
			this._itemPool.splice(index, 1);
						
			return item;
		}
		
		/**
		 * 	Lägger tillbaka föremålet till poolen för föremål
		 * 
		 * 	@return void
		 */
		private function setItem(item:Pickup):void {
			
			item.x = _inactivePos.x;
			item.y = _inactivePos.y;
			item._isActive = false;
			
			Session.tweener.remove(item);
			item.scaleX = 0;
			item.scaleY = 0;
			
			this._itemPool.push(item);
			this._target.addChild(item);
		}
	}
}