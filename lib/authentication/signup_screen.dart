import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../functionalities/auth.dart';
import '../methods/common_methods.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignUpScreen> {

  TextEditingController userNameTextEditingControler =TextEditingController();
  TextEditingController userPhoneTextEditingControler =TextEditingController();
  TextEditingController emailTextEditingControler =TextEditingController();
  TextEditingController passwordTextEditingController =TextEditingController();
  CommonMethods cMethods = CommonMethods();

  bool isLoading = false;

   checkIfNetworkAvailable()
   {
     cMethods.checkConnectivity(context);
     signUpFormValidation();

  }

   signUpFormValidation()
   {
     if(userNameTextEditingControler.text.trim().length<3)
     {
    cMethods.displaySnackBar("Your name must be atleast 4 or more characters.", context) ;
   }
     else if (userPhoneTextEditingControler.text.trim().length<10)
     {
       cMethods.displaySnackBar("your name must be atleast 8 or more characters", context);

     }
     else if (emailTextEditingControler.text.trim().length< 7)
     {
       cMethods.displaySnackBar("your name must be atleat 8 or more characters", context);
    }
     else if (!emailTextEditingControler.text.contains("0"))
     {
      cMethods.displaySnackBar("please write valid email", context); 
     }
    else if(passwordTextEditingController.text.trim().length<8)
    {
      cMethods.displaySnackBar("your password must be atleast 8 or more characters", context);
    }
     else
    {
      // register user
    }
  
  }
  @override
  Widget build(BuildContext context) 
  {
    return  Scaffold(
     body: SingleChildScrollView(
      child: Padding (
        padding: const EdgeInsets.all(70) ,
        child:Column(
         children: [

          // Image.asset(
          //  "assets/images/images_2.jpg" 
          // ),

          const Text(
           'Create a User\'s Account',
           style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black
           ) 
          ),
          
          // text field

           Padding(
           padding: const EdgeInsets.all(22),
           child: Column(
            children: [


              // TextField(
              //   controller: userNameTextEditingControler,
              //   keyboardType: TextInputType.text,
              //   decoration: const InputDecoration(
              //     labelText: "User Name",
              //     labelStyle: TextStyle(
              //       fontSize: 24,
              //       color: Colors.black,
              //     ),
              //     hintText: "User Name",


                // ),
                // style: const TextStyle(
                //   color: Colors.black,
                //   fontSize: 10,

                // ),
              // ),
              // const SizedBox( height: 22,),

              
              // TextField(
              //   controller: userPhoneTextEditingControler,
              //   keyboardType: TextInputType.number,
              //   decoration: const InputDecoration(
              //     labelText: "User Phone number",
              //     labelStyle: TextStyle(
              //       fontSize: 24,
              //       color: Colors.black,
              //     ),
              //     hintText: "User Phone number",


              //   ),
              //   style: const TextStyle(
              //     color: Colors.black,
              //     fontSize: 10,

              //   ),
              // ),
              // const SizedBox( height: 22,),

             

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
               await supabase.auth.signUp( email: emailTextEditingControler.text,password: passwordTextEditingController.text);
                 setState(() {
                   isLoading = false;
                 });
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen(),),);
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signup with your credentials', style: TextStyle(color: Colors.green),),),);
                  }
                  catch(e){
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('An error has occurred', style: TextStyle(color: Colors.redAccent),),),);
                  }

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10,)
                ),
                child: isLoading? const CircularProgressIndicator(color: Colors.white,): const Text(
                  "Sign up", style: TextStyle(color: Colors.black),

                ),
                ),



            ],
           ) 
          ),

          // text button

          TextButton(
            onPressed:() 
            {
              Navigator.push(context, MaterialPageRoute(builder:(c)=>const LoginScreen()));

            },

            child: const Text(
             "Already have an Account? Login Here",
             style: TextStyle(
              color: Colors.black,
             ),
              ),

          ),
         ]) 
        ) ));


      
     
    
  }
}