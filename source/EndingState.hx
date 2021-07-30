package;
import flixel.*;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

/**
 * ...
 * @author bbpanzu
 */
class EndingState extends FlxState
{

	var _goodEnding:Bool = false;
	
	public function new(goodEnding:Bool = true) 
	{
		super();
		_goodEnding = goodEnding;
		
	}
	
	override public function create():Void 
	{
		trace(PlayState.storyWeek);
		super.create();	
		var end:FlxSprite = new FlxSprite(0, 0);
		//ignore this messed up coding, im just dumb Aj lol
		if (PlayState.storyWeek == 0)
			endIt();
		if (PlayState.storyWeek == 1)
			endIt();
		if (PlayState.storyWeek == 2)
			endIt();
		else
			FlxG.camera.fade(FlxColor.BLACK, 0.8, true);
			if (PlayState.storyWeek == 3)		
				end.loadGraphic(Paths.image("Girlfriend/endlmao"));
				end.loadGraphic(Paths.image("endlmao"));
			add(end);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (FlxG.keys.pressed.ENTER){
			endIt();
		}
		
	}
	
	
	public function endIt(e:FlxTimer=null){
		trace("ENDING");
		FlxG.switchState(new StoryMenuState());
	}
	
}