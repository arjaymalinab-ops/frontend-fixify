import 'package:flutter/material.dart';

class NotificationCustomerScreen extends StatefulWidget {
  @override
  _NotificationCustomerScreenState createState() =>
      _NotificationCustomerScreenState();
}

class _NotificationCustomerScreenState
    extends State<NotificationCustomerScreen> {
  // Mock notification data
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 1,
      'type': 'booking',
      'title': 'Booking Confirmed',
      'message':
          'Your booking for Electrical services has been confirmed. Handyman will arrive at 2:00 PM.',
      'time': '5 minutes ago',
      'isRead': false,
      'icon': Icons.check_circle,
      'color': Color(0xFF2A7F6E),
    },
    {
      'id': 2,
      'type': 'payment',
      'title': 'Payment Successful',
      'message':
          'Your payment of ₱850 for Plumbing service has been processed successfully.',
      'time': '2 hours ago',
      'isRead': false,
      'icon': Icons.payment,
      'color': Colors.blue,
    },
    {
      'id': 3,
      'type': 'reminder',
      'title': 'Service Reminder',
      'message':
          'Your appointment with Carpenter is scheduled for tomorrow at 10:00 AM.',
      'time': '1 day ago',
      'isRead': true,
      'icon': Icons.alarm,
      'color': Colors.orange,
    },
    {
      'id': 4,
      'type': 'promo',
      'title': 'Special Offer!',
      'message':
          'Get 15% off on your next Aircon servicing. Limited time offer!',
      'time': '2 days ago',
      'isRead': true,
      'icon': Icons.local_offer,
      'color': Colors.purple,
    },
    {
      'id': 5,
      'type': 'review',
      'title': 'Rate Your Experience',
      'message':
          'How was your service with Juan Dela Cruz? Leave a review now.',
      'time': '3 days ago',
      'isRead': true,
      'icon': Icons.rate_review,
      'color': Colors.teal,
    },
  ];

  void _markAsRead(int id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n['id'] == id);
      if (index != -1) {
        _notifications[index]['isRead'] = true;
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
  }

  void _clearAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear All Notifications'),
        content: Text('Are you sure you want to clear all notifications?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _notifications.clear();
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text('Clear All'),
          ),
        ],
      ),
    );
  }

  int get _unreadCount {
    return _notifications.where((n) => !n['isRead']).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1E5F4B),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (_unreadCount > 0)
            IconButton(
              icon: Icon(Icons.mark_chat_read),
              onPressed: _markAllAsRead,
              tooltip: 'Mark all as read',
            ),
          if (_notifications.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_sweep),
              onPressed: _clearAll,
              tooltip: 'Clear all',
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                // Header with unread count
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Colors.grey[50],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      if (_unreadCount > 0)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF2A7F6E),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$_unreadCount unread',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Notifications List
                Expanded(
                  child: ListView.builder(
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      final notification = _notifications[index];
                      return _buildNotificationItem(notification);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Dismissible(
      key: Key(notification['id'].toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        setState(() {
          _notifications.removeWhere((n) => n['id'] == notification['id']);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Notification dismissed'),
            duration: Duration(seconds: 2),
            backgroundColor: Color(0xFF2A7F6E),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          _markAsRead(notification['id']);
          _showNotificationDetails(notification);
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification['isRead']
                ? Colors.white
                : Color(0xFF2A7F6E).withOpacity(0.05),
            border: Border(
              bottom: BorderSide(color: Colors.grey[200]!, width: 1),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: notification['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  notification['icon'],
                  color: notification['color'],
                  size: 24,
                ),
              ),
              SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: notification['isRead']
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              color: Color(0xFF1E5F4B),
                            ),
                          ),
                        ),
                        if (!notification['isRead'])
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Color(0xFF2A7F6E),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      notification['message'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      notification['time'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF2A7F6E).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none,
              size: 60,
              color: Color(0xFF2A7F6E),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'No Notifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5F4B),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'You\'re all caught up!',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  void _showNotificationDetails(Map<String, dynamic> notification) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: notification['color'].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      notification['icon'],
                      color: notification['color'],
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E5F4B),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          notification['time'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                notification['message'],
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              SizedBox(height: 20),
              if (notification['type'] == 'booking')
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/my-bookings');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2A7F6E),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('View Booking'),
                ),
              if (notification['type'] == 'review')
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Review feature coming soon!'),
                        backgroundColor: Color(0xFF2A7F6E),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2A7F6E),
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Write a Review'),
                ),
            ],
          ),
        );
      },
    );
  }
}
