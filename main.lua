--author:eRycKkAwa

--bibliotecas
push = require 'push' 
Class = require 'class'

--crição de classes
require 'Bird'

--dimensões da janela
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

--import de imagens
local background = love.graphics.newImage('assets/background.png')
--efeito parallax
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 413

local ground = love.graphics.newImage('assets/ground.png')
--efeito parallax
local groundScroll = 0
local GROUND_SCROLL_SPEED = 60

--criação do pássaro local
local bird = Bird()

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

function love.update(dt)
     -- Atualiza o deslocamento do plano de fundo com base no tempo decorrido
    -- desde o último quadro (dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt ) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

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

    bird:render()

    push:finish()
end