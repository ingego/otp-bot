import 'dart:convert';
import 'dart:io' as io;
import 'package:dio/dio.dart';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:collection/collection.dart';
import 'dart:collection';

String? url;
Response? resp;

Function eq = const ListEquality().equals;

Future<void> envSetUp(url) async {
  resp = await Dio().get(url!);
}

Future<List> getTags(name) async{
  io.File file = io.File.fromUri(Uri.file("C:/Users/79509/dart/champion_selection/champion.json", windows: true));
  var response = jsonDecode(await file.readAsString());
  return response['data'][name]['tags'];
}

Future<List<Bs4Element>?> getTierlist(String role, String elo) async{
  if(elo == 'mid') { 
      elo = 'middle';
  }
  await envSetUp('https://www.leagueofgraphs.com/champions/builds/$role/$elo');
  BeautifulSoup sp = BeautifulSoup(resp!.data);
  var tierList = sp.find('div', class_: 'medium-24 columns')?.findAll("span", class_: 'name');
  return tierList;
}

List<String> sortedChampionMap(String main, String sub, Map tierList) {
  List<String> recommendedChampions = [];
  tierList.forEach((k,v) {
    if (eq(v, [main, sub]) || eq(v, [sub, main]) || eq(v, [main])){
      recommendedChampions.add(k);
    }
  });
  return recommendedChampions;
}

Future<List<String>> getMainTags(List pull) async {
  Map tags = {'Assassin': 0, 'Fighter': 0, 'Mage': 0, 'Marksman': 0, 'Support': 0, 'Tank': 0};
  for (String champion in pull){
    List tagsOfPullChamp = await getTags(champion);
    for (String tag in tagsOfPullChamp) {
      tags[tag] ++;
    }
  }
  var sortedKeys = tags.keys.toList(growable:false)
    ..sort((k2, k1) => tags[k1].compareTo(tags[k2]));
  LinkedHashMap sortedMap = LinkedHashMap
    .fromIterable(sortedKeys, key: (k) => k, value: (k) => tags[k]);
  return [sortedMap.keys.elementAt(0), sortedMap.keys.elementAt(1)];
}

Future<List<String>> getRecommendedChampions(role, elo, pull) async{
  Map tagTierList = {};
  for(var champ in (await getTierlist(role, elo))!) {
    String name = champ.getText().replaceAll(' ', '').replaceAll('\n', '').replaceAll('.', '').replaceAll("'", '');
    tagTierList[name] = await getTags(name);
  }
  var mainTags = await getMainTags(pull);
  return sortedChampionMap(mainTags[0], mainTags[1], tagTierList);
}

Future<String> getBestChampionStats(elo, role, List champions) async{
  if(elo == 'mid') { 
      elo = 'middle';
  }
  String championStats = '';
  for(String champion in champions){
    String Champ = champion.toLowerCase();
    await envSetUp('https://www.leagueofgraphs.com/champions/builds/$Champ/$elo/$role');
    BeautifulSoup sp = BeautifulSoup(resp!.data);
    var pickrate = sp.find("div", id: 'graphDD1')?.getText().replaceAll('\n', '').replaceAll(' ', '');
    var winrate = sp.find("div", id: 'graphDD2')?.getText().replaceAll('\n', '').replaceAll(' ', '');
    var banrate = sp.find("div", id: 'graphDD3')?.getText().replaceAll('\n', '').replaceAll(' ', '');
    championStats = championStats + '$champion   pickrate: $pickrate   winrate: $winrate   banrate: $banrate\n';
  }
  return championStats;
}