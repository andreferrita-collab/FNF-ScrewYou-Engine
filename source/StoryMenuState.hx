package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.text.FlxText.FlxTextAlign;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class StoryMenuState extends MusicBeatState
{
	var scoreText:FlxText;
	var txtTracklist:FlxText;

	var weekData:Array<Dynamic> = [
		['Tutorial'],
		['Bopeebo', 'Fresh', 'Dadbattle'],
		['Spookeez', 'South'],
		['Pico', 'Philly', "Blammed"],
		['Satin-Panties', "High", "Milf"]
	];

	var weekCharacters:Array<Dynamic> = [
		['dad', 'bf', 'gf'],
		['dad', 'bf', 'gf'],
		['spooky', 'bf', 'gf'],
		['pico', 'bf', 'gf'],
		['mom', 'bf', 'gf']
	];

	public static var weekUnlocked:Array<Bool> = [true, true, true, true, true];

	var curWeek:Int = 0;
	var curDifficulty:Int = 1;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;
	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	override function create()
	{
		if (FlxG.sound.music != null && !FlxG.sound.music.playing)
			FlxG.sound.playMusic('assets/music/freakyMenu' + TitleState.soundExt);

		persistentUpdate = true;
		persistentDraw = true;

		scoreText = new FlxText(10, 10, 0, "WEEK SCORE: 0", 32);
		scoreText.setFormat("VCR OSD Mono", 32);

		var rankText:FlxText = new FlxText(0, 10, 0, "RANK: GREAT", 32);
		rankText.setFormat("assets/fonts/vcr.ttf", 32);
		rankText.screenCenter(FlxAxes.X);

		var ui_tex = FlxAtlasFrames.fromSparrow(
			AssetPaths.campaign_menu_UI_assets__png,
			AssetPaths.campaign_menu_UI_assets__xml
		);

		var yellowBG:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 400, 0xFFF9CF51);
		add(yellowBG);

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();
		add(grpWeekCharacters);

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		add(blackBarThingie);

		for (i in 0...weekData.length)
		{
			var weekThing = new MenuItem(0, yellowBG.y + yellowBG.height + 10, i);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			weekThing.screenCenter(FlxAxes.X);

			grpWeekText.add(weekThing);

			if (!weekUnlocked[i])
			{
				var lock = new FlxSprite(weekThing.x + weekThing.width + 10, weekThing.y);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				grpLocks.add(lock);
			}
		}

		for (char in 0...3)
		{
			var c = new MenuCharacter(
				(FlxG.width * 0.25) * (1 + char) - 150,
				weekCharacters[curWeek][char]
			);

			c.y += 70;

			switch (c.character)
			{
				case 'dad':
					c.setGraphicSize(Std.int(c.width * 0.5));

				case 'bf':
					c.setGraphicSize(Std.int(c.width * 0.9));
					c.x -= 80;

				case 'gf':
					c.setGraphicSize(Std.int(c.width * 0.5));

				case 'pico':
					c.y += 170;
					c.flipX = true;
					c.x -= 40;
			}

			c.updateHitbox();
			grpWeekCharacters.add(c);
		}

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		leftArrow = new FlxSprite().loadGraphicFromSprite(null);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');

		sprDifficulty = new FlxSprite();
		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');

		rightArrow = new FlxSprite();
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', "arrow right");
		rightArrow.animation.addByPrefix('press', "arrow push right");
		rightArrow.animation.play('idle');

		difficultySelectors.add(leftArrow);
		difficultySelectors.add(sprDifficulty);
		difficultySelectors.add(rightArrow);

		txtTracklist = new FlxText(0, yellowBG.y + yellowBG.height + 100, 0, "TRACKS", 32);
		txtTracklist.alignment = FlxTextAlign.CENTER;
		txtTracklist.screenCenter(FlxAxes.X);
		txtTracklist.x -= FlxG.width * 0.35;

		add(scoreText);
		add(txtTracklist);

		updateText();

		super.create();
	}

	override function update(elapsed:Float)
	{
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));
		scoreText.text = "WEEK SCORE: " + lerpScore;

		super.update(elapsed);
	}

	function updateText()
	{
		txtTracklist.text = "TRACKS\n";

		for (i in weekData[curWeek])
			txtTracklist.text += "\n" + i;

		txtTracklist.text = txtTracklist.text.toUpperCase();
	}
}
