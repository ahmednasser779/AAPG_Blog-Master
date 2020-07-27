import 'package:aapgblogflutter/models/api_response.dart';
import 'package:aapgblogflutter/models/blog_model.dart';
import 'package:aapgblogflutter/models/web_view.dart';
import 'package:aapgblogflutter/screens/design/design_drawer.dart';
import 'package:aapgblogflutter/screens/settings/settings_screen.dart';
import 'package:aapgblogflutter/services/blog_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class DesignScreen extends StatefulWidget {
  @override
  _DesignScreenState createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
  BlogServices get service => GetIt.I<BlogServices>();
  ApiResponse<List<BlogModel>> _apiResponse;
  bool _isLoading = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  ScrollController controller = ScrollController();
  double topContainer = 0;

  openDrawer() {
    setState(() {
      xOffset = -160;
      yOffset = 80;
      scaleFactor = 0.8;
      isDrawerOpen = true;
    });
  }

  closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  Future<bool> _willPopBack() async {
    if (isDrawerOpen) {
      return (await closeDrawer()) ?? false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _fetchArticles();
    controller.addListener(() {
      double value = controller.offset/390;
      setState(() {
        topContainer = value;
      });
    });
  }

  _fetchArticles() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getDesignArticles();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (closingDesignDrawer) {
      closeDrawer();
      setState(() {
        closingDesignDrawer = false;
      });
    }
    return WillPopScope(
      onWillPop: _willPopBack,
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 250),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0)),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: isDarkMode? Colors.white: Colors.green[700],
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: isDarkMode? Colors.black54: Colors.white,
            centerTitle: true,
            title: Text('مقالات التصميم',
                style: TextStyle(color: isDarkMode? Colors.white: Colors.green[700])),
            actions: <Widget>[
              isDrawerOpen
                  ? IconButton(
                icon: Icon(Icons.close, color: isDarkMode? Colors.white: Colors.green[700], size: 35),
                onPressed: () {
                  closeDrawer();
                },
              )
                  : IconButton(
                  icon: Icon(Icons.menu, color: isDarkMode? Colors.white: Colors.green[700], size: 30),
                  onPressed: () {
                    openDrawer();
                  }),
            ],
          ),
          body: Builder(
            builder: (_) {
              if (_isLoading) {
                return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(isDarkMode? Colors.black54: Colors.green[700])));
              }
              if (_apiResponse.error) {
                return Center(child: Text(_apiResponse.errorMessage));
              }
              return RefreshIndicator(
                color: isDarkMode? Colors.grey: Colors.green[700],
                onRefresh: () =>_fetchArticles(),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: controller,
                  itemBuilder: (_, index) {
                    double scale = 1.0;
                    if (topContainer > 0.5) {
                      scale = index + 0.9 - topContainer;
                      if (scale < 0) {
                        scale = 0;
                      } else if (scale > 1) {
                        scale = 1;
                      }
                    }
                    return Opacity(
                      opacity: scale,
                      child: Transform(
                        transform:  Matrix4.identity()..scale(scale,scale),
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return WebViewModel(url: _apiResponse.data[index].link);
                            }));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 12, right: 12, left: 12),
                            height: 375,
                            child: Card(
                              elevation: 5,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 130,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                _apiResponse.data[index].image),
                                            fit: BoxFit.fill)),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, right: 8, left: 8),
                                      child: Text(
                                        _apiResponse.data[index].name,
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: isDarkMode? Colors.white: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(top: 8, left: 8),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            _apiResponse.data[index].date,
                                            style: TextStyle(
                                                color: isDarkMode? Colors.white: Colors.black, fontSize: 12),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        _apiResponse.data[index].description,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(
                                            color: isDarkMode? Colors.white54: Colors.grey[700], fontSize: 12),
                                        textAlign: TextAlign.right,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _apiResponse.data.length,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
