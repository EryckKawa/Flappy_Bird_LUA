--Assigment 1
--Make pipe gaps slight random
--make pipe intervals slighty random
--award players a "medal" based on their score, using images
--implemente a pause feature

-- Bibliotecas necessárias
push = require 'push' 
Class = require 'class' 

require 'StateMachine'
require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'



require 'Bird' 
require 'Pipe' 
require 'PipePair'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('assets/background.png')
local ground = love.graphics.newImage('assets/ground.png')

local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 413


local groundScroll = 0
local GROUND_SCROLL_SPEED = 60

scrolling = true
 
function love.load()
    
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Twitterry Bird')
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false, 
        vsync = true,       
        resizable = true    
    })

    smallFont = love.graphics.newFont('assets/font.tff', 8)
    mediumFont = love.graphics.newFont('assets/flappy.tff', 14)
    flappyFont = love.graphics.newFont('assets/flappy.tff', 28)
    hugeFont = love.graphics.newFont('assets/flappy.tff', 56)

    love.graphics.setFont(flappyFont)

    sounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static')
        ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static')
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static')
        ['score'] = love.audio.newSource('sounds/score.wav', 'static')

        ['music'] = love.audio.newSource('sounds/marios_way.wav', 'static')
    }

    sounds['music']:setLooping(true)
    sounds['music']:play()
    
    love.keyboard.keysPressed = {}

end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    -- Atualiza o deslocamento do plano de fundo com base no tempo decorrido
    -- desde o último quadro (dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

    bird:update(dt)

    love.keyboard.keysPressed = {}
    
    spawnTimer = spawnTimer + dt
    
    if spawnTimer > 2 then
        local y = math.max(-PIPE_HEIGHT + 10, math.min(lastY + math.random(-60, 60), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        lastY = y
        table.insert(pipePairs, PipePair(y))
        spawnTimer = 0
    end
    

    for k, pair in pairs(pipePairs) do
        pair:update(dt)
        if pair.x < -PIPE_WIDTH then
            pair.remove = true
        end
    end

    for k, pair in pairs(pipePairs) do
        if pair.remove then
            table.remove(pipePairs, k)
        end
    end
end

function love.resize(w, h)
    -- Atualiza o redimensionamento da tela usando a biblioteca push
    push:resize(w, h)
end

function love.keypressed(key)
    -- Fecha o jogo se a tecla Esc for pressionada
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.draw()
    -- Inicia o renderizador da biblioteca push
    push:start()

    -- Desenha o plano de fundo com efeito parallax
    love.graphics.draw(background, -backgroundScroll, 0)

    for k, pair in pairs(pipePairs) do
        pair:render()
    end
    -- Desenha o chão com efeito parallax
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    -- Renderiza a instância do pássaro
    bird:render()

    -- Finaliza o renderizador da biblioteca push
    push:finish()
end
