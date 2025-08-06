# Sistema de Login - Flutter App

## 📋 Funcionalidades Implementadas

### ✅ Autenticação Completa
- **Login** com validação de email e senha
- **Cadastro** de novos usuários
- **Logout** com confirmação
- **Recuperação de senha** (simulada)
- **Persistência de sessão** usando SharedPreferences

### 🔐 Segurança e Validações
- Validação de formato de email
- Senha mínima de 6 caracteres
- Confirmação de senha no cadastro
- Tratamento de erros com mensagens amigáveis
- Estados de loading durante operações

### 🎨 Interface de Usuário
- Campos com ícones e validação visual
- Botões de mostrar/esconder senha
- Indicadores de carregamento
- Mensagens de erro com opção de fechar
- Drawer com informações do usuário e logout

## 🚀 Como Usar

### 1. Usuários de Teste
Para testar o app, você pode usar estes usuários pré-cadastrados:

```
Email: admin@email.com
Senha: 123456

Email: user@email.com  
Senha: senha123

Email: hellenilda@email.com
Senha: minhasenha
```

### 2. Fluxo de Login
1. Abra o app (abre automaticamente na tela de login)
2. Digite email e senha
3. Clique em "Entrar"
4. Se os dados estiverem corretos, será redirecionado para a HomePage

### 3. Cadastro de Novo Usuário
1. Na tela de login, clique em "Não possui Login? Cadastre-se"
2. Preencha todos os campos obrigatórios
3. Confirme a senha
4. Clique em "Cadastrar"
5. Será automaticamente logado e redirecionado para a HomePage

### 4. Recuperação de Senha
1. Na tela de login, clique em "Esqueci a senha"
2. Digite seu email no modal
3. Clique em "Enviar"
4. Uma mensagem confirmará o envio (simulado)

### 5. Logout
1. Na HomePage, abra o menu lateral (drawer)
2. Clique em "Sair"
3. Confirme a ação no dialog
4. Será redirecionado para a tela de login

## 🏗️ Arquitetura

### Estrutura de Pastas
```
lib/
├── features/
│   ├── common/
│   │   ├── models/
│   │   │   ├── user.dart
│   │   │   └── auth_result.dart
│   │   ├── services/
│   │   │   └── auth_service.dart
│   │   └── constants/
│   ├── login/
│   │   ├── login_page.dart
│   │   └── login_controller.dart
│   ├── sign_in/
│   │   ├── signin_page.dart
│   │   └── signin_controller.dart
│   └── home/
│       └── home_page.dart
```

### Componentes Principais

#### AuthService
- Gerencia a autenticação de usuários
- Simula uma API com usuários mock
- Persiste dados com SharedPreferences
- Valida credenciais e formato de dados

#### LoginController
- Controla o estado da tela de login
- Gerencia campos de texto e validações
- Comunica-se com o AuthService
- Notifica mudanças na UI

#### SignInController
- Similar ao LoginController mas para cadastro
- Inclui validação de confirmação de senha
- Registra novos usuários

## 🔧 Dependências Utilizadas

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.2.2  # Para persistência de dados
```

## 💡 Próximos Passos

Para expandir a funcionalidade de login, você pode:

1. **Integrar com API real**: Substituir o AuthService mock por chamadas HTTP
2. **Adicionar biometria**: Implementar login com digital/face
3. **OAuth**: Adicionar login com Google/Facebook
4. **Validações avançadas**: Força da senha, bloqueio após tentativas
5. **Recuperação real**: Envio de email real para reset de senha
6. **Criptografia**: Hash das senhas armazenadas

## 🐛 Tratamento de Erros

O sistema trata os seguintes cenários:
- Email ou senha vazios
- Email em formato inválido
- Senha muito curta
- Usuário não encontrado
- Senha incorreta
- Email já cadastrado
- Problemas de conectividade

## 📱 Estados da UI

- **Loading**: Indicador visual durante operações
- **Error**: Mensagens de erro com opção de fechar
- **Success**: Redirecionamento automático após sucesso
- **Validation**: Validação em tempo real dos campos

## 🔒 Segurança

Medidas implementadas:
- Validação client-side
- Ocultação de senhas por padrão
- Logout limpa dados locais
- Sessão persistente segura
- Tratamento de estados sensíveis

---

**Desenvolvido com ❤️ em Flutter**