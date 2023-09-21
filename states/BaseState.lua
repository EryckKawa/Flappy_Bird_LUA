-- Definição da Classe BaseState
BaseState = Class{}

-- Inicialização da Classe BaseState
function BaseState:init() 
    -- O construtor init() é chamado quando um objeto BaseState é criado.
    -- No entanto, neste caso, a função init() está vazia, o que significa que não realiza nenhuma inicialização especial.
end

-- Função para entrar no estado (método vazio por padrão)
function BaseState:enter() 
    -- Este método pode ser sobrescrito por classes derivadas (subclasses) para realizar ações específicas quando o estado é ativado.
    -- Por padrão, esta função não faz nada.
end

-- Função para sair do estado (método vazio por padrão)
function BaseState:exit() 
    -- Este método pode ser sobrescrito por classes derivadas (subclasses) para realizar ações específicas quando o estado é desativado.
    -- Por padrão, esta função não faz nada.
end

-- Função de atualização do estado (método vazio por padrão)
function BaseState:update(dt) 
    -- Este método pode ser sobrescrito por classes derivadas (subclasses) para atualizar a lógica do estado.
    -- O argumento 'dt' é o tempo decorrido desde a última atualização.
    -- Por padrão, esta função não faz nada.
end

-- Função de renderização do estado (método vazio por padrão)
function BaseState:render() 
    -- Este método pode ser sobrescrito por classes derivadas (subclasses) para renderizar elementos gráficos específicos do estado.
    -- Por padrão, esta função não faz nada.
end
