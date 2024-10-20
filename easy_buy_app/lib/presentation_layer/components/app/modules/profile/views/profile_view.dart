import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My profile',
          style: Theme.of(context).textTheme.titleLarge,  // Updated from headline6 to titleLarge
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image and User Info
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // Replace with real image URL
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Matilda Brown', // Replace with actual name
                        style: Theme.of(context).textTheme.titleLarge,  // Updated to titleLarge
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'matildabrown@mail.com', // Replace with actual email
                        style: Theme.of(context).textTheme.bodyMedium,  // Updated to bodyMedium
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Profile Options List
              _buildProfileOption(
                context,
                'My orders',
                'Already have 12 orders',
                Icons.shopping_bag_outlined,
              ),
              _buildProfileOption(
                context,
                'Shipping addresses',
                '3 addresses',
                Icons.location_on_outlined,
              ),
              _buildProfileOption(
                context,
                'Payment methods',
                'Visa **34',
                Icons.credit_card_outlined,
              ),
              _buildProfileOption(
                context,
                'Promocodes',
                'You have special promocodes',
                Icons.card_giftcard_outlined,
              ),
              _buildProfileOption(
                context,
                'My reviews',
                'Reviews for 4 items',
                Icons.reviews_outlined,
              ),
              _buildProfileOption(
                context,
                'Settings',
                'Notifications, password',
                Icons.settings_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build each profile option row
  Widget _buildProfileOption(
      BuildContext context, String title, String subtitle, IconData icon) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),  // Updated to titleMedium
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),  // Updated to bodyMedium
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
      onTap: () {
        // Handle navigation here
      },
    );
  }
}
