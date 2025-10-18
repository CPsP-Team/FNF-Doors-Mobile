package mobile;

import haxe.crypto.Md5;
import openfl.utils.Assets;
#if sys
import sys.FileSystem;
import sys.io.File;
#end
using StringTools;
class Asset2File
{
	public static var path:String = lime.system.System.applicationStorageDirectory;

	public static function getPath(id:String)
	{
		#if android
		var file = Assets.getBytes(id);
		var md5 = Md5.encode(Md5.make(file).toString());
		var filePath = path + md5;

		if (!FileSystem.exists(filePath))
			File.saveBytes(filePath, file);

		return filePath;
		#else
		return #if sys Sys.getCwd() + #end id;
		#end
	}
    // by musk
	public static function readDirectory(folder:String):Array<String>
	{
		var something:Array<String> = []; // algo algo, extraño a mi algo:( - musk
		trace('hsys go to: ' + folder);

		for (library in Assets.list().filter(archives -> archives.contains(folder)))
		{
			var splitFolder:Array<String> = [];
			var stringFolder:String = library;

			if (!library.startsWith('.') && !something.contains(folder)) {
				stringFolder = stringFolder.replace(folder + '/', ''); // yea
				splitFolder = stringFolder.split('/');
			}
			if (!something.contains(splitFolder[0])) // para que no se repitan
				something.push(splitFolder[0]);
		}

		// ordenar por abecedario a-z
		something.sort(function(a:String, b:String):Int
		{
			a = a.toUpperCase();
			b = b.toUpperCase();

			if (a < b)
				return -1;
			else if (a > b)
				return 1;
			else
				return 0;
		});

		trace('hsys result is: ' + something);
		return something;
	}
}