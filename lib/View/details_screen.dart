import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String name;
  String image;
  int totalcases,totaldeaths,totalrecovered,active,critical,todayrecovered,test;
   DetailsScreen({
     required this.name,
     required this.critical,
     required this.totalcases,
     required this.todayrecovered,
     required this.totaldeaths,
     required this.active,
     required this.image,
     required this.totalrecovered,
     required this.test,


});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Stack(
      alignment: Alignment.topCenter,
          children: [
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.067),
              child: Card(
                        child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*.06,),
              reusable_row(title: "Cases", value: widget.totalcases.toString()),
              reusable_row(title: "Critical", value: widget.critical.toString()),
              reusable_row(title: "TodayRecovered", value: widget.todayrecovered.toString()),
              reusable_row(title: "TotalDeaths", value: widget.totaldeaths.toString()),
              reusable_row(title: "Active", value: widget.active.toString()),
              reusable_row(title: "TotalRecovered", value: widget.todayrecovered.toString()),
              reusable_row(title: "Test", value: widget.test.toString()),

                      ],
                    ),

                    ),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.image),

            )

        ],
      )

        ],
      ),
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
