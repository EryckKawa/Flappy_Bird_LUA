TitleScreenState = Class {__includes = BaseState}

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed("space") then
        gStateMachine:change("countdown") -- Muda para o estado de contagem regressiva ao pressionar a barra de espaço
    end
end

function TitleScreenState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf("Twitterry!", 0, 64, VIRTUAL_WIDTH, "center") -- Exibe o título do jogo

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Press Space to Play!", 0, 100, VIRTUAL_WIDTH, "center") -- Instrução para começar a jogar
end
