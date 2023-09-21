-- Declaração da Classe `Pipe`
Pipe = Class {}

-- Carregamento da Imagem do Tubo
local PIPE_IMAGE = love.graphics.newImage("assets/pipe.png")

-- Velocidade de Deslocamento, Altura e Largura do Tubo
PIPE_SPEED = 60
PIPE_HEIGHT = 288
PIPE_WIDTH = 70

-- Inicialização da Instância de Tubo
function Pipe:init(orientation, y)
    -- Define a posição inicial horizontal do tubo fora da tela à direita
    self.x = VIRTUAL_WIDTH
    -- Define a posição vertical do cano
    self.y = y

    -- Obtém a largura da imagem do tubo e a armazena na variável self.width (usada para detecção de colisão)
    self.width = PIPE_IMAGE:getWidth()
    --Altura definida nas constantes
    self.height = PIPE_HEIGHT

    -- A orientação do tubo, 'top' para o tubo superior e 'bottom' para o tubo inferior
    self.orientation = orientation
end

-- Atualização do Tubo
function Pipe:update(dt)
end

-- Renderização do Tubo
function Pipe:render()
    -- Desenha o tubo na tela. A posição Y é ajustada com base na orientação do tubo.
    -- Se for um tubo superior, a posição Y é invertida para que ele pareça estar pendurado no teto.
    love.graphics.draw(
        PIPE_IMAGE,
        self.x,
        (self.orientation == "top" and self.y + PIPE_HEIGHT or self.y),
        0,
        1,
        self.orientation == "top" and -1 or 1
    )
end
