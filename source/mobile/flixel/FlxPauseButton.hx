package mobile.flixel;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

#if mobile
import flixel.input.touch.FlxTouch;
#end

/**
 * Class to manage the pause button on mobile devices
 * Implements singleton pattern to ensure only one instance exists
 * Class methods are static for easy access on any states if needed
 * @author Dechis
 */
class FlxPauseButton
{
    private static var instance:FlxPauseButton;
    private var pauseButton:FlxSprite;
    private var isVisible:Bool = false;
    private var onClickCallback:Void->Void;
    
    public static function getInstance():FlxPauseButton 
    {
        if (instance == null) 
        {
            instance = new FlxPauseButton();
        }
        return instance;
    }
    
    private function new() 
    {
    }
    
    /**
     * Main function to show the pause button on mobile devices
	 * @param camera - Camera where the button will be displayed
     * @param parent - Group where the button will be added (optional)
     * @param onClick - Callback for when the button is clicked (optional)
     */
    public static function showPauseButton(camera:flixel.FlxCamera, ?parent:FlxGroup, ?onClick:Void->Void):Void 
    {
        #if mobile
        var manager = getInstance();
        
        manager.pauseButton = new FlxSprite().loadGraphic('mobile/game/pauseButton.png');
        manager.pauseButton.antialiasing = true;
        manager.pauseButton.scrollFactor.set();
        manager.pauseButton.alpha = 0.7;
        manager.pauseButton.scale.set(0.9, 0.9);
        manager.pauseButton.updateHitbox();
        
        manager.pauseButton.x = FlxG.width - manager.pauseButton.width - 20;
        manager.pauseButton.y = 20;
        
        manager.pauseButton.cameras = [camera];
        
        manager.onClickCallback = onClick;
        
        if (parent != null) 
        {
            parent.add(manager.pauseButton);
        }
        else 
        {
            FlxG.state.add(manager.pauseButton);
        }
        
        manager.isVisible = true;
        
        trace("Button added");
        #else
        trace("Button only available on mobile");
        #end
    }
    
    public static function hidePauseButton():Void 
    {
        #if mobile
        var manager = getInstance();
        
        if (manager.pauseButton != null && manager.isVisible) 
        {
            manager.pauseButton.destroy();
            manager.pauseButton = null;
            manager.onClickCallback = null;
            manager.isVisible = false;
            trace("Pause button removed");
        }
        #end
    }

    public static function isButtonVisible():Bool 
    {
        #if mobile
        return getInstance().isVisible;
        #else
        return false;
        #end
    }
    
    public static function updatePosition():Void 
    {
        #if mobile
        var manager = getInstance();
        if (manager.pauseButton != null && manager.isVisible) 
        {
            manager.pauseButton.x = FlxG.width - manager.pauseButton.width - 20;
            manager.pauseButton.y = 20;
        }
        #end
    }
    
    public static function update():Void 
    {
        #if mobile
        var manager = getInstance();
        
        if (manager.pauseButton == null || !manager.isVisible) 
        {
            return;
        }
        
        if (manager.pauseButton.cameras == null || manager.pauseButton.cameras.length == 0) 
        {
            trace("Warning: PauseButton cameras not properly set, skipping touch check");
            return;
        }
        
        var camera = manager.pauseButton.cameras[0];
        if (camera == null) 
        {
            trace("Warning: PauseButton camera is null, skipping touch check");
            return;
        }
        
        var justPressed = false;
        
        for (touch in FlxG.touches.list)
        {
            if (touch == null) continue;
            
            try {
                var touchPos = touch.getWorldPosition(camera); 
                if (touch.justPressed && manager.pauseButton.overlapsPoint(touchPos, true, camera))
                {
                    justPressed = true;
                    break;
                }
            }
            catch (e:Dynamic) {
                trace("Error processing touch: " + e);
                try {
                    if (touch.justPressed && manager.pauseButton.overlapsPoint(touch.getWorldPosition()))
                    {
                        justPressed = true;
                        break;
                    }
                }
                catch (e2:Dynamic) {
                    trace("Error in fallback touch processing: " + e2);
                }
            }
        }
        
        if (justPressed) 
        {         
            if (manager.onClickCallback != null) 
            {
                manager.onClickCallback();
            }
        }
        #end
    }
}
