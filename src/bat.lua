
ScreenHeight = love.graphics.getPixelHeight()
ScreenWidth = love.graphics.getPixelWidth()
BatPosY = (ScreenHeight / 2) - 130 / 2

PlayerId = {
    player1 = 1,
    player2 = 2
}

Bat = {
    x = 0,
    y = BatPosY,
    w = 25,
    h = 130,
    speed = 200,
    acceleration = 10,
    ai = false,
    player = PlayerId.player1
}

function Bat:new(xPos)
    local object = {}
    setmetatable(object, self)
    self.__index = self

    object.x = xPos
    return object
end

function Bat:setPosition(a, b)
    self.x = a
    self.y = b
end

function Bat:setSpeed(s)
    self.speed = s
end

function Bat:setSize(w, h)
    self.w = w
    self.h = h
end

function Bat:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Bat:moveManually(dt, down, up)
    if love.keyboard.isDown(down) then
        self:down(dt)
    elseif love.keyboard.isDown(up) then
        self:up(dt)
    end
end

function Bat:moveAutomatically(dt, ball)

end

function Bat:up(dt)
    self.y = self.y - self.speed * dt
end

function Bat:down(dt)
    self.y = self.y + self.speed * dt
end
