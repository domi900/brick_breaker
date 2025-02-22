
Bola = Class{}

function Bola:init(x, y, radius, tag)
    self.x = x
    self.y = y
    self.raio = radius
    self.tag = tag

    self.world = world

    self.dy = 200
    self.dx = 0
    
end

function Bola:update(dt)
    
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

function Bola:reset(x, y)
    self.x = x
    self.y = y
    self.dy = 200
    
end

function Bola:render()
    love.graphics.circle("fill", self.x, self.y, self.raio)
end