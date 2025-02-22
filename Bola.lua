
Bola = Class{}

function Bola:init(x, y, width, height, tag)
    self.x = x
    self.y = y
    self.tag = tag
    self.width = width
    self.height = height
    self.world = world

    self.dy = 200
    self.dx = 0
    
end

function Bola:update(dt)
    
    self.y = self.y + self.dy * dt
    self.x = self.x + self.dx * dt

    if self.x <= 0 then
        self.x = 0  -- Evita que o quadrado entre na parede
        self.dx = math.abs(self.dx)  -- Inverte a direção para a direita
    elseif self.x + self.width >= 500 then
        self.x = 500 - self.width  -- Mantém dentro da tela
        self.dx = -math.abs(self.dx)  -- Inverte a direção para a esquerda
    end

    -- Colisão com o teto
    if self.y <= 0 then
        self.y = 0  -- Evita que o quadrado vá para fora da tela
        self.dy = math.abs(self.dy)  -- Rebate para baixo
    end
end

function Bola:aplicarForca(direcao)
    self.dy = -200
    if direcao == "direita" then
        self.dx = math.random(100, 200)
    elseif direcao == "esquerda" then
        self.dx = math.random(-200, -50)
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
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end