
Bola = Class{}

function Bola:init(x, y, radius, tag, world)
    self.x = x
    self.y = y
    self.r = radius
    --self.width = width
    --self.height = height
    self.dx = 0
    self.tag = tag

    self.world = world

    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)

    self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.shape = love.physics.newCircleShape(self.r)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    
    self.fixture:setRestitution(1)

    self.fixture:setUserData(self)

    self.body:setFixedRotation(true)

    self.fixture:setCategory(1)
    
end

function Bola:update(dt)
    self.dy = self.y + self.dy * dt
    --self.body:setLinearVelocity(0, self.dy)

    self.x, self.y = self.body:getPosition()
end

function Bola:aplicarForca()
    self.body:applyForce( 0, -300 )
end    

function Bola:reset(x, y)
    self.body:setPosition( x, y )
    
end

function Bola:render()
    love.graphics.circle("fill", self.x, self.y, self.r)
end