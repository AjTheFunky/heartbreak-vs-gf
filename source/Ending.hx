package;
import flixel.*;
/**
 * ...
 * @author bbpanzu
 */
class Ending extends MusicBeatState
{

	public function new() 
	{
		super();
		bgColor = 0xFF4D1B30;
	}
	
	override function create() 
	{
		super.create();
		
		
		FlxG.sound.playMusic(Paths.music("vsgfendingjingle"));
		
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("thanksbizarreethen"));
		add(bg);
		
	}
	
	
	override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
		if (controls.ACCEPT){
			FlxG.switchState(new StoryMenuState());
		}
		
	}
	
	
	
}