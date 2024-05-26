import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rental_app/Screens/home_drawer.dart';
import 'package:rental_app/authentication/login_screen.dart';
import 'package:rental_app/functionalities/data.dart';

class CarBooking extends StatefulWidget {
  final String id;
  final String price;
  final String model;
  final String name;
  final String imageUrl;
  final String serviceType;
  final String transportType;
  CarBooking(
      {super.key,
      required this.id,
      required this.price,
      required this.model,
      required this.name,
      required this.transportType,
      required this.serviceType,
      required this.imageUrl});

  @override
  State<CarBooking> createState() => _CarBookingState();
}

class _CarBookingState extends State<CarBooking> {
  TextEditingController phoneNumber = TextEditingController();

  TextEditingController paymentName = TextEditingController();

  TextEditingController numberOfHours = TextEditingController();

  double totalAmount = 0.0;

   DateTime? date = null;
   String? formattedDate = null;
   TimeOfDay? timeOfDay = null;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    if(supabase.auth.currentUser == null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
    }

    const double rowSize = 18;
    const style = TextStyle(fontWeight: FontWeight.w500);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: const Icon(Icons.arrow_back)),
        centerTitle: false,
        title: const Text(
          'Booking Form',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const HomeDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    minRadius: 60,
                    backgroundImage: NetworkImage(widget.imageUrl),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Name : ${widget.name}',
                          style: const TextStyle(
                            fontSize: rowSize,
                          ),
                        ),
                        Text(
                          'Model : ${widget.model}',
                          style: const TextStyle(
                            fontSize: rowSize,
                          ),
                        ),
                        Text(
                          'Service Type : ${widget.serviceType}',
                          style: const TextStyle(
                            fontSize: rowSize,
                          ),
                        ),
                        Text(
                          'Transport Type : ${widget.transportType}',
                          style: const TextStyle(
                            fontSize: rowSize,
                          ),
                        ),
                        Text(
                          'Price Per hour : ${widget.price} Tsh/=',
                          style: const TextStyle(
                            fontSize: rowSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text(
                            'Phone Number',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (String value) {
                              setState(() {
                                phoneNumber.text = value;
                              });
                            },
                            style: const TextStyle(height: 0.1),
                            decoration: InputDecoration(
                              hintText: 'Number of payment',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text(
                            'Payment name',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (String value) {
                              setState(() {
                                paymentName.text = value;
                              });
                            },
                            style: const TextStyle(height: .1),
                            decoration: InputDecoration(
                              hintText: 'Name for payment',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                )),
                            onPressed: () async => {
                              date = await showDialog<DateTime?>(
                                  context: context,
                                  builder: (context) {
                                    return DatePickerDialog(
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.utc(3000),
                                    );
                                  }),
                              if (date != null)
                                {
                                  setState(() {
                                    date = date;
                                  }),
                                },
                              formattedDate = DateFormat('yyyy-MM-dd')
                                  .format(date!)
                                  .toString(),
                            },
                            child: const Text('choose date'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text(
                            'Choose Start Time',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                )),
                            onPressed: () async => {
                              timeOfDay = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ),
                              if (timeOfDay != null)
                                {
                                  timeOfDay!
                                          .format(context)
                                          .toString()
                                },
                            },
                            child: const Text('start time'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          child: Text(
                            'Number of hours',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: numberOfHours,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(height: .1),
                            decoration: InputDecoration(
                              hintText: 'hours',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (String value) => {
                              if (value.isNotEmpty)
                                {
                                  setState(() {
                                    numberOfHours.text = value;
                                    try {
                                      totalAmount = double.parse(value) *
                                          double.parse(widget.price);
                                    } catch (e) {
                                      setState(() {});
                                    }
                                  }),
                                }
                              else if (value.isEmpty)
                                {
                                  setState(() {
                                    totalAmount = 0.0;
                                  }),
                                }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Amount to be paid is $totalAmount Tsh/=',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      child: (phoneNumber.text.isEmpty ||
                              paymentName.text.isEmpty ||
                              date == null ||
                              timeOfDay == null ||
                              numberOfHours.text.isEmpty||
                              timeOfDay == null)
                          ? ElevatedButton(
                              onPressed: () => {},
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 45),
                                backgroundColor: Colors.redAccent,
                              ),
                              child: const Text(
                                'Fill All the form',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ))
                          : ElevatedButton(
                              onPressed: ()  async {
                                setState(() {
                                  isLoading = true;
                                });
                                bool status = await saveOrder(phoneNumber: phoneNumber.text, paymentName: paymentName.text, date: formattedDate!, time: timeOfDay.toString(), numberOfHours: numberOfHours.text, totalPrice: totalAmount.toString(), carId: widget.id, userId: supabase.auth.currentUser!.id);
                                setState(() {
                                  isLoading = false;
                                });

                                if(status == true){
                                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Icon(Icons.done, color: Colors.greenAccent,),
                                     Text('Order added successful', style: TextStyle(color: Colors.greenAccent, fontSize: 17),),
                                   ],
                                 )));
                                }
                                else if(status == false){
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.dangerous, color: Colors.redAccent,),
                                      Text('An error has occured ', style: TextStyle(color: Colors.redAccent, fontSize: 17),),
                                    ],
                                  )));
                                }

                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 45),
                                backgroundColor: Colors.redAccent,
                              ),
                              child: isLoading? const CircularProgressIndicator(color: Colors.black,): const Text(
                                'Oder Now',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Payment methods',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 90,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/mpesa.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 90,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/tigopesa.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'press',
                                style: style,
                              ),
                              Text(
                                '*150*00#',
                                style: style,
                              ),
                              Text(
                                '4: Lipa kwa simu',
                                style: style,
                              ),
                              Text(
                                '1: Ingiza lipa namba',
                                style: style,
                              ),
                              Text(
                                '1: Mpesa',
                                style: style,
                              ),
                              Text(
                                'Lipa namba 57054772',
                                style: style,
                              ),
                              Text(
                                'Jina LUSEKELO GAUDEN MWAMWALA',
                                style: style,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'press',
                                style: style,
                              ),
                              Text(
                                '*150*01#',
                                style: style,
                              ),
                              Text(
                                '5: Lipa kwa simu',
                                style: style,
                              ),
                              Text(
                                '1: kwenda Tigo Pesa',
                                style: style,
                              ),
                              Text(
                                'Lipa namba 15794164',
                                style: style,
                              ),
                              Text(
                                'Jina MWAMWALA FAMILY',
                                style: style,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
