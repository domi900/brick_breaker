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
    self:limparBlocos()  -- Remove blocos antigos antes de criar novos

    local layout = {
        "XXXXXXXXX",  
        "X      XX",  
        "X XX XXXX",  
        "XXXXXXXXX"
    }

    local bloco_largura = 50
    local bloco_altura = 20
    local inicio_x = 30
    local inicio_y = 100

    for linha = 1, #layout do
        for coluna = 1, #layout[linha] do
            if layout[linha]:sub(coluna, coluna) == "X" then
                local x = inicio_x + (coluna - 1) * (bloco_largura + 5)
                local y = inicio_y + (linha - 1) * (bloco_altura + 5)
                table.insert(self.blocos, Bloco(x, y, bloco_largura, bloco_altura, "bloco"))
            end
        end
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
        if self.bola.x + self.bola.raio > bloco.x and self.bola.x - self.bola.raio < bloco.x + bloco.width and
        self.bola.y + self.bola.raio > bloco.y and self.bola.y - self.bola.raio < bloco.y + bloco.height then

            -- Calcula a sobreposição da bola com o bloco
            local overlapLeft = math.abs((self.bola.x + self.bola.raio) - bloco.x)
            local overlapRight = math.abs((self.bola.x - self.bola.raio) - (bloco.x + bloco.width))
            local overlapTop = math.abs((self.bola.y + self.bola.raio) - bloco.y)
            local overlapBottom = math.abs((self.bola.y - self.bola.raio) - (bloco.y + bloco.height))

            -- Determina se a colisão foi mais horizontal ou vertical
            if overlapLeft < overlapRight and overlapLeft < overlapTop and overlapLeft < overlapBottom then
                -- Colisão pela esquerda
                self.bola.dx = -math.abs(self.bola.dx)
            elseif overlapRight < overlapLeft and overlapRight < overlapTop and overlapRight < overlapBottom then
                -- Colisão pela direita
                self.bola.dx = math.abs(self.bola.dx)
            elseif overlapTop < overlapLeft and overlapTop < overlapRight and overlapTop < overlapBottom then
                -- Colisão pelo topo
                self.bola.dy = -math.abs(self.bola.dy)
            elseif overlapBottom < overlapLeft and overlapBottom < overlapRight and overlapBottom < overlapTop then
                -- Colisão pela parte inferior
                self.bola.dy = math.abs(self.bola.dy)
            end

            -- Remove o bloco da lista
            table.remove(self.blocos, i)
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