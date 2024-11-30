Controller = Object:extend()

function Controller:init()
    self.UNASSIGNED_PLAYERS = {}
    self.REGISTRY = {}

    self.SELECTED_NODE = nil

    local joysticks = love.joystick.getJoysticks()
    if joysticks then
        self.UNASSIGNED_PLAYERS = joysticks
    end

    -- button enums
    self.X = 1
    self.Y = 2
    self.A = 3
    self.B = 4
    self.UP = 11
    self.DWN = 12
    self.LFT = 13
    self.RGT = 14
    self.LB = 21
    self.RB = 22
    self.OPT = 0


end


-- NEED TO ADD BUTTON HOLDING
function Controller:press_button(button, source)
    local pressed = {
        btn = button, 
        src = source,
        time_pressed = love.timer.getTime(), 
        time_released = nil
    }
    table.insert(self.REGISTRY, pressed)
end

function Controller:release_button(button, source)
    for key, input in pairs(self.REGISTRY) do
        if input.btn == button and input.src == source and input.time_released == nil then
            input.time_released = love.timer.getTime()
        end
    end
end

function Controller:resolve_registry()
    for i, input in ipairs(self.REGISTRY) do
        if input.time_released ~= nil then
            if game:add_player_action(input, input.src) then
                table.remove(self.REGISTRY, i)
            else
                if game:unresolved_input(input) then
                    game:add_player_action(input, input.src)
                end
                table.remove(self.REGISTRY, i)
            end
        end
    end
end

function Controller:joystick_connected(source)
    local new = Player()
    new.source = source
    
    table.insert(self.UNASSIGNED_PLAYERS, new)
end

function Controller:joystick_disconnected(source)
    for i, player in ipairs(self.UNASSIGNED_PLAYERS) do
        if player.source == source then
            table.remove(self.UNASSIGNED_PLAYERS, i)
        end
    end
    for i, player in ipairs(game.PLAYERS) do
        if player.source == source then
            table.remove(game.PLAYERS, i)
        end
    end
end

function Controller:handle_axis(source)
    local player = game:get_player_by_source(source)
    if player ~= nil then
        local left_x = player.source:getGamepadAxis('leftx')
        local left_y = player.source:getGamepadAxis('lefty')
        if math.abs(left_x) > player.deadzone or math.abs(left_y) > player.deadzone then
            local axis = math.abs(left_x) > math.abs(left_y) and (left_x > 0 and 'dpright' or 'dpleft') or (left_y > 0 and 'dpdown' or 'dpup')
            self:press_button(axis, source)
            self:release_button(axis, source)
        end
    end
end