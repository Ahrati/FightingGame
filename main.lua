require "engine.object"
require "engine.controller"
require "engine.player"
require "game"
require "common.global"

function love.load()
    game:start()

    -- temp keyboard player
    game:add_player(nil)
    --

end

function love.update(dt)
    game:update(dt)

    -- temp test with keyboard
    --
    local kb = game:get_player_by_source(nil)

    for key, value in pairs(kb.actions) do
        --print(value.btn)
    end
    --
    --
end

function love.draw()
    love.graphics.printf(game.TEXT, 200, 200, 200, "center")
end

function love.keypressed(key)
    game.CONTROLLER:press_button(key, nil)
end

function love.keyreleased(key)
    game.CONTROLLER:release_button(key, nil)
end

function love.gamepadpressed(joystick, button)
    game.CONTROLLER:press_button(button, joystick)
end

function love.gamepadreleased(joystick, button)
    game.CONTROLLER:release_button(button, joystick)
end

function love.joystickadded(joystick)
    game.CONTROLLER:joystick_connected(joystick)
end

function love.joystickremoved(joystick)
    game.CONTROLLER:joystick_disconnected(joystick)
end
