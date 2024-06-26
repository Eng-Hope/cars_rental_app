import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Map<String, dynamic>>> allAvailableCars(String name) async {
  return await supabase.from('Cars')
      .select()
      .eq('status', 'Available')
      .or('name.ilike.%$name%,model.ilike.%$name%');

}

Future<Map<String, dynamic>> getCar(String id) async {
  return await supabase.from('Cars').select().eq('id', id).single();
}

Future<bool> saveOrder(
    {required String phoneNumber,
    required String paymentName,
    required String date,
    required String time,
    required String numberOfHours,
    required String totalPrice,
    required String carId,
    required String userId}) async {
  bool isSaved = false;
  try {
    await supabase.from('Orders').insert({
      'phoneNumber': phoneNumber,
      'paymentName': paymentName,
      'Date': date,
      'time': time,
      'numberOfHours': numberOfHours,
      'totalPrice': totalPrice,
      'carId': carId,
      'userId': userId
    });
    isSaved = true;
  } catch (e) {
    print(e);
  }
  return isSaved;
}

Future<List<Map<String, dynamic>>> getPaymentList(String userId) async{
  return await supabase.from('Orders').select('totalPrice, Date, time, Status, carId, Cars(imageUrl, name, model)').eq('userId', userId);
}
