Game = Object:extend()

function Game:init()
    self:global()
end

function Game:start()

    self.PLAYERS = {}
    self.CONTROLLER = Controller()

    self.ALLOW_JOIN = true

    -- do settings loading here
end

function Game:add_player(source)
    if self:get_player_by_source(source) ~= nil then return -1 end 
    local player = Player()
    player.source = source
    table.insert(self.PLAYERS, player)
end

function Game:get_player_by_source(source)
    for _, player in pairs(self.PLAYERS) do
        if player.source == source then
            return player
        end
    end
    return nil
end

function Game:add_player_action(action, source)
    local player = self:get_player_by_source(source)
    if player == nil then return false end
    table.insert(player.actions, action)
    return true
end

function Game:update_player_actions(action, source)
end


function Game:unresolved_input(input)

    -- handling joining of new players
    for _, player in ipairs(self.UNASSIGNED_PLAYERS) do
        if input.source == player and self.ALLOW_JOIN then
            self:add_player(input.source)
        end
    end

end

function Game:update(dt)
    
    self.CONTROLLER:resolve_registry()

    
    for _, player in ipairs(self.PLAYERS) do
        player:update(dt)
    end
end

function Game:get_sources()
end