import 'package:flutter/material.dart';
import '../models/user.dart';

class UserListWidget extends StatelessWidget {
  final List<User> users;

  const UserListWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade200,
                child: const Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                user.name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                user.email,
                style: TextStyle(color: Colors.teal.shade700),
              ),
              trailing: const Icon(Icons.arrow_forward, color: Colors.teal),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailScreen(user: user),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Colors.teal),
                const SizedBox(width: 10),
                Text(
                  'Username: ${user.username}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.email, color: Colors.teal),
                const SizedBox(width: 10),
                Text(
                  'Email: ${user.email}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.teal),
                const SizedBox(width: 10),
                Text(
                  'Phone: ${user.phone}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.web, color: Colors.teal),
                const SizedBox(width: 10),
                Text(
                  'Website: ${user.website}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.business, color: Colors.teal),
                const SizedBox(width: 10),
                Text(
                  'Company: ${user.company.name}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
