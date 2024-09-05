import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_covid_19_tracker_app/Services/state_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:math' as math;
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_covid_19_tracker_app/main.dart';

import 'countries_list.dart';

class Worldstatescreen extends StatefulWidget {

  @override
  State<Worldstatescreen> createState() => _WorldstatescreenState();
}

class _WorldstatescreenState extends State<Worldstatescreen> with TickerProviderStateMixin {
  @override
  late final AnimationController _animation=AnimationController(
    duration: Duration(seconds: 3),
    vsync:this,
  )..repeat();
  @override
  void initState() {
    //
    // Timer(Duration(seconds: 5),() => Navigator.push(context,MaterialPageRoute(builder: (context) => Worldstatescreen(),)),);
    // super.initState();
  }
  @override
  void dispose() {
    // Dispose the animation controller when the state is disposed
    _animation.dispose();
    super.dispose();
  }

  final colorlist =<Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
     const Color(0xffde5246),
  ];

  Widget build(BuildContext context) {
    StateServices statesservices=StateServices();

    return SafeArea(
      child:Scaffold(
        body:
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
         SizedBox(height: MediaQuery.of(context).size.height*.01,),
            FutureBuilder(
              future:statesservices.fetchWorldStatesRecords(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 50,
                      controller:_animation,
                    ),
                  );
                }else{
                 return Column(
                   children: [
                     PieChart(
                       dataMap: {
                         "Total":double.parse(snapshot.data!.cases.toString()),
                         "Recovered":double.parse(snapshot.data!.recovered.toString()),
                         "Death":double.parse(snapshot.data!.deaths.toString()),
                       },
                       animationDuration:const Duration(milliseconds: 1200),
                       chartType: ChartType.ring,
                       colorList: colorlist,
                       chartRadius: MediaQuery.of(context).size.width/2.9,
                       legendOptions: LegendOptions(
                           legendPosition: LegendPosition.left
                       ),
                       chartValuesOptions: ChartValuesOptions(
                         showChartValuesInPercentage: true
                       ),
                     ),
                     Padding(
                       padding:  EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height*.06),
                       child: Card(
                         child: Column(
                           children: [
                             reusable_row(title: 'Total', value: snapshot.data!.cases.toString()),
                             reusable_row(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                             reusable_row(title: 'Death', value: snapshot.data!.deaths.toString()),
                             reusable_row(title: 'Active', value: snapshot.data!.active.toString()),
                             reusable_row(title: 'Critical', value: snapshot.data!.critical.toString()),
                             reusable_row(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                             reusable_row(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),

                           ],
                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap: (){
                       Navigator.push(context,MaterialPageRoute(builder: (context) => CountriesListScreen(),));
                       },
                       child:Container(
                         height: 50,
                         child: Center(
                           child: Text("Track Countries"),
                         ),
                         decoration: BoxDecoration(
                             color: Color(0xff1aa260),
                             borderRadius: BorderRadius.circular(10)
                         ),
                       ),
                     )
                   ],
                 );
                }

            },

            ),

          ],
        ),
      ),
    )
    );
  }
}




class reusable_row extends StatelessWidget {
  String title,value;
  reusable_row({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider(

          )
        ],
      ),
    );
  }
}
