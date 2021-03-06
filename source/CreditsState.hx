package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		bg.scale.x = bg.scale.y = scaleRatio;
		bg.screenCenter();
		
		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		//trace("finding mod shit");
		for (folder in Paths.getModDirectories())
		{
			var creditsFile:String = Paths.mods(folder + '/data/credits.txt');
			if (FileSystem.exists(creditsFile))
			{
				var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
				for(i in firstarray)
				{
					var arr:Array<String> = i.replace('\\n', '\n').split("::");
					if(arr.length >= 5) arr.push(folder);
					creditsStuff.push(arr);
				}
				creditsStuff.push(['']);
			}
		};
		var folder = "";
			var creditsFile:String = Paths.mods('data/credits.txt');
			if (FileSystem.exists(creditsFile))
			{
				var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
				for(i in firstarray)
				{
					var arr:Array<String> = i.replace('\\n', '\n').split("::");
					if(arr.length >= 5) arr.push(folder);
					creditsStuff.push(arr);
				}
				creditsStuff.push(['']);
			}
		#end
             //there are too many fucking people on this team 
		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			['Rapture Team'],
			['Jinx',                    'jinx',         'Director Artist Animator BG Artist And VA For Pandora',                'https://twitter.com/G3T_J1NX3D',      '0xFFF28C28'],
			['Viva',                    'vi',           'Co-Director Charter And Writer',                  'https://twitter.com/Glitchy2260',     '0xFF32CD32'],
			['Niffirg',                  'niff',              'Second Charter',                             'https://twitter.com/n1ffirg',        '0xFF5E1BC7'],
			['Static',                  'static',        'Coded Everything In',                                  'https://twitter.com/static_is_gay',   '0xFFBF40BF'],
			['Biposi',                   'biposi',      'BG Artist',                                  'https://twitter.com/biposi_gardner',             '0xFFD2042D'],
			['Enshinir',                 'enshin',      'Artist And Animator',                                    'https://twitter.com/enshinir',       '0xFFC41E3A'],
			['Jayfii',                    'jay',         'Character Designer',                            'https://twitter.com/Jayfii_',       '0xFFEA3C53'],
			['Soda',                      'soda',         'Character Designer And BG Artist',              'https://twitter.com/sodalitetwt',    '0xFF8C19E0 '],
			['Asriel',                     'asriel',      'BG Artist And Writer',                            'https://twitter.com/vvaterbucket',        '0xFFFAF0E6'],
			['Juile',                      'juile',       'Artist And Animator',                            'https://twitter.com/The_Pickle578',        '0xFFFFF44F'],
			['KaiBrainRotz',            'kai',            'Artist And BG Artist',                           'https://twitter.com/kaibrainrots',         '0xFF191970'],
			['RushBlush',               'rush',            'Artist And BG Artist',                          'https://twitter.com/Rushblushuwu',         '0xFF9932CC'],
			['Bunnyn00dles',             'bunny',           'Artist',                                        'https://twitter.com/bunnyn00dles',        '0xFFFF69B4'],
			['TheDomGom',                 'dom',             'Artist And Animator',                           'https://twitter.com/DomGom1',            '0xFFFAF0BE'],
			['Random Inc.',               'random',          'Artist And Animator',                           'https://twitter.com/RandomIncIsDead',    '0xFF9400D3'],
			['XoopLord',                   'xoop',           'Artist And Animator',                           'https://twitter.com/xooplord',           '0xFF8A2BE2'],
			['MrHat',                       'hat',              'Made The Pico Songs And The Geese Songs',   'https://twitter.com/mrhatmusicguy11',                             '0xFF808080'],
			['Jboots',                       'jboots',           'Made The Darnell Songs',                     'https://twitter.com/JbootsGames',                            '0xFF330C0B'],
			['Starlight Zone',                'starlight',        'VA For Mother Lactose And No Songs Used In This Build',               'https://twitter.com/StarlightZone7',                            '0xFF0892D0'],
			['Coquers_',                      'coquers',    'Made Frightened And The Sour Feelings Week Songs',      'https://twitter.com/Coquers1',                            '0xFFFF355E'],
			['Ora',                            'ora',             'Made The Game Over Theme And VA For Overseer',                       'https://twitter.com/oran_is',                            '0xFF1E90FF'],
			['SirFitness',                     'sirf',           'No Songs Used In This Build',                   'https://twitter.com/sfgamertalks',                            '0xFFF9F6EE'],
			['Oliver',                         'oliver',         'Writer',                                              '',                            '0xFFA4C639'],
			['Neen',                         'neen',           'Writer And VA For Virus',                        'https://twitter.com/TakoNeen',                            '0xFFFFFF66'],
			['RedPanda',                     'red',            'VA For Lila',                                    'https://twitter.com/redpandaa98',                 '0xFF800020'],
			['TerminatorMKII',               'term',           'VA For Darnell',                  'https://cdn.discordapp.com/emojis/934671438529593384.gif?size=48&quality=lossless',    '0xFF343434'],
			['Genius',                        'genius',         'VA For Pump',                     'https://twitter.com/Geniusvlog',                                             '0xFF9932CC'],
			['SlimShadie',                     'slim',          'VA For Monika',                    '',                               '0xFFF67209'],
			['CommentatorMack',                'mack',          'VA For Tankman',                   '',                               '0xFFF609F2'],
			['EBitTV',                          'ebit',          'VA For BF',                       '',                               '0xFF09F6EA'],
			['Tasha',                            'tasha',         'VA For Anti',                     '',                              '0xFF744F4F'],
			['Flacodir',                       'flaco',         'VA For Haru',                      '',                               '0xFFDBC723'],
			['Chaotic',                        'chao',          'VA For Pico',                      '',                               '0xFFFB9700'],
            ['Snowfie',                        'snow',          'VA For Skid',                      '',                              '0xFFE0F3F4'],
		    ['UniqueGeese',                     'geese',        'VA For Himself',                   '',                              '0xFF8700FD'],
 			['Psych Engine Team'], 
			['Shadow Mario',		'shadowmario',		'Main Programmer of Psych Engine',						'https://twitter.com/Shadow_Mario_',	'444444'],
			['RiverOaken',			'riveroaken',		'Main Artist/Animator of Psych Engine',					'https://twitter.com/river_oaken',		'C30085'],
			['bb-panzu',			'bb-panzu',			'Additional Programmer of Psych Engine',				'https://twitter.com/bbsub3',			'389A58'],
			[''],
			['Engine Contributors'],
			['shubs',				'shubs',			'New Input System Programmer',							'https://twitter.com/yoshubs',			'4494E6'],
			['SqirraRNG',			'gedehari',			'Chart Editor\'s Sound Waveform base',					'https://twitter.com/gedehari',			'FF9300'],
			['iFlicky',				'iflicky',			'Delay/Combo Menu Song Composer\nand Dialogue Sounds',	'https://twitter.com/flicky_i',			'C549DB'],
			['PolybiusProxy',		'polybiusproxy',	'.MP4 Video Loader Extension',							'https://twitter.com/polybiusproxy',	'FFEAA6'],
			['Keoiki',				'keoiki',			'Note Splash Animations',								'https://twitter.com/Keoiki_',			'FFFFFF'],
			['Smokey',				'smokey',			'Spritemap Texture Support',							'https://twitter.com/Smokey_5_',		'0033CC'],
			[''],
			[''],
			["Funkin' Crew"],
			['ninjamuffin99',		'ninjamuffin99',	"Programmer of Friday Night Funkin'",					'https://twitter.com/ninja_muffin99',	'F73838'],
			['PhantomArcade',		'phantomarcade',	"Animator of Friday Night Funkin'",						'https://twitter.com/PhantomArcade3K',	'FFBB1B'],
			['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",						'https://twitter.com/evilsk8r',			'53E52C'],
			['kawaisprite',			'kawaisprite',		"Composer of Friday Night Funkin'",						'https://twitter.com/kawaisprite',		'6475F3'],
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			optionText.yAdd -= 70;
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("pixel.otf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		if(controls.ACCEPT) {
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}
		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}