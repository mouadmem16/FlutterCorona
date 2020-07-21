import 'package:covid_bdcc2/services/callMsgService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:covid_bdcc2/config/palette.dart';
import 'package:covid_bdcc2/config/styles.dart';
import 'package:covid_bdcc2/data/data.dart';
import 'package:covid_bdcc2/widgets/info_desc.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CallsAndMessagesService _service = GetIt.I<CallsAndMessagesService>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(child: Container(height: 40,color: Palette.primaryColor,)),
          _buildHeader(screenHeight),
          _buildSymptomsTips(screenHeight),
          _buildPreventionTips(screenHeight),
          _buildInfoCards(screenHeight)
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'COVID-19',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Are you feeling sick?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'If you feel sick with any COVID-19 symptoms, please call or text us immediately for help',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      onPressed: () {
                        _service.call(alloYakada);
                      },
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Call Now',
                        style: Styles.buttonTextStyle,
                      ),
                      textColor: Colors.white,
                    ),
                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      onPressed: () {
                        _service.sendSms(alloYakada);
                      },
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      icon: const Icon(
                        Icons.chat_bubble,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Send SMS',
                        style: Styles.buttonTextStyle,
                      ),
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPreventionTips(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Prevention Tips',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: screenHeight * 0.2,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: prevention
                    .map((e) => Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Column(
                            children: <Widget>[
                              Image.asset(
                                e.keys.first,
                                height: screenHeight * 0.12,
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              Text(
                                e.values.first,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                    ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildInfoCards(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical:20.0, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Informations to know',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: screenHeight * 0.6,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: infos
                    .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal:10.0),
                      child: InfoCard(
                        image: e.keys.first,
                        title: e.values.first[0],
                        text: e.values.first[1],
                      ),
                    ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSymptomsTips(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'COVID-19 Symptoms',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              height: screenHeight * 0.2,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: symptoms
                    .map((e) => Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Column(
                            children: <Widget>[
                              Image.asset(
                                e.keys.first,
                                height: screenHeight * 0.12,
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              Text(
                                e.values.first,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                    ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
