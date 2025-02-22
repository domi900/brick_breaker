-- nivel.lua
Nivel = Class{}

require 'Bola'

require 'Plataforma'

require 'Bloco'



function Nivel:init()
    --cirando os blocos
    self.blocos = {}
    --criarOsblocos(world)
    
    self.plataforma1 = Plataforma(WINDOW_WIDTH/2 - 100, 500, 100, 20, "plataforma")
    
    self.world = world
    
    self.bola = Bola(300, 30, 10, "bola")
    
end

function Nivel:Update(dt)
    self.bola:update(dt)
    self.plataforma1:update(dt)
    
end


function Nivel:criarBlocos()
    self:limparBlocos()  -- Garante que os blocos antigos sejam removidos antes de criar novos
    local indiceBloco = 1
    local linha_blocos = 200

    for linha = 1, 4 do
        local distanciax = 10

        for i = 1, 8 do
            local novoBloco = Bloco(distanciax, linha_blocos, 50, 10, "bloco", indiceBloco)
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

function Nivel:checarColisoes(blocoColisao)
    for i = #self.blocos, 1, -1 do
        if blocoColisao == "colidiu" .. self.blocos[i].index then
            self.blocos[i]:destroy()
            table.remove(self.blocos, i) -- Remove corretamente da lista
        end
    end
end

function Nivel:render()
    for _, bloco in ipairs(self.blocos) do
        bloco:render()
    end
    self.bola:render()
    self.plataforma1:render()

end