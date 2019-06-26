package scene {
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.display.Bitmap;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	import asset.MenuBtnsGFX;
	import scene.HighscoreState;
	import scene.tutorial.SinglePlayerTutorialState;
	import scene.tutorial.CoopTutorialState;
	
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------
	public class MenuState extends DisplayState {
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _background:Bitmap;
		private var _menuBtns:MenuBtnsGFX;
		private var _btnIndex:int = 1;
		
		private var _menuMusic:SoundObject;
		private var _selectSound:SoundObject;
		
		private var _controls:EvertronControls = new EvertronControls;
		
		private var _menuLayer:DisplayStateLayer;
		
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------
		private static const LAYER_BACKGROUND:String = "menu";
		
		// --------------------------------------------------------
		// Embedded Classes
		// --------------------------------------------------------
		[Embed(source="../../asset/png/MenuBackground.png")]
		public static const BACKGROUND:Class;
		
		[Embed(source = "../../asset/sound/startGame.mp3")]
		private const STARTGAME:Class;
		
		[Embed(source = "../../asset/sound/Select.mp3")]
		private const SELECT:Class;
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function MenuState() {

		}
		
		// --------------------------------------------------------
		// Override Public Methods
		// --------------------------------------------------------
		override public function init():void {
			this.initLayers();
			this.initBackground();
			this.initMenuButtons();
			this.initMenuSound();
		}
		
		override public function update():void {
			this.updateControls();
		}
		
		override public function dispose():void {
			this._background = null;
			this._menuBtns = null;
			this._controls = null;
			this._menuLayer = null;
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		
		/**
		 * 	Initialiserar ljud
		 * 
		 * 	@return void
		 */
		private function initMenuSound():void {
			Session.sound.masterChannel.sources.add("startgame", STARTGAME);
			this._menuMusic = Session.sound.masterChannel.get("startgame");
			
			if(!this._menuMusic.isPlaying) 
				this._menuMusic.play(999);
			
			Session.sound.soundChannel.sources.add("select", SELECT);
			this._selectSound = Session.sound.soundChannel.get("select");
		}
		
		/**
		 * 	Initialiserar lager
		 * 
		 * 	@return void
		 */
		private function initLayers():void {
			this._menuLayer = this.layers.add(LAYER_BACKGROUND);
		}
		
		/**
		 * 	Initialiserar bakgrund
		 * 
		 * 	@return void
		 */
		private function initBackground():void {
			this._background = new BACKGROUND();
			this._menuLayer.addChild(this._background);
		}
		
		/**
		 * 	Initialiserar knappar för meny
		 * 
		 * 	@return void
		 */
		private function initMenuButtons():void {
			this._menuBtns = new MenuBtnsGFX();
			this._menuBtns.x = (Session.application.width - this._menuBtns.width) / 2;
			this._menuBtns.y = (Session.application.height - this._menuBtns.height) / 1.1;
			this._menuLayer.addChild(this._menuBtns);
			
			this._menuBtns.gotoAndStop(this._btnIndex);
		}
		
		/**
		 * 	Menyval nedåt
		 * 
		 * 	@return void
		 */
		private function selectDown():void {
			
			if(this._btnIndex == 3)
				return;
			
			this._btnIndex += 1;
			this._menuBtns.gotoAndStop(this._btnIndex);
			this._selectSound.play();
		}
		
		/**
		 * 	Menyval uppåt
		 * 
		 * 	@return void
		 */
		private function selectUp():void {
		
			if(this._btnIndex == 1)
				return;
			
			this._btnIndex -= 1;
			this._menuBtns.gotoAndStop(this._btnIndex);
			this._selectSound.play();
		}
		
		/**
		 * 	Menyval som startar ett nytt tillstånd
		 * 	Kollar efter menyknapparnas label	
		 * 
		 * 	@return void
		 */
		private function select():void {
			
			if(this._menuBtns.currentLabel == "singleplayer") {
				Session.application.displayState = new SinglePlayerTutorialState();
				this._menuMusic.stop();
			}
			
			if(this._menuBtns.currentLabel == "coop") {
				Session.application.displayState = new CoopTutorialState();
				this._menuMusic.stop();
			}
						
			if(this._menuBtns.currentLabel == "highscore") {
				Session.application.displayState = new HighscoreState();
			}
		}
		
		/**
		 * 	Uppdaterar kontroller
		 * 
		 * 	@return void
		 */
		private function updateControls():void {
			if(Input.keyboard.justPressed(this._controls.PLAYER_BUTTON_1))
				this.select();
			
			if(Input.keyboard.justPressed(this._controls.PLAYER_UP))
				this.selectUp();
			
			if(Input.keyboard.justPressed(this._controls.PLAYER_DOWN))
				this.selectDown();
		}
	}
}