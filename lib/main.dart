import 'package:flutter/material.dart';
import 'university.dart';
import 'package:idea/screen/university_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'University List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UniversityListScreen(),
    );
  }
}



class UniversityListScreen extends StatefulWidget {
  @override
  _UniversityListScreenState createState() => _UniversityListScreenState();
}

class _UniversityListScreenState extends State<UniversityListScreen> {
  final List<University> universities = [
    University(
      name: 'Астана медицина университеті',
      location: 'Нұр-Султан',
      phone: '8(7172) 53 94 24',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSviAl1xO9d_u5qam-8b0R2DxEcgqLLW-k9xg&s',
      programs: [
        'B001-Педагогика және психология',
        'B002-Мектепке дейінгі оқыту және тәрбиелеу',
        'B003-Бастауышта оқыту педагогикасы мен әдістемесі',
        'B009-Математика мұғалімдерін дайындау',
      ],
      id: '001',
    ),
    University(
      name: 'С.Сейфуллин атындағы Қазақ агротехникалық университеті',
      location: 'Нұр-Султан',
      phone: '8(7172) 53 94 24',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSviAl1xO9d_u5qam-8b0R2DxEcgqLLW-k9xg&s',
      programs: [
        'A001-Агрономия',
        'A002-Зоотехния',
        'A003-Ветеринария',
      ],
      id: '002',
    ),
    University(
      name: 'Ш.Есенов атындағы Каспий мемлекеттік технологиялар және инжиниринг университеті',
      location: 'Ақтау',
      phone: '8(7172) 53 94 24',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSviAl1xO9d_u5qam-8b0R2DxEcgqLLW-k9xg&s',
      programs: [
        'T001-Технология',
        'T002-Инженерия',
      ],
      id: '003',
    ),
    University(
      name: 'М.Оспанов атындағы Батыс Қазақстан мемлекеттік медицина университеті',
      location: 'Ақтөбе',
      phone: '8(7172) 53 94 24',
      imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSviAl1xO9d_u5qam-8b0R2DxEcgqLLW-k9xg&s',
      programs: [
        'M001-Медицина',
        'M002-Стоматология',
      ],
      id: '004',
    ),
  ];

  final List<String> cities = [
    'Барлық қалалар',
    'Нұр-Султан',
    'Ақтау',
    'Ақтөбе',
  ];

  late List<University> filteredUniversities;
  TextEditingController searchController = TextEditingController();
  String selectedCity = 'Барлық қалалар';

  @override
  void initState() {
    super.initState();
    filteredUniversities = universities;
    searchController.addListener(_filterUniversities);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterUniversities() {
    setState(() {
      filteredUniversities = universities
          .where((university) => university.name
          .toLowerCase()
          .contains(searchController.text.toLowerCase()) &&
          (selectedCity == 'Барлық қалалар' || university.location == selectedCity))
          .toList();
    });
  }

  void _onCitySelected(String city) {
    setState(() {
      selectedCity = city;
      _filterUniversities();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Университеттер тізімі', style: TextStyle(fontFamily: 'Montserrat'), ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                        },
                      ),
                      hintText: 'search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.filter_list),
                  onSelected: _onCitySelected,
                  itemBuilder: (BuildContext context) {
                    return cities.map((String city) {
                      return PopupMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filteredUniversities.length,
              itemBuilder: (context, index) {
                return UniversityCard(
                  university: filteredUniversities[index],
                  index: index,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UniversityDetailScreen(
                          university: filteredUniversities[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UniversityCard extends StatelessWidget {
  final University university;
  final int index;
  final VoidCallback onTap;

  const UniversityCard({
    Key? key,
    required this.university,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        onTap: onTap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0), // Сглаживание углов
          child: Image.network(
            university.imageUrl,
            width: 120, // Установим одинаковую ширину
            height: 120, // Установим одинаковую высоту
            fit: BoxFit.cover, // Обрезка изображения по размеру контейнера
          ),
        ),
        title: Text(university.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: Colors.grey, size: 20),
                SizedBox(width: 5), // Adding a small space between icon and text
                Text(university.location),
              ],
            ),
            SizedBox(height: 7),
            Row(
              children: [
                Icon(Icons.local_phone_outlined, color: Colors.grey, size: 20,),
                SizedBox(width: 5), // Adding a small space between icon and text
                Text(university.phone),
              ],
            ),
          ],
        ),
        trailing: Text(
          (index + 1).toString().padLeft(3, '0'),
          style: TextStyle(color: Colors.grey, fontFamily: 'Montserrat'),
        ),
      ),
    );
  }
}
