
Plataforma = Class{}


function Plataforma:init(x, y, width, height, tag, world)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dx = 0
    self.world = world
    self.tag = tag

    --colisão
    self.body = love.physics.newBody(world, self.x, self.y, "kinematic")
    self.shape = love.physics.newRectangleShape(self.width / 2, self.height / 2, self.width,self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    self.fixture:setUserData(self)

    self.body:setFixedRotation(true)

end

function Plataforma:update(dt)

    --movimentação da plataforma

    self.body:setLinearVelocity(self.dx, 0)

    self.x, self.y = self.body:getPosition()

end


function Plataforma:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end