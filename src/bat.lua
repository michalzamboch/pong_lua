PlayerId = {
    player1 = 1,
    player2 = 2
}

Bat = {
    x = 0,
    y = 0,
    w = 25,
    h = 125,
    speed = 200,
    ai = false,
    player = PlayerId.player1
}

function Bat:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
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

function Bat:move(dt)
    if self.ai == true then
        self:aiMove(dt)
        print("ai")
    else
        if self.player == PlayerId.player1 then
            Bat:player1Move(dt)
            print("pl 1")
        else
            Bat:player2Move(dt)
            print("pl 2")
        end
    end
end

function Bat:player1Move(dt)
    if love.keyboard.isDown("down") then
        self:down(dt)
    elseif love.keyboard.isDown("up") then
        self:up(dt)
    end
end

function Bat:player2Move(dt)
    if love.keyboard.isDown("s") then
        self:down(dt)
    elseif love.keyboard.isDown("w") then
        self:up(dt)
    end
end

function Bat:up(dt)
    self.y = self.y - self.speed * dt
end

function Bat:down(dt)
    self.y = self.y + self.speed * dt
end

function Bat:aiMove(dt)

end
