Parede = Class{}

function Parede:init(x, y, w, height, world, tag)
    self.x = x
    self.y = y
    self.width = w
    self.height = height

    self.tag = tag

end

function Parede:update(dt)

    --movimentação da plataforma

end


function Parede:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end