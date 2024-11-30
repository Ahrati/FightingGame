Game = Object:extend()

function Game:init()
    self:global()
end

function Game:start()

    self.PLAYERS = {}
    self.CONTROLLER = Controller()

    self.ALLOW_JOIN = true

    self.TEXT = ''
    self.TIMER_TEXT = 0
    -- do settings loading here

    --temp
    self.CONTROL_SCHEME = {
        keyboard = {
            default = true,
            type = 'keyboard',
            inputs = {
                ['u'] = game.CONTROLLER.X,
                ['i'] = game.CONTROLLER.Y,
                ['j'] = game.CONTROLLER.A,
                ['k'] = game.CONTROLLER.B,
                ['w'] = game.CONTROLLER.UP,
                ['s'] = game.CONTROLLER.DWN,
                ['a'] = game.CONTROLLER.LFT,
                ['d'] = game.CONTROLLER.RGT,
                ['o'] = game.CONTROLLER.LB,
                ['l'] = game.CONTROLLER.RB,
                ['p'] = game.CONTROLLER.OPT,
            }
        },
        joystick = {
            default = true,
            type = 'joystick',
            inputs = {
                ['x'] = game.CONTROLLER.X,
                ['y'] = game.CONTROLLER.Y,
                ['a'] = game.CONTROLLER.A,
                ['b'] = game.CONTROLLER.B,
                ['dpup'] = game.CONTROLLER.UP,
                ['dpdown'] = game.CONTROLLER.DWN,
                ['dpleft'] = game.CONTROLLER.LFT,
                ['dpright'] = game.CONTROLLER.RGT,
                ['leftshoulder'] = game.CONTROLLER.LB,
                ['rightshoulder'] = game.CONTROLLER.RB,
                ['start'] = game.CONTROLLER.OPT,
            }
        },
    }
end

function Game:add_player(source)
    if self:get_player_by_source(source) ~= nil then return -1 end 

    local player = Player()
    player.source = source

    local type = source == nil and 'keyboard' or 'joystick'
    for _, scheme in pairs(self.CONTROL_SCHEME) do
        if scheme.type == type then
            player.binding = scheme.inputs
        end
    end

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


-- input = {btn, src, time_pressed, time_released}
function Game:add_player_action(input, source)
    local player = self:get_player_by_source(source)
    if player == nil then return false end
    local action = {
        e = input,
        executed = false
    }
    table.insert(player.actions, action)
    return true
end

function Game:update_player_actions(action, source)
end

-- input = {btn, src, time_pressed, time_released}
function Game:unresolved_input(input)
    -- handling joining of new players
    for _, player in ipairs(self.CONTROLLER.UNASSIGNED_PLAYERS) do
        if input.src == player and self.ALLOW_JOIN then
            self:add_player(input.src)
        end
    end

end

function Game:update(dt)
    
    self.CONTROLLER:resolve_registry()

    
    for _, player in ipairs(self.PLAYERS) do
        player:update(dt)
    end
    
    if love.timer.getTime() - self.TIMER_TEXT > 0.6 then
        self.TEXT = ''
        self.TIMER_TEXT = 0
    end
end

function Game:get_sources()
end

-- Action should come in the form of self.CONTROLLER input enum
function Game:do_action(action, player)
    if action == self.CONTROLLER.X then
        self.TEXT = self.TEXT .. ' [X] '
    end
    if action == self.CONTROLLER.Y then
        self.TEXT = self.TEXT .. ' [Y] '
    end
    if action == self.CONTROLLER.A then
        self.TEXT = self.TEXT .. ' [A] '
    end
    if action == self.CONTROLLER.B then
        self.TEXT = self.TEXT .. ' [B] '
    end
    if action == self.CONTROLLER.OPT then
        self.TEXT = self.TEXT .. ' [OPTIONS] '
    end
    if action == self.CONTROLLER.UP then
        self.TEXT = self.TEXT .. ' [UP] '
    end
    if action == self.CONTROLLER.DWN then
        self.TEXT = self.TEXT .. ' [DOWN] '
    end
    if action == self.CONTROLLER.LFT then
        self.TEXT = self.TEXT .. ' [LEFT] '
    end
    if action == self.CONTROLLER.RGT then
        self.TEXT = self.TEXT .. ' [RIGHT] '
    end
    if action == self.CONTROLLER.LB then
        self.TEXT = self.TEXT .. ' [LB] '
    end
    if action == self.CONTROLLER.RB then
        self.TEXT = self.TEXT .. ' [RB] '
    end

    self.TIMER_TEXT = love.timer.getTime()
end
