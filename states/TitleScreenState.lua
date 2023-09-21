TitleScreen = Class{__includes = BaseState}

function TitleScreen:init()
    
end

function TitleScreen:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('coundown')
    end
end

function TitleScreen:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Twitterry!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter!', 0, 100, VIRTUAL_WIDTH, 'center')
end