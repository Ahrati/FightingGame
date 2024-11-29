Controller = Object:extend()

function Controller:init()
    self.UNASSIGNED_PLAYERS = {}
    self.REGISTRY = {}

    local joysticks = love.joystick.getJoysticks()
    if joysticks then
        self.UNASSIGNED_PLAYERS = joysticks
    end
end

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
        if input.btn == button and input.source == source and input.time_released == nil then
            input.time_released = love.timer.getTime()
        end
    end
end

function Controller:assign_player()
end

function Controller:resolve_registry()
    for i, input in ipairs(self.REGISTRY) do
        if input.time_released ~= nil then
            if game:add_player_action(input, input.source) then
                table.remove(self.REGISTRY, i)
            else
                game:unresolved_input(input)
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
end