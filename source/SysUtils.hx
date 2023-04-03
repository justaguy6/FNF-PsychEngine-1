package;

import lime.utils.Assets;

using StringTools;

class SysUtils {

    public static var elcamino:String = lime.system.System.applicationStorageDirectory;
    public static function exists(arquivo:String, ?extensao:AssetType = null):Bool
    {
        var formato:String = '';
    
        switch (type)
        {
            case FONT:
                formato = '.ttf';
                if (!Assets.exists(arquivo + formato))
                    formato = '.otf';
            case IMAGE:
                formato = '.png';
            case MOVIE_CLIP:
                formato = '.swf';
            case MUSIC | SOUND:
                formato = '.ogg';
            case TEXT:
                formato = '.txt';
                if (!Assets.exists(arquivo + formato))
                    formato = '.xml';
             case BINARY | TEMPLATE:
                formato = '.ay cabron';
                FlxG.log.add('Return: Put the file format in the path.');
            }
    
        return Assets.exists(arquivo + formato);
    }

    public static function getContent(arquivo:String):String
    {
        Assets.getText(arquivo);
    }

    /*
	** https://api.haxeflixel.com/Array.html
	** https://api.haxeflixel.com/String.html
	*/
	    public static function readDirectory(library:String):Array<String>
        {
            var libraryArray:Array<String> = [];
            var gettt = Assets.list();
    
            for (folder in gettt.filter(file -> file.contains('$library')))
            {
                /*
                ** folder.replace('$library/', '');
                ** newFolder = folder; El string se convertía en 'assets' xdxdxdxdxjaskdjasd
                */
                var newFolder:String = folder.replace('$library/', '');
                if (newFolder.contains('/'))
                    newFolder = newFolder.replace(newFolder.substring(newFolder.indexOf('/'), newFolder.length), '');
                if (!libraryArray.contains(newFolder) && !newFolder.startsWith('.'))
                    libraryArray.push(newFolder);
            }
    
            libraryArray.sort(function(a:String, b:String):Int 
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
    
            return libraryArray;
        }

        // O relPath, deve ser um caminho como assets/images/arquivo, se não não vai funcionar
        public static function absolutePath(relPath:String):String 
        {
            FlxG.log.add(relPath);
            return elcamino + relPath;
        }

        public static function isDirectory(path:String):Bool 
        {
            return absolutePath(path);
        }

}