Parede = Class{}

function Parede:init(x, y, w, height, world, tag)
    self.x = x
    self.y = y
    self.width = w
    self.height = height

    self.tag = tag

    self.body = love.physics.newBody(world, self.x, self.y, "static")
    self.shape = love.physics.newRectangleShape(self.width / 2, self.height / 2, self.width,self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    --self.fixture:setRestitution(1)
    self.fixture:setUserData(self)

    --self.body:setFixedRotation(true)
end

function Parede:update(dt)

    --movimentação da plataforma

end


function Parede:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end