--author:eRycKkAwa

--bibliotecas
push = require 'push' 

--dimensões da janela
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

--import de imagens
local background = love.graphics.newImage('background.png')
--efeito parallax
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
--efeito parallax
local groundScroll = 0

function love.load()
    --aplica filtro na janela para retirar o blur dos pixels devido ao upscale da tela com a dimensão virtual
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Flappppppyyyyyyyy Bird')
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullsreen = false,
        vsync = true,
        resizable = true
    })

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == escape then
        love.event.quit()
    end
end

function love.draw()
    
    push:start()

    love.graphics.draw(background, -backgroundScroll, 0)

    love.graphics.draw(ground, -groundScroll,VIRTUAL_HEIGHT - 16)

    push:finish()
end