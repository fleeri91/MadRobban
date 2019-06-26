package component.highscore {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	
	/**
	 *	Publik klass för en highscore tabell
	 */
	public class HighscoreTable extends Sprite {
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _rows:Vector.<HighscoreRow> = new Vector.<HighscoreRow>();
		private var _header:TextField;
		
		// --------------------------------------------------------
		// Private Statics
		// --------------------------------------------------------
		private static const DEFAULT_BACKGROUND_WIDTH:int = 500;
		private static const DEFAULT_BACKGROUND_HEIGHT:int = 400;
		private static const DEFAULT_BACKGROUND_COLOR:uint = 0x000000;
		private static const DEFAULT_HEADER_PADDING:int = 10;
		private static const DEFAULT_FONT:String = "8-Bit Madness";
		private static const DEFAULT_FONTSIZE:int = 64;
		private static const DEFAULT_FONTCOLOR:uint = 0xF9045C;
		
		// --------------------------------------------------------
		// Public Getters & Setters
		// --------------------------------------------------------
		
		/**
		 *	Setter ...
		 * 
		 * 	@param	XML
		 * 	@return void
		 */
		public function set data(value:XML):void {
			if (value.items.length() > 0) populateHighscoreRows(value);
		}

		/**
		 *	Setter ...
		 * 
		 * 	@param 	String
		 * 	@return void
		 */
		public function set header(value:String):void {
			_header.text = value.toLocaleUpperCase();
		}
		
		/**
		 *	Getter ...
		 * 
		 * 	@return String
		 */
		public function get header():String {
			return _header.text;
		}
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function HighscoreTable() {
			this.init();
		}
		
		public function dispose():void {
			disposeHighscoreRows();
		}
		
		private function init():void {
			initBackground();
			initHighscoreHeader();
			initHighscoreRows();
		}
		
		/**
		 *	Initialiserar bakgrunden
		 * 
		 * 	@return void
		 */
		private function initBackground():void {
			this.graphics.beginFill(DEFAULT_BACKGROUND_COLOR);
			this.graphics.drawRoundRect(this.x, this.y, DEFAULT_BACKGROUND_WIDTH, DEFAULT_BACKGROUND_HEIGHT, 50, 50);
			this.graphics.endFill();
		}
		
		/**
		 *	Initialiserar rubriken för tabellen
		 * 
		 * 	@return void
		 */
		private function initHighscoreHeader():void {
			_header = new TextField();
			_header.defaultTextFormat = textFormat();
			_header.backgroundColor = DEFAULT_BACKGROUND_COLOR;
			_header.background = true;
			_header.embedFonts = true;
			_header.x = 50;
			_header.y = 5;
			_header.width  = 400;
			_header.height = 50;
			addChild(_header);
		}
		
		/**
		 *	Initialiserar tabellens rader
		 * 
		 * 	@return void
		 */
		private function initHighscoreRows():void {
			for (var i:int = 0; i < 10; i++) {
				initHighscoreRow(i);
			}
		}
		
		/**
		 *	Initialiserar en specifik rad i tabellen
		 * 
		 * 	@param	int
		 * 	@return void
		 */
		private function initHighscoreRow(index:int):void {
			var row:HighscoreRow = new HighscoreRow();
			row.y = (index * row.height) + (_header.height + DEFAULT_HEADER_PADDING);
			row.x = DEFAULT_HEADER_PADDING;
			row.name = "NAME";
			row.position = index + 1;
			row.score = 0;
			
			_rows.push(row);
			addChild(row);
		}
		
		/**
		 *	Disponerar tabellens rader
		 * 
		 * 	@return void
		 */
		private function disposeHighscoreRows():void {
			for (var i:int = 0; i < _rows.length; i++) {
				disposeHighscoreRow(i);
			}
			
			_rows.length = 0;
		}
		
		/**
		 *	Disponerar en specifik rad i tabellen
		 * 
		 * 	@param	int
		 * 	@return void
		 */
		private function disposeHighscoreRow(index:int):void {
			_rows[index].dispose();
			_rows[index] = null;
			_rows.splice(index, 1);
		}
		
		/**
		 *	...
		 * 	
		 * 	@param	XML
		 * 	@return void
		 */
		private function populateHighscoreRows(data:XML):void {
			for (var i:int = 0; i < data.items.item.length(); i++) {
				_rows[i].position = i + 1;
				_rows[i].name = data.items.item[i].name;
				_rows[i].score = data.items.item[i].score;
			}
		}
		
		/**
		 *	Skapar ett nytt textformat
		 * 
		 * 	@return TextFormat
		 */
		private function textFormat():TextFormat {
			var _format:TextFormat = new TextFormat();
			_format.size = DEFAULT_FONTSIZE;
			_format.color = DEFAULT_FONTCOLOR;
			_format.font = DEFAULT_FONT;
			_format.align = TextFormatAlign.CENTER;
			return _format;
		}
	}
}