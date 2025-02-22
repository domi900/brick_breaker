-- nivel.lua
Nivel = Class{}

require 'Bola'

require 'Plataforma'

require 'Bloco'



function Nivel:init()
    --cirando os blocos
    self.blocos = {}
    --criarOsblocos(world)
    
    self.plataforma = Plataforma(WINDOW_WIDTH/2 - 100, 500, 100, 20, "plataforma")
    
    self.world = world
    
    self.bola = Bola(300, 300, 10, "bola")
    
end

function Nivel:Update(dt)
    self.bola:update(dt)
    self.plataforma:update(dt)
    
end


function Nivel:criarBlocos()
    self:limparBlocos()  -- Garante que os blocos antigos sejam removidos antes de criar novos
    local indiceBloco = 1
    local linha_blocos = 200

    for linha = 1, 4 do
        local distanciax = 10

        for i = 1, 8 do
            if i == 1 then
                distanciax = 40
            end
            local novoBloco = Bloco(distanciax, linha_blocos, 50, 20, "bloco", indiceBloco)
            table.insert(self.blocos, novoBloco)
            distanciax = distanciax + 60
            indiceBloco = indiceBloco + 1
        end

        linha_blocos = linha_blocos - 40
    end
end

function Nivel:limparBlocos()
    for i = #self.blocos, 1, -1 do
        self.blocos[i]:destroy()
        table.remove(self.blocos, i)
    end
end

function Nivel:checarColisoes()
    for i = #self.blocos, 1, -1 do
        local bloco = self.blocos[i]
        if self.bola.x < bloco.x + bloco.width and
           self.bola.x + self.bola.raio * 2 > bloco.x and
           self.bola.y < bloco.y + bloco.height and
           self.bola.y + self.bola.raio * 2 > bloco.y then
            table.remove(self.blocos, i)
            self.bola.dy = -self.bola.dy
        end
    end
end

function Nivel:render()
    for _, bloco in ipairs(self.blocos) do
        bloco:render()
    end
    self.bola:render()
    self.plataforma:render()

end