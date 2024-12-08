import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController shController = TextEditingController();
  late Future<QuerySnapshot>? searchResults; 

  @override
  void initState() {
    super.initState();
    searchResults = null; 
  }

  void searchUser() {
    setState(() {
      
      if (shController.text.isEmpty) {
        searchResults = null;
      } else {
        
        searchResults = FirebaseFirestore.instance
            .collection('users')
            .where('userName', isEqualTo: shController.text)
            .get();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: shController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Name",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) {
                searchUser();
              },
            ),
          
            if (searchResults != null)
              FutureBuilder(
                  future: searchResults,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error.toString()}"),
                      );
                    }
                    if (snapshot.hasData) {
                      var docs = snapshot.data!.docs;
                      if (docs.isEmpty) {
                        return const Center(child: Text("No users found"));
                      }
                      return Expanded(
                        child: ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            var user = docs[index];
                            return ListTile(
                              title: Text(
                                user['userName'] ?? 'No name',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage('assets/profile.jpg'),
                                radius: 25,
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(child: Text("No data available"));
                    }
                  })
          ],
        ),
      ),
    );
  }
}
