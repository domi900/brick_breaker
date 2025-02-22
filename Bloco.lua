Bloco = Class{}

function Bloco:init(x, y, width, height, tag, index)
    self.width = width
    self.height = height
    self.tag = tag
    self.index = index
    self.x = x
    self.y = y

end

function Bloco:destroy()
    
end

function Bloco:render()
    love.graphics.rectangle("fill", self.x - self.width / 2, self.y - self.height / 2, self.width, self.height)
end