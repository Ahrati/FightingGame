controlScheme = {
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
            ['x'] = game.CONTROLLER.UP,
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

return controlScheme