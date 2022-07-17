import 'package:champion_selection/champion_selection.dart' as champion_selection;

void main(List<String> arguments) async{
  var champions = await champion_selection.getRecommendedChampions('top'.toLowerCase(), 'Platinum'.toLowerCase(), ['Fiora', 'Irelia', 'Olaf', 'Mordekaiser']);
  print(champions);
  print(await champion_selection.getBestChampionStats('top'.toLowerCase(), 'Platinum'.toLowerCase(), champions));
}
