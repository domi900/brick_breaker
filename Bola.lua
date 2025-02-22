
Bola = Class{}

function Bola:init(x, y, radius, tag)
    self.x = x
    self.y = y
    self.r = radius
    self.tag = tag

    self.world = world

    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
    
end

function Bola:update(dt)
    self.dy = self.y + self.dy * dt
end

function Bola:aplicarForca()
    
end    

function Bola:reset(x, y)
    self.x = x
    self.y = y
    self.dy = math.random(2) == 1 and -100 or 100
    
end

function Bola:render()
    love.graphics.circle("fill", self.x, self.y, self.r)
end