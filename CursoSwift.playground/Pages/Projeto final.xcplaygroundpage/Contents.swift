import Foundation

// Enum para definir a prioridade de uma tarefa
enum Prioridade: String, CaseIterable {
    case baixa = "Baixa"
    case media = "Média"
    case alta = "Alta"

    // Retorna a prioridade com base em um índice
    static func fromIndex(_ index: Int) -> Prioridade? {
        guard index >= 0 && index < Prioridade.allCases.count else {
            return nil
        }
        return Prioridade.allCases[index]
    }
}

// Protocolo para tipos que podem fornecer um resumo em string
protocol Resumivel {
    func resumo() -> String
}

// Estrutura que representa uma tarefa
struct Task: Resumivel {
    var titulo: String
    var prioridade: Prioridade
    var concluida: Bool
    var acaoAoConcluir: () -> Void // Closure a ser executada quando a tarefa for concluída
    var vencimento: Date? // Data de vencimento opcional

    // Implementação do método resumo() do protocolo Resumivel
    func resumo() -> String {
        let status = concluida ? "✅ Concluída" : "⏳ Pendente"
        let vencimentoStr: String
        if let dataVencimento = vencimento {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            vencimentoStr = " (Vence em: \(formatter.string(from: dataVencimento)))"
        } else {
            vencimentoStr = ""
        }
        return "[\(status)] \(titulo) (Prioridade: \(prioridade.rawValue))\(vencimentoStr)"
    }
}

// Classe responsável por gerenciar as tarefas, isolada no MainActor para segurança de concorrência.
@MainActor
class ToDoManager {
    // Array para armazenar todas as tarefas
    var tasks: [Task] = []

    // Função para adicionar uma nova tarefa, agora com parâmetros para simulação
    // Permite definir o estado inicial 'concluida', 'acaoAoConcluir' e 'vencimento'
    func addTask(
        titulo: String,
        prioridadeRawValue: String,
        concluida: Bool = false, // Novo parâmetro com valor padrão
        acaoAoConcluir: (() -> Void)? = nil, // Novo parâmetro com valor padrão
        vencimentoString: String? = nil
    ) {
        print("\n--- Adicionar Nova Tarefa Simulada ---")
        guard !titulo.isEmpty else {
            print("❌ Título não pode ser vazio.")
            return
        }

        guard let prioridade = Prioridade(rawValue: prioridadeRawValue) else {
            print("❌ Prioridade inválida: \(prioridadeRawValue).")
            return
        }

        var vencimento: Date? = nil
        if let dateString = vencimentoString {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            if let parsedDate = formatter.date(from: dateString) {
                vencimento = parsedDate
            } else {
                print("⚠️ Formato de data inválido para '\(dateString)'. Data de vencimento não será definida.")
            }
        }

        // Usa a closure fornecida ou uma ação padrão
        let finalAcaoAoConcluir: () -> Void = acaoAoConcluir ?? {
            print("🎉 Tarefa '\(titulo)' concluída com sucesso!")
        }

        let newTask = Task(
            titulo: titulo,
            prioridade: prioridade,
            concluida: concluida, // Usa o valor fornecido
            acaoAoConcluir: finalAcaoAoConcluir, // Usa a closure final
            vencimento: vencimento
        )
        tasks.append(newTask)
        print("✅ Tarefa '\(titulo)' adicionada com sucesso!")
    }

    // Função para listar tarefas com opções de filtro e ordenação, agora com parâmetros para simulação
    func listTasks(statusFilterInput: String = "3", sortOptionInput: String = "3") {
        print("\n--- Listar Tarefas Simuladas ---")
        if tasks.isEmpty {
            print("Nenhuma tarefa cadastrada.")
            return
        }

        var filteredTasks = tasks

        switch statusFilterInput {
        case "1": // Pendente
            filteredTasks = tasks.filter { !$0.concluida }
        case "2": // Concluída
            filteredTasks = tasks.filter { $0.concluida }
        case "3": // Todas
            break
        default:
            print("⚠️ Opção de filtro de status inválida na simulação. Exibindo todas as tarefas.")
        }

        var sortedTasks = filteredTasks

        switch sortOptionInput {
        case "1": // Alta primeiro
            sortedTasks = filteredTasks.sorted { (task1, task2) -> Bool in
                let order: [Prioridade: Int] = [.alta: 0, .media: 1, .baixa: 2]
                return order[task1.prioridade]! < order[task2.prioridade]!
            }
        case "2": // Baixa primeiro
            sortedTasks = filteredTasks.sorted { (task1, task2) -> Bool in
                let order: [Prioridade: Int] = [.alta: 2, .media: 1, .baixa: 0]
                return order[task1.prioridade]! < order[task2.prioridade]!
            }
        case "3": // Sem ordenação
            break
        default:
            print("⚠️ Opção de ordenação inválida na simulação. Exibindo na ordem atual.")
        }

        if sortedTasks.isEmpty {
            print("Nenhuma tarefa encontrada com os filtros aplicados.")
            return
        }

        print("\n--- Suas Tarefas ---")
        for (index, task) in sortedTasks.enumerated() {
            print("\(index + 1). \(task.resumo())")
        }
    }

    // Função para marcar uma tarefa como concluída, agora com parâmetro para simulação
    func markTaskAsCompleted(taskNumberInput: Int) {
        print("\n--- Marcar Tarefa como Concluída Simulada ---")
        if tasks.isEmpty {
            print("Nenhuma tarefa para marcar como concluída.")
            return
        }

        guard taskNumberInput > 0 && taskNumberInput <= tasks.count else {
            print("❌ Número de tarefa inválido na simulação: \(taskNumberInput).")
            return
        }

        let actualIndex = taskNumberInput - 1

        if tasks[actualIndex].concluida {
            print("⚠️ Esta tarefa já está concluída.")
            return
        }

        tasks[actualIndex].concluida = true
        print("✅ Tarefa '\(tasks[actualIndex].titulo)' marcada como concluída!")
        tasks[actualIndex].acaoAoConcluir()
    }
}

// Cria uma instância do ToDoManager
let toDoManager = ToDoManager()

// --- Simulação de Ações ---

print("--- INICIANDO SIMULAÇÃO ---")

// 1. Adicionar algumas tarefas iniciais
toDoManager.addTask(
    titulo: "Estudar para prova de Swift",
    prioridadeRawValue: "Alta",
    concluida: false, // Explicitamente pendente
    acaoAoConcluir: { print("🎉 Parabéns por concluir essa tarefa importante!") },
    vencimentoString: "28/05/2025"
)
toDoManager.addTask(
    titulo: "Fazer compras de supermercado",
    prioridadeRawValue: "Média",
    concluida: false,
    acaoAoConcluir: { print("🛒 Compras feitas, geladeira cheia!") },
    vencimentoString: nil
)
toDoManager.addTask(
    titulo: "Lavar o carro",
    prioridadeRawValue: "Baixa",
    concluida: true, // Adicionada já como concluída para demonstração
    acaoAoConcluir: { print("✨ Carro brilhando desde o início!") },
    vencimentoString: nil
)
toDoManager.addTask(
    titulo: "Pagar contas de luz e água",
    prioridadeRawValue: "Alta",
    concluida: false,
    acaoAoConcluir: { print("💸 Contas em dia, ufa!") },
    vencimentoString: "25/05/2025"
)
toDoManager.addTask(
    titulo: "Agendar consulta médica",
    prioridadeRawValue: "Média",
    concluida: false,
    acaoAoConcluir: { print("🩺 Consulta agendada com sucesso!") },
    vencimentoString: "01/06/2025"
)

// 2. Listar todas as tarefas
print("\n--- Listando todas as tarefas após adição ---")
toDoManager.listTasks(statusFilterInput: "3", sortOptionInput: "3") // Todas, sem ordenação

// 3. Tentar marcar uma tarefa que já está concluída (Lavar o carro - tarefa 3)
print("\n--- Tentando marcar 'Lavar o carro' (já concluída) ---")
toDoManager.markTaskAsCompleted(taskNumberInput: 3)

// 4. Marcar uma tarefa como concluída (ex: "Fazer compras de supermercado" - supondo que seja a tarefa 2 na lista inicial)
print("\n--- Marcando 'Fazer compras de supermercado' como concluída ---")
toDoManager.markTaskAsCompleted(taskNumberInput: 2)

// 5. Listar apenas as tarefas pendentes, ordenadas por prioridade (alta primeiro)
print("\n--- Listando tarefas pendentes (Alta primeiro) ---")
toDoManager.listTasks(statusFilterInput: "1", sortOptionInput: "1")

// 6. Adicionar mais uma tarefa
toDoManager.addTask(
    titulo: "Preparar apresentação do projeto",
    prioridadeRawValue: "Alta",
    concluida: false,
    acaoAoConcluir: { print("💻 Apresentação pronta para arrasar!") },
    vencimentoString: "30/05/2025"
)

// 7. Listar todas as tarefas novamente para ver o estado atual
print("\n--- Listando todas as tarefas após mais uma adição e conclusão ---")
toDoManager.listTasks(statusFilterInput: "3", sortOptionInput: "3")

print("\n--- SIMULAÇÃO CONCLUÍDA ---")
