import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s19_bloc_cubits/presentation/blocs/register/register_cubit.dart';

import '../widgets/inputs/custom_input.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New user"),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView()
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: const SingleChildScrollView(
        child: Column(
          children: [
            FlutterLogo( size: 100,),

            _RegisterForm(),

            SizedBox(height: 20,),

            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}


class _RegisterForm extends StatelessWidget {
  const _RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final cubit = context.watch<RegisterCubit>();
    final username = cubit.state.username;
    final password = cubit.state.password;
    final email = cubit.state.email;
    
    return Form(
      child: Column(
        children: [
          CustomTextForm(
            label: "Username",
            onChanged: (p0) => cubit.usernameChanged(p0),
            errormsg: username.errorMsg
          ),

          const SizedBox(height: 10,),

          CustomTextForm(
            label: "Email",
            // onChanged: (p0) => email = p0,
            onChanged: (p0) => cubit.emailChanged(p0),
            errormsg: email.errorMsg,
          ),

          const SizedBox(height: 20,),

          CustomTextForm(
            label: "Password",
            obscureText: true,
            // onChanged: (p0) => password = p0,
            onChanged: (p0) => cubit.passwordChanged(p0),
            errormsg: password.errorMsg,            
          ),

          const SizedBox(height: 20,),

          FilledButton.tonalIcon(
            onPressed: (){
              cubit.onSubimit();
            },
            icon: const Icon(Icons.save), 
            label: const Text("Save user")
          ),

        ],
      )
    );
  }
}