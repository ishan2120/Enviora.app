import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';
import 'file_complaint_page.dart';
import 'track_vehicle_page.dart';

class MyReportsPage extends StatefulWidget {
  const MyReportsPage({super.key});

  @override
  State<MyReportsPage> createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {
  ReportStatus? _selectedFilter;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _currentNavIndex = 0;

  // Sample data - In a real app, this would come from a backend
  final List<Report> _allReports = [
    Report(
      id: 'EV-7712',
      type: ReportType.illegalDumping,
      issueType: 'Illegal Waste Dumping',
      description: 'Large pile of garbage bags dumped on the street',
      status: ReportStatus.pending,
      reportedDate: DateTime(2024, 10, 12),
      imageUrl: 'assets/images/Rectangle 117.png',
    ),
    Report(
      id: 'EV-7740',
      type: ReportType.missedCollection,
      issueType: 'Overflowing Bin',
      description: 'Bins are overflowing and not collected',
      status: ReportStatus.inProgress,
      reportedDate: DateTime(2024, 9, 28),
      imageUrl: 'assets/images/Rectangle 118.png',
    ),
    Report(
      id: 'EV-7891',
      type: ReportType.illegalDumping,
      issueType: 'Illegal Waste Dumping',
      description: 'Waste dumped near residential area',
      status: ReportStatus.resolved,
      reportedDate: DateTime(2024, 10, 12),
      imageUrl: 'assets/images/Rectangle 117.png',
    ),
  ];

  final SupervisorUpdate _latestUpdate = SupervisorUpdate(
    supervisorName: 'Supervisor Thasara',
    message:
        'We have dispatched a collection team to #EV-7740. You should see it cleared within the next 48 hours.',
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
  );

  List<Report> get _filteredReports {
    var reports = _allReports;

    // Filter by status
    if (_selectedFilter != null) {
      reports = reports.where((r) => r.status == _selectedFilter).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      reports = reports.where((r) {
        return r.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            r.typeString.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            r.issueType.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return reports;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'My Reports',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Status Filter Tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              children: [
                _FilterTab(
                  label: 'All',
                  isSelected: _selectedFilter == null,
                  onTap: () {
                    setState(() {
                      _selectedFilter = null;
                    });
                  },
                ),
                const SizedBox(width: 12),
                _FilterTab(
                  label: 'Pending',
                  isSelected: _selectedFilter == ReportStatus.pending,
                  color: const Color(0xFF4CAF50),
                  onTap: () {
                    setState(() {
                      _selectedFilter = ReportStatus.pending;
                    });
                  },
                ),
                const SizedBox(width: 12),
                _FilterTab(
                  label: 'In Progress',
                  isSelected: _selectedFilter == ReportStatus.inProgress,
                  color: const Color(0xFF4CAF50),
                  onTap: () {
                    setState(() {
                      _selectedFilter = ReportStatus.inProgress;
                    });
                  },
                ),
                const SizedBox(width: 12),
                _FilterTab(
                  label: 'Resolved',
                  isSelected: _selectedFilter == ReportStatus.resolved,
                  color: const Color(0xFF4CAF50),
                  onTap: () {
                    setState(() {
                      _selectedFilter = ReportStatus.resolved;
                    });
                  },
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search report ID or type...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.green[400]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Reports List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount:
                  _filteredReports.length + 1, // +1 for latest update section
              itemBuilder: (context, index) {
                if (index == _filteredReports.length) {
                  // Latest Update Section
                  return _LatestUpdateCard(update: _latestUpdate);
                }

                final report = _filteredReports[index];
                return _ReportCard(report: report);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FileComplaintPage()),
          );
        },
        backgroundColor: const Color(0xFF4CAF50),
        child: const Icon(Icons.add, size: 32),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4CAF50),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
          if (index == 2) {
            // Navigate to Track Vehicle page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TrackVehiclePage(),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'GUIDE'),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'TRACK',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PROFILE'),
        ],
      ),
    );
  }
}

class _FilterTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color? color;
  final VoidCallback onTap;

  const _FilterTab({
    required this.label,
    required this.isSelected,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? (color ?? Colors.black) : Colors.grey,
        ),
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final Report report;

  const _ReportCard({required this.report});

  Color _getStatusColor() {
    switch (report.status) {
      case ReportStatus.pending:
        return const Color(0xFFFFA726);
      case ReportStatus.inProgress:
        return const Color(0xFF42A5F5);
      case ReportStatus.resolved:
        return Colors.black87;
    }
  }

  Color _getStatusBackgroundColor() {
    switch (report.status) {
      case ReportStatus.pending:
        return const Color(0xFFFFF3E0);
      case ReportStatus.inProgress:
        return const Color(0xFFE3F2FD);
      case ReportStatus.resolved:
        return Colors.grey[200]!;
    }
  }

  IconData _getReportIcon() {
    switch (report.type) {
      case ReportType.missedCollection:
        return Icons.delete_outline;
      case ReportType.illegalDumping:
        return Icons.warning_amber_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusBackgroundColor(),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    report.statusString,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  report.typeString,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Reported on ${DateFormat('MMM dd').format(report.reportedDate)} #${report.id}',
                  style: TextStyle(fontSize: 14, color: Colors.green[600]),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    // Navigate to history page
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View History',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.green[700],
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.green[700],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: report.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      report.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(_getReportIcon(), size: 40, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class _LatestUpdateCard extends StatelessWidget {
  final SupervisorUpdate update;

  const _LatestUpdateCard({required this.update});

  String _getTimeAgo(DateTime timestamp) {
    final difference = DateTime.now().difference(timestamp);
    if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LATEST UPDATE',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4CAF50),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color(0xFF4CAF50),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            update.supervisorName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            _getTimeAgo(update.timestamp),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  update.message,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
