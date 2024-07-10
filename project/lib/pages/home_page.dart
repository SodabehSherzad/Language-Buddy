import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/pages/login_page.dart';
import 'package:project/pages/search_page.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../classes/theme_notifire.dart';
import '../classes/topics_model.dart';
import '../models/user.dart';
import '../classes/vocabulary_model.dart';
import '../data/bedroom_appiances.dart';
import '../data/computer_and_it.dart';
import '../data/diseases.dart';
import '../data/education.dart';
import '../data/insurance.dart';
import '../data/job_interview.dart';
import '../data/living_room_appliances.dart';
import '../data/stationary.dart';
import '../data/topic_data.dart';
import '../methods/get_data.dart';
import '../methods/shared_preferences.dart';
import 'favorite_page.dart';
import 'item_page.dart';
import 'my_profile_page.dart';
import 'register_page.dart';
import 'translation_page.dart';
import 'user_item_page.dart';
import '../data/apartment.dart';
import '../data/bank.dart';
import '../data/bathroom_appliances.dart';
import '../data/dentist_visit.dart';
import '../data/doctor_specialists.dart';
import '../data/doctor_visit.dart';
import '../data/emergency.dart';
import '../data/immigration.dart';
import '../data/kitchen_appliances.dart';
import '../data/pharmacy.dart';
import '../data/psychology.dart';
import '../data/shopping.dart';
import '../data/transportation.dart';
import '../data/travel.dart';

import '../data/airport.dart';
import '../data/animals.dart';
import '../data/cosmetics.dart';
import '../data/culture.dart';
import '../data/dating.dart';
import '../data/environment.dart';
import '../data/family.dart';
import '../data/feelings.dart';
import '../data/food.dart';
import '../data/fruits.dart';
import '../data/hobbies.dart';
import '../data/hotel.dart';
import '../data/human_body.dart';
import '../data/legal_matters.dart';
import '../data/public_services.dart';
import '../data/social_interaction.dart';
import '../data/spices.dart';
import '../data/useful_adjectives.dart';
import '../data/useful_nouns.dart';
import '../data/useful_verbs.dart';
import '../data/useful_words.dart';
import '../data/utilities.dart';
import '../data/vegetables.dart';
import '../data/weather.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.blue,
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green,
);

class HomePage extends StatefulWidget {
  static const RoutName = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isRandom = false;
  bool isExpansionEnabled = false;
  bool isTtsEnabled = true;

  String selectedLanguage = "en";

  void _selectLanguage(String languageCode) {
    setState(() {
      selectedLanguage = languageCode;
    });
  }

  List<VocabularyModel> searchResults = [];

  bool isSearchActive = false;
  bool isSearchBoxVisible = true;
  bool isBackButtonVisible = false;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isRandom = SharedPreferencesManager.getIsRandom();
    isExpansionEnabled = SharedPreferencesManager.getIsExpansionEnabled();
    isTtsEnabled = SharedPreferencesManager.getIsTtsEnabled();
    selectedLanguage = SharedPreferencesManager.getSelectedLanguage();
  }

  Map<int, List> topicData = {
    1: doctor_visit,
    2: dentist_visit,
    3: pharmacy,
    4: diseases,
    5: doctor_specialists,
    6: psychology,
    7: emergency,
    8: insurance,
    9: bank,
    10: immigration,
    11: transportation,
    12: travel,
    13: shopping,
    14: apartment,
    15: kitchen_appliances,
    16: bathroom_appliances,
    17: bedroom_appliances,
    18: living_room_appliances,
    19: computer_and_it,
    20: stationary,
    21: education,
    22: job_interview,
    23: social_interaction,
    24: culture,
    25: legal_matters,
    26: utilities,
    27: public_services,
    28: weather,
    29: hobbies,
    30: environment,
    31: dating,
    32: cosmetics,
    33: food,
    34: animals,
    35: vegetables,
    36: fruits,
    37: spices,
    38: feelings,
    39: human_body,
    40: family,
    41: airport,
    42: hotel,
    43: useful_words,
    44: useful_verbs,
    45: useful_adjectives,
    46: useful_nouns,
  };

  void _filterTopics(String query) {
    Set<VocabularyModel> uniqueResults = {};

    if (query.isNotEmpty) {
      topicData.forEach((id, topicList) {
        final List<TopicsModel> topics =
        topicList.map((map) => TopicsModel.fromMap(map)).where((topic) {
          final topicNameDe = topic.name_de.toLowerCase().trim();
          final topicNameEn = topic.name_en.toLowerCase().trim();
          final topicNameFa = topic.name_fa.toLowerCase().trim();
          final queryText = query.toLowerCase().trim();

          if (selectedLanguage == 'en') {
            return topicNameDe.contains(queryText) ||
                topicNameEn.contains(queryText);
          } else if (selectedLanguage == 'fa') {
            return topicNameFa.contains(queryText);
          } else {
            return topicNameDe.contains(queryText);
          }
        }).toList();

        for (var topic in topics) {
          final VocabularyModel vocabularyTopic =
          VocabularyModel.fromTopicsModel(topic);
          uniqueResults.add(vocabularyTopic);
        }
      });
    }

    setState(() {
      isSearchActive = query.isNotEmpty;
      searchResults = uniqueResults.toList();
    });
  }

  String _getTopicNameForLanguage(TopicsModel topic) {
    if (selectedLanguage == "en") {
      return topic.name_en;
    } else if (selectedLanguage == "fa") {
      return topic.name_fa;
    } else {
      return topic.name_de;
    }
  }

  void _navigateToItemPage(TopicsModel topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ItemPage(
              isRandom: isRandom,
              isExpansionEnabled: isExpansionEnabled,
              isTtsEnabled: isTtsEnabled,
              language: selectedLanguage,
              selectedTopic: topic,
            ),
      ),
    );
  }

  int _selectedIndex = 0;

  static List<Widget> _pages = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final _data = TopicsMethods(topics);
    List<TopicsModel> topicList = _data.getTopicsData();

    // Sample data
    String userId = '123';
    String name = 'John Doe';
    String address = '123 Main St, City';
    String description = 'I am a language enthusiast.';
    List<String> languages = ['English', 'German', 'French'];
    List<String> friends = ['Alice', 'Bob', 'Charlie'];
    String imageUrl = '../assets/user.webp';

    // Create a UserProfile instance
    UserProfile currentUser = UserProfile(
      userId: userId,
      name: name,
      address: address,
      description: description,
      languages: languages,
      friends: friends,
      imageUrl: imageUrl, role: 'Teacher',
    );

    _pages = <Widget>[
      OrientationBuilder(
        builder: (context, orientation) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(labelText: 'Search'),
                  onSubmitted: (query) {
                    // Perform filtering when the user submits the search query
                    _filterTopics(query);
                    setState(() {
                      isSearchActive =
                      true; // Set isSearchActive to true when the query is submitted
                    });
                  },

                  // onChanged: (query){
                  //   setState(() {
                  //     _filterTopics(query);
                  //   });
                  // },
                ),
              ),
              Expanded(
                  child: isSearchActive
                      ? SearchResultsPage(
                      searchResults: searchResults,
                      language: selectedLanguage)
                      : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                      orientation == Orientation.landscape ? 4 : 2,
                      crossAxisSpacing:
                      10, // Adjust the horizontal spacing between items
                      mainAxisSpacing:
                      10, // Adjust the vertical spacing between items
                    ),
                    itemCount: topicList.length,
                    itemBuilder: (context, index) {
                      final topic = topicList[index];
                      return InkWell(
                        onTap: () {
                          _navigateToItemPage(topic);
                        },
                        child: showCard(
                          topic.name_en,
                          topic.name_de,
                          _getTopicNameForLanguage(topic),
                        ),
                      );
                    },
                  ))
            ],
          );
        },
      ),
      TranslatePage(),
      ProfilePage(userProfile: currentUser),
      UserListPage(),
      // RegistrationPage()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }




  @override
  Widget build(BuildContext context) {
    final themeNotifier =
    Provider.of<ThemeNotifier>(context); // Access the theme notifier

    // Use the current theme from the ThemeNotifier
    final theme = themeNotifier.currentTheme;

    Container _drawerList(BuildContext context) {

      return Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: const [
                  Expanded(
                    flex: 5,
                    child: Image(
                      image: AssetImage("assets/drawer.png"),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                (themeNotifier.isDarkModeEnabled)
                    ? Icons.dark_mode_rounded
                    : Icons.sunny,
                color: Colors.blue,
              ),
              title: const Text(
                "Switch Theme",
              ),
              trailing: Switch(
                value: themeNotifier.isDarkModeEnabled,
                onChanged: (value) {
                  themeNotifier.toggleTheme();
                  SharedPreferencesManager.setIsDarkModeEnabled(
                      themeNotifier.isDarkModeEnabled);
                },
              ),
            ),
            ListTile(
              leading: Icon(
                (isRandom) ? Icons.shuffle_on_rounded : Icons.shuffle_rounded,
                color: Colors.blue,
              ),
              title: const Text("Random Vocabulary"),
              trailing: Switch(
                value: isRandom,
                onChanged: (value) {
                  setState(() {
                    isRandom = value;
                    SharedPreferencesManager.setIsRandom(isRandom);
                  });
                },
              ),
            ),
            ListTile(
              leading: (isTtsEnabled)
                  ? const Icon(
                Icons.volume_up_rounded,
                color: Colors.blue,
              )
                  : const Icon(
                Icons.volume_off_rounded,
                color: Colors.blue,
              ),
              title: const Text("Text-To-Speech"),
              trailing: Switch(
                value: isTtsEnabled,
                onChanged: (value) {
                  setState(() {
                    isTtsEnabled = value;
                    SharedPreferencesManager.setIsTtsEnabled(isTtsEnabled);
                  });
                },
              ),
            ),
            ListTile(
              leading: Icon(
                (isExpansionEnabled)
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: Colors.blue,
              ),
              title: const Text("Term Expansion"),
              trailing: Switch(
                value: isExpansionEnabled,
                onChanged: (value) {
                  setState(() {
                    isExpansionEnabled = value;
                    SharedPreferencesManager.setIsExpansionEnabled(
                        isExpansionEnabled);
                  });
                },
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritePage()),
                );
              },
              child: const ListTile(
                leading: Icon(Icons.favorite, color: Colors.blue),
                title: Text("Favorite Page"),
              ),
            ),

            PopupMenuButton<String>(
              onSelected: (value) {
                _selectLanguage(value);
                SharedPreferencesManager.setSelectedLanguage(value);
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'en',
                  child: Text("English"),
                ),
                const PopupMenuItem<String>(
                  value: 'fa',
                  child: Text("Persian"),
                ),
              ],
              child: ListTile(
                leading: const Icon(Icons.language, color: Colors.blue),
                title: Text(
                  selectedLanguage == 'en' ? "English" : "Persian",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
              },
              leading: Icon(Icons.logout, color: Colors.blue),
              title: Text("Logout"),
            ),

          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Learn German'),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            label: 'Translate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            label: 'My Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'Users Profile',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.login),
          //   label: 'Register Page',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: _drawerList(context),
      ),
    );
  }

  IconData getFontAwesomeIcon(String name_en) {
    switch (name_en) {
      case "Doctor Visit":
        return FontAwesomeIcons.stethoscope;
      case "Dentist Visit":
        return FontAwesomeIcons.tooth;
      case "Pharmacy":
        return FontAwesomeIcons.pills;
      case "Diseases":
        return FontAwesomeIcons.microscope;
      case "Doctor Specialists":
        return FontAwesomeIcons.userMd;
      case "Psychology":
        return FontAwesomeIcons.brain;
      case "Emergency":
        return FontAwesomeIcons.ambulance;
      case "Insurance":
        return FontAwesomeIcons.fileContract;
      case "Bank":
        return FontAwesomeIcons.university;
      case "Immigration":
        return FontAwesomeIcons.passport;
      case "Transportation":
        return FontAwesomeIcons.bus;
      case "Travel":
        return FontAwesomeIcons.plane;
      case "Shopping":
        return FontAwesomeIcons.shoppingBag;
      case "Apartment":
        return FontAwesomeIcons.building;
      case "Kitchen Appliances":
        return FontAwesomeIcons.blender;
      case "Bathroom Appliances":
        return FontAwesomeIcons.shower;
      case "Bedroom Appliances":
        return FontAwesomeIcons.bed;
      case "Living Room Appliances":
        return FontAwesomeIcons.couch;
      case "Computer and IT":
        return FontAwesomeIcons.laptop;
      case "Stationery":
        return FontAwesomeIcons.pen;
      case "Education":
        return FontAwesomeIcons.graduationCap;
      case "Job Interview":
        return FontAwesomeIcons.briefcase;
      case "Social Interaction":
        return FontAwesomeIcons.users;
      case "Culture":
        return FontAwesomeIcons.globe;
      case "Legal Matters":
        return FontAwesomeIcons.balanceScale;
      case "Utilities":
        return FontAwesomeIcons.wrench;
      case "Public Services":
        return FontAwesomeIcons.hospital;
      case "Weather":
        return FontAwesomeIcons.sun;
      case "Hobbies":
        return FontAwesomeIcons.paintBrush;
      case "Environment":
        return FontAwesomeIcons.tree;
      case "Dating":
        return FontAwesomeIcons.heart;
      case "Cosmetics":
        return FontAwesomeIcons.smile;
      case "Food":
        return FontAwesomeIcons.utensils;
      case "Animals":
        return FontAwesomeIcons.paw;
      case "Vegetables":
        return FontAwesomeIcons.carrot;
      case "Fruits":
        return FontAwesomeIcons.apple;
      case "Spices":
        return FontAwesomeIcons.pepperHot;
      case "Feelings":
        return FontAwesomeIcons.heartbeat;
      case "Human Body":
        return FontAwesomeIcons.user;
      case "Family":
        return FontAwesomeIcons.users;
      case "Airport":
        return FontAwesomeIcons.planeArrival;
      case "Hotel":
        return FontAwesomeIcons.hotel;
      case "Useful Words":
        return FontAwesomeIcons.language;
      case "Useful Verbs":
        return FontAwesomeIcons.comment;
      case "Useful Adjectives":
        return FontAwesomeIcons.smile;
      case "Useful Nouns":
        return FontAwesomeIcons.book;
      default:
        return FontAwesomeIcons.question;
    }
  }

  Container showCard(text_en, text_de, text_lan) {
    final iconData =
    getFontAwesomeIcon(text_en); // Get the icon based on name_en
    Color cardColor = ThemeNotifier().isDarkModeEnabled
        ? Colors.white
        : Colors.black; // Set card background color based on theme mode

    return Container(
      width: 187,
      height: 200,
      child: Card(
        // color: cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                icon: FaIcon(
                  iconData,
                  size: 40,
                  color: Colors.blue,
                ), onPressed: () {  },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Text(
                    '${text_de}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${text_lan}',
                    style: const TextStyle(fontSize: 16, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

}

class WebViewPage extends StatelessWidget {
  final String url;

  WebViewPage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView Page'),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}


