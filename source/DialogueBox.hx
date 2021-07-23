package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitLeft2:FlxSprite;
	var portraitgf:FlxSprite;
	var portraitgf2:FlxSprite;
	var portraitgf3:FlxSprite;
	var portraitgf4:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitRight2:FlxSprite;
	var portraitRight3:FlxSprite;
	var portraitRight4:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'tutorial' | 'tutorial-remix' | 'highly-fresh':
				FlxG.sound.playMusic(Paths.music('bop'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'gfilfw':
				FlxG.sound.playMusic(Paths.music('highly'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'heartaches':
				FlxG.sound.playMusic(Paths.music('gfilfw'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'apart':
				FlxG.sound.playMusic(Paths.music('heart'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'holiday':
				FlxG.sound.playMusic(Paths.music('date'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'mistletoe':
				FlxG.sound.playMusic(Paths.music('holiday'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'date-night':
				FlxG.sound.playMusic(Paths.music('toes'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'tutorial' | 'tutorial-remix' | 'bopanties' | 'highly-fresh' | 'gfilfw' | 'heartaches' | 'apart' | 'crash-n-burn' | 'holiday' | 'mistletoe'| 'date-night':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [6], "", 24);
				box.setGraphicSize(Std.int(box.width * 0.2));
				box.updateHitbox();
				box.y = 450;
				box.x = 0;
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		
		
		portraitLeft = new FlxSprite(150, 150);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/DadPortrait');
		portraitLeft.animation.addByPrefix('enter', 'dad portrait', 24, false);
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitLeft2 = new FlxSprite(150, 150);
		portraitLeft2.frames = Paths.getSparrowAtlas('weeb/MomPortrait');
		portraitLeft2.animation.addByPrefix('enter', 'mom portrait', 24, false);
		add(portraitLeft2);
		portraitLeft2.visible = false;

		portraitgf = new FlxSprite(150, 150);
		portraitgf.frames = Paths.getSparrowAtlas('weeb/GFPortrait');
		portraitgf.animation.addByIndices('enter', 'gf portrait', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], "", 24, false);
		add(portraitgf);
		portraitgf.visible = false;

		portraitgf2 = new FlxSprite(150, 150);
		portraitgf2.frames = Paths.getSparrowAtlas('weeb/GFPortrait');
		portraitgf2.animation.addByPrefix('enter', 'gf portrait mad', 24, false);
		add(portraitgf2);
		portraitgf2.visible = false;

		portraitgf3 = new FlxSprite(150, 150);
		portraitgf3.frames = Paths.getSparrowAtlas('weeb/GFPortrait');
		portraitgf3.animation.addByPrefix('enter', 'gf portrait demon', 24, false);
		add(portraitgf3);
		portraitgf3.visible = false;

		portraitgf4 = new FlxSprite(150, 150);
		portraitgf4.frames = Paths.getSparrowAtlas('weeb/GFPortrait');
		portraitgf4.animation.addByPrefix('enter', 'gf portrait console', 24, false);
		add(portraitgf4);
		portraitgf4.visible = false;

		portraitRight = new FlxSprite(650, 150);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/BoyfriendPortrait');
		portraitRight.animation.addByIndices('enter', 'boyfriend portrait',[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], "",  24, false);
		add(portraitRight);
		portraitRight.visible = false;

		portraitRight2 = new FlxSprite(650, 150);
		portraitRight2.frames = Paths.getSparrowAtlas('weeb/BoyfriendPortrait');
		portraitRight2.animation.addByIndices('enter', 'boyfriend portrait christmas', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], "", 24, false);
		add(portraitRight2);
		portraitRight2.visible = false;

		portraitRight3 = new FlxSprite(650, 150);
		portraitRight3.frames = Paths.getSparrowAtlas('weeb/BoyfriendPortrait');
		portraitRight3.animation.addByPrefix('enter', 'boyfriend portrait christmas sad', 24, false);
		add(portraitRight3);
		portraitRight3.visible = false;

		portraitRight4 = new FlxSprite(650, 150);
		portraitRight4.frames = Paths.getSparrowAtlas('weeb/BoyfriendPortrait');
		portraitRight4.animation.addByPrefix('enter', 'boyfriend portrait christmas scared', 24, false);
		add(portraitRight4);
		portraitRight4.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight4.visible = false;
				portraitLeft2.visible = false;
				portraitgf.visible = false;
				portraitgf2.visible = false;
				portraitgf3.visible = false;
				portraitgf4.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'mom':
				portraitRight.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight4.visible = false;
				portraitLeft.visible = false;
				portraitgf.visible = false;
				portraitgf2.visible = false;
				portraitgf3.visible = false;
				portraitgf4.visible = false;
				if (!portraitLeft2.visible)
				{
					portraitLeft2.visible = true;
					portraitLeft2.animation.play('enter');
				}
			case 'gf':
				portraitRight.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight4.visible = false;
				portraitLeft2.visible = false;
				portraitLeft.visible = false;
				portraitgf2.visible = false;
				portraitgf3.visible = false;
				portraitgf4.visible = false;
				if (!portraitgf.visible)
				{
					portraitgf.visible = true;
					portraitgf.animation.play('enter');
				}
			case 'gf-mad':
				portraitRight.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight4.visible = false;
				portraitLeft2.visible = false;
				portraitgf.visible = false;
				portraitLeft.visible = false;
				portraitgf3.visible = false;
				portraitgf4.visible = false;
				if (!portraitgf2.visible)
				{
					portraitgf2.visible = true;
					portraitgf2.animation.play('enter');
				}
			case 'gf-demon':
				portraitRight.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight4.visible = false;
				portraitLeft2.visible = false;
				portraitgf.visible = false;
				portraitgf2.visible = false;
				portraitLeft.visible = false;
				portraitgf4.visible = false;
				if (!portraitgf3.visible)
				{
					portraitgf3.visible = true;
					portraitgf3.animation.play('enter');
				}
			case 'gf-love':
				portraitRight.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight4.visible = false;
				portraitLeft2.visible = false;
				portraitgf.visible = false;
				portraitgf2.visible = false;
				portraitgf3.visible = false;
				portraitLeft.visible = false;
				if (!portraitgf4.visible)
				{
					portraitgf4.visible = true;
					portraitgf4.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight4.visible = false;
				portraitLeft2.visible = false;
				portraitgf.visible = false;
				portraitgf2.visible = false;
				portraitgf3.visible = false;
				portraitgf4.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'bf-christmas':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitRight3.visible = false;
				portraitRight4.visible = false;
				portraitLeft2.visible = false;
				portraitgf.visible = false;
				portraitgf2.visible = false;
				portraitgf3.visible = false;
				portraitgf4.visible = false;
				if (!portraitRight2.visible)
				{
					portraitRight2.visible = true;
					portraitRight2.animation.play('enter');
				}
			case 'bf-christmas-sad':
				portraitLeft.visible = false;
				portraitRight2.visible = false;
				portraitRight.visible = false;
				portraitRight4.visible = false;
				portraitLeft2.visible = false;
				portraitgf.visible = false;
				portraitgf2.visible = false;
				portraitgf3.visible = false;
				portraitgf4.visible = false;
				if (!portraitRight3.visible)
				{
					portraitRight3.visible = true;
					portraitRight3.animation.play('enter');
				}
			case 'bf-christmas-scared':
				portraitLeft.visible = false;
				portraitRight2.visible = false;
				portraitRight3.visible = false;
				portraitRight.visible = false;
				portraitLeft2.visible = false;
				portraitgf.visible = false;
				portraitgf2.visible = false;
				portraitgf3.visible = false;
				portraitgf4.visible = false;
				if (!portraitRight4.visible)
				{
					portraitRight4.visible = true;
					portraitRight4.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
