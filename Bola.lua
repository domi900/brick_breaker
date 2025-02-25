
Bola = Class{}

function Bola:init(x, y, radius, tag)
    self.x = x
    self.y = y
    self.raio = radius
    self.tag = tag
    self.diametro = self.raio * 2
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

    self.dy = 200
    self.dx = 0

    
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

    self.y = self.y + self.dy * dt
    self.x = self.x + self.dx * dt

    if self.x - self.raio <= 0 then
        self.x = self.raio  -- Evita que a bola entre na parede
        self.dx = math.abs(self.dx)  -- Inverte a direção para a direita
    elseif self.x + self.raio >= 500 then
        self.x = 500 - self.raio  -- Mantém dentro da tela
        self.dx = -math.abs(self.dx)  -- Inverte a direção para a esquerda
    end

    -- Colisão com o teto
    if self.y - self.raio <= 0 then
        self.y = self.raio  -- Evita que a bola vá para fora da tela
        self.dy = math.abs(self.dy)  -- Rebate para baixo
    end
end

function Bola:aplicarForca(direcao)
    self.dy = -200
    if direcao == "direita" then
        self.dx = math.random(10, 200)
    elseif direcao == "esquerda" then
        self.dx = math.random(-200, -10)
    else    
        self.dx = self.dx
    end

end    

function Bola:getPosicao()
    return self.x + self.diametro, self.y + self.diametro
end

function Bola:reset(x, y)
    self.x = x
    self.y = y
    self.dy = 200
    
end

function Bola:render()
    love.graphics.circle("fill", self.x, self.y, self.raio)
    love.graphics.circle("line", self.x, self.y, self.raio + 2)
end