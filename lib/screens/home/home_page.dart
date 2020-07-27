import 'package:aapgblogflutter/animations/fade_animation.dart';
import 'package:aapgblogflutter/models/api_response.dart';
import 'package:aapgblogflutter/models/blog_model.dart';
import 'package:aapgblogflutter/models/web_view.dart';
import 'package:aapgblogflutter/screens/home/drawer_page.dart';
import 'package:aapgblogflutter/screens/settings/settings_screen.dart';
import 'package:aapgblogflutter/services/blog_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  List imgList = [
    'assets/images/introduction.jpg',
    'assets/images/marketing.jpg',
    'assets/images/business.jpg',
    'assets/images/design.jpg',
    'assets/images/technology.jpg',
    'assets/images/skills.jpg',
  ];
  var _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  BlogServices get service => GetIt.I<BlogServices>();
  ApiResponse<List<BlogModel>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  _fetchArticles() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getRecentArticles();
    setState(() {
      _isLoading = false;
    });
  }

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
    } else {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit an App'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No', style: TextStyle(color: Colors.red)),
                ),
                FlatButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (closingDrawer) {
      closeDrawer();
      setState(() {
        closingDrawer = false;
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
              backgroundColor: isDarkMode ? Colors.black54 : Colors.green[700],
              leading: Container(),
              centerTitle: true,
              title: Container(
                  height: 55,
                  width: 110,
                  child: Image.asset('assets/images/blog_logo.png')),
              actions: <Widget>[
                isDrawerOpen
                    ? IconButton(
                        icon: Icon(Icons.close, color: Colors.white, size: 35),
                        onPressed: () {
                          closeDrawer();
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.menu, color: Colors.white, size: 30),
                        onPressed: () {
                          openDrawer();
                        }),
              ],
            ),
            body: Builder(
              builder: (_) {
                if (_isLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(isDarkMode
                              ? Colors.black54
                              : Colors.green[700])));
                }
                if (_apiResponse.error) {
                  return Center(child: Text(_apiResponse.errorMessage));
                }
                return RefreshIndicator(
                  color: isDarkMode ? Colors.grey : Colors.green[700],
                  onRefresh: () => _fetchArticles(),
                  child: ListView(
                    children: <Widget>[
                      FadeAnimation(
                        1,
                        Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                      height: 150,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      }),
                                  items: imgList.map((item) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(item),
                                                  fit: BoxFit.fill)),
                                        );
                                      },
                                    );
                                  }).toList(),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: imgList.map((item) {
                                int index = imgList.indexOf(item);
                                return Container(
                                  width: 8,
                                  height: 8,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == index
                                        ? isDarkMode
                                            ? Colors.white54
                                            : Color.fromRGBO(0, 0, 0, 0.9)
                                        : Color.fromRGBO(0, 0, 0, 0.4),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      FadeAnimation(
                        1.1,
                        Padding(
                          padding: const EdgeInsets.only(right: 8, top: 12),
                          child: Text('أحدث المقالات',
                              style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.right),
                        ),
                      ),
                      SizedBox(height: 5),
                      FadeAnimation(
                        1.2,
                        Container(
                            height: 380,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (_) {
                                      return WebViewModel(
                                          url: _apiResponse.data[index].link);
                                    }));
                                  },
                                  child: Container(
                                    width: 310,
                                    child: Card(
                                      elevation: 5,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            height: 120,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        _apiResponse
                                                            .data[index].image),
                                                    fit: BoxFit.fill)),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8, right: 5),
                                              child: Text(
                                                _apiResponse.data[index].name,
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    color: isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 8, left: 5),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                    _apiResponse
                                                        .data[index].date,
                                                    style: TextStyle(
                                                        color: isDarkMode
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontSize: 12),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Text(
                                                _apiResponse
                                                    .data[index].description,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                    color: isDarkMode
                                                        ? Colors.white54
                                                        : Colors.grey[700],
                                                    fontSize: 12),
                                                textAlign: TextAlign.right,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: 10,
                            )),
                      ),
                      FadeAnimation(
                        1.3,
                        Padding(
                            padding: const EdgeInsets.only(right: 8, top: 22),
                            child: Text('اشترك الآن حتى يصلك كل جديد',
                                style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.right)),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            FadeAnimation(
                              1.4,
                              Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: TextFormField(
                                    controller: _nameController,
                                    // ignore: missing_return
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'من فضلك أدخل الاسم';
                                      }
                                    },
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                        hintText: 'الاسم',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[700]),
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                  )),
                            ),
                            FadeAnimation(
                              1.5,
                              Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: TextFormField(
                                    controller: _emailController,
                                    // ignore: missing_return
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'من فضلك أدخل البريد الإلكتروني';
                                      }
                                    },
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                        hintText: 'البريد الإلكتروني',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[700]),
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      FadeAnimation(
                        1.6,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              child: RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: Text(
                                              'مرحباََ' +
                                                  ' ' +
                                                  _nameController.text
                                                      .toString(),
                                              textDirection: TextDirection.rtl,
                                            ),
                                            content: Text(
                                              'لقد تم الاشتراك بنجاح',
                                              textDirection: TextDirection.rtl,
                                            ),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text(
                                                  'حسناََ',
                                                  style: TextStyle(
                                                      color: isDarkMode
                                                          ? Colors.white
                                                          : Colors.green[700]),
                                                ),
                                                onPressed: () {
                                                  _nameController.clear();
                                                  _emailController.clear();
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }
                                },
                                child: Text('اشترك',
                                    style: TextStyle(
                                        color: isDarkMode
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 20)),
                                color: isDarkMode
                                    ? Colors.grey
                                    : Colors.green[700],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
