PauseState = Class{__includes = BaseState}

function PauseState:init()
    -- Aqui você pode adicionar elementos à tela de pausa, como texto, botões, etc.
end

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('play')
    end
end

function PauseState:render()
    love.graphics.printf("PAUSED",0, 120, VIRTUAL_WIDTH,'center')
end