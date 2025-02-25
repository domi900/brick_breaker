
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

    self.dy = 60
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

function Bola:aplicarForca(cimaBaixo, esquerdaDireita)

    --variação x
    local vx = self.dx
    
    if cimaBaixo == "cimaInicio" then
        vx = math.random(-50, 50)
        self.dy = -self.dy
        self.dx = vx
        self.body:applyLinearImpulse( -vx, self.dy, self.body:getX(), self.body:getY())
    
    elseif cimaBaixo == "cima" then
        self.dy = -self.dy
        if vx < 0 then
            self.body:applyLinearImpulse( -vx, self.dy, self.body:getX(), self.body:getY())
        else
            self.body:applyLinearImpulse( vx, self.dy, self.body:getX(), self.body:getY())
        end
    elseif cimaBaixo == "baixo" then
        self.dy = -self.dy
        if vx < 0 then
            vx = math.random(30, 60)
            self.body:applyLinearImpulse( -vx, self.dy, self.body:getX(), self.body:getY())
        else
            vx = math.random(30, 60)
            self.body:applyLinearImpulse( vx, self.dy, self.body:getX(), self.body:getY())
        end
    end

    if esquerdaDireita == "esquerda" then
        self.dx = math.random(30, 60)
        self.body:applyLinearImpulse( -self.dx, self.dy, self.body:getX(), self.body:getY())
    end

    if esquerdaDireita == "direita" then
        self.dx = math.random(30, 60)
        self.body:applyLinearImpulse( self.dx, self.dy, self.body:getX(), self.body:getY())
    end
    
end    

function Bola:reset()
    self.body:setPosition(250, 500)
    self.body:setLinearVelocity(0, 0)
    
end

function Bola:render()
    love.graphics.circle("fill", self.x, self.y, self.r)
end