Bloco = Class{}

function Bloco:init(x, y, width, height, tag, world)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dx = 0
    self.tag = tag


    self.world = world

    self.body = love.physics.newBody(world, self.x, self.y, "static")
    self.shape = love.physics.newRectangleShape(self.width / 2, self.height / 2, self.width,self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    
    self.fixture:setUserData(self)

    self.body:setFixedRotation(true)
    
end

function Bloco:update(dt)

end

function Bloco:destroy()
    self.width = 0
    self.height = 0
    self.fixture:setMask(1)
end

function Bloco:render()

    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

end