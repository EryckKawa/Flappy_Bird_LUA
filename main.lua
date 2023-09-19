-- Bibliotecas necessárias
push = require 'push' -- Biblioteca para ajustar a resolução da tela
Class = require 'class' -- Biblioteca para criar classes

-- Classes personalizadas
require 'Bird' -- Importa a classe Bird do arquivo Bird.lua

require 'Pipe' -- Importa a classe Pipe do arquivo Pipe.lua

-- Dimensões da janela
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- Importa as imagens do plano de fundo e do chão
local background = love.graphics.newImage('assets/background.png')
local ground = love.graphics.newImage('assets/ground.png')

-- Efeito parallax para o plano de fundo
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 413

-- Efeito parallax para o chão
local groundScroll = 0
local GROUND_SCROLL_SPEED = 60

-- Cria uma instância da classe Bird
local bird = Bird()

local pipes = {}

local spawnTimer = 0

function love.load()
    -- Aplica um filtro na janela para evitar o efeito de desfoque dos pixels
    -- devido ao dimensionamento da tela com a dimensão virtual
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Define o título da janela
    love.window.setTitle('Flappppppyyyyyyyy Bird')
    
    -- Configura a tela usando a biblioteca push
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = false, -- Janela não é em tela cheia
        vsync = true,       -- VSync ativado para evitar screen tearing
        resizable = true    -- A janela pode ser redimensionada
    })

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
        table.insert(pipes, Pipe())
        spawnTimer = 0
    end

    for k, pipe in pairs(pipes) do
        pipe:update(dt)
        if pipe.x < -pipe.width then
            table.remove(pipes, k)
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

    for k, pipe in pairs(pipes) do
        pipe:render()
    end
    -- Desenha o chão com efeito parallax
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    -- Renderiza a instância do pássaro
    bird:render()

    -- Finaliza o renderizador da biblioteca push
    push:finish()
end
