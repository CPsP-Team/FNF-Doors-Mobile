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

	public static function readDirectory(path:String):Array<String> {
        var files:Array<String> = [];

        for (asset in Assets.list()) {
            if (StringTools.startsWith(asset, path + "/")) {
                var relative = asset.substr(path.length + 1);
                if (relative.indexOf("/") == -1 && relative != "")
                    files.push(relative);
            }
        }

        return files;
	}

	public static function isDirectory(path:String):Bool {
        #if sys
        return sys.FileSystem.exists(path) && sys.FileSystem.isDirectory(path);
        #else
        for (asset in Assets.list()) {
            if (StringTools.startsWith(asset, path + "/")) {
                return true;
            }
        }
        return false;
        #end
	}
}
