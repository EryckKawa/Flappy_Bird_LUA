-- Define o estado `PauseState` como uma classe derivada de `BaseState`
PauseState = Class {__includes = BaseState}

function PauseState:update(dt)
    -- Verifica se a tecla 'p' foi pressionada para retomar o jogo
    if love.keyboard.wasPressed("p") then
        -- Muda o estado de volta para "play" e passa os parâmetros necessários para retomar o jogo
        gStateMachine:change(
            "play",
            {
                bird = self.bird,            -- Passa a instância do pássaro
                pipePairs = self.pipePairs,  -- Passa a tabela de pares de canos
                timer = self.timer,          -- Passa o temporizador
                score = self.score,          -- Passa a pontuação
                lastY = self.lastY,          -- Passa a posição vertical do último par de canos gerado
                gap = self.gap               -- Passa a distância entre os canos
            }
        )
    end
end

function PauseState:enter(params)
    -- Quando entra no estado de pausa, desativa o deslocamento do cenário e pausa a música
    scrolling = false
    sounds["music"]:pause()

    -- Recupera os parâmetros passados ao entrar no estado
    self.bird = params.bird            -- Obtém a instância do pássaro
    self.pipePairs = params.pipePairs  -- Obtém a tabela de pares de canos
    self.timer = params.timer          -- Obtém o temporizador
    self.score = params.score          -- Obtém a pontuação

    self.lastY = params.lastY          -- Obtém a posição vertical do último par de canos gerado
    self.gap = params.gap              -- Obtém a distância entre os canos
end

function PauseState:exit()
    -- Quando sai do estado de pausa, retoma o deslocamento do cenário e a música
    scrolling = true
    sounds["music"]:play()
end

function PauseState:render()
    -- Renderiza os pares de canos na tela
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    -- Define a fonte e exibe a pontuação atual na tela
    love.graphics.setFont(flappyFont)
    love.graphics.print("Score: " .. tostring(self.score), 8, 8)

    -- Renderiza o pássaro na tela
    self.bird:render()
    
    -- Exibe o texto "PAUSED" no centro da tela
    love.graphics.printf("PAUSED", 0, 120, VIRTUAL_WIDTH, "center")

end
