package scene.game {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import asset.GameOverBtnsGFX;
	import asset.GameOverAnimationGFX;
	
	import component.highscore.Highscore;
	
	import object.background.Background;
	
	import scene.MenuState;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.fx.Flash;
	import se.lnu.stickossdk.fx.Shake;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	
	/**
	 *	Speltillstånd när spelet är över
	 */
	public class GameOverState extends DisplayState {
		
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------	
		private var _menuBtns:GameOverBtnsGFX;
		private var _gameOverAnimation:GameOverAnimationGFX;
		
		private var _finishedPlaying:Boolean;
		
		private var _backgroundLayer:DisplayStateLayer;
		private var _highscoreLayer:DisplayStateLayer;
		private var _gameOverTextLayer:DisplayStateLayer;
		
		private var _btnIndex:int = 1;
		private var _controls:EvertronControls = new EvertronControls();
		private var _mode:String;
		private var _points:int;
		private var _highscore:Highscore;
		private var _gameOverText:TextField = new TextField();
		
		private var _timerHighscore:Timer;
		
		private var _controlsActive:Boolean;
		
		private var _background:Background;
		
		private var _gameOverMusic:SoundObject;
		
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------	
		private static const LAYER_BACKGROUND:String = "background";
		private static const LAYER_HIGHSCORE:String = "highscore";
		private static const LAYER_TEXT:String = "text";
		private static const DEFAULT_GAMEOVER_TIME:uint = 2000;
		
		// --------------------------------------------------------
		// Embedded Sounds
		// --------------------------------------------------------	
		[Embed(source ="../../../asset/sound/EndGame.mp3")]
		private static const GAMEOVERMUSIC:Class;
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------	
		public function GameOverState(mode:String, points:int) {
			this._mode = mode;
			this._points = points;
		}
		
		// --------------------------------------------------------
		// Public Override Methods
		// --------------------------------------------------------	
		override public function init():void {			
			this.initLayers();
			this.initMusic();
			this.initHighscore();
			this.initGameOverButtons();
			this.initGameOverAnimation();
		}
		
		override public function update():void {
			
			this.updateAnimation();
			
			if(!this._controlsActive)
				return;
			
			this.updateControls();
		}
		
		override public function dispose():void {	
			this._highscore.dispose();
			this._highscore = null;
						
			this._gameOverMusic.dispose();
			this._gameOverMusic = null;
			
			this._controls = null;
			this._gameOverText = null;
			this._menuBtns = null;
			
			this._backgroundLayer = null;
			this._gameOverTextLayer = null;
			this._highscoreLayer = null;
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------	
		
		/**
		 *	Initialiserar ljud
		 * 
		 *	@return	void
		 */
		private function initMusic():void {
			Session.sound.musicChannel.sources.add("gameover", GAMEOVERMUSIC);
			this._gameOverMusic = Session.sound.musicChannel.get("gameover");
		}
		
		/**
		 *	Uppdaterar kontroller
		 * 
		 *	@return	void
		 */
		private function updateControls():void {
			
			if(Input.keyboard.justPressed(this._controls.PLAYER_BUTTON_1))
				this.select();
			
			if(Input.keyboard.justPressed(this._controls.PLAYER_LEFT))
				this.selectUp();
			
			if(Input.keyboard.justPressed(this._controls.PLAYER_RIGHT))
				this.selectDown();
		}
		
		/**
		 *	Initialiserar lager
		 * 
		 *	@return	void
		 */
		private function initLayers():void {
			this._backgroundLayer = layers.add(LAYER_BACKGROUND);
			this._highscoreLayer = layers.add(LAYER_HIGHSCORE);
			this._gameOverTextLayer = layers.add(LAYER_TEXT);
		}
		
		/**
		 *	Initialiserar animation för gameover
		 * 
		 *	@return	void
		 */
		private function initGameOverAnimation():void {
			this._gameOverAnimation = new GameOverAnimationGFX();
			this._gameOverAnimation.x = (Session.application.size.x >> 1);
			this._gameOverAnimation.y = (Session.application.size.y >> 1);	
			this._backgroundLayer.addChild(_gameOverAnimation);
		}
		
		/**
		 *	Uppdaterar animation för gameover
		 * 
		 *	@return	void
		 */
		private function updateAnimation():void {
			var child:MovieClip = _gameOverAnimation.getChildAt(1) as MovieClip;
			if(child.currentFrame == child.totalFrames && !this._finishedPlaying) {
				child.stop();
				
				this._finishedPlaying = true;
				this._gameOverMusic.play(999);
				this.smartSendHighscore(_mode);
			}
			
			if(child.currentFrame == 77) {
				Session.effects.add(new Flash(_backgroundLayer, 1000, 0xFFFFFF, new Rectangle(0, 0, 800, 600)));
				Session.effects.add(new Shake(_backgroundLayer, 1000, new Point(10, 10), new Point(0, 0)));
			}	
		}
		
		/**
		 *	Initialiserar highscore-list
		 * 
		 *	@return	void
		 */
		private function initHighscore():void {
			this._highscore = new Highscore(_mode);				
			this._highscore.cacheAsBitmap = true;
			this._highscore.x = (Session.application.size.x >> 1) - (this._highscore.width >> 1);
			this._highscore.y = -500;
			this._highscoreLayer.addChild(_highscore);
		}
		
		/**
		 *	Visar highscore-lista
		 * 
		 *	@return	void
		 */
		private function showHighscore():void {
			
			this._controlsActive = true;
						
			Session.tweener.add(_highscore, {
				duration: 500,
				y: 100
			});
			
			Session.tweener.add(_menuBtns, {
				duration: 500,
				alpha: 1,
				y: 525
			});
			
			Session.tweener.add(_gameOverText, {
				duration: 500,
				y: 1000
			});
			
			this._controlsActive = true;
		}
				
		/**
		 *	Skickar data till server
		 * 
		 * 	@param	String
		 *	@return	void
		 */
		private function smartSendHighscore(mode:String):void {
			if(mode == "singleplayer") 	Session.highscore.smartSend(0, _points, 10, onHighscoreComplete);
			if(mode == "coop") 			Session.highscore.smartSend(1, _points, 10, onHighscoreComplete);
		}
		
		/**
		 *	Callback-funktion som aktiveras när data har skickats till servern
		 * 	Uppdaterar och visar highscore-listan	
		 * 
		 * 	@param	XML
		 *	@return	void
		 */
		private function onHighscoreComplete(data:XML):void {
			this._highscore.update();
			showHighscore();
		}
			
		/**
		 *	Initialiserar knappar
		 * 
		 *	@return	void
		 */
		private function initGameOverButtons():void {
			this._menuBtns = new GameOverBtnsGFX();
			this._menuBtns.x = (Session.application.width - this._menuBtns.width) / 2;
			this._menuBtns.y = 0 - _menuBtns.height;
			this._menuBtns.alpha = 0;
			this._highscoreLayer.addChild(this._menuBtns);
			
			this._menuBtns.gotoAndStop(this._btnIndex);
		}
		
		/**
		 *	Hanterar funktionalitet vid knapptryck av menyknapparna
		 * 
		 *	@return	void
		 */
		private function select():void {
			
			if(this._menuBtns.currentLabel == "playagain" && this._mode == "singleplayer") {
				Session.application.displayState = new IntroState("singleplayer");
			}
			
			if(this._menuBtns.currentLabel == "playagain" && this._mode == "coop") {
				Session.application.displayState = new IntroState("coop");
			}
			
			if(this._menuBtns.currentLabel == "mainmenu") {
				Session.application.displayState = new MenuState();
			}
		}
		
		/**
		 *	Hanterar menyval nedåt
		 * 
		 *	@return	void
		 */
		private function selectDown():void {
			
			if(this._btnIndex == 2)
				return;
			
			this._btnIndex += 1;
			this._menuBtns.gotoAndStop(this._btnIndex);
		}
		
		/**
		 *	Hanterar menyval uppåt
		 * 
		 *	@return	void
		 */
		private function selectUp():void {
			
			if(this._btnIndex == 1)
				return;
			
			this._btnIndex -= 1;
			this._menuBtns.gotoAndStop(this._btnIndex);
		}
	}
}