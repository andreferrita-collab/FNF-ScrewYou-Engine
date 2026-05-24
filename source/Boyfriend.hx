package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Boyfriend extends Character
{
	override function update(elapsed:Float)
	{
		if (animation.curAnim.name.endsWith('miss')
			&& animation.curAnim.finished
			&& !debugMode)
		{
			playAnim('idle', true);
		}

		if (animation.curAnim.name == 'firstDeath'
			&& animation.curAnim.finished)
		{
			playAnim('deathLoop');
		}

		super.update(elapsed);
	}
}
