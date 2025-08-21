import 'dart:collection';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trackside_app/main.dart';


String? nextRace;                        //Global values
final Map<String, Map<String, dynamic>> driversData= {};
final Map<String, int> constructorsPoints= {};
final Map<String, String> driverPhotos= {};


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

    driversData.clear();
    for (var entry in driversList){

      final String driver= entry['driver'];
      final int points= entry['points'];
      final String team= entry['team'];
      
      driversData[driver]= {
        'points': points, 
        'team': team,
      };         //logic for mapping driver points and team

    }

    final List constructorsList= latestdata['constructors_championship'];

    constructorsPoints.clear();
    for (var entry in constructorsList){

      final String team= entry['team'];
      final int points= entry['points'];
      constructorsPoints[team]= points;     //Logic for mapping team points

    }

    final Map<String, dynamic> photosMap = latestdata['driver_photos'];

    driverPhotos.clear();     

    photosMap.forEach((key, value) {        
      driverPhotos[key] = value.toString();
    });

  }


}