Game = Object:extend()

function Game:init()
    self:global()
end

function Game:start()

    self.PLAYERS = {}
    self.CONTROLLER = Controller()

    self.ALLOW_JOIN = true
    self.NUM_PLAYERS = 0

    self.TEXT = ''
    self.TIMER_TEXT = 0
    -- do settings loading here


    self.CONTROL_SCHEME = {
        keyboard = {
            type = 'keyboard',
            inputs = {
                ['u'] = self.CONTROLLER.X,
                ['i'] = self.CONTROLLER.Y,
                ['j'] = self.CONTROLLER.A,
                ['k'] = self.CONTROLLER.B,
                ['w'] = self.CONTROLLER.UP,
                ['s'] = self.CONTROLLER.DWN,
                ['a'] = self.CONTROLLER.LFT,
                ['d'] = self.CONTROLLER.RGT,
                ['o'] = self.CONTROLLER.LB,
                ['l'] = self.CONTROLLER.RB,
                ['p'] = self.CONTROLLER.OPT,
            }
        },
        joystick = {
            type = 'joystick',
            inputs = {
                ['x'] = self.CONTROLLER.X,
                ['y'] = self.CONTROLLER.Y,
                ['a'] = self.CONTROLLER.A,
                ['b'] = self.CONTROLLER.B,
                ['dpup'] = self.CONTROLLER.UP,
                ['dpdown'] = self.CONTROLLER.DWN,
                ['dpleft'] = self.CONTROLLER.LFT,
                ['dpright'] = self.CONTROLLER.RGT,
                ['leftshoulder'] = self.CONTROLLER.LB,
                ['rightshoulder'] = self.CONTROLLER.RB,
                ['start'] = self.CONTROLLER.OPT,
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
    for i, player in ipairs(self.CONTROLLER.UNASSIGNED_PLAYERS) do
        if input.src == player.source and self.ALLOW_JOIN then
            self:add_player(input.src)
            table.remove(self.CONTROLLER.UNASSIGNED_PLAYERS, i)
            return true
        end
    end
    return false
end

function Game:update(dt)
    
    -- updating game variables
    self.NUM_PLAYERS = table.getn(self.PLAYERS)



    --

    self.CONTROLLER:resolve_registry()
    
    for _, player in ipairs(self.PLAYERS) do
        player:update(dt)
    end
    
    if love.timer.getTime() - self.TIMER_TEXT > 0.6 then
        self.TEXT = ''
        self.TIMER_TEXT = 0
    end

    --

    if self.NUM_PLAYERS >= self.MAX_PLAYERS then
        self.ALLOW_JOIN = false
    end
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
