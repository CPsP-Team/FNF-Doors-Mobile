package mobile;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import objects.ui.DoorsOption.DoorsOptionType;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import options.substates.BaseOptionsMenu;
import openfl.Lib;
import objects.ui.DoorsOption.CommonDoorsOption;

using StringTools;

class AndroidSettingsSubState extends BaseOptionsMenu
{
	public function new()
	{
		internalTitle = "androidControls";
		title = 'Android Controls Settings';
		rpcTitle = 'Android Controls Settings Menu'; // hi, you can ask what is that, i will answer it's all what you needed lol.

var option:CommonDoorsOption = {
    name: 'vpadOpacity', // mariomaster was here again
    description: 'vpadOpacity',
    variable: 'padalpha',
    type: DoorsOptionType.PERCENT,
    scrollSpeed: 1.6,
    minValue: 0.1, // prevent invisible vpad
    maxValue: 1,
    changeValue: 0.01,
    decimals: 2
};
addOption(option);

var option:CommonDoorsOption = {
    name: 'hitboxOpacity', // mariomaster is dead :00000
    description: 'hitboxOpacity',
    variable: 'hitboxalpha',
    type: DoorsOptionType.PERCENT,
    scrollSpeed: 1.6,
    minValue: 0.0,
    maxValue: 1,
    changeValue: 0.01,
    decimals: 2
};
addOption(option);

		super();
	}
}
