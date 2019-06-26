package ui.timer {
	
	
	// ------------------------------------------------------------
	// Imports
	// ------------------------------------------------------------	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.fx.Flicker;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	
	import ui.timer.TimerBar;
	import ui.timer.TimerFrame;
	
	// ------------------------------------------------------------
	// Public Class
	// ------------------------------------------------------------	
	public class RageTimer extends DisplayStateLayerSprite {
		
		// --------------------------------------------------------
		// Public Properties
		// --------------------------------------------------------
		public var timerBar:TimerBar;
		
		// --------------------------------------------------------
		// Private Properties
		// --------------------------------------------------------
		private var _timerFrame:TimerFrame;
		
		private var _timer:uint;
		private var _maxTime:uint;
		private var _currentTime:Number;
		private var _timePercentage:Number;
		
		private var _flickerActivated:Boolean;
		
		private var _highRageSound:SoundObject;
		
		// --------------------------------------------------------
		// Private Static Constants
		// --------------------------------------------------------
		private static const DEFAULT_FONT_SIZE:int = 26;
		private static const DEFAULT_FONT_COLOR:uint = 0xFFFFFF;
		private static const DEFAULT_FONT_FACE:String = "8-Bit Madness";
		private static const DEFAULT_TEXT_VALUE:String = "0";

		// ------------------------------
		// Audio Imports
		// ------------------------------
		[Embed(source ="../../../asset/sound/HighRage.mp3")]
		private static const HIGHRAGE:Class;
		
		// --------------------------------------------------------
		// Public Getter & Setter
		// --------------------------------------------------------
		
		/**
		 * 	Getter för den återstående tiden
		 * 
		 *	@return Number
		 */
		public function get rage():Number {
			return _currentTime;
		}
		
		/**
		 * 	Setter för den återstående tiden
		 * 
		 *	@return void
		 */
		public function set rage(value:Number):void {
			this._currentTime = value;
		}
		
		/**
		 * 	Getter för den återstående maxtiden
		 * 
		 *	@return Number
		 */
		public function get maxRage():Number {
			return _maxTime;
		}
		
		/**
		 * 	Setter för den återstående tiden
		 * 
		 *	@return void
		 */
		public function set maxRage(value:Number):void {
			this._maxTime = value;
		}
		
		public function get ragePercentage():Number {
			return _timePercentage;
		}
		
		// --------------------------------------------------------
		// Constructor Method
		// --------------------------------------------------------
		public function RageTimer() {
			this.initSound();
			this.initRageTimer();
			this.initFrame();
			
			this.startTimer();
			
			this._maxTime = 20;
			this._currentTime = 0;
		}
		
		override public function dispose():void {
			this._highRageSound = null;
			this._timerFrame = null;
		}
		
		// --------------------------------------------------------
		// Private Methods
		// --------------------------------------------------------
		private function initSound():void {
			Session.sound.soundChannel.sources.add("highrage", HIGHRAGE);
			this._highRageSound = Session.sound.soundChannel.get("highrage");
		}
		
		/**
		 *	Startar timern för nedräkning
		 * 
		 *	@return void
		 */
		private function startTimer():void {
			this._timer = setInterval(countUp, 10);
		}
		
		/**
		 * 	Stoppar timern för nedräkning
		 * 
		 *	@return void
		 */
		private function stopTimer():void {
			clearInterval(_timer);
			this.timerBar.scaleX = 1;
		}
		
		/**
		 * 	Räknar tiden för timern och skalar timer bar beroende på hur mycket tid som återstår.
		 * 	Applicerar blinkeffekt på timer bar om den återstående tiden är under 25%
		 * 	Ändrar animation på ragetimerframe om den återstående tiden är mellan 0 - 49, 50 - 74 & 75 - 100
		 * 
		 *	@return void
		 */
		private function countUp():void {
						
			if(this._currentTime >= this._maxTime) {
				this.stopTimer();
				return;
			}
			
			if(this._timePercentage >= 0 && this._timePercentage <= 0.49)		this._timerFrame.animation = 1;
			if(this._timePercentage >= 0.50 && this._timePercentage <= 0.74)	this._timerFrame.animation = 2;
			
			if(this._timePercentage >= 0.75 && !this._flickerActivated) {
				this._timerFrame.animation = 3
				this._highRageSound.play(999);
				this.startFlickerEffect(10000);
			}	
			
			if(this._timePercentage <= 0.75 && this._flickerActivated) {
				this.stopFlickerEffect();
				this._highRageSound.stop();
			}
				
			if(this._currentTime <= 0)
				this._currentTime = 0;
			
			this._currentTime += 0.0166;
			this._timePercentage = this._currentTime / this._maxTime;
			this.timerBar.scaleX = this._timePercentage;
		}
				
		/**
		 * 	Skapar timer bar
		 * 
		 *	@return void
		 */
		private function initRageTimer():void {
			this.timerBar = new TimerBar();
			this.timerBar.scaleX = 0;
			this.timerBar.x = 344;
			this.timerBar.y = 17;
			this.addChild(this.timerBar);
		}
		
		/**
		 * 	Skapar ramen för timer bar
		 * 
		 *	@return void
		 */
		private function initFrame():void {
			this._timerFrame = new TimerFrame();
			this._timerFrame.x = 320;
			this._timerFrame.y = 15;
			this.addChild(this._timerFrame);
		}
						
		/**
		 * 	Startar blinkeffekt för timer bar
		 * 
		 *	@return void
		 */
		private function startFlickerEffect(duration:Number):void {
			this._flickerActivated = true;
			Session.effects.add(new Flicker(this.timerBar, duration, 200, true));
		}
		
		/**
		 * 	Stoppar blinkeffekt för timer bar
		 * 
		 *	@return void
		 */
		private function stopFlickerEffect():void {
			this._flickerActivated = false;
			Session.effects.dispose();
		}
	}
}	