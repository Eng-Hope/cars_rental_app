import 'package:supabase_flutter/supabase_flutter.dart';
final supabase = Supabase.instance.client;

Future<AuthResponse> signUp(String email, String password) async {
   return await supabase.auth.signUp(email: email, password: password);
}


Future<AuthResponse> login(String email, String password) async{
  return await supabase.auth.signInWithPassword(email: email, password: password);
}