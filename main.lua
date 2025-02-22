
--altura e largura da tela
WINDOW_HEIGHT = 600
WINDOW_WIDTH = 500


--importando classes e bibliotecas
Class = require 'libraries/class'

require 'Plataforma'

require 'Bola'

require 'Parede'

require 'Bloco'

require 'Nivel'

--variaveis globais
plataforma_velocidade = 350

mensagem = ""

blocoColisao = "w"

colisaoBolaPlataforma = false

gamestate = "menu"





function love.load()

    --configura a tela
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {resizable=false, vsync = true})

    --desativa os filtros
    love.graphics.setDefaultFilter('nearest', 'nearest')
   

    --carrega a fonte/ cada tamanho de fonte precisa ser carregado separadamente
    smallFont = love.graphics.newFont('font.ttf', 8)
    bigfont = love.graphics.newFont('font.ttf', 32)
    love.graphics.setFont(smallFont)

    --mundo para a fisica


    --paredes
    paredeDireita = Parede(498, 0, 2, 600, world, "paredeDireita")
    paredeEsquerda = Parede(0, 0, 2, 600, world, "paredeEsquerda")
    paredeCima = Parede(0, 0, 500, 2, world, "paredeCima")
    paredeBaixo = Parede(0, 598, 500, 2, world, "paredeBaixo")

    --cirando os blocos
    --criarOsblocos(world)
    
    nivel = Nivel()
    nivel:criarBlocos()

end

function love.update(dt)

    if gamestate == "play" then    
        
        --movimetaçãoda plataforma
        if love.keyboard.isDown('left') then
            if nivel.plataforma.x < 2 then
                nivel.plataforma.dx = 0
            else
                nivel.plataforma.dx = -plataforma_velocidade
            end
        elseif love.keyboard.isDown('right') then
            if math.abs(nivel.plataforma.x + nivel.plataforma.width) >= 498 then
                nivel.plataforma.dx = 0
            else
                nivel.plataforma.dx = plataforma_velocidade
            end
        else
            nivel.plataforma.dx = 0
        end

        --checa se aconteceu uma colisão da bola com um bloco
        nivel:checarColisoes()
        
        --checa se aconteceu uma colisão da bola com a plataforma
        if nivel.bola.x + nivel.bola.raio > nivel.plataforma.x and nivel.bola.x - nivel.bola.raio < nivel.plataforma.x + nivel.plataforma.width and
        nivel.bola.y + nivel.bola.raio > nivel.plataforma.y and nivel.bola.y - nivel.bola.raio < nivel.plataforma.y + nivel.plataforma.height then
            mensagem = "colidiu"
            
            nivel.bola.y = nivel.plataforma.y - nivel.bola.raio           
            if nivel.plataforma.dx > 0 then
                nivel.bola:aplicarForca("direita")
            elseif nivel.plataforma.dx < 0 then
                nivel.bola:aplicarForca("esquerda")
            else
                nivel.bola:aplicarForca("parado")
            end
        end  
        

        
    end

    if gamestate == "menu" then
        nivel.bola:reset(300, 300)
    end
    

    nivel:Update(dt)

    

end

function love.keypressed(key)
    if key == 'escape' then
        -- fecha o jogo
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gamestate == "menu" then
            gamestate = "play"
        else
            gamestate = "menu"
        end
    end
end

function love.draw()
    love.graphics.setFont(bigfont)
    love.graphics.print("TA ONLINE", 50, 50)

    love.graphics.setFont(smallFont)
    love.graphics.print(mensagem, 100, 100, nil, 2)
    love.graphics.print(gamestate, 100, 400, nil, 2)


    --Renderização

    paredeDireita:render()
    paredeEsquerda:render()
    paredeCima:render()
    paredeBaixo:render()

    if gamestate == "play" then
        nivel:render()
    end

    

end