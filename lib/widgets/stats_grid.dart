import 'package:covid_bdcc2/services/HttpClient.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class StatsGrid extends StatelessWidget {
  final String country;
  final HttpClient httpFactory = GetIt.I<HttpClient>();

  StatsGrid({@required this.country});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: (this.country == "glob")
          ? httpFactory.getGlobStats()
          : httpFactory.getCountryStats(this.country),
      builder: (_, snap) {
        return (!snap.hasData)
            ? Center(child: CircularProgressIndicator())
            : Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          _buildStatCard('Total Cases', snap.data["total_cases"], Colors.orange),
                          _buildStatCard('Deaths', snap.data["total_deaths"], Colors.red),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          _buildStatCard('Recovered', snap.data["total_recovered"], Colors.green),
                          _buildStatCard('Active', snap.data["total_active_cases"], Colors.lightBlue),
                          _buildStatCard('Critical', snap.data["total_serious_cases"], Colors.purple),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
