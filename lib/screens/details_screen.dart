import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Models/country_api.dart';

class CountryDetailsScreen extends StatelessWidget {
  final CountryModel countryModel;

  const CountryDetailsScreen({Key? key, required this.countryModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      appBar: AppBar(
        title: Text(countryModel.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.network(
              countryModel.flag,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              fit: BoxFit.cover,
            ),
            buildCard('Name', countryModel.name),
            buildCard('Population', countryModel.population.toString()),
            buildCard('Capital', countryModel.capital.toString()),
            buildCard('Region', countryModel.region),
            buildCard('SubRegion', countryModel.subregion),
           
            const SizedBox(
              height: 2,
            ),
            Visibility(
              visible: countryModel.borders != null ? true : false,
              child:  Center(
                child: Text(
                  'Borders:'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            countryModel.borders != null
                ? SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: countryModel.borders!.length,
                      itemBuilder: (context, index) {
                        var bord = countryModel.borders![index];
                        return Card(
                          child: SizedBox(
                            height: 40,
                            width: 80,
                            child: Center(
                                child: Text(
                              bord,
                              style: const TextStyle(fontSize: 25),
                            )),
                          ),
                        );
                      },
                    ),
                  )
                : const Text(''),
          ],
        ),
      ),
    );
  }

  Card buildCard(String name, String data) {
    return Card(
          margin: const EdgeInsets.all(10),
          elevation: 5.0,
          color: Colors.grey,
          shadowColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide.lerp(
              const BorderSide(width: 10,color: Colors.green),
              const BorderSide(width: 6,color: Colors.green),
              2.0,
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 25),
            onTap: () {},
            leading: Text(
              name,
              style: const TextStyle(fontSize: 20,color: Colors.white),
            ),
            trailing: Text(
              data.toUpperCase(),
              style: const TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ),
        );
  }
}
