sets = {}
function sets.intersects(a, b)
    local res = {}
    local count = 0

    if (next(a) == nil or next(b) == nil) then return false end

    for k, v in pairs(a) do
        if a[k] and b[k] then
            res[k] = true
            count = count + 1
        end
    end
    for k, v in pairs(b) do
        if a[k] and b[k] then
            res[k] = true
            count = count + 1
        end
    end

    return count > 0
end

-- recur on nested tables
function sets.tostring(tbl)
    local r = nil
    for ikey, ival in sets.spairs(tbl) do

        if r then
            r = r .. ", "
        else
            r = "{ "
        end

        r = r .. tostring(ikey) .. ":"
        if type(ival) == "table" then
            r = r .. sets.tostring(ival)
        else
            r = r .. tostring(ival)
        end
    end

    if r then
        r = r .. " }"
    else
        r = ""
    end

    return r
end

function sets.apply(tbl, func) for i, v in pairs(tbl) do func(v) end end

-- example usage:
--  level.tilesets = {{name="a",val=123}{name="b",val=234}{name="c", val=345}}
--  tilesets = index(level.tilesets,name)
-- allows access by
--  tilesets[name]
--
function sets.indexon(tbl, id)
    local rtbl = {}
    for i, v in pairs(tbl) do rtbl[v[id]] = tbl[i] end
    return rtbl
end

-- applies func to all values in tbl
function sets.map(tbl, func)
    local rtbl = {}
    for i, v in pairs(tbl) do rtbl[i] = func(v) end
    return rtbl
end

-- appends if there are no overlapping indexes
function sets.append(tbla, tblb)
    local rtbl = tbla
    for i, v in pairs(tblb) do
        if rtbl[i] then

            -- assert(false, "ERROR: index collision appending tables")
        else
            rtbl[i] = v
        end
    end
    return rtbl
end

function sets.spairs(t, order)
    -- collect the keys
    local keys = {}
    if type(t) == 'table' then
        for k in pairs(t) do keys[#keys + 1] = k end

        -- if order function given, sort by it by passing the table and keys a, b,
        -- otherwise just sort the keys 
        if order then
            table.sort(keys, function(a, b) return order(t, a, b) end)
        else
            table.sort(keys, function(a, b)
                if (type(a) == 'number' and type(b) == 'number') or
                    (type(a) == 'string' and type(b) == 'string') then
                    return a > b
                else
                    return false
                end
            end)
        end

        -- return the iterator function
        local i = 0
        return function()
            i = i + 1
            if keys[i] then return keys[i], t[keys[i]] end
        end
    else
        return nil
    end
end

function sets.pop(set)
    v = set[1]
    table.remove(set, 1)
    return v
end

function sets.stringsplit(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end
