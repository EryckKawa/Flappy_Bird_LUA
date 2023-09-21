-- Declaração da classe Bird
Bird = Class {}

-- Gravidade aplicada ao pássaro
local GRAVITY = 20

-- Inicialização da instância do Bird
function Bird:init()
    -- Carrega a imagem do pássaro
    self.image = love.graphics.newImage("assets/bird.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    -- Posiciona o pássaro no meio da tela
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    -- Velocidade vertical (dy) inicial
    self.dy = 0
end

-- Verifica se há colisão entre o pássaro e um cano
function Bird:collides(pipe)
    -- Colisão AABB (caixa delimitadora)
    if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
        if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end

    return false
end

-- Atualiza o estado do pássaro
function Bird:update(dt)
    -- Aplica a gravidade ao deslocamento vertical
    self.dy = self.dy + GRAVITY * dt

    -- Verifica se a tecla "espaço" foi pressionada para fazer o pássaro subir
    if love.keyboard.wasPressed("space") then
        self.dy = -5 -- Impulso vertical para cima
    end

    -- Atualiza a posição vertical do pássaro
    self.y = self.y + self.dy
end

-- Renderiza o pássaro na tela
function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end
