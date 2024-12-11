import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  SharedPreferences? perf;
  num hieght = 0, wieght = 0;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() {
        perf = value;
        hieght = perf!.getDouble("last_input_hieght")?.toDouble() ?? 0;
        wieght = perf!.getDouble("last_input_wieght")?.toDouble() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: bodysection());
  }

  Widget bodysection() {
    if (perf == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "0.00 BMI",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [wieghtiput(), hieghtiput()],
          )
        ],
      ),
    );
  }

  Widget wieghtiput() {
    return Column(
      children: [
        Text("Wieght"),
        InputQty(
          initVal: wieght,
          maxVal: double.infinity,
          minVal: 0,
          steps: 1,
          onQtyChanged: (value) {
            setState(() {
              wieght = value;
              perf!.setDouble("last_input_wieght", wieght.toDouble());
            });
          },
        )
      ],
    );
  }

  Widget hieghtiput() {
    return Column(
      children: [
        Text("Hieght"),
        InputQty(
          initVal: hieght,
          maxVal: double.infinity,
          minVal: 0,
          steps: 1,
          onQtyChanged: (value) {
            setState(() {
              hieght = value;
              perf!.setDouble("last_input_hieght", hieght.toDouble());
            });
          },
        )
      ],
    );
  }
}
