function DistanceBetween(x1, y1, x2, y2)
    local yRes = (y2 - y1) ^ 2
    local xRes = (x2 - x1) ^ 2
    return math.sqrt(yRes + xRes)
end

function Intersects(bat, circleX, circleY, circleR)
    local x = math.abs(circleX - bat.x)
    local y = math.abs(circleY - bat.y)

    if x > (bat.w / 2 + circleR) then
        return false
    end
    if y > (bat.h / 2 + circleR) then
        return false
    end

    if x <= (bat.w / 2) then
        return true
    end
    if y <= (bat.h / 2) then
        return true
    end

    local cornerDistance_squared = ((x - bat.w / 2) ^ 2) + ((y - bat.h / 2) ^ 2)
    return (cornerDistance_squared <= (circleR ^ 2))
end

function PointIn(x, y, r)
    return ((x >= r:getX() and y >= r:getY()) and
        (x <= r:getX2() and y >= r:getY()) and
        (x >= r:getX() and y <= r:getY2()) and
        (x <= r:getX2() and y <= r:getY2()))
end

function RectInRect(r1, r2)
    return (PointIn(r1:getX(), r1:getY(), r2) or
        PointIn(r1:getX2(), r1:getY(), r2) or
        PointIn(r1:getX(), r1:getY2(), r2) or
        PointIn(r1:getX2(), r1:getY2(), r2))
end

function CollidesRect(r1, r2)
    return RectInRect(r1, r2) or RectInRect(r2, r1)
end
