function DistanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
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

function CircleInRect(circle, rect)
    return (PointIn(circle:getX1(), circle:getY1(), rect) or
        PointIn(circle:getX2(), circle:getY1(), rect) or
        PointIn(circle:getX1(), circle:getY2(), rect) or
        PointIn(circle:getX2(), circle:getY2(), rect))
end

function CollidesRect(r1, r2)
    return RectInRect(r1, r2) or RectInRect(r2, r1)
end

function SpeedUpBounce(ballSpeed, batDirection)
    if ballSpeed ~= 0 then
        return batDirection
    else
        return 0
    end
end
