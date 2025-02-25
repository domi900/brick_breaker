
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

    self.dy = 50
    self.dx = 0

    self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.shape = love.physics.newCircleShape(self.r)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    
    --self.fixture:setRestitution(1)

    self.fixture:setUserData(self)

    self.body:setFixedRotation(true)

    self.fixture:setCategory(1)
    
end

function Bola:update(dt)
    

    self.x, self.y = self.body:getPosition()
end

function Bola:aplicarForca(direcao)
    if direcao == "baixo" then
        self.body:applyLinearImpulse( self.dx, self.dy, self.body:getX(), self.body:getY())
    elseif direcao == "cima" then
        self.body:applyLinearImpulse( self.dx, -self.dy, self.body:getX(), self.body:getY())
    elseif direcao == "esquerda" then
        self.body:applyLinearImpulse( -self.dx, self.dy, self.body:getX(), self.body:getY())
    elseif direcao == "direita" then
        self.body:applyLinearImpulse( self.dx, self.dy, self.body:getX(), self.body:getY())
    end
    --self.body:applyForce( 0, -300 )
end    

function Bola:reset()
    self.body:setPosition(250, 520)
    self.body:setLinearVelocity(0, 0)
    
end

function Bola:render()
    love.graphics.circle("fill", self.x, self.y, self.r)
end