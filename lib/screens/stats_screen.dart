import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:covid_bdcc2/config/palette.dart';
import 'package:covid_bdcc2/config/styles.dart';
import 'package:covid_bdcc2/widgets/widgets.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final _countries = ["MA", "FR", "glob"];
  static StatsGrid _statsGrid;
  static CovidBarChart _covidBarChart;

  @override
  void initState() {
    _statsGrid = StatsGrid(country: _countries[0]);
    _covidBarChart = CovidBarChart(country: _countries[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: Container(
            height: 40,
            color: Palette.primaryColor,
          )),
          _buildHeader(),
          _buildRegionTabBar(),
          SliverToBoxAdapter(
              child: SizedBox(
            height: 10,
          )),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: _statsGrid,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: _covidBarChart,
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Statistics',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 3,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text('Morocco'),
              Text('France'),
              Text('Global'),
            ],
            onTap: (index) {
              setState(() {
                _statsGrid = StatsGrid(country: _countries[index]);
                if (_countries[index] != "glob") _covidBarChart = CovidBarChart(country: _countries[index]);
              });
            },
          ),
        ),
      ),
    );
  }
}
