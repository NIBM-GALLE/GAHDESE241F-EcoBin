import 'package:flutter/material.dart';

class EventsAndUpdatesPage extends StatefulWidget {
  const EventsAndUpdatesPage({Key? key}) : super(key: key);

  @override
  State<EventsAndUpdatesPage> createState() => _EventsAndUpdatesPageState();
}

class _EventsAndUpdatesPageState extends State<EventsAndUpdatesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2E7D32)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Events & Updates",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2E7D32),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF4CAF50),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF4CAF50),
          tabs: const [Tab(text: "Upcoming Events"), Tab(text: "Eco Updates")],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildEventsTab(), _buildUpdatesTab()],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4CAF50),
        child: const Icon(Icons.filter_list),
        onPressed: () {
          _showFilterDialog(context);
        },
      ),
    );
  }

  Widget _buildEventsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildEventCard(
          title: "Community Cleanup Day",
          date: "Mar 22, 2025",
          time: "09:00 AM - 01:00 PM",
          location: "Central Park",
          description:
              "Join us for our monthly community cleanup event. Gloves and bags will be provided. Help us keep our parks clean!",
          isRegistered: true,
        ),
        const SizedBox(height: 16),
        _buildEventCard(
          title: "Recycling Workshop",
          date: "Mar 28, 2025",
          time: "02:00 PM - 04:00 PM",
          location: "Community Center",
          description:
              "Learn about creative ways to reuse common household items. Bring your own recyclables to transform them into useful items.",
          isRegistered: false,
        ),
        const SizedBox(height: 16),
        _buildEventCard(
          title: "Earth Hour Celebration",
          date: "Mar 30, 2025",
          time: "08:30 PM - 10:00 PM",
          location: "City Square",
          description:
              "Join the global movement by turning off your lights for one hour to raise awareness about climate change. Live music and speeches included.",
          isRegistered: false,
        ),
        const SizedBox(height: 16),
        _buildEventCard(
          title: "Green Market Fair",
          date: "Apr 05, 2025",
          time: "10:00 AM - 05:00 PM",
          location: "Riverside Park",
          description:
              "Shop sustainable products from local vendors. Food, crafts, and eco-friendly items available.",
          isRegistered: false,
        ),
        const SizedBox(height: 16),
        _buildEventCard(
          title: "Tree Planting Day",
          date: "Apr 12, 2025",
          time: "10:00 AM - 02:00 PM",
          location: "Highland Hills",
          description:
              "Help us plant 100 new trees in our neighborhood. Tools and saplings provided. Bring water and wear comfortable clothes.",
          isRegistered: false,
        ),
      ],
    );
  }

  Widget _buildUpdatesTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildUpdateCard(
          title: "Reduce Plastic Waste",
          date: "Mar 15, 2025",
          description:
              "Simple steps to minimize plastic in your daily life. Learn about alternatives to common single-use plastics and how to properly recycle plastic items.",
          category: "Education",
          imageIcon: Icons.eco_outlined,
        ),
        const SizedBox(height: 16),
        _buildUpdateCard(
          title: "New Recycling Center Opening",
          date: "Mar 18, 2025",
          description:
              "Visit our newest recycling center on Main Street. State-of-the-art facilities for all your recycling needs, including electronics and hazardous waste.",
          category: "Announcement",
          imageIcon: Icons.location_on_outlined,
        ),
        const SizedBox(height: 16),
        _buildUpdateCard(
          title: "City Plans to Ban Single-Use Plastics",
          date: "Mar 10, 2025",
          description:
              "The city council has proposed a new ordinance to ban single-use plastics in restaurants and retail establishments starting June 2025.",
          category: "Policy",
          imageIcon: Icons.policy_outlined,
        ),
        const SizedBox(height: 16),
        _buildUpdateCard(
          title: "Water Conservation Tips",
          date: "Mar 05, 2025",
          description:
              "With summer approaching, learn how to conserve water at home and in your garden. Simple changes can lead to significant savings.",
          category: "Education",
          imageIcon: Icons.water_drop_outlined,
        ),
        const SizedBox(height: 16),
        _buildUpdateCard(
          title: "EcoBin App Updates",
          date: "Mar 01, 2025",
          description:
              "We've added new features to make recycling easier! Check out the improved bin locator and waste sorting guide in our latest update.",
          category: "App Updates",
          imageIcon: Icons.system_update_outlined,
        ),
      ],
    );
  }

  Widget _buildEventCard({
    required String title,
    required String date,
    required String time,
    required String location,
    required String description,
    required bool isRegistered,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.event_outlined,
                    size: 28,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: Color(0xFF4CAF50),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            date,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_outlined,
                      size: 16,
                      color: Color(0xFF4CAF50),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Color(0xFF4CAF50),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      location,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isRegistered)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.check_circle_outline,
                              size: 14,
                              color: Color(0xFF4CAF50),
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Registered",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF4CAF50),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isRegistered
                                ? Colors.grey[200]
                                : const Color(0xFF4CAF50),
                        foregroundColor:
                            isRegistered ? Colors.grey[700] : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(isRegistered ? "Cancel" : "Register"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateCard({
    required String title,
    required String date,
    required String description,
    required String category,
    required IconData imageIcon,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    imageIcon,
                    size: 28,
                    color: const Color(0xFF4CAF50),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            date,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF4CAF50),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              category,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF4CAF50),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Read More",
                      style: TextStyle(
                        color: Color(0xFF4CAF50),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(
              "Filter",
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Date Range",
                  style: TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Start Date"),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("End Date"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Categories",
                  style: TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildFilterChip("Cleanup"),
                    _buildFilterChip("Education"),
                    _buildFilterChip("Workshop"),
                    _buildFilterChip("Community"),
                    _buildFilterChip("Policy"),
                    _buildFilterChip("Announcement"),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Reset",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Apply"),
              ),
            ],
          ),
    );
  }

  Widget _buildFilterChip(String label) {
    return FilterChip(
      label: Text(label),
      selected: false,
      onSelected: (selected) {},
      backgroundColor: Colors.grey[200],
      selectedColor: const Color(0xFFE8F5E9),
      checkmarkColor: const Color(0xFF4CAF50),
      labelStyle: TextStyle(color: Colors.grey[800]),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
