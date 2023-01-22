-- General

function ScreenWidth()
    return love.graphics.getPixelWidth()
end

function ScreenHeight()
    return love.graphics.getPixelHeight()
end

MyFontSize = 45
GeneralFont = love.graphics.newFont(MyFontSize)

SizeConstant = 1
ManipulateSize = true

MotionConstant = 1
ManipulateMotion = true
Rng = love.math.newRandomGenerator(os.time())

-- Game
ScorePosition = ScreenWidth() / 4
BatStartPosition = 25
MaxPoints = 10
PlayerMode1 = true
PlayerMode2 = false

-- Bat
BatHeight = 120
BatPositionY = (ScreenHeight() / 2) - BatHeight / 2
BatSpeed = 200
BatSpeedAi = 100
BatWidth = 20

-- Player
PointsPositionY = 25
Player1Up = "w"
Player1Down = "s"
Player2Up = "up"
Player2Down = "down"

-- Ball
BallSize = 20
BallPositionX = ScreenWidth() / 2 - BallSize / 2
BallPositionY = ScreenHeight() / 2 - BallSize / 2
BallMinSpeedX = 225
BallMaxSpeedX = 275
BallMinSpeedY = 125
BallMaxSpeedY = 150

function RandomSpeed(minSpeed, maxSpeed)
    local speed = Rng:random(minSpeed, maxSpeed)

    local indexes = { -1, 1 }
    return speed * indexes[math.random(#indexes)]
end

function RandomSpeedX()
    return RandomSpeed(BallMinSpeedX, BallMinSpeedX)
end

function RandomSpeedY()
    return RandomSpeed(BallMinSpeedY, BallMinSpeedY)
end
