package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, FlxPoint>;
	public var isPlayer:Bool = false;
	public var curCharacter:String = "bf";

	public var holdTimer:Float = 0;
	private var danced:Bool = false;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, FlxPoint>();

		curCharacter = character;
		this.isPlayer = isPlayer;

		antialiasing = true;

		var tex:FlxAtlasFrames;

		switch (curCharacter)
		{
			// ================= GF =================
			case "gf":
				tex = FlxAtlasFrames.fromSparrow(
					"assets/images/GF_assets.png",
					"assets/images/GF_assets.xml"
				);

				frames = tex;

				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);

				animation.addByIndices('danceLeft', 'GF Dancing Beat',
					[0,1,2,3,4,5,6], "", 24, false);

				animation.addByIndices('danceRight', 'GF Dancing Beat',
					[7,8,9,10,11,12,13], "", 24, false);

				addOffset('cheer', 0, 0);
				addOffset('singLEFT', 0, -19);
				addOffset('singRIGHT', 0, -20);
				addOffset('singUP', 0, 4);
				addOffset('singDOWN', 0, -20);

				playAnim('danceRight');

			// ================= DAD =================
			case "dad":
				tex = FlxAtlasFrames.fromSparrow(
					"assets/images/DADDY_DEAREST.png",
					"assets/images/DADDY_DEAREST.xml"
				);

				frames = tex;

				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle', 0, 0);
				addOffset('singUP', 0, 50);
				addOffset('singRIGHT', 0, 0);
				addOffset('singLEFT', 0, 0);
				addOffset('singDOWN', 0, -30);

				playAnim('idle');

			// ================= SPOOKY =================
			case "spooky":
				tex = FlxAtlasFrames.fromSparrow(
					"assets/images/spooky_kids_assets.png",
					"assets/images/spooky_kids_assets.xml"
				);

				frames = tex;

				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);

				addOffset('singUP', 0, 0);
				addOffset('singDOWN', 0, 0);
				addOffset('singLEFT', 0, 0);
				addOffset('singRIGHT', 0, 0);

				playAnim('singLEFT');

			// ================= MOM =================
			case "mom":
				tex = FlxAtlasFrames.fromSparrow(
					"assets/images/Mom_Assets.png",
					"assets/images/Mom_Assets.xml"
				);

				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle', 0, 0);
				addOffset('singUP', 0, 0);
				addOffset('singRIGHT', 0, 0);
				addOffset('singLEFT', 0, 0);
				addOffset('singDOWN', 0, 0);

				playAnim('idle');

			// ================= MONSTER =================
			case "monster":
				tex = FlxAtlasFrames.fromSparrow(
					"assets/images/Monster_Assets.png",
					"assets/images/Monster_Assets.xml"
				);

				frames = tex;

				animation.addByPrefix('idle', 'monster idle', 24);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle', 0, 0);
				addOffset('singUP', 0, 0);
				addOffset('singRIGHT', 0, 0);
				addOffset('singLEFT', 0, 0);
				addOffset('singDOWN', 0, 0);

				playAnim('idle');

			// ================= PICO =================
			case "pico":
				tex = FlxAtlasFrames.fromSparrow(
					"assets/images/Pico_FNF_assetss.png",
					"assets/images/Pico_FNF_assetss.xml"
				);

				frames = tex;

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

				addOffset('idle', 0, 0);
				addOffset('singUP', 0, 0);
				addOffset('singLEFT', 0, 0);
				addOffset('singRIGHT', 0, 0);
				addOffset('singDOWN', 0, 0);

				playAnim('idle');

			// ================= BF =================
			case "bf":
				tex = FlxAtlasFrames.fromSparrow(
					"assets/images/BOYFRIEND.png",
					"assets/images/BOYFRIEND.xml"
				);

				frames = tex;

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);

				addOffset('idle', 0, 0);
				addOffset('singUP', 0, 0);
				addOffset('singLEFT', 0, 0);
				addOffset('singRIGHT', 0, 0);
				addOffset('singDOWN', 0, 0);

				flipX = true;
				playAnim('idle');
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [new FlxPoint(x, y)];
	}
		}
