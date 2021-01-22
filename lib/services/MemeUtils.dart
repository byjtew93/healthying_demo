import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class MemeUtils {
  // ignore: non_constant_identifier_names
  static String API_KEY;
  static String region;

  // ignore: non_constant_identifier_names
  static init({@required String API_KEY, String region = "fr"}) {
    MemeUtils.API_KEY = API_KEY;
    MemeUtils.region = region;
    print("initialize MemeUtils with: {API_KEY = $API_KEY, region = $region}");
  }

  static Widget get _defaultLoadingWidget => CupertinoActivityIndicator();
  static Widget get _defaultErrorWidget =>
      Container(color: Colors.white60, child: Center(child: Icon(Icons.cloud_off_rounded, color: Colors.red)));

  static _loadingBuilder(Widget loadingWidget) =>
      (BuildContext _, Widget w, ImageChunkEvent e) => e == null ? w : loadingWidget ?? _defaultLoadingWidget;

  static Widget _imageFromLink(String link, {loadingWidget}) {
    print("< _imageFromLink()");
    return Image.network(
      link,
      loadingBuilder: _loadingBuilder(loadingWidget),
    );
  }

  static String analyzeGroupedResponse(http.Response resp) {
    print("> analyzeGroupedResponse(0)");
    if (resp == null || resp.statusCode != 200) return '';
    Map<String, dynamic> respData = json.decode(resp.body);
    print("> analyzeGroupedResponse(1)");
    print("> analyzeGroupedResponse(1): "
        "\nrespData= $respData");
    if (respData == null || !respData.containsKey('data') || !(respData['data'] is Iterable)) return '';
    print("> analyzeGroupedResponse(2)");
    Iterable data = respData['data'];
    if (data.isEmpty && !(data.first is Map) || data.first.isEmpty) return '';
    Map<String, dynamic> first = data.first;
    print("> analyzeGroupedResponse(3)");
    if (!first.containsKey('images') && !(first['images'] is Map)) return '';
    Map<String, dynamic> images = first['images'];
    if (!images.containsKey("original") || !(images['original'] is Map)) return '';
    print("<analyzeGroupedResponse> URL: < ${images['original']['url']} >");
    return images['original']['url'];
  }

  static String analyzeUniqueResponse(http.Response resp) {
    if (resp == null || resp.statusCode != 200) return '';
    Map<String, dynamic> respData = json.decode(resp.body);
    if (respData == null || !respData.containsKey('data') || !(respData['data'] is Map)) return '';
    Map<String, dynamic> data = respData['data'];
    if (!data.containsKey('images') && !(data['images'] is Map)) return '';
    Map<String, dynamic> images = data['images'];
    if (!images.containsKey("downsized") || !(images['downsized'] is Map)) return '';
    return images['downsized']['url'];
  }

  static Future<Widget> stickerByKeyword({@required String keyword, int numberOfResults = 1, imageLoadingWidget}) async {
    String link = await stickerByKeywordLink(keyword, numberOfResults);
    if (link == null || link.isEmpty) return _defaultErrorWidget;
    return _imageFromLink(link, loadingWidget: imageLoadingWidget);
  }

  static Future<String> stickerByKeywordLink(String keyword, int numberOfResults) async {
    print("<> stickerByKeywordLink()");
    http.Response resp = await http
        .get("https://api.giphy.com/v1/stickers/search?api_key=$API_KEY&q=$keyword&limit=$numberOfResults&offset=0&rating=g&lang=$region");
    return analyzeGroupedResponse(resp);
  }

  // ignore: non_constant_identifier_names
  Future<Widget> GIFByKeyword({@required String keyword, int numberOfResults = 1, imageLoadingWidget}) async {
    String link = await GIFByKeywordLink(keyword, numberOfResults);
    if (link == null || link.isEmpty) return _defaultErrorWidget;
    return _imageFromLink(link, loadingWidget: imageLoadingWidget);
  }

  // ignore: non_constant_identifier_names
  static Future<String> GIFByKeywordLink(String keyword, int numberOfResults) async {
    print("<> GIFByKeywordLink()");
    http.Response resp = await http
        .get("https://api.giphy.com/v1/gifs/search?api_key=$API_KEY&q=$keyword&limit=$numberOfResults&offset=0&rating=g&lang=$region");
    return analyzeGroupedResponse(resp);
  }

  /// Let [keyword] null/empty to have a fully random result.
  static Future<Widget> randomGIFByKeyword({String keyword, imageLoadingWidget}) async {
    String link = await randomGIFByKeywordLink(keyword);
    if (link == null || link.isEmpty) return _defaultErrorWidget;
    return _imageFromLink(link, loadingWidget: imageLoadingWidget);
  }

  static Future<String> randomGIFByKeywordLink(String keyword) async {
    print("<> randomGIFByKeywordLink()");
    http.Response resp = await http.get("https://api.giphy.com/v1/gifs/random?api_key=$API_KEY&tag=${keyword ?? ''}&rating=g");
    return analyzeUniqueResponse(resp);
  }

  /// Let [keyword] null/empty to have a fully random result.
  static Future<Widget> randomStickerByKeyword({String keyword, imageLoadingWidget}) async {
    String link = await randomStickerByKeywordLink(keyword);
    if (link == null || link.isEmpty) return _defaultErrorWidget;
    return _imageFromLink(link, loadingWidget: imageLoadingWidget);
  }

  static Future<String> randomStickerByKeywordLink(String keyword) async {
    print("<> randomStickerByKeywordLink()");
    http.Response resp = await http.get("https://api.giphy.com/v1/stickers/random?api_key=$API_KEY&tag=${keyword ?? ''}&rating=g");
    return analyzeUniqueResponse(resp);
  }
}
