
  -- First create a table specifying the staircases we want to set:
  local staircases = {
    ["MinionMath-Regular"] = {
      ["u1D43B"] = {
        bottomright = {
          {height=305,kern=-50},
          {height=405,kern=-20},
          {kern=0}
        },
      },
    },
  }
  local function initstaircase(tfmdata)
    local values = staircases[tfmdata.properties.psname]
    if not values then return end
    for cp, value in next, values do
      local tcp = type(cp)
      if tcp == 'string' then
        cp = tfmdata.resources.unicodes[cp]
      end
      local char = tfmdata.characters[cp]
      if char then
        local staircase = char.staircases
        if not staircase then
          staircase = {}
          char.staircases = staircase
        end
        for corner, v in next, value do
          staircase[corner] = v
        end
      end
    end
  end
  fonts.constructors.newfeatures'otf'.register{
    name = 'staircase',
    description = 'Overwrite staircase values',
    initializers = {
      base = initstaircase,
    },
  }
