import 'package:flutter/material.dart';
import 'package:rental_app/Screens/home.dart';
import '../authentication/login_screen.dart';
import '../functionalities/auth.dart';
class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
       child: Column(

        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget> [
                 Container(

                  width:100,
                  height: 100,
                  decoration:  const BoxDecoration(
                    shape: BoxShape.circle,
                      )
                      ) 
                    ,]


                 ) 
          ,) ,)

         , const ListTile(
          leading: Icon (Icons.person),
          title: Text(
            'My account', 
            style:TextStyle(
              fontSize:18,),
              ),

              onTap: null,

         ),

          ListTile(
          leading: const Icon (Icons.check_box_outline_blank_sharp),
          title: const Text(
            'Services', 
            style:TextStyle(
              fontSize:18,),
              ),

              onTap: ()=>{Navigator.push(context, MaterialPageRoute(builder: (c)=>const Home()))

              },
         ),

          const ListTile(
          leading: Icon (Icons.wallet),
          title: Text(
            'Payments', 
            style:TextStyle(
              fontSize:18,),
              ),

               onTap: null,

          ),

          const ListTile(
          leading: Icon (Icons. lock_clock),
          title: Text(
            'My rides', 
            style:TextStyle(
              fontSize:18,),
              ),

              onTap: null,
    ),

    const ListTile(
          leading: Icon (Icons.nat ),
          title: Text(
            'About', 
            style:TextStyle(
              fontSize:18,),
              ),
               onTap: null
    ),

      ListTile(
          leading: const Icon (Icons.logout ),
          title: const Text(
            'Log Out', 
            style:TextStyle(
              fontSize:18,),
              ),

               onTap: () async{
                    supabase.auth.signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (c)=>const LoginScreen()));
               }
     )
               
    ]
    )
    );
  }
}