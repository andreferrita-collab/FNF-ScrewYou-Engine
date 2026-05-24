package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>> = [];
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;
	private var danced:Bool = false;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		curCharacter = character;
		this.isPlayer = isPlayer;

		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':

				var gfTex = FlxAtlasFrames.fromSparrow(
					"assets/images/characters/GF_assets.png","assets/images/characters/GF_assets.xml"
				);

				frames = gfTex;

				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);

				animation.addByIndices('danceLeft', 'GF Dancing Beat',
					[30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
					"", 24, false);

				animation.addByIndices('danceRight', 'GF Dancing Beat',
					[15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29],
					"", 24, false);

				playAnim('danceRight');

			case 'dad':

				var dadTex = FlxAtlasFrames.fromSparrow(
					AssetPaths.images_characters_DADDY_DEAREST__png,
					AssetPaths.images_characters_DADDY_DEAREST__xml
				);

				frames = dadTex;

				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				playAnim('idle');

			case 'spooky':

				var spookyTex = FlxAtlasFrames.fromSparrow(
					AssetPaths.images_characters_spooky_kids_assets__png,
					AssetPaths.images_characters_spooky_kids_assets__xml
				);

				frames = spookyTex;

				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);

				playAnim('singLEFT');

			case 'mom':

				var momTex = FlxAtlasFrames.fromSparrow(
					AssetPaths.images_characters_Mom_Assets__png,
					AssetPaths.images_characters_Mom_Assets__xml
				);

				frames = momTex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				playAnim('idle');

			case 'monster':

				var monsterTex = FlxAtlasFrames.fromSparrow(
					AssetPaths.images_characters_Monster_Assets__png,
					AssetPaths.images_characters_Monster_Assets__xml
				);

				frames = monsterTex;

				animation.addByPrefix('idle', 'monster idle', 24);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				playAnim('idle');

			case 'pico':

				var picoTex = FlxAtlasFrames.fromSparrow(
					AssetPaths.images_characters_Pico_FNF_assetss__png,
					AssetPaths.images_characters_Pico_FNF_assetss__xml
				);

				frames = picoTex;

				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);

				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
				}
				else
				{
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
				}

				playAnim('idle');

			case 'bf':

				var bfTex = FlxAtlasFrames.fromSparrow(
					AssetPaths.images_characters_BOYFRIEND__png,
					AssetPaths.images_characters_BOYFRIEND__xml
				);

				frames = bfTex;

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);

				playAnim('idle');
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (curCharacter != 'bf')
		{
			if (animation.curAnim != null)
			{
				if (animation.curAnim.name.startsWith('sing'))
				{
					holdTimer += elapsed;
				}
			}
		}
	}

	public function dance()
	{
		switch (curCharacter)
		{
			case 'gf':

				danced = !danced;

				if (danced)
					playAnim('danceRight');
				else
					playAnim('danceLeft');

			default:
				playAnim('idle');
		}
	}

	public function playAnim(name:String, ?force:Bool = false)
	{
		animation.play(name, force);

		if (animOffsets.exists(name))
		{
			var daOffset = animOffsets.get(name);
			offset.set(daOffset[0], daOffset[1]);
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
