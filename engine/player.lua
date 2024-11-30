Player = Object:extend()

function Player:init()
    self.binding = {}
    self.character = nil
    self.source = nil
    self.actions = {}
    self.type = nil
    self.axis = {left_x = 0, left_y = 0}
end

function Player:update(dt)
    for _, action in ipairs(self.actions) do
        if action.executed == false then
            action.executed = true
            game:do_action(self.binding[action.e.btn], self)
        end
    end

    if self.type == 'joystick' then
        game.CONTROLLER:handle_axis(self.source)
    end
end