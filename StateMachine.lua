-- Esta classe implementa uma máquina de estados finitos (FSM).
StateMachine = Class{}

-- O construtor da classe inicializa as seguintes propriedades:
--
-- * `self.empty`: um estado vazio, que é usado quando a FSM não está em nenhum estado.
-- * `self.states`: uma tabela de estados, que mapeia nomes de estados para funções que criam instâncias dos estados.
-- * `self.current`: o estado atual da FSM.
function StateMachine:init(states)
    self.empty = {
        render = function() end,
        update = function() end,
        enter = function() end,
        exit = function() end
    }

    self.states = states or {}
    self.current = self.empty
end

-- Este método transita a FSM para o estado especificado pelo parâmetro `stateName`.
-- O método também passa os parâmetros `enterParams` para o método `enter()` do novo estado.
function StateMachine:change(stateName, enterParams)
    --Garante que deva existir um estado válido
    assert(self.states[stateName])
    self.current:exit()
    self.current = self.states[stateName]()
    self.current:enter(enterParams) 
end

-- Este método atualiza o estado atual da FSM.
function StateMachine:update()
    self.current:update(dt)
end

-- Este método renderiza o estado atual da FSM.
function StateMachine:render()
    self.current:render()
end