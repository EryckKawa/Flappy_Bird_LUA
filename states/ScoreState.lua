ScoreState = Class {__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score -- Recebe a pontuação do estado anterior
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed("space") then
        gStateMachine:change("countdown") -- Muda para o estado de contagem regressiva ao pressionar a barra de espaço
    end
end

function ScoreState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf("Nice try!", 0, 64, VIRTUAL_WIDTH, "center") -- Exibe uma mensagem na tela

    love.graphics.setFont(mediumFont)
    love.graphics.printf("Score: " .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, "center") -- Exibe a pontuação

    love.graphics.printf("Presse Space to Play Again!", 0, 160, VIRTUAL_WIDTH, "center") -- Instrução para jogar novamente

    if self.score > 12 then
        love.graphics.printf("You earned a Gold Medal for your performance!!!", 0, 200, VIRTUAL_WIDTH, "center")
        love.graphics.draw(gold, 275, 220)
    elseif self.score > 8 then
        love.graphics.printf("You earned a Silver Medal for your performance!!!", 0, 200, VIRTUAL_WIDTH, "center")
        love.graphics.draw(silver, 275, 220)
    elseif self.score > 4 then
        love.graphics.printf("You earned a Bronze Medal for your performance!!!", 0, 200, VIRTUAL_WIDTH, "center")
        love.graphics.draw(bronze, 275, 220)
    end
end
