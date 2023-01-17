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
