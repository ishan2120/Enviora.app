import 'package:flutter/material.dart';

class ActivityItem {
  final String id;
  final String title;
  final String subtitle;
  final String date;
  final String status;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color statusColor;
  final String type; // 'report', 'pickup', 'collection'

  ActivityItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.status,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.statusColor,
    required this.type,
  });
}

class ActivityHistoryScreen extends StatefulWidget {
  const ActivityHistoryScreen({super.key});

  @override
  State<ActivityHistoryScreen> createState() => _ActivityHistoryScreenState();
}

class _ActivityHistoryScreenState extends State<ActivityHistoryScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Reports', 'Pickups', 'Completed'];

  // Sample Data
  final List<ActivityItem> _allActivities = [
    // REPORTED ISSUES
    ActivityItem(
      id: 'ENV-2026-001',
      title: 'Illegal Dumping Reported',
      subtitle: 'Near Galle Road, Colombo 03',
      date: '15 Feb 2026',
      status: 'Pending',
      description: 'Reported large pile of construction waste',
      icon: Icons.warning_amber_rounded,
      iconColor: Colors.red,
      statusColor: const Color(0xFFFF9800),
      type: 'report',
    ),
    ActivityItem(
      id: 'ENV-2026-002',
      title: 'Illegal Dumping Reported',
      subtitle: 'Nugegoda Junction, Colombo',
      date: '10 Feb 2026',
      status: 'Resolved',
      description: 'Municipal team cleared the waste',
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
      statusColor: const Color(0xFF4CAF50),
      type: 'report',
    ),
    // SPECIAL PICKUP REQUESTS
    ActivityItem(
      id: 'ENV-2026-003',
      title: 'Special Pickup Request',
      subtitle: 'Old sofa and wooden furniture',
      date: '14 Feb 2026',
      status: 'In Progress',
      description: 'Scheduled for pickup on 18 Feb 2026',
      icon: Icons.local_shipping_outlined,
      iconColor: Colors.blue,
      statusColor: const Color(0xFF2196F3),
      type: 'pickup',
    ),
    ActivityItem(
      id: 'ENV-2026-004',
      title: 'Special Pickup Request',
      subtitle: 'Tree trunks and garden waste',
      date: '05 Feb 2026',
      status: 'Completed',
      description: 'Items successfully collected',
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
      statusColor: const Color(0xFF4CAF50),
      type: 'pickup',
    ),
    ActivityItem(
      id: 'ENV-2026-005',
      title: 'Special Pickup Request',
      subtitle: 'Old refrigerator and washing machine',
      date: '16 Feb 2026',
      status: 'Pending',
      description: 'Awaiting municipal confirmation',
      icon: Icons.local_shipping_outlined,
      iconColor: Colors.orange,
      statusColor: const Color(0xFFFF9800),
      type: 'pickup',
    ),
    // COMPLETED COLLECTIONS
    ActivityItem(
      id: 'ENV-2026-006',
      title: 'Garbage Collection',
      subtitle: 'Weekly collection - Zone 5',
      date: '12 Feb 2026',
      status: 'Completed',
      description: 'Organic and recyclable waste collected',
      icon: Icons.recycling,
      iconColor: Colors.green,
      statusColor: const Color(0xFF4CAF50),
      type: 'collection',
    ),
    ActivityItem(
      id: 'ENV-2026-007',
      title: 'Garbage Collection',
      subtitle: 'Weekly collection - Zone 5',
      date: '05 Feb 2026',
      status: 'Completed',
      description: 'All waste types collected successfully',
      icon: Icons.recycling,
      iconColor: Colors.green,
      statusColor: const Color(0xFF4CAF50),
      type: 'collection',
    ),
    ActivityItem(
      id: 'ENV-2026-008',
      title: 'Garbage Collection',
      subtitle: 'Weekly collection - Zone 5',
      date: '29 Jan 2026',
      status: 'Missed',
      description: 'Collection was not completed on schedule',
      icon: Icons.cancel_outlined,
      iconColor: Colors.red,
      statusColor: const Color(0xFFF44336),
      type: 'collection',
    ),
  ];

  List<ActivityItem> get _filteredActivities {
    if (_selectedFilter == 'All') {
      return _allActivities;
    } else if (_selectedFilter == 'Reports') {
      return _allActivities.where((a) => a.type == 'report').toList();
    } else if (_selectedFilter == 'Pickups') {
      return _allActivities.where((a) => a.type == 'pickup').toList();
    } else if (_selectedFilter == 'Completed') {
      return _allActivities
          .where((a) => a.status == 'Completed' || a.status == 'Resolved')
          .toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 12),
            _buildFilterTabs(),
            const SizedBox(height: 12),
            _buildSummaryCards(),
            const SizedBox(height: 12),
            Expanded(
              child: _filteredActivities.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredActivities.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ActivityCard(item: _filteredActivities[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              'Activity History',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
          ),
          const SizedBox(width: 48), // Balance for back button
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF388E3C) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: isSelected
                      ? null
                      : Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              count: '8',
              label: 'Total Activities',
              icon: Icons.list,
              iconColor: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildSummaryCard(
              count: '3',
              label: 'Pending',
              icon: Icons.schedule,
              iconColor: const Color(0xFFFF9800),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildSummaryCard(
              count: '5',
              label: 'Completed',
              icon: Icons.check_circle_outline,
              iconColor: const Color(0xFF4CAF50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String count,
    required String label,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: 4),
          Text(
            count,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212121),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No activities found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your activity history will appear here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'HOME', false),
            _buildNavItem(Icons.menu_book, 'GUIDE', false),
            _buildNavItem(Icons.map, 'MAP', false),
            _buildNavItem(Icons.person, 'PROFILE', true),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (label == 'PROFILE') {
          Navigator.pop(context); // Go back to profile screen
        }
        // Other navigation logic would go here
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF4CAF50) : const Color(0xFF757575),
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color:
                  isActive ? const Color(0xFF4CAF50) : const Color(0xFF757575),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityCard extends StatefulWidget {
  final ActivityItem item;

  const ActivityCard({super.key, required this.item});

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left Colored Border
              Container(
                width: 4,
                color: widget.item.statusColor,
              ),
              Expanded(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Icon
                            CircleAvatar(
                              backgroundColor:
                                  widget.item.statusColor.withOpacity(0.1),
                              radius: 20,
                              child: Icon(
                                widget.item.icon,
                                color: widget.item.iconColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.item.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Color(0xFF212121),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        widget.item.date,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.item.subtitle,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.item.description,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: widget.item.statusColor,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          widget.item.status,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
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
                    ),
                    // Expanded Details
                    if (_isExpanded)
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            _buildDetailRow('Reference ID', widget.item.id),
                            const SizedBox(height: 4),
                            _buildDetailRow('Location', widget.item.subtitle),
                            const SizedBox(height: 4),
                            _buildDetailRow(
                                'Submitted', '${widget.item.date}, 10:30 AM'),
                            const SizedBox(height: 16),
                            if (widget.item.status == 'Pending')
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () {
                                    _showCancelConfirmation(context);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.red,
                                    side: const BorderSide(color: Colors.red),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text('Cancel Request'),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF212121),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Request?'),
          content: const Text(
              'Are you sure you want to cancel this request? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No, Keep It'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Request cancelled successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('Yes, Cancel',
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
