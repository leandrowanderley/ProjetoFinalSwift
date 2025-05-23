# 📝 ToDoPriori — Projeto Final do Curso de Swift

Este repositório contém o playground com a **implementação completa** do projeto **ToDoPriori**, desenvolvido por mim como **exemplo prático do projeto final** do **Curso de Swift da Oxetech Maceió**, ministrado por mim, **Leandro Wanderley Cavalcante**.  
Os alunos podem utilizar este código como **referência** para tirar dúvidas ou revisar os conceitos aplicados.

## 🧑‍🏫 Sobre o Projeto

Este projeto foi desenvolvido por **Leandro Wanderley Cavalcante**, instrutor do curso, como **material de apoio** para os estudantes. Serve como um exemplo de implementação completa para auxiliar quem tiver dúvidas sobre como estruturar o projeto final.

---

## 🚀 Descrição

O **ToDoPriori** é um gerenciador de tarefas simples que permite:

- Adicionar tarefas com prioridade (baixa, média, alta)
- Marcar tarefas como concluídas
- Executar uma ação associada ao concluir cada tarefa
- Filtrar e listar tarefas com base em status ou prioridade
- Lidar com datas de vencimento opcionais

---

## 🧠 Conceitos Abordados

Este projeto utiliza diversos conceitos fundamentais do Swift:

- ✅ **Variáveis e constantes (`let` / `var`)**
- 🔁 **Estruturas de controle (`if`, `switch`, `for`)**
- 🧩 **Funções e closures**
- 🧱 **Structs e enums**
- 📚 **Manipulação de coleções (`Array`, `filter`, `map`, `sorted`)**
- 📜 **Protocolos e extensões**
- ❓ **Optionals e tratamento de valores ausentes**

---

## 🏗️ Estrutura da Tarefa

A estrutura principal do app é a `Task`, definida da seguinte forma:

```swift
struct Task: Resumivel {
    let titulo: String
    let prioridade: Prioridade
    var concluida: Bool
    let acaoAoConcluir: () -> Void
    let vencimento: Date?

    func resumo() -> String {
        // Implementação do protocolo Resumivel
    }
}
```

---

## 📌 Enum Prioridade

Crie um enum chamado `Prioridade` com os casos `.baixa`, `.media` e `.alta` para representar o nível de prioridade das tarefas.

---

## 📌 Protocolo Resumivel

Defina um protocolo `Resumivel` que declare o método `resumo() -> String`. Faça a struct `Task` adotar esse protocolo e implementar o método para fornecer um resumo textual da tarefa.

---

## 📌 Estruturas de Controle para Filtragem

Explique que a listagem e filtragem de tarefas utiliza estruturas de controle como `if`, `switch` e `for`, além dos métodos de coleção `filter`, `sorted` e `map` para manipular a lista de tarefas conforme status ou prioridade.

---

## 📌 Optionals e Tratamento de Datas

Informe que o campo `vencimento` na struct `Task` é do tipo opcional (`Date?`). Para exibir essa data, utilize o tratamento seguro com `if let` para desembrulhar a data ou o operador coalescente `??` para fornecer um valor padrão quando a data estiver ausente.

---

## 📌 Exemplos de Uso das Funções

Inclua exemplos de como utilizar as funções para:

- Adicionar uma tarefa ao array de tarefas
- Listar tarefas filtradas por prioridade ou status
- Marcar uma tarefa como concluída e executar sua ação associada

---

## 📌 Extensions (Opcional)

Caso tenha criado extensões para adicionar funcionalidades extras (por exemplo, formatação de datas), mencione essa prática e dê uma breve descrição do que a extensão realiza.


## 🛠 Funcionalidades Implementadas
 - `adicionarTarefa(tarefa: Task)`

 - `listarTarefas(filtrandoPor prioridade: Prioridade?)`

 - `marcarComoConcluida(titulo: String)`

💡 Exemplo de Uso
```swift
let tarefa = Task(
    titulo: "Estudar para prova",
    prioridade: .alta,
    concluida: false,
    acaoAoConcluir: {
        print("🎉 Parabéns por concluir essa tarefa importante!")
    },
    vencimento: nil
)
```
## 🌟 Desafio Extra (Opcional)
 - Implementação de persistência em arquivo com Codable

 - Criação de uma interface gráfica usando SwiftUI

## 📁 Conteúdo do Repositório
CursoSwift.playground/ — Playground com todo o código-fonte do projeto.
