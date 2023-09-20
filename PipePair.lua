PipePair = Class{}  -- Declaração da Classe PipePair

local GAP_HEIGHT = 100  -- Altura do espaço (espaço entre os canos)

function PipePair:init(y)
    self.x = VIRTUAL_WIDTH   -- Define a posição inicial horizontal do par de canos fora da tela à direita
    self.y  = y  -- Define a posição vertical do par de canos com base no argumento 'y' passado ao inicializar

    self.pipes = {
        ['upper'] = Pipe('top', self.y),  -- Cria um cano superior, posicionando-o na coordenada 'y'
        ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + GAP_HEIGHT)  -- Cria um cano inferior, posicionando-o abaixo do cano superior com um espaço 'GAP_HEIGHT'
    }

    self.remove = false  -- Inicializa a variável 'remove' como falsa (será definida como verdadeira quando o par de canos sair da tela)
end

function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt  -- Move o par de canos para a esquerda com base na velocidade ('PIPE_SPEED') e no tempo decorrido ('dt')
        self.pipes['lower'].x = self.x  -- Atualiza a posição horizontal do cano inferior
        self.pipes['upper'].x = self.x  -- Atualiza a posição horizontal do cano superior
    else
        self.remove = true  -- Define 'remove' como verdadeiro quando o par de canos sair completamente da tela
    end
end

function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()  -- Renderiza cada cano (superior e inferior) dentro do par de canos
    end
end
