import 'package:flutter/material.dart';
import 'package:flutter_covid_19_tracker_app/Services/state_services.dart';
import 'package:flutter_covid_19_tracker_app/View/details_screen.dart';
import 'package:shimmer/shimmer.dart';
class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  @override
  StateServices statesservices=StateServices();

  final searchcontroller=TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchcontroller,
                onChanged: (value) {
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: "Search with country name"
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future:statesservices.countriesListApi(),
                  builder: (context,snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return  ListView.builder(
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                            child:  Column(
                          children: [
                          ListTile(
                          title: Container(height: 10,width: 80,color: Colors.white,),
                          subtitle: Container(height: 10,width: 80,color: Colors.white,),
                            leading: Container(height: 50,width: 50,color: Colors.white,),
                          ),
                          ],
                          )
                          );


                        },
                        // itemCount: 3,
                      );
                    }else{
                        return
                          ListView.builder(
                        itemBuilder: (context, index) {
                          String name=snapshot.data![index]['country'];
                          if(searchcontroller.text.isEmpty){
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                    context, MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    name: name,
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    active: snapshot.data![index]['active'],
                                    critical:snapshot.data![index]['critical'],
                                    test: snapshot.data![index]['tests'],
                                    todayrecovered: snapshot.data![index]['todayRecovered'],
                                    totalcases: snapshot.data![index]['cases'],
                                    totaldeaths: snapshot.data![index]['deaths'],
                                    totalrecovered: snapshot.data![index]['todayRecovered'],


                                  ),));
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(snapshot.data![index]['country'].toString()),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag'],),
                                      height: 50,
                                      width: 50,
                                    ),

                                  )
                                ],
                              ),
                            );
                          }else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase())){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context, MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                        name: name,
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        active: snapshot.data![index]['active'],
                                        critical:snapshot.data![index]['critical'],
                                        test: snapshot.data![index]['tests'],
                                        todayrecovered: snapshot.data![index]['todayRecovered'],
                                        totalcases: snapshot.data![index]['cases'],
                                        totaldeaths: snapshot.data![index]['deaths'],
                                        totalrecovered: snapshot.data![index]['todayRecovered'],


                                      ),));
                                  },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country'].toString()),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag'],),
                                      height: 50,
                                      width: 50,
                                    ),

                                  ),
                                )
                              ],
                            );
                          }else{
                            return Container();
                          }

                        },
                        itemCount: snapshot.data!.length,
                      );
                    }
                    }



              ),
            )
          ],
        ),
      ),
    );
  }
}
