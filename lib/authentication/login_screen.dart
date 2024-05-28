import 'package:flutter/material.dart';
import 'package:rental_app/authentication/signup_screen.dart';
import '../Screens/home.dart';
import '../functionalities/auth.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingControler =TextEditingController();
  TextEditingController passwordTextEditingController =TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(
      child: Padding (
        padding: const EdgeInsets.all(50) ,
        child:Column(
         children: [
          const Text(
           'Login as a user',
           style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black
           ) 
          ),

           Padding(
           padding: const EdgeInsets.all(22),
           child: Column(
            children: [
               TextField(
                controller: emailTextEditingControler,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "User Email",
                  labelStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  hintText: "User Email",
                ),
                style: const TextStyle(
                  color: Colors.black,

                ),
              ),
              const SizedBox( height: 22,),
               TextField(
                controller: passwordTextEditingController,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "User password",
                  labelStyle: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                  hintText: "User password",
                ),
                style: const TextStyle(
                  color: Colors.black,

                ),
              ),
              const SizedBox( height: 22,),
              ElevatedButton(
                onPressed:() async {
                try{
                  setState(() {
                    isLoading = true;
                  });
                   await supabase.auth.signInWithPassword(email: emailTextEditingControler.text,password:  passwordTextEditingController.text);
                  setState(() {
                    isLoading = false;
                  });

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Home(),),);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Success', style: TextStyle(color: Colors.greenAccent, fontSize: 17),),),);
                }
                catch(e){
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid Credentials', style: TextStyle(color: Colors.redAccent, fontSize: 17),),),);
                }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10,)
                ),

                child: isLoading? const CircularProgressIndicator(): const Text(
                  "Log in",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),

                ),
                ),



            ],
           ) 
          ),

          // text button

          TextButton(
            onPressed:() 
            {
               Navigator.push(context, MaterialPageRoute(builder: (c)=>const SignUpScreen()));
            },
            child: const Text(
             "Don't have an Account? Register Here" ,
             style: TextStyle(
              color: Colors.black,
             ),
              ),
          ),
         ], 
        ) ,
      ),
     )
    );
  }
}
      
        

//       ),
//     );
//   }
// }