-- Importação de bibliotecas
push = require "push"       -- Biblioteca para ajustar a resolução da tela
Class = require "class"     -- Biblioteca para criar classes

-- Importação de estados do jogo
require "StateMachine"
require "states/BaseState"
require "states/CountdownState"
require "states/PlayState"
require "states/ScoreState"
require "states/TitleScreenState"
require "states/PauseState"
-- Importação de classes personalizadas
require "Bird"
require "Pipe"
require "PipePair"

-- Dimensões da janela
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
--Coloquei outra largura pra corrigir um bug visual :c
VIRTUAL_WIDTH = 550
VIRTUAL_HEIGHT = 288

-- Carrega imagens de fundo e chão
local background = love.graphics.newImage("assets/background.png")
local ground = love.graphics.newImage("assets/ground.png")

-- Configuração do efeito parallax para o plano de fundo
local backgroundScroll = 0
local BACKGROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT = 413

-- Configuração do efeito parallax para o chão
local groundScroll = 0
local GROUND_SCROLL_SPEED = 60

-- Volume desejado para os sons
desiredVolume = 0.1

-- Variável para controlar o deslocamento
scrolling = true

function love.load()
    -- Configura o filtro de escala para evitar desfoque de pixels
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Inicializa a semente do gerador de números aleatórios
    math.randomseed(os.time())

    -- Define o título da janela
    love.window.setTitle("Twitterry Bird")

    
    -- Carrega diferentes tamanhos de fonte
    smallFont = love.graphics.newFont("assets/font.ttf", 8)
    mediumFont = love.graphics.newFont("assets/flappy.ttf", 14)
    flappyFont = love.graphics.newFont("assets/flappy.ttf", 28)
    hugeFont = love.graphics.newFont("assets/flappy.ttf", 56)
    
    -- Define a fonte padrão
    love.graphics.setFont(flappyFont)

    -- Carrega os sons do jogo
    sounds = {
        ["jump"] = love.audio.newSource("sounds/jump.wav", "static"),
        ["explosion"] = love.audio.newSource("sounds/explosion.wav", "static"),
        ["hurt"] = love.audio.newSource("sounds/hurt.wav", "static"),
        ["score"] = love.audio.newSource("sounds/score.wav", "static"),
        ["music"] = love.audio.newSource("sounds/marios_way.mp3", "static")
    }
    
    -- Configura a música para repetição contínua e define o volume
    sounds["music"]:setLooping(true)
    sounds["music"]:setVolume(desiredVolume)
    sounds["music"]:play()
    
    -- Configura a tela usando a biblioteca push
    push:setupScreen(
        VIRTUAL_WIDTH,
        VIRTUAL_HEIGHT,
        WINDOW_WIDTH,
        WINDOW_HEIGHT,
        {
            fullscreen = false,
            vsync = true,
            resizable = true
        }
    )

    -- Cria uma máquina de estados para gerenciar o jogo
    gStateMachine =
    StateMachine {
        ["title"] = function()
            return TitleScreenState()
        end,
        ["countdown"] = function()
            return CountdownState()
        end,
        ["play"] = function()
            return PlayState()
        end,
        ["score"] = function()
            return ScoreState()
        end,
        ["pause"] = function()
            return PauseState()
        end
    }
    
    -- Inicializa o estado do jogo com o estado do título
    gStateMachine:change("title")

    -- Inicializa a tabela de teclas pressionadas
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    -- Atualiza o redimensionamento da tela usando a biblioteca push
    push:resize(w, h)
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end


function love.update(dt)
    -- Atualiza o deslocamento do plano de fundo e do chão com base no tempo decorrido
    if scrolling then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH
    end

    -- Atualiza o estado atual da máquina de estados
    gStateMachine:update(dt)

    -- Limpa a tabela de teclas pressionadas
    love.keyboard.keysPressed = {}
end


function love.keypressed(key)
    -- Fecha o jogo se a tecla Esc for pressionada
    if key == "escape" then
        love.event.quit()
    end

    -- Registra a tecla pressionada na tabela
    love.keyboard.keysPressed[key] = true
end

function love.draw()
    -- Inicia o renderizador da biblioteca push
    push:start()

    -- Desenha o plano de fundo com efeito parallax
    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    
    push:finish()
    
end