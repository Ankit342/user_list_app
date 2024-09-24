import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'widgets/user_list_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'User List App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserListScreen(),
      ),
    );
  }
}

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: userProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.teal,
            ))
          : userProvider.errorMessage.isNotEmpty
              ? Center(child: Text(userProvider.errorMessage))
              : Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _searchController,
                          cursorColor: Colors.teal,
                          decoration: InputDecoration(
                            labelText: 'Search by Name',
                            labelStyle: TextStyle(
                              color: Colors
                                  .teal.shade700, // Consistent with teal AppBar
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.teal,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.teal.shade300,
                                width: 1.5,
                              ),
                            ),
                            suffixIcon: const Icon(Icons.search,
                                color: Colors.teal), // Adds a search icon
                            filled: true,
                            fillColor: Colors
                                .teal.shade50, // Light background for contrast
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                          ),
                          onChanged: (value) {
                            userProvider.searchUsers(value);
                          },
                          style: const TextStyle(
                            color: Colors.black87, // Ensures good readability
                          ),
                        )),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await userProvider.fetchUsers();
                        },
                        color: Colors.teal,
                        backgroundColor: Colors.teal.shade50,
                        child: UserListWidget(users: userProvider.users),
                      ),
                    ),
                  ],
                ),
    );
  }
}
