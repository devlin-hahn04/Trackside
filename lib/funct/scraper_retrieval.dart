import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trackside_app/main.dart';


String? nextRace;                        //Global values
final Map<String, int> driversPoints= {};
final Map<String, int> constructorsPoints= {};


Future<Map<String, dynamic>?> retrieveScraperData() async {
  
  try {
    final result = await scraperClient
        .from('f1_data')
        .select('data')
        .order('inserted_at', ascending: false)
        .limit(1)
        .single();

    return result['data'] as Map<String, dynamic>?;
  } 
  
  catch (e) {
    print('Error retrieving scraper data: $e');
    return null;
  }
}

Future<void> loadlatestdata() async{

  final latestdata= await retrieveScraperData();

  if(latestdata != null){

    nextRace= latestdata['next_race'];   //next race value

    final List driversList= latestdata['drivers_championship'];

    for (var entry in driversList){

      final String driver= entry['driver'];
      final int points= entry['points'];
      driversPoints[driver]= points;         //logic for mapping driver points

    }

    final List constructorsList= latestdata['constructors_championship'];

    for (var entry in constructorsList){

      final String team= entry['team'];
      final int points= entry['points'];
      constructorsPoints[team]= points;     //Logic for mapping team points

    }

  }


}