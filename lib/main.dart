// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:intl/intl.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   String time = '';
//   String date = '';
//   String errortime = '';
//   String amPm = '';

//   List<String> countries = [
//     'Asia/Vientiane',
//     'America/New_York',
//     'Europe/London',
//     'Europe/Berlin',
//     'Asia/Dubai',
//     'Asia/Kolkata',
//     'Asia/Tokyo',
//     'Australia/Sydney',
//     'Pacific/Auckland',
//     'Africa/Johannesburg',
//     'America/Los_Angeles',
//     'Asia/Shanghai',
//     'America/Sao_Paulo',
//   ];
//   Future<void> getTime(String timezone) async {
//     errortime = '';
//     try {
//       // Make the API request
//       var url = Uri.parse('http://worldtimeapi.org/api/timezone/$timezone');
//       var response = await http.get(url);
//       print(response.statusCode);
//       print(response.body);

//       // Process the response
//       if (response.statusCode == 200) {
//         var responseData = json.decode(response.body);
//         var datetime = responseData['datetime'];
//         DateTime parsedDateTime =
//             DateFormat("yyyy-MM-dd'T'HH:mm").parse(datetime);

//         String extractTime() {
//           DateFormat formatter = DateFormat('HH:mm');
//           return formatter.format(parsedDateTime);
//         }

//         String extractDate() {
//           DateFormat formatter = DateFormat('yyyy-MM-dd');
//           return formatter.format(parsedDateTime);
//         }

//         String extractAmPm() {
//           DateFormat formatter = DateFormat('a');
//           return formatter.format(parsedDateTime);
//         }

//         setState(() {
//           date = extractDate();
//           time = extractTime();
//           amPm = extractAmPm();
//           print(amPm);
//         });
//       } else {
//         setState(() {
//           time = 'Failed to get time';
//           date = 'Failed to get date';
//         });
//       }
//     } catch (error) {
//       setState(() {
//         errortime = 'cannot get time plaese try again';
//         time = 'Failed to get time';
//         date = 'Failed to get date';
//       });
//     }
//   }

//   String selectedValue = 'Asia/Vientiane';
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getTime(selectedValue);
//   }

//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: const Text("World time")),
//         body: SingleChildScrollView(
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 50, bottom: 30),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   errortime != ""
//                       ? Text(
//                           errortime,
//                           style: TextStyle(color: Colors.red),
//                         )
//                       : SizedBox(
//                           height: 10,
//                         ),
//                   Text(
//                     "$time $amPm",
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 25,
//                   ),
//                   Text(
//                     date,
//                     style:
//                         TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(left: 50, right: 50, top: 50),
//                     child: Container(
//                       width: double
//                           .infinity, // Set the width of the dropdown button
//                       height: 50,
//                       // padding: EdgeInsets.symmetric(horizontal: 8), // Add horizontal padding to the dropdown
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 217, 217,
//                             217), // Set the background color of the dropdown button
//                         border: Border
//                             .all(), // Add a border around the dropdown button
//                         borderRadius:
//                             BorderRadius.circular(4), // Apply border radius
//                       ), // Set the height of the dropdown button
//                       child: DropdownButton<String>(
//                         value: selectedValue,
//                         hint: const Padding(
//                           padding: EdgeInsets.only(
//                             right: 150,
//                           ),
//                           child: Text('Select an option'),
//                         ),
//                         iconSize: 50,
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             selectedValue = newValue!;
//                             print(newValue);
//                             getTime(newValue);
//                           });
//                         },
//                         items: countries
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 18.0),
//                               child: Row(
//                                 children: [
//                                   Image.network("flag of countries"),
//                                   Text(value),
//                                 ],
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String time = '';
  String date = '';
  String amPm = '';
  bool success = false;
  List<String> countries = [
    'Asia/Vientiane',
    'America/New_York',
    'Europe/London',
    'Europe/Berlin',
    'Asia/Dubai',
    'Asia/Kolkata',
    'Asia/Tokyo',
    'Australia/Sydney',
    'Pacific/Auckland',
    'Africa/Johannesburg',
    'America/Los_Angeles',
    'Asia/Shanghai',
    'America/Sao_Paulo',
  ];

  Map<String, String> flagImages = {
    'Asia/Vientiane':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Flag_of_Laos.svg/2560px-Flag_of_Laos.svg.png',
    'America/New_York':
        'https://upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/1200px-Flag_of_the_United_States.svg.png',
    'Europe/London':
        'https://www.flagsonline.it/uploads/2019-12-10/420-272/London-bandiere-flag-drapeau.jpg',
    'Europe/Berlin':
        'https://upload.wikimedia.org/wikipedia/en/thumb/b/ba/Flag_of_Germany.svg/1200px-Flag_of_Germany.svg.png',
    'Asia/Dubai':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_United_Arab_Emirates.svg/255px-Flag_of_the_United_Arab_Emirates.svg.png',
    'Asia/Kolkata':
        'https://www.mapsofindia.com/maps/india/india-flag-1280x768.jpg',
    'Asia/Tokyo':
        'https://upload.wikimedia.org/wikipedia/en/thumb/9/9e/Flag_of_Japan.svg/800px-Flag_of_Japan.svg.png',
    'Australia/Sydney':
        'https://cdn.britannica.com/78/6078-004-77AF7322/Flag-Australia.jpg',
    'Pacific/Auckland':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Flag_of_Iceland.svg/2560px-Flag_of_Iceland.svg.png',
    'Africa/Johannesburg':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Flag_of_Johannesburg%2C_South_Africa.svg/800px-Flag_of_Johannesburg%2C_South_Africa.svg.png',
    'America/Los_Angeles':
        'https://cdn.britannica.com/79/4479-050-6EF87027/flag-Stars-and-Stripes-May-1-1795.jpg',
    'Asia/Shanghai':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/255px-Flag_of_the_People%27s_Republic_of_China.svg.png',
    'America/Sao_Paulo':
        'https://upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/1200px-Flag_of_Brazil.svg.png',
  };

  // Future<void> getTime(String timezone) async {
  //   errortime = '';
  //   try {
  //     // Make the API request
  //     var url = Uri.parse('http://worldtimeapi.org/api/timezone/$timezone');
  //     var response = await http.get(url);
  //     print(response.statusCode);
  //     print(response.body);

  //     // Process the response
  //     if (response.statusCode == 200) {
  //       var responseData = json.decode(response.body);
  //       var datetime = responseData['datetime'];
  //       DateTime parsedDateTime =
  //           DateFormat("yyyy-MM-dd'T'HH:mm").parse(datetime);

  //       String extractTime() {
  //         DateFormat formatter = DateFormat('HH:mm');
  //         return formatter.format(parsedDateTime);
  //       }

  //       String extractDate() {
  //         DateFormat formatter = DateFormat('yyyy-MM-dd');
  //         return formatter.format(parsedDateTime);
  //       }

  //       String extractAmPm() {
  //         DateFormat formatter = DateFormat('a');
  //         return formatter.format(parsedDateTime);
  //       }

  //       setState(() {
  //         date = extractDate();
  //         time = extractTime();
  //         amPm = extractAmPm();
  //         print(amPm);
  //       });
  //     } else {
  //       setState(() {
  //         time = 'Failed to get time';
  //         date = 'Failed to get date';
  //       });
  //     }
  //   } catch (error) {
  //     setState(() {
  //       errortime = 'Cannot get time. Please try again.';
  //       time = 'Failed to get time';
  //       date = 'Failed to get date';
  //     });
  //   }
  // }
  Future<void> getTime(String timezone) async {
    success = false;
    while (!success) {
      try {
        // Make the API request
        var url = Uri.parse('http://worldtimeapi.org/api/timezone/$timezone');
        var response = await http.get(url);
        print(response.statusCode);
        print(response.body);

        // Process the response
        if (response.statusCode == 200) {
          var responseData = json.decode(response.body);
          var datetime = responseData['datetime'];
          DateTime parsedDateTime =
              DateFormat("yyyy-MM-dd'T'HH:mm").parse(datetime);

          String extractTime() {
            DateFormat formatter = DateFormat('HH:mm');
            return formatter.format(parsedDateTime);
          }

          String extractDate() {
            DateFormat formatter = DateFormat('yyyy-MM-dd');
            return formatter.format(parsedDateTime);
          }

          String extractAmPm() {
            DateFormat formatter = DateFormat('a');
            return formatter.format(parsedDateTime);
          }

          setState(() {
            date = extractDate();
            time = extractTime();
            amPm = extractAmPm();
            print(amPm);
          });

          success = true; // Set success to true to exit the loop
        } else {
          setState(() {
            time = 'Failed to get time';
            date = 'Failed to get date';
          });
        }
      } catch (error) {
        setState(() {
          time = 'Failed to get time';
          date = 'Failed to get date';
        });
      }
    }
  }

  String selectedValue = 'Asia/Vientiane';

  @override
  void initState() {
    super.initState();
    getTime(selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("World Time")),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  success == false
                      ? CircularProgressIndicator()
                      : Column(
                          children: [
                            Text(
                              "$time $amPm",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 25),
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 50),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 217, 217, 217),
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: DropdownButton<String>(
                        value: selectedValue,
                        hint: const Padding(
                          padding: EdgeInsets.only(right: 130),
                          child: Text('Select an option'),
                        ),
                        iconSize: 50,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            print(newValue);
                            getTime(newValue);
                          });
                        },
                        items: countries
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.network(
                                    flagImages[value]!,
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(value),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
