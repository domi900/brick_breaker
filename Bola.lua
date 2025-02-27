
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

    self.dy = 200
    self.dx = 0

    self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
    self.shape = love.physics.newCircleShape(self.r)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    
    self.fixture:setRestitution(1)

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
    

    --a verificação é sobre a direção que a bola tem que ir depois da colisão

    if cimaBaixo == "cimaInicio" then
        vx = math.random(-200, 170)
        self.dy = -self.dy
        self.dx = vx
        self.body:setLinearVelocity( vx, self.dy )
    
    elseif cimaBaixo == "cima" then
        if vx < 0 then
            --mantem a direção vertical da bola, mas altera um pouco o angulo
            vx = math.random(-200, -150)
            self.dx = vx
            --muda a direção da bola de baixo pra cima
            self.dy = -self.dy
            self.body:setLinearVelocity( vx, self.dy )
        else
            vx = math.random(150, 200)
            self.dx = vx
            self.dy = -self.dy
            self.body:setLinearVelocity( vx, self.dy )
        end

    elseif cimaBaixo == "baixo" then
        self.dy = 200
        if vx < 0 then
            vx = math.random(-200, -150)
            self.dx = vx
            self.body:setLinearVelocity( vx, self.dy )
        else
            vx = math.random(150, 200)
            self.dx = vx
            self.body:setLinearVelocity( vx, self.dy )
        end
    end

    --se a bola tem que ir para a esquerda self.dx tem que ser negativo
    if esquerdaDireita == "esquerda" then
        self.dx = math.random(-200, -150)
        self.body:setLinearVelocity( self.dx , self.dy )
    end

    --se a bola tem que ir para a direita self.dx tem que ser positivo
    if esquerdaDireita == "direita" then
        self.dx = math.random(150, 200)
        self.body:setLinearVelocity( self.dx, self.dy )
    end
    
end    

function Bola:reset()
    self.body:setPosition(250, 500)
    self.body:setLinearVelocity(0, 0)
    
end

function Bola:render()
    love.graphics.circle("fill", self.x, self.y, self.r)
end