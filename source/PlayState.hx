package;

import flixel.FlxG;
import flixel.system.FlxSound;
import Song.SwagSong;

class PlayState extends MusicBeatState
{
	var _song:SwagSong;

	var inst:FlxSound;
	var vocals:FlxSound;

	override public function create()
	{
		super.create();

		loadSong('bopeebo');
	}

	function loadSong(song:String)
	{
		_song = Song.loadFromJson(song);
		Conductor.mapBPMChanges(_song);
		Conductor.changeBPM(_song.bpm);

		if (inst != null)
			inst.stop();
		if (vocals != null)
			vocals.stop();

		inst = new FlxSound().loadEmbedded(Paths.sound(Paths.formatToSongPath(_song.song) + '/Inst', false, 'songs'));
		inst.onComplete = function()
		{
			vocals.pause();
			vocals.time = 0;
			inst.pause();
			inst.time = 0;
		};
		FlxG.sound.list.add(inst);

		vocals = new FlxSound().loadEmbedded(Paths.sound(Paths.formatToSongPath(_song.song) + '/Voices', false, 'songs'));
		FlxG.sound.list.add(vocals);
	}

	function resyncVocals()
	{
		// bitch
		vocals.pause();
		inst.play();
		Conductor.songPosition = inst.time;
		vocals.time = Conductor.songPosition;
		vocals.play();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.SPACE)
		{
			if (inst.playing)
			{
				inst.pause();
				vocals.pause();
			}
			else {}
		}
	}
}
