
function Game:fullscreen()
    Fullscreen = not Fullscreen
    love.window.setFullscreen(Fullscreen)
    if Fullscreen then
        MotionConstant = 2
    else
        MotionConstant = 1
    end

    local vertical = ScreenHeight() / 2 - self.bat1.h / 2
    self.bat1:setVerticalPos(vertical)
    self.bat2:setHorizontalPos(ScreenWidth() - self.bat2.w * 2)
    self.bat2:setVerticalPos(vertical)
    self.player1.x = ScreenWidth() / 4
    self.player2.x = self.player1.x * 3
    self.ball:reset()
end
