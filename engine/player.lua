Player = Object:extend()

function Player:init()
    self.binding = {}
    self.character = nil
    self.source = nil
    self.actions = {}
end

function Player:update(dt)
    -- do actions needed, save them for calculating combos
    -- example:
    for _, action in ipairs(self.actions) do
        if action.executed == false then
            action.executed = true
            game:do_action(self.binding[action.e.btn], self)
        end
    end
end