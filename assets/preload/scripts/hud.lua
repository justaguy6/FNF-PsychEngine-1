
local options = {
    FPSText = true,
    defaultHealth = true,
    ghostTapp = false,
    --laztrix
} 



local items = {'timeBar','timeBarBG','timeTxt','scoreTxt','grpNoteSplashes'}
function onCreatePost()
    setProperty('botplayTxt.y',getProperty('healthBarBG.y') - (downscroll and -80 or 80))
    for i = 1,#items do
        setProperty(items[i]..'.visible',false)
    end
    for i = 0,3 do
        setPropertyFromGroup('opponentStrums',i,'x',50 + (112 * (i % 4)))
        setPropertyFromGroup('playerStrums',i,'x',680 + (112 * (i % 4)))
    end
    if options.defaultHealth then
        setHealthBarColors('ff0000', '66ff33')
    end

    makeLuaText('FunkinFPS', 'FPS: 0', 0, 10, 3)
    setTextSize('FunkinFPS',14)
    setTextBorder('FunkinFPS',-90,'FFFFFF')
    setObjectCamera('FunkinFPS','camOther')
    addLuaText('FunkinFPS')

    makeLuaText('FunkinScore', 'Score: 0', 0, getProperty('healthBarBG.x') + getProperty('healthBarBG.width') - 190, getProperty('healthBarBG.y') + 30)
    setTextSize('FunkinScore',16)
    setTextBorder('FunkinScore',-1000,'FFFFFF')
    addLuaText('FunkinScore')

    ghostTap = getPropertyFromClass('ClientPrefs', 'ghostTapping')
    setPropertyFromClass('ClientPrefs', 'ghostTapping', options.ghostTapp)
end
function onEvent(n)
    if n == 'Change Character' and options.defaultHealth then
        setHealthBarColors('ff0000', '66ff33')
    end
end
function onUpdatePost()
    for i = 1,2 do
        local sexo = 'iconP'..i
        setProperty(sexo..'.origin.x',20+(i-1)*60)
        setProperty(sexo..'.origin.y',0)
        setProperty(sexo..'.scale.x',lerp(getProperty(sexo..'.scale.x'), 1, 0.5))
    end
    setProperty('botplayTxt.alpha',1)
    setTextString('FunkinFPS',(options.FPSText and 'FPS: '..getPropertyFromClass("Main", "fpsVar.currentFPS") or '' ))
end
function onDestroy()
    setPropertyFromClass('ClientPrefs', 'ghostTapping', ghostTap)
end
function onUpdateScore()
    setTextString('FunkinScore','Score: '..score)
end
function opponentNoteHit(id, direc)
    runHaxeCode("game.opponentStrums.members["..direc.."].playAnim('static', true);")
end
function goodNoteHit(id, direc)
    if botPlay then
        runHaxeCode("game.playerStrums.members["..direc.."].playAnim('static', true);")
    end
end
function lerp(from,to,i)return from+(to-from)*i end
--laztrix