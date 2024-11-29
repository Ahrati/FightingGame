Player = Object:extend()

function Player:init()
    self.binding = {}
    self.character = nil
    self.source = nil
    self.actions = {}
end

function Player:set_binds(bind)
end

function Player:update(dt)
    -- do actions needed, save them for calculating combos
end