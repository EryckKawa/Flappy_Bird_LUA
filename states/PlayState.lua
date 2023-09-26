PlayState = Class {__includes = BaseState}

-- Velocidade e dimensões dos canos e do pássaro
PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288
BIRD_WIDTH = 38
BIRD_HEIGHT = 24

function PlayState:init()
    -- Inicializa o estado de jogo com o pássaro, pares de canos, temporizador e pontuação
    self.bird = Bird()                -- Cria uma instância do pássaro
    self.pipePairs = {}               -- Inicializa uma tabela para armazenar os pares de canos
    self.timer = 0                    -- Inicializa um temporizador para gerar pares de canos
    self.score = 0                   -- Inicializa a pontuação do jogador
    self.gap = 2                     -- Inicializa um temporizador para contar a distância entre os canos
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20 -- Inicializa a posição vertical do último par de canos gerado
end

function PlayState:update(dt)
    -- Atualiza o temporizador
    self.timer = self.timer + dt
    
    -- Gera novos pares de canos a cada 2 segundos
    if self.timer > self.gap then
        local y = math.max(-PIPE_HEIGHT + 10, math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = y
        table.insert(self.pipePairs, PipePair(y)) -- Cria e adiciona um novo par de canos à tabela
        self.gap = 2 + math.random(-0.5, 0.5)
        self.timer = 0
    end
    
    -- Verifica se o pássaro passou pelos canos para marcar pontos
    for k, pair in pairs(self.pipePairs) do
        if not pair.scored then
            if pair.x + PIPE_WIDTH < self.bird.x then
                self.score = self.score + 1
                pair.scored = true
                sounds["score"]:play()
            end
        end

        pair:update(dt) -- Atualiza o par de canos

    end
    
    -- Verifica colisões entre o pássaro e os canos
    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                -- Toca o som de explosão e de dano
                sounds["explosion"]:setVolume(desiredVolume)
                sounds["explosion"]:play()
                sounds["hurt"]:setVolume(desiredVolume)
                sounds["hurt"]:play()
                
                -- Muda o estado para o estado de pontuação com a pontuação atual
                gStateMachine:change("score", {score = self.score})
            end
        end
    end
    -- Remove pares de canos que estão fora da tela
    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end


    self.bird:update(dt) -- Atualiza o pássaro

    -- Verifica se o pássaro atingiu o chão para terminar o jogo
    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        -- Toca o som de explosão e de dano
        sounds["explosion"]:setVolume(desiredVolume)
        sounds["explosion"]:play()
        sounds["hurt"]:setVolume(desiredVolume)
        sounds["hurt"]:play()

        -- Muda o estado para o estado de pontuação com a pontuação atual
        gStateMachine:change("score", {score = self.score})
    end

end

function PlayState:render()
    -- Renderiza todos os pares de canos
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    -- Define a fonte para exibir a pontuação
    love.graphics.setFont(flappyFont)
    love.graphics.print("Score: " .. tostring(self.score), 8, 8)

    self.bird:render() -- Renderiza o pássaro
end

function PlayState:enter(params)
    scrolling = true -- Inicia o deslocamento do cenário
    if params then
        self.bird = params.bird
        self.pipePairs = params.pipePairs
        self.timer = params.timer
        self.score = params.score
        self.lastY = params.lastY
    end
end

function PlayState:exit()
    scrolling = false -- Para o deslocamento do cenário ao sair do estado de jogo
end
