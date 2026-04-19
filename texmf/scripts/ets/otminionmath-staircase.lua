local mathkerns = {
    ["MinionMath-Regular"] = {
        ["u1D43B"] = { -- H
            bottomright = {
                {height=200,kern=-50},
                {height=300,kern=-30},
                {kern=0}
            },
        },
        ["u1D43C"] = { -- I
            bottomright = {
                {height=200,kern=-40},
                {height=300,kern=-20},
                {kern=-0}
            },
        },
        ["u1D447"] = { -- T
            bottomright = {
                {height=200,kern=-170},
                {height=400,kern=-110},
                {kern=-70}
            },
        },
        ["u1D448"] = { -- U
            bottomright = {
                {height=200,kern=-50},
                {height=400,kern=-40},
                {kern=-30}
            },
        },
        ["u1D44A"] = { -- W
            bottomright = {
                {height=200,kern=-130},
                {height=400,kern=-100},
                {kern=-50}
            },
        },
        ["u1D453"] = { -- f
            bottomright = {
                {height=200,kern=-160},
                {height=300,kern=-120},
                {kern=0}
            },
        },
    },
}
local function initmathkern(tfmdata)
    local values = mathkerns[tfmdata.properties.psname]
    if not values then return end
    for cp, value in next, values do
        local tcp = type(cp)
        if tcp == 'string' then
            cp = tfmdata.resources.unicodes[cp]
        end
        local char = tfmdata.characters[cp]
        if char then
            local mathkern = char.mathkerns
            if not mathkern then
                mathkern = {}
                char.mathkerns = mathkern
            end
            for corner, v in next, value do
                mathkern[corner] = v
            end
        end
    end
end
fonts.constructors.newfeatures'otf'.register{
    name = 'staircase',
    description = 'Overwrite mathkern values',
    initializers = {
        base = initmathkern,
    },
}

