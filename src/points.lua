Points = {
    count = 0
}

function Points:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Points:draw()
    
end

function Points:increase()
    
end