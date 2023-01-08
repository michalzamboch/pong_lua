require "bat"
require "ball"

function distanceBetween(x1, y1, x2, y2)
    local yRes = (y2 - y1) ^ 2
    local xRes = (x2 - x1) ^ 2
    return math.sqrt(yRes + xRes)
end

--[[
bool intersects(CircleType circle, RectType rect)
{
    circleDistance.x = abs(circle.x - rect.x);
    circleDistance.y = abs(circle.y - rect.y);

    if (circleDistance.x > (rect.width/2 + circle.r)) { return false; }
    if (circleDistance.y > (rect.height/2 + circle.r)) { return false; }

    if (circleDistance.x <= (rect.width/2)) { return true; } 
    if (circleDistance.y <= (rect.height/2)) { return true; }

    cornerDistance_sq = (circleDistance.x - rect.width/2)^2 +
                         (circleDistance.y - rect.height/2)^2;

    return (cornerDistance_sq <= (circle.r^2));
}
]] --

function intersects(ball, bat)
    local x = math.abs(ball.x - bat.x)
    local y = math.abs(ball.y - bat.y)

    if x > (bat.w / 2 + ball.r) then
        return false
    end
    if y > (bat.h / 2 + ball.r) then
        return false
    end

    if x <= (bat.w / 2) then
        return true
    end
    if y <= (bat.h / 2) then
        return true
    end

    local cornerDistance_squared = ((x - bat.w / 2) ^ 2) + ((y - bat.h / 2) ^ 2)
    return (cornerDistance_squared <= (ball.r ^ 2))
end
