-- General

function ScreenWidth()
    return love.graphics.getPixelWidth()
end

function ScreenHeight()
    return love.graphics.getPixelHeight()
end

MyFontSize = 45
GeneralFont = love.graphics.newFont(MyFontSize)

MotionConstant = 1
ManipulateMotion = true
Rng = love.math.newRandomGenerator(os.time())

Mute = false
Volume = 0.5

ScaleX = 1
ScaleY = 1

-- Paths
ImagePath = "assets/images/"
SoundPath = "assets/sounds/"

-- Game
ScorePosition = ScreenWidth() / 4
MaxPoints = 10
PlayerMode1 = true
PlayerMode2 = false
ShowFPS = false

-- Bat
BatHeight = love.graphics.newImage(ImagePath .. "1.png"):getHeight()
BatPositionY = (ScreenHeight() / 2) - BatHeight / 2
BatSpeed = 200
BatSpeedAi = 100
BatWidth = love.graphics.newImage(ImagePath .. "1.png"):getWidth()

-- Player
PointsPositionY = 25
PlayerLeftUp = "w"
PlayerLeftDown = "s"
PlayerLeftPush = "d"
PlayerRightUp = "up"
PlayerRightDown = "down"
PlayerRightPush = "right"

-- Ball
BallSize = love.graphics.newImage(ImagePath .. "ball.png"):getWidth()
BallPositionX = ScreenWidth() / 2 - BallSize / 2
BallPositionY = ScreenHeight() / 2 - BallSize / 2
BallMinSpeedX = 250
BallMaxSpeedX = 300
BallMinSpeedY = 125
BallMaxSpeedY = 150
