import 'package:flutter/material.dart';
import 'package:idea/university.dart';

class UniversityDetailScreen extends StatelessWidget {
  final University university;

  UniversityDetailScreen({required this.university});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    university.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 16,
                  right: 16,
                  child: Card(
                    elevation: 8.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            university.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 16),
                              SizedBox(width: 15),
                              Text(university.location),
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 16),
                              SizedBox(width: 15),
                              Text(university.phone),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Text(
                                '№',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              SizedBox(width: 15),
                              Text(university.id),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: university.programs.length,
                    itemBuilder: (context, index) {
                      return ProgramCard(program: university.programs[index]);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgramCard extends StatelessWidget {
  final String program;

  const ProgramCard({Key? key, required this.program}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          program,
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
    );
  }
}
