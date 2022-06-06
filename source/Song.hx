package;

import haxe.Json;
import openfl.utils.Assets;

using StringTools;

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var bpm:Float;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var validScore:Bool;
}

typedef SwagSection =
{
	var sectionNotes:Array<Dynamic>;
	var lengthInSteps:Int;
	var typeOfSection:Int;
	var mustHitSection:Bool;
	var bpm:Float;
	var changeBPM:Bool;
	var altAnim:Bool;
}

class Song
{
	public static function loadFromJson(jsonInput:String, ?folder:String)
	{
		if (folder == null)
			folder = jsonInput;

		var rawJson:String = Assets.getText(Paths.getPath(folder.toLowerCase() + '/' + jsonInput.toLowerCase(), JSON, 'songs')).trim();
		// LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
		while (!rawJson.endsWith("}"))
			rawJson = rawJson.substr(0, rawJson.length - 1);

		var swagShit:SwagSong = cast Json.parse(rawJson).song;
		swagShit.validScore = true;
		return swagShit;
	}
}
