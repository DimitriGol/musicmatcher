import 'package:flutter/material.dart';
import 'package:songbird/database_management/database_funcs.dart';
import 'package:songbird/main.dart';
import 'package:songbird/classes/users.dart';

class LikesPage extends StatefulWidget
{
   const LikesPage({super.key});

  @override
  State<LikesPage> createState() => _LikesPageState();
}


class _LikesPageState extends State<LikesPage> {
  @override
  Widget build(BuildContext context) {
    // Accessing likedArtists from CURRENT_USER
    // Map<String, dynamic> likedArtists = CURRENT_USER.likedArtists;
    // print(CURRENT_USER.likedArtists);

    
    return Scaffold(
      body: 
        FutureBuilder(
          builder: (ctx, snapshot){
            // Checking if future is resolved
            if (snapshot.connectionState == ConnectionState.done) {
              // If we got an error
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }
              // if we got our data
              else if (snapshot.hasData) {
                // Extracting data from snapshot object
                final artistData = snapshot.data as Map<String, String>;
                if (artistData.isEmpty){
                  return(
                    Center(
                      child: 
                        Text(
                          "You haven't liked any artists yet!"
                        )
                      )
                  );
                }
                else{
                  // print(artistData);
                  return Padding(
                    padding: const EdgeInsets.all(8.0), // Set the padding for the entire ListView
                    child: Center(
                      child: ListView(
                        children: artistData.entries.map((entry) {
                          String artistName = entry.key;

                          // getUserDataFromFirestore(artistUUID);
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 23,
                              backgroundColor: Colors.grey,
                              //display artist profile picture
                              backgroundImage: NetworkImage(
                                entry.value
                              )
                            ),
                            //display artist name
                            title: Text(artistName, style: TextStyle(fontWeight: FontWeight.bold)), 
                            trailing: IconButton(
                              icon: Container(
                              child: Icon(Icons.favorite_sharp, color: Colors.red.shade700)),
                              onPressed: ()
                              {
                                CURRENT_USER.likedArtists.remove(entry.key);
                                // print(CURRENT_USER.likedArtists);
                              },
                            ),
                          );
                        }).toList() //loop ends
                      ),
                    ),
                  );
                }
              }
            }
          return Center(
            child: CircularProgressIndicator(),
          );
          },
          future: likesPageMap(CURRENT_USER.likedArtists), 
        )
    );
  }
}