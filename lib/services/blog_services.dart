import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:aapgblogflutter/models/api_response.dart';
import 'package:aapgblogflutter/models/blog_model.dart';

class BlogServices {
  static const Api ='http://aapgsuez.net/android/android-app';

  Future<ApiResponse<List<BlogModel>>> getMarketingArticles(){
    return http.get(Api + '/blog-marketing.php')
        .then((data){
          if(data.statusCode == 200){
            Map<String, dynamic> map = json.decode(data.body);
            List<dynamic> jsonData = map['Blog Articles'];
            final articles = <BlogModel>[];
            for(var item in jsonData){
              articles.add(BlogModel.fromJson(item));
            }
            return ApiResponse<List<BlogModel>> (data: articles);
          }
          return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'An error occured');
    }).catchError((e){
      debugPrint(e.toString());
      if(e.toString().contains('SocketException: Failed host lookup:')){
        return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'Check your internet connection');
      }
      return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'An error occured');
    });
  }

  Future<ApiResponse<List<BlogModel>>> getRecentArticles(){
    return http.get(Api + '/blog-recent.php')
        .then((data){
      if(data.statusCode == 200){
        Map<String, dynamic> map = json.decode(data.body);
        List<dynamic> jsonData = map['Blog Articles'];
        final articles = <BlogModel>[];
        for(var item in jsonData){
          articles.add(BlogModel.fromJson(item));
        }
        return ApiResponse<List<BlogModel>> (data: articles);
      }
      return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'An error occured');
    }).catchError((e){
      debugPrint(e.toString());
      if(e.toString().contains('SocketException: Failed host lookup:')){
        return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'Check your internet connection');
      }
      return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'An error occured');
    });
  }

  Future<ApiResponse<List<BlogModel>>> getBusinessArticles(){
    return http.get(Api + '/blog-business.php')
        .then((data){
      if(data.statusCode == 200){
        Map<String, dynamic> map = json.decode(data.body);
        List<dynamic> jsonData = map['Blog Articles'];
        final articles = <BlogModel>[];
        for(var item in jsonData){
          articles.add(BlogModel.fromJson(item));
        }
        return ApiResponse<List<BlogModel>> (data: articles);
      }
      return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'An error occured');
    }).catchError((e){
      debugPrint(e.toString());
      if(e.toString().contains('SocketException: Failed host lookup:')){
        return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'Check your internet connection');
      }
      return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'An error occured');
    });
  }

  Future<ApiResponse<List<BlogModel>>> getDesignArticles(){
    return http.get(Api + '/blog-design.php')
        .then((data){
      if(data.statusCode == 200){
        Map<String, dynamic> map = json.decode(data.body);
        List<dynamic> jsonData = map['Blog Articles'];
        final articles = <BlogModel>[];
        for(var item in jsonData){
          articles.add(BlogModel.fromJson(item));
        }
        return ApiResponse<List<BlogModel>> (data: articles);
      }
      return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'An error occured');
    }).catchError((e){
      debugPrint(e.toString());
      if(e.toString().contains('SocketException: Failed host lookup:')){
        return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'Check your internet connection');
      }
      return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'An error occured');
    });
  }

  Future<ApiResponse<List<BlogModel>>> getTechnologyArticles(){
    return http.get(Api + '/blog-web.php')
        .then((data){
      if(data.statusCode == 200){
        Map<String, dynamic> map = json.decode(data.body);
        List<dynamic> jsonData = map['Blog Articles'];
        final articles = <BlogModel>[];
        for(var item in jsonData){
          articles.add(BlogModel.fromJson(item));
        }
        return ApiResponse<List<BlogModel>> (data: articles);
      }
      return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'An error occured');
    }).catchError((e){
      debugPrint(e.toString());
      if(e.toString().contains('SocketException: Failed host lookup:')){
        return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'Check your internet connection');
      }
      return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'An error occured');
    });
  }

  Future<ApiResponse<List<BlogModel>>> getSkillsArticles(){
    return http.get(Api + '/blog-soft.php')
        .then((data){
      if(data.statusCode == 200){
        Map<String, dynamic> map = json.decode(data.body);
        List<dynamic> jsonData = map['Blog Articles'];
        final articles = <BlogModel>[];
        for(var item in jsonData){
          articles.add(BlogModel.fromJson(item));
        }
        return ApiResponse<List<BlogModel>> (data: articles);
      }
      return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'An error occured');
    }).catchError((e){
      debugPrint(e.toString());
      if(e.toString().contains('SocketException: Failed host lookup:')){
        return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'Check your internet connection');
      }
      return ApiResponse<List<BlogModel>> (error: true, errorMessage: 'An error occured');
    });
  }



}