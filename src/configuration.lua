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
BallSpeedX = 150
BallSpeedY = -150

function RandomSpeed(minSpeed, maxSpeed)
    local speed = Rng:random(minSpeed, maxSpeed)

    if Rng:random(0, 100) < 50 then
        return speed * (-1)
    else
        return speed
    end
end

function RandomSpeedX()
    return RandomSpeed(225, 275)
end

function RandomSpeedY()
    return RandomSpeed(125, 175)
end