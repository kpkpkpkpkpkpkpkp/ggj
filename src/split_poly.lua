Polygon = require 'lib.HC.polygon'
hcvector = require 'lib.HC.vector-light'
local vector = require 'lib.vector'


function split_poly(shape, x, y, dx, dy)
    poly1 = {}
    poly2 = {}
    
    a, b = getIntersects(shape, x, y, dx, dy)
    a.x, a.y = a:unpack()
    b.x, b.y = b:unpack()
    
    for i, v in pairs(shape.vertices) do
        q = shape.vertices[i + 1]
        --check which 'side' of line a,b the point is on, and add it to one of the two shapes
        position = (b.x - a.x) * (v.y - a.y) - (b.y - a.y) * (v.x - a.x)
        if position < 0 then
            table.insert(poly1, v)
        
        elseif position > 0 then
            table.insert(poly2, v)
        end
    end
    table.insert(poly1, a)
    table.insert(poly1, b)
    table.insert(poly2, a)
    table.insert(poly2, b)
    
    poly1 = appSortPointsClockwise(poly1)
    poly2 = appSortPointsClockwise(poly2)
    
    poly1 = expand(poly1)
    poly2 = expand(poly2)
    
    p1 = Polygon(unpack(poly1))
    p2 = Polygon(unpack(poly2))
    
    if p1 then p1.colo = {
        math.random(170, 200) / 255,
        math.random(170, 200) / 255,
        math.random(170, 200) / 255,
        0.5
    }
    end
    if p2 then
        p2.colo = {
            math.random(170, 200) / 255,
            math.random(170, 200) / 255,
            math.random(170, 200) / 255,
            0.5
        }
    end
    return p1, p2
end

function expand(verts)
    r = {}
    for i, v in ipairs(verts) do
        r[1 + #r] = v.x
        r[1 + #r] = v.y
    end
    return r
end

function getIntersects(shape, x, y, dx, dy)
    outis = {}
    ray_parameters = shape:intersectionsWithRay(x, y, dx, dy)
    v1 = vector(x, y)
    v2 = vector(dx, dy)
    
    for i, rp in pairs(ray_parameters) do
        -- ix,iy=(x,y) + ray_parameter * (dx, dy)
        iv = v1 + (v2 * rp)
        table.insert(outis, iv)
    end
    --There should only ever be two because the shapes are convex and have no holes. If there are more there's a problem.
    -- assert(#outis <= 2, "should only be two intersections")
    return unpack(outis)
end

-- returns true if three vertices lie on a line
function areCollinear(p, q, r, eps)
    return math.abs(hcvector.det(q.x - p.x, q.y - p.y, r.x - p.x, r.y - p.y)) <= (eps or 1e-32)
end

app = {}
function appSortPointsClockwise(points)
    local centerPoint = appGetCenterPointOfPoints(points)
    app.pointsCenterPoint = centerPoint
    table.sort(points, appGetIsLess)
    return points
end

function appGetIsLess(a, b)
    local center = app.pointsCenterPoint
    
    if a.x >= 0 and b.x < 0 then return true
    elseif a.x == 0 and b.x == 0 then return a.y > b.y
    end
    
    local det = (a.x - center.x) * (b.y - center.y) - (b.x - center.x) * (a.y - center.y)
    if det < 0 then return true
    elseif det > 0 then return false
    end
    
    local d1 = (a.x - center.x) * (a.x - center.x) + (a.y - center.y) * (a.y - center.y)
    local d2 = (b.x - center.x) * (b.x - center.x) + (b.y - center.y) * (b.y - center.y)
    return d1 > d2
end

function appGetCenterPointOfPoints(points)
    local pointsSum = {x = 0, y = 0}
    for i = 1, #points do pointsSum.x = pointsSum.x + points[i].x; pointsSum.y = pointsSum.y + points[i].y end
    return {x = pointsSum.x / #points, y = pointsSum.y / #points}
end
