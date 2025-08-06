# Tasks Manager - App de Gerenciamento de Tarefas

Um aplicativo Flutter completo para gerenciamento de tarefas com sistema de autenticação e funcionalidades avançadas.

## 🚀 Funcionalidades Implementadas

### 🔐 Sistema de Autenticação
- **Login**: Sistema de login com validação de email e senha
- **Cadastro**: Registro de novos usuários com validações robustas
- **Esqueci minha senha**: Sistema de recuperação de senha com interface melhorada
- **Logout**: Funcionalidade de logout seguro
- **Persistência de sessão**: Usuário permanece logado entre sessões

### ✅ Gerenciamento de Tarefas
- **Adicionar tarefas**: Criação de novas tarefas com título e descrição opcional
- **Editar tarefas**: Modificação de tarefas existentes
- **Excluir tarefas**: Remoção de tarefas com confirmação
- **Marcar como concluída**: Toggle de status de conclusão
- **Pesquisar tarefas**: Busca em tempo real por título ou descrição
- **Tarefas de exemplo**: Criação automática de tarefas iniciais para novos usuários

### 🎨 Interface e UX
- **Design moderno**: Interface limpa e intuitiva
- **Responsividade**: Adaptação para diferentes tamanhos de tela
- **Animações**: Transições suaves e feedback visual
- **Estados de loading**: Indicadores de carregamento
- **Mensagens de feedback**: Notificações de sucesso e erro
- **Organização melhorada**: Código bem estruturado e componentizado

### 📊 Funcionalidades Adicionais
- **Estatísticas**: Contador de tarefas total, concluídas e pendentes
- **Drawer lateral**: Menu com informações do usuário e navegação
- **Estado vazio**: Interface amigável quando não há tarefas
- **Validações robustas**: Validação de dados em tempo real

## 🛠️ Validações Implementadas

### Cadastro
- **Nome**: 
  - Mínimo 2 caracteres, máximo 50
  - Apenas letras, espaços e acentos permitidos
- **Email**: Formato válido de email
- **Senha**: 
  - Mínimo 6 caracteres, máximo 50
  - Deve conter pelo menos uma letra e um número
- **Confirmação de senha**: Deve coincidir com a senha

### Login
- **Email**: Formato válido e obrigatório
- **Senha**: Mínimo 6 caracteres

### Tarefas
- **Título**: Mínimo 3 caracteres, máximo 100
- **Descrição**: Opcional, máximo 500 caracteres

## 🏗️ Arquitetura do Projeto

```
lib/
├── features/
│   ├── common/
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   └── app_text_styles.dart
│   │   ├── models/
│   │   │   ├── auth_result.dart
│   │   │   ├── task.dart
│   │   │   └── user.dart
│   │   └── services/
│   │       ├── auth_service.dart
│   │       └── task_service.dart
│   ├── home/
│   │   ├── widgets/
│   │   │   ├── task_dialog.dart
│   │   │   └── task_item.dart
│   │   ├── home_controller.dart
│   │   └── home_page.dart
│   ├── login/
│   │   ├── widgets/
│   │   │   └── forgot_password_dialog.dart
│   │   ├── login_controller.dart
│   │   └── login_page.dart
│   └── sign_in/
│       ├── signin_controller.dart
│       └── signin_page.dart
├── app.dart
└── main.dart
```

## 📱 Screens

### 1. Tela de Login
- Campos de email e senha
- Botão "Esqueci a senha"
- Link para cadastro
- Validações em tempo real
- Estados de loading

### 2. Tela de Cadastro
- Campos: nome, email, senha e confirmação
- Validações robustas
- Interface organizada e responsiva
- Navegação de volta para login

### 3. Tela Principal (Home)
- Lista de tarefas com opções de edição
- Barra de pesquisa funcional
- Botão flutuante para adicionar tarefas
- Drawer com estatísticas e logout
- Estados vazios informativos

### 4. Dialogs
- **Adicionar/Editar Tarefa**: Formulário completo
- **Confirmar Exclusão**: Proteção contra exclusões acidentais
- **Esqueci Minha Senha**: Interface melhorada com instruções claras

## 🔧 Tecnologias Utilizadas

- **Flutter**: Framework principal
- **Dart**: Linguagem de programação
- **SharedPreferences**: Persistência local de dados
- **Material Design**: Sistema de design
- **Provider Pattern**: Gerenciamento de estado

## 🎯 Melhorias Implementadas

### Design e UX
- ✅ Interface de "Esqueci minha senha" completamente reformulada
- ✅ Organização e identação melhorada na SignInPage
- ✅ Componentes reutilizáveis para melhor manutenção
- ✅ Animações e transições suaves
- ✅ Feedback visual consistente

### Lógica e Funcionalidades
- ✅ Sistema completo de gerenciamento de tarefas
- ✅ Validações robustas em todas as entradas
- ✅ Persistência de dados local
- ✅ Pesquisa em tempo real
- ✅ Estados de loading e erro bem tratados
- ✅ Nome de usuário dinâmico no "Bem-vindo"

### Código e Arquitetura
- ✅ Separação clara de responsabilidades
- ✅ Controladores para gerenciamento de estado
- ✅ Serviços isolados para cada funcionalidade
- ✅ Models bem estruturados
- ✅ Widgets componentizados e reutilizáveis

## 🚀 Como Executar

1. Certifique-se de ter o Flutter instalado
2. Clone o projeto
3. Execute `flutter pub get` para instalar as dependências
4. Execute `flutter run` para iniciar o aplicativo

## 📝 Próximas Funcionalidades (Sugestões)

- [ ] Categorias de tarefas
- [ ] Data de vencimento
- [ ] Notificações
- [ ] Sincronização na nuvem
- [ ] Temas personalizáveis
- [ ] Backup e restauração
- [ ] Compartilhamento de tarefas

## 🎉 Projeto Finalizado

Todas as funcionalidades solicitadas foram implementadas com sucesso:

- ✅ Design da tela "Esqueci minha senha"
- ✅ Sistema completo de cadastro com validações
- ✅ Nome de usuário dinâmico na tela principal
- ✅ Sistema completo de tarefas (CRUD)
- ✅ Organização e identação melhorada
- ✅ Funcionalidades extras para melhor experiência

O aplicativo está pronto para uso e pode ser expandido com novas funcionalidades conforme necessário!
