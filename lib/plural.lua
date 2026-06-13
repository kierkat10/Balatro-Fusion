-- simple plural s function for localization
-- taken right from cryptid with a single change to support empty fields lol
function BalatroFusion.pluralize(str, vars)
    local inside = str:match("<(.-)>") -- finds args
    local _table = {}
    if inside then
        for v in (inside .. ","):gmatch("([^,]*),") do -- adds args to array (capture empty fields too)
            table.insert(_table, v)
        end
        local num = vars[tonumber(string.match(str, ">(%d+)"))] -- gets reference variable
        if type(num) == "string" then
            num = (Big and to_number(to_big(num))) or num
        end
        if not num then
            num = 1
        end
        local plural = _table[1] -- default
        local checks = { [1] = "=" } -- checks 1 by default
        local checks1mod = false -- tracks if 1 was modified
        if #_table > 1 then
            for i = 2, #_table do
                local isnum = tonumber(_table[i])
                if isnum then
                    if not checks1mod then
                        checks[1] = nil
                    end -- dumb stuff
                    checks[isnum] = "<" .. (_table[i + 1] or "") -- do less than for custom values
                    if isnum == 1 then
                        checks1mod = true
                    end
                    i = i + 1
                elseif i == 2 then
                    checks[1] = "=" .. _table[i]
                end
            end
        end
        local function fch(str, c)
            return string.sub(str, 1, 1) == c -- gets first char and returns boolean
        end
        local keys = {}
        for k in pairs(checks) do
            table.insert(keys, k)
        end
        table.sort(keys, function(a, b)
            return a < b
        end)
        if not (tonumber(num) or is_number(num)) then
            num = 1
        end
        for _, k in ipairs(keys) do
            if fch(checks[k], "=") then
                if to_big(math.abs(math.abs(num) - k)) < to_big(0.001) then
                    return string.sub(checks[k], 2, -1)
                end
            elseif fch(checks[k], "<") then
                if to_big(num) < to_big(k - 0.001) then
                    return string.sub(checks[k], 2, -1)
                end
            end
        end
        return plural
    end
end

-- Redefined here to include pluralize function
function SMODS.localize_box(lines, args)
    local final_line = {}
    for _, part in ipairs(lines) do
        if part.control.element then
            local elem = args.vars.elements[tonumber(part.control.element)]
            if elem.is and elem:is(Node) then
                elem = { n=G.UIT.O, config = { object = elem }}
            end
            final_line[#final_line+1] = elem
        end
        local assembled_string = ''
        for _, subpart in ipairs(part.strings) do
            assembled_string = assembled_string..(type(subpart) == 'string' and subpart or (BalatroFusion.pluralize and BalatroFusion.pluralize(subpart[1], args.vars)) or format_ui_value(args.vars[tonumber(subpart[1])]) or format_ui_value(args.vars[tonumber(subpart[1])]) or 'ERROR')
        end

        local thunk = {
            bg_col = part.control.B and args.vars.colours[tonumber(part.control.B)] or part.control.X and loc_colour(part.control.X) or nil,
            text_col = part.control.V and args.vars.colours[tonumber(part.control.V)] or part.control.C and loc_colour(part.control.C),
            underline = part.control.u and loc_colour(part.control.u),
            strikethrough = part.control.st and loc_colour(part.control.st),
            font = SMODS.Fonts[part.control.f] or G.FONTS[tonumber(part.control.f)],
            scale_mod = part.control.s and tonumber(part.control.s) or args.scale  or 1
        }
        local desc_scale = (thunk.font or G.LANG.font).DESCSCALE
        if G.F_MOBILE_UI then desc_scale = desc_scale*1.5 end
        
        if args.type == 'name' then
            local final_name_assembled_string = ''
            for _, part in ipairs(lines) do
              local assembled_string_part = ''
              for _, subpart in ipairs(part.strings) do
                  assembled_string_part = assembled_string_part..(type(subpart) == 'string' and subpart or format_ui_value(format_ui_value(args.vars[tonumber(subpart[1])])) or 'ERROR')
              end
              final_name_assembled_string = final_name_assembled_string..assembled_string_part
          end
          final_line[#final_line+1] = {n=G.UIT.C, config={align = "m", colour = thunk.bg_col, r = 0.05, padding = 0.03, res = 0.15}, nodes={}}
          final_line[#final_line].nodes[1] = {n=G.UIT.O, config={
          button = part.control.button,
          underline = thunk.underline,
          strikethrough = thunk.strikethrough,
            object = DynaText({string = {assembled_string},
              colours = {thunk.text_col or args.text_colour or G.C.UI.TEXT_LIGHT},
              bump = not args.no_bump,
              text_effect = SMODS.DynaTextEffects[part.control.E] and part.control.E,
              silent = not args.no_silent,
              pop_in = (not args.no_pop_in and (args.pop_in or 0)) or nil,
              pop_in_rate = (not args.no_pop_in and (args.pop_in_rate or 4)) or nil,
              maxw = args.maxw or 5,
              shadow = not args.no_shadow,
              y_offset = args.y_offset or -0.6,
              spacing = (not args.no_spacing and math.max(0, 0.32*(17 - #(final_name_assembled_string or assembled_string)))) or nil,
              font = thunk.font,
              button = part.control.button,
              strikethrough = part.control.st and loc_colour(part.control.st),
              underline = part.control.u and loc_colour(part.control.u),
              scale = (0.55 - 0.004*#(final_name_assembled_string or assembled_string))*thunk.scale_mod*(args.fixed_scale or 1)
            })
          }}
        elseif part.control.E then
            local _float, _silent, _pop_in, _bump, _spacing = nil, true, nil, nil, nil
            local text_effects
            if part.control.E == '1' then
                _float = true; _silent = true; _pop_in = 0
            elseif part.control.E == '2' then
                _bump = true; _spacing = 1
            elseif SMODS.DynaTextEffects[part.control.E] then
                text_effects = part.control.E
            end
            final_line[#final_line+1] = {n=G.UIT.C, config={align = "m", colour = thunk.bg_col, r = 0.05, padding = 0.03, res = 0.15}, nodes={}}
            final_line[#final_line].nodes[1] = {n=G.UIT.O, config={
                button = part.control.button,
                underline = thunk.underline,
                strikethrough = thunk.strikethrough,
                object = DynaText({string = {assembled_string}, colours = {thunk.text_col or loc_colour()},
                    float = _float,
                    silent = _silent,
                    pop_in = _pop_in,
                    bump = _bump,
                    text_effect = text_effects,
                    spacing = _spacing,
                    font = thunk.font,
                    scale = 0.32*thunk.scale_mod*desc_scale})
                }
            }
        elseif part.control.X or part.control.B then
            final_line[#final_line+1] = {n=G.UIT.C, config={align = "m", colour = part.control.B and args.vars.colours[tonumber(part.control.B)] or loc_colour(part.control.X), r = 0.05, padding = 0.03, res = 0.15}, nodes={
                {n=G.UIT.T, config={
                    button = part.control.button,
                    text = assembled_string,
                    colour = thunk.text_col or loc_colour(),
                    font = thunk.font,
                    underline = thunk.underline,
                    strikethrough = thunk.strikethrough,
                    scale = 0.32*thunk.scale_mod*desc_scale}},
                }}
        else
            final_line[#final_line+1] = {n=G.UIT.T, config={
                button = part.control.button,
                detailed_tooltip = part.control.T and (G.P_CENTERS[part.control.T] or G.P_TAGS[part.control.T]) or nil,
                text = assembled_string,
                shadow = args.shadow,
                colour = thunk.text_col or args.text_colour or loc_colour(nil, args.default_col),
                font = thunk.font,
                underline = thunk.underline,
                strikethrough = thunk.strikethrough,
                scale = 0.32*thunk.scale_mod*desc_scale
            }}
        end
    end
    return final_line
end