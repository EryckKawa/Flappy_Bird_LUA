-- Classe CountdownState derivada da classe BaseState
CountdownState = Class{__includes = BaseState}

-- Tempo total do contador
COUNTDOWN_TIME = 1

-- Inicialização do estado Countdown
function CountdownState:init()
    -- Inicializa o valor do contador
    self.count = 3
    -- Inicializa o temporizador
    self.timer = 0
end

-- Função de atualização do estado Countdown
function CountdownState:update(dt)
    -- Incrementa o temporizador com o tempo decorrido desde a última atualização
    self.timer = self.timer + dt

    -- Verifica se o temporizador ultrapassou o tempo de contagem regressiva
    if self.timer > COUNTDOWN_TIME then
        -- Reduz o tempo para o próximo número no contador
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1
        
        -- Verifica se o contador chegou a zero
        if self.count == 0 then
            -- Muda o estado do jogo para o estado 'play'
            gStateMachine:change('play')
        end
    end
end

-- Função de renderização do estado Countdown
function CountdownState:render(dt)
    -- Define a fonte usada para renderizar o contador
    love.graphics.setFont(hugeFont)
    -- Renderiza o valor do contador centralizado na tela
    love.graphics.printf(tostring(self.count), 0, 120, VIRTUAL_WIDTH, 'center')
end
