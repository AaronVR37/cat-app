import 'package:camera/camera.dart';
import 'package:cat_application/helpers/database_helper.dart';
import 'package:cat_application/screens/details_page.dart';
import 'package:cat_application/screens/taken_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:cat_application/widgets/image_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../models/cat_model.dart';

class HomePageWidget extends StatefulWidget {
  final CameraDescription firstCamera;

  const HomePageWidget({Key? key, required this.firstCamera}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Cats',
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        Text(
                          'Beautiful cats',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(135, 0, 0, 0),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: (FutureBuilder<List<Cat>>(
                    future: DatabaseHelper.instance.getCats(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Cat>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: const Text("Loading"),
                          ),
                        );
                      } else {
                        return snapshot.data!.isEmpty
                            ? Center(
                                child:
                                    Container(child: const Text("No Cats :(")),
                              )
                            : ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                children: snapshot.data!.map((planet) {
                                  return Center(
                                      child: GestureDetector(
                                    child: Container(
                                      child: Image_s(path: planet.Image),
                                      height: 325,
                                      width: 200,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        final route = MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsScreenWidget(
                                                  firstCamera:
                                                      widget.firstCamera,
                                                  Name: planet.Name,
                                                  Image: planet.Image,
                                                  Race: planet.Race,
                                                  Food: planet.Food,
                                                ));
                                        Navigator.push(context, route);
                                      });
                                    },
                                  ));
                                }).toList());
                      }
                    })),
              ),
              Padding(
                padding: EdgeInsetsDirectional.zero,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FFButtonWidget(
                      onPressed: () {
                        print('button_n_planet pressed ...');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => TakenPictureScreen(
                                    camera: widget.firstCamera,
                                  )),
                        );
                      },
                      text: '',
                      icon: Icon(
                        Icons.add,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 15,
                      ),
                      options: FFButtonOptions(
                        width: 50,
                        height: 50,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
