-- Declaração da Classe `Pipe`
Pipe = Class {}

-- Carregamento da Imagem do Tubo
local PIPE_IMAGE = love.graphics.newImage('assets/pipe.png')

-- Velocidade de Deslocamento do Tubo
local PIPE_SCROLL = -60

-- Inicialização da Instância de Tubo
function Pipe:init()
    -- Define a posição inicial horizontal do tubo fora da tela à direita
    self.x = VIRTUAL_WIDTH

    -- Define a posição vertical do tubo como um valor aleatório entre 1/4 da altura virtual e a altura virtual menos 10 pixels
    self.y = math.random(VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT - 10)

    -- Obtém a largura da imagem do tubo e a armazena na variável self.width (usada para detecção de colisão)
    self.width = PIPE_IMAGE:getWidth()
end

-- Atualização do Tubo
function Pipe:update(dt)
    -- Atualiza a posição horizontal do tubo com base no tempo decorrido multiplicado pela velocidade de deslocamento
    self.x = self.x + PIPE_SCROLL * dt
end

-- Renderização do Tubo
function Pipe:render()
    -- Desenha a imagem do tubo na posição atual do tubo (arredondando as coordenadas para evitar problemas de renderização)
    love.graphics.draw(PIPE_IMAGE, math.floor(self.x + 0.5), math.floor(self.y))
end
