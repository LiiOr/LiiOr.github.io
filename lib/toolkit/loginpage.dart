import 'package:flutter/material.dart';
import 'package:mylabs/main.dart';

class LoginScreen extends StatefulWidget {
  //final String logoImagePath;
  
  const LoginScreen({
    super.key, /*required this.logoImagePath,*/
  });
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool errorMsg = false;
  bool _obscureText = true;
  //final HttpService httpService = HttpService();

  /*login() async {
    if (_formKey.currentState!.validate()) {
      await Future.delayed(const Duration(seconds: 1));
      Map<String, String> data = {
        'email': _emailController.text.trim(),
        'password': _passwordController.text,
      };
      http.Response response = await httpService.post('/user/login', data);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await storage.write(key: 'token', value: jsonData['token']);
        if (context.mounted) Navigator.pushReplacementNamed(context, homeRoute);
      } else if (response.statusCode == 403) {
        setState(() {
          errorMsg = true;
        });
      }
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
    }
  }*/

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: const Text('SIMPLE LOGIN PAGE'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Image.asset(widget.logoImagePath, height: size.height * 0.2),
                      const Icon(Icons.login, size: 50.0),
                      const Text('Simple Login Page', style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 50),
                      Form(
                        autovalidateMode: autovalidateMode,
                        key: _formKey,
                        child: SizedBox(
                            width: 500,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez renseigner une adresse email';
                                    }
                                    if (value.isValidEmail() == false) {
                                      return 'Le format de votre email est invalide';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.person),
                                      labelText: 'Email',
                                      border: const OutlineInputBorder(),
                                      errorText: errorMsg
                                          ? "Paire email / mdp incorrecte."
                                          : null),
                                ),
                                const SizedBox(height: 30),
                                TextFormField(
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez renseigner votre mot de passe';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    //login();
                                  },
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.lock),
                                      labelText: 'Mot de passe',
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.remove_red_eye_sharp),
                                      ),
                                      errorText: errorMsg
                                          ? "Paire email / mdp incorrecte."
                                          : null),
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  width: 500,
                                  height: 45,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        //login();
                                      },
                                      child: const Text('Connexion')),
                                ),
                                const SizedBox(height: 50),
                                TextButton(
                                    onPressed: () {
                                      /*Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ResetPasswordScreen(),
                                        ),
                                      );*/
                                    },
                                    child: const Text('Mot de passe oublié ?',
                                        style: TextStyle(fontWeight: FontWeight.bold))),
                              ],
                            )),
                      ),
                      const SizedBox(height: 30),
                      Center(
                          child: Text('Version $numVersion',
                              style: const TextStyle(fontSize: 12)))
                    ]))));
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
