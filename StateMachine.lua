StateMachine = Class {}

-- Inicializa a máquina de estados
function StateMachine:init(states)
    -- Estado vazio padrão com funções vazias para renderização, atualização, entrada e saída
    self.empty = {
        render = function()
        end,
        update = function()
        end,
        enter = function()
        end,
        exit = function()
        end
    }

    -- Tabela de estados definidos
    self.states = states or {}

    -- Estado atual, inicializado como o estado vazio padrão
    self.current = self.empty
end

-- Função para mudar o estado atual para um novo estado
function StateMachine:change(stateName, enterParams)
    -- Garante que o estado especificado existe na tabela de estados
    assert(self.states[stateName])

    -- Chama a função de saída do estado atual
    self.current:exit()

    -- Define o estado atual como o novo estado especificado e chama a função de entrada
    self.current = self.states[stateName]()
    self.current:enter(enterParams)
end

-- Função de atualização, chama a função de atualização do estado atual
function StateMachine:update(dt)
    self.current:update(dt)
end

-- Função de renderização, chama a função de renderização do estado atual
function StateMachine:render()
    self.current:render()
end
