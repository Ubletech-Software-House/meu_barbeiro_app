import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? _selectedProfile; // Cliente ou Barbeiro
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: integrar chamada de API de cadastro
      // print('Nome: ${_nameController.text}');
      // print('E-mail: ${_emailController.text}');
      // print('Telefone: ${_phoneController.text}');
      // print('Senha: ${_passwordController.text}');
      // print('Perfil: $_selectedProfile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202020),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo pequeno no topo
                Image.asset(
                  'assets/images/logo.png',
                  height: 80,
                ),
                const SizedBox(height: 24),
                // Nome completo
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome completo',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o nome completo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // E-mail
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Informe um e-mail válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Telefone
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o telefone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Senha
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a senha';
                    }
                    if (value.length < 8 ||
                        !RegExp(r'^(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
                      return 'Senha fraca (mín. 8 caracteres, 1 letra maiúscula, 1 número)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Confirmar Senha
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirme a senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                // Seleção de perfil
                DropdownButtonFormField<String>(
                  value: _selectedProfile,
                  decoration: const InputDecoration(
                    labelText: 'Perfil',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'cliente', child: Text('Cliente')),
                    DropdownMenuItem(
                        value: 'barbeiro', child: Text('Barbeiro')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedProfile = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Selecione um perfil' : null,
                ),
                const SizedBox(height: 32),
                // Botão de cadastro
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFf39c12),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: _register,
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
