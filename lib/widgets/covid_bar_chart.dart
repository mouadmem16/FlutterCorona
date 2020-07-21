import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:covid_bdcc2/config/styles.dart';
import 'package:get_it/get_it.dart';
import 'package:covid_bdcc2/services/HttpClient.dart';

class CovidBarChart extends StatelessWidget {
  final country;
  final HttpClient httpFactory = GetIt.I<HttpClient>();

  CovidBarChart({@required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Daily New Cases',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: FutureBuilder(
              future: httpFactory.getCountryTimeline(this.country),
              builder: (_, snap) {
                if (!snap.hasData)
                  return Center(child: CircularProgressIndicator());
                else {
                  List<String> keys = snap.data.keys.toList();
                  List<int> values = snap.data.values.toList();

                  return BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 16.0,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          margin: 10.0,
                          showTitles: true,
                          textStyle: Styles.chartLabelsTextStyle,
                          rotateAngle: 35.0,
                          getTitles: (double value) {
                            return keys[value.toInt()];
                          },
                        ),
                        leftTitles: SideTitles(
                            margin: 10.0,
                            showTitles: true,
                            textStyle: Styles.chartLabelsTextStyle,
                            getTitles: (value) {
                              if (value == 0) {
                                return '0';
                              } else if (value % 3 == 0) {
                                return '${(value * 33.34).toInt()}';
                              }
                              return '';
                            }),
                      ),
                      gridData: FlGridData(
                        show: true,
                        checkToShowHorizontalLine: (value) => value % 3 == 0,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: Colors.black12,
                          strokeWidth: 1.0,
                          dashArray: [5],
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: values
                          .asMap()
                          .map((key, value) => MapEntry(
                              key,
                              BarChartGroupData(
                                x: key,
                                barRods: [
                                  BarChartRodData(
                                    y: (value > 500) ? 510 / 32: value.toDouble() / 32,
                                    color: Colors.red,
                                  ),
                                ],
                              )))
                          .values
                          .toList(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
