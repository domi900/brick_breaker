Bloco = Class{}

function Bloco:init(x, y, width, height, tag, index)
    self.width = width
    self.height = height
    self.tag = tag
    self.index = index
    self.x = x
    self.y = y

end

function Bloco:checarColisao()
    if self.x < nivel.bola.x + nivel.bola.raio and self.x + self.width > nivel.bola.x - nivel.bola.raio and
    self.y < nivel.bola.y + nivel.bola.raio and self.y + self.height > nivel.bola.y - nivel.bola.raio then
        return true
    end
    
end

function Bloco:render()
    love.graphics.rectangle("fill", self.x - self.width / 2, self.y - self.height / 2, self.width, self.height)
end