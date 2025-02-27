
--altura e largura da tela
WINDOW_HEIGHT = 600
WINDOW_WIDTH = 500


--importando classes e bibliotecas
Class = require 'libraries/class'

require 'Plataforma'

require 'Bola'

require 'Parede'

require 'Bloco'

--variaveis globais
plataforma_velocidade = 350

mensagem = ""

blocoColisao = "w"

bolaCimaBaixo = ""
esquerdaDireita = ""

colisaoBolaPlataforma = false

gamestate = "start"

-- funções de detectar colisão
function ColisaoInicio(a, b, contact)
    local o1, o2 = a:getUserData(), b:getUserData()
    
    
    -- verifica se a colosão é entra a bola e um bloco
    if o1 and o2 then
        if o1.tag == "bloco" or o2.tag == "bloco" then
            mensagem = o1.tag .. " destruiu " .. o2.tag
            if o1.tag == "bloco" then
                blocoColisao = "colidiu" .. o1.index   
            else
                blocoColisao = "colidiu" .. o2.index
            end

        -- verifica se a colisão é entre a bola e as paredes  
        elseif o1.tag == "paredeCima" or o2.tag == "paredeCima" then
            if o1.tag == "bola" or o2.tag == "bola" then
                bolaCimaBaixo = "paredeCima"
            end
        elseif o1.tag == "paredeBaixo" or o2.tag == "paredeBaixo" then
            if o1.tag == "bola" or o2.tag == "bola" then
                gamestate = "start"
            end
        elseif o1.tag == "paredeDireita" or o2.tag == "paredeDireita" then
            if o1.tag == "bola" or o2.tag == "bola" then
                esquerdaDireita = "paredeDireita"
            end
        elseif o1.tag == "paredeEsquerda" or o2.tag == "paredeEsquerda" then
            if o1.tag == "bola" or o2.tag == "bola" then
                esquerdaDireita = "paredeEsquerda"
            end 
        
        -- verifica se a colisão é entre a bola e a plataforma    
        elseif o1.tag == "plataforma" or o2.tag == "plataforma" then
            if o1.tag == "bola" or o2.tag == "bola" then
                colisaoBolaPlataforma = true
            end
        
        --verifica se a colisão é entre a bola e o sensor
        elseif o1.tag == "sensor" or o2.tag == "sensor" then
            gamestate = "start"
        else
            mensagem = o1.tag .. " colidiu com " .. o2.tag
        end
    end

end


function ColisaoFim(a, b, contact)

end

function criarOsblocos(world)
    blocos = {}
    indiceBloco = 1

    for linha = 1, 4 do
        
        if linha == 1 then
            linha_blocos = 200
        end
        
        for i = 1, 8 do
            if i == 1 then    
                distanciax = 30
            end
            blocos[indiceBloco] = Bloco(distanciax, linha_blocos, 50 , 20, "bloco", world, indiceBloco)  -- Criando e armazenando os blocos
            distanciax = distanciax + 55
            indiceBloco = indiceBloco + 1
        end

        linha_blocos = linha_blocos - 40
    end
end

function destruirBlocos()
    for i, bloco in ipairs(blocos) do
        bloco:destroy()
        table.remove(blocos, i)
    end
end




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

    world = love.physics.newWorld(0, 0)
    world:setCallbacks(ColisaoInicio, ColisaoFim)


    --paredes
    paredeDireita = Parede(498, 0, 2, 600, world, "paredeDireita")
    paredeEsquerda = Parede(0, 0, 2, 600, world, "paredeEsquerda")
    paredeCima = Parede(0, 0, 500, 2, world, "paredeCima")
    paredeBaixo = Parede(0, 598, 500, 2, world, "paredeBaixo")

    --cirando os blocos
    criarOsblocos(world)
    
    --plataforma
    plataforma1 = Plataforma(200, 520, 100, 20, "plataforma", world)
    
    --bola
    bola = Bola(250, 500, 10, "bola", world)
    
    --sensor
    sensor = {}
    sensor.x = 0
    sensor.y = 570
    sensor.width = 500
    sensor.height = 20
    sensor.tag = "sensor"
    sensor.body = love.physics.newBody(world, sensor.x, sensor.y, "static")
    sensor.shape = love.physics.newRectangleShape(sensor.width / 2, sensor.height / 2, sensor.width, sensor.height)
    sensor.fixture = love.physics.newFixture(sensor.body, sensor.shape)
    sensor.fixture:setUserData(sensor)
    sensor.fixture:setSensor(true)

end

function love.update(dt)

    world:update(dt)

    if gamestate == "play" then    
        
        if blocos == {} then
            gamestate = "start"
        end
        
        --movimetaçãoda plataforma
        if love.keyboard.isDown('left') then
            if plataforma1.x < 2 then
                plataforma1.dx = 0
            else
                plataforma1.dx = -plataforma_velocidade
            end
        elseif love.keyboard.isDown('right') then
            if math.abs(plataforma1.x + plataforma1.width) >= 498 then
                plataforma1.dx = 0
            else
                plataforma1.dx = plataforma_velocidade
            end
        else
            plataforma1.dx = 0
        end

        --verifica se aconteceu uma colisão da bola com um bloco
        if blocos  then
            for i, bloco in ipairs(blocos) do
                if blocoColisao == "colidiu" .. bloco.index then
                    bloco:destroy()
                    table.remove(blocos, i)
                    blocoColisao = "w"
                end
            end
        end

        --verifica se aconteceu uma colisão da bola com as paredes
        --os parametros bolaCimaBaixo e esquerdaDireita informam a direção que a bola tem que ir depois da colisão
        if bolaCimaBaixo == "paredeCima" then
                bola:aplicarForca("baixo", "")
                bolaCimaBaixo = ""
        elseif esquerdaDireita == "paredeDireita" then
            bola:aplicarForca("", "esquerda")
            esquerdaDireita = ""
        elseif esquerdaDireita == "paredeEsquerda" then
            bola:aplicarForca("", "direita")
            esquerdaDireita = ""
        end

        --verifica se aconteceu uma colisão da bola com a plataforma
        if colisaoBolaPlataforma then
            bola:aplicarForca("cima")
            bolaCimaBaixo = ""
            colisaoBolaPlataforma = false
        end    
        
    elseif gamestate == "start" then
        --movimetaçãoda plataforma
        if love.keyboard.isDown('left') then
            if plataforma1.x < 2 then
                plataforma1.dx = 0
            else
                plataforma1.dx = -plataforma_velocidade
            end
        elseif love.keyboard.isDown('right') then
            if math.abs(plataforma1.x + plataforma1.width) >= 498 then
                plataforma1.dx = 0
            else
                plataforma1.dx = plataforma_velocidade
            end
        else
            plataforma1.dx = 0
        end
        
        --bola acompanhar a plataforma
        bola.body:setPosition(plataforma1.x + plataforma1.width / 2, 500)
        
        --destruir os blocos
        destruirBlocos()
    end

    plataforma1:update(dt)
    bola:update(dt)

    if bola.y > 600 then
        bola:reset()
        plataforma1:reset()
        gamestate = "start"
    end

end

function love.keypressed(key)
    if key == 'escape' then
        -- fecha o jogo
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        --quando o jogo começa, a bola é lançada
        if gamestate == "start" then
            gamestate = "play"
            criarOsblocos(world)
            bola:aplicarForca("cimaInicio", "")
        else
            gamestate = "start"
            destruirBlocos()
            bola:reset()
            plataforma1:reset()
        end
    end
end

function love.draw()
    
    if gamestate == "start" then
        love.graphics.setFont(bigfont)
        love.graphics.print("O Quebra tijolo", 130, 50)

        love.graphics.setFont(smallFont)
        love.graphics.print("Aperte enter", 200, 100, nil, 2)
    end
    --love.graphics.print(gamestate, 100, 400, nil, 2)


    --Renderização

    paredeDireita:render()
    paredeEsquerda:render()
    paredeCima:render()
    paredeBaixo:render()


    plataforma1:render()
    bola:render()
        
    --renderizando blocos
    if gamestate == "play" then
        if blocos then
            for i, bloco in ipairs(blocos) do
                bloco:render()
            end
        end
    end
    --love.graphics.rectangle("line", sensor.x, sensor.y, sensor.width, sensor.height)

end