import 'dart:async';
import 'dart:convert';
import 'package:country_api/Models/country_api.dart';
import 'package:country_api/utils/connectivity.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'details_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StreamController _streamController;
  late Stream _stream;
  var countryList = <CountryModel>[];

  void _getAllCountry() async {
    if(await ConnectivityHandler.connectivity() == true){
      var url = 'https://restcountries.com/v2/all';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        for (var countryData in jsonData) {
          CountryModel countryModel = CountryModel.fromJSON(countryData);
          countryList.add(countryModel);
          _streamController.add(countryList);
        }
      } else {
        _streamController.add('wrong');
      }
    }
    else{
      Fluttertoast.showToast(msg: "Please Connect to the Internet and try again");
    }
  }

  @override
  void initState() {
    _getAllCountry();
    _streamController = StreamController();
    _stream = _streamController.stream;
    _streamController.add('empty');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries List'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'loading') {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == 'wrong') {
              return const Text('something went wrong');
            } else if (snapshot.data == 'empty') {
              return const Center(child: CircularProgressIndicator());
            }else {
              return ListView.builder(
                itemCount: countryList.length,
                itemBuilder: (context, index) {
                  var country = countryList[index];
                  return Card(
                    child: ListTile(
                      //minVerticalPadding: 20.0,
                      leading: CircleAvatar(
                        radius: 25,
                        child: ClipOval(
                          child: SvgPicture.network(
                            country.flag,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(country.name),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return CountryDetailsScreen(countryModel: country);
                        }));
                      },
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
