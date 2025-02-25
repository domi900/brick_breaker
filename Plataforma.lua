
Plataforma = Class{}


function Plataforma:init(x, y, width, height, tag, world)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dx = 0
    self.world = world
    self.tag = tag


end

function Plataforma:update(dt)

    --movimentação da plataforma
    self.dx = self.x + self.dx * dt
    self.x = self.dx
end

function Plataforma:reset(x, y)
    self.x = x
    self.y = y
end

function Plataforma:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end