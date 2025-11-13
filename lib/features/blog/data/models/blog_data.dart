import 'package:flutter/material.dart';
import 'package:my_protfolio/features/blog/data/models/blog_post_model.dart';

class BlogData {
  static final List<BlogPost> posts = [
    BlogPost(
      id: '1',
      title: 'Mastering Socket.IO in Flutter — Smooth Real-Time Connections with Auto-Reconnect',
      excerpt:
          'Build a robust real-time connection system for your Flutter app using Socket.IO — with smart reconnection, transport optimization, and clean lifecycle management.',
      content: '''
🚀 Why Socket.IO in Flutter?
Real-time updates are a must for modern apps — whether it's a chat system, live feed, or status tracker.
With socket_io_client, you can seamlessly bring event-based communication into your Flutter app.

But here's the catch — if you don't handle reconnection properly, users may:

- Miss updates during network drops.
- Experience duplicate event listeners.
- Or worse — crash the app with stale connections.
Let's fix that 💪

🧩 Step 1: Add the Dependency
Add this to your pubspec.yaml:

dependencies:
  socket_io_client: ^3.1.2
Import it:

import 'package:socket_io_client/socket_io_client.dart' as IO;

⚙️ Step 2: Build a Reliable Connection
Here's the core setup for a resilient socket connection in Flutter:

_socket = IO.io(
  AppEnvironment.socketUrl,
  IO.OptionBuilder()
      .enableForceNewConnection()   // Ensures a clean, isolated connection
      .setTransports(['websocket']) // Use WebSocket (faster + stable)
      .enableAutoConnect()          // Auto connect when available
      .setReconnectionAttempts(2)   // Retry twice if connection drops
      .setReconnectionDelay(3000)   // 3s delay between retries
      .build(),
);
// Disconnect old connection (if exists)
if (_socket.connected) {
  _socket.disconnect();
}
// Connect the new socket
_socket.connect();

🧠 Understanding the Options
OptionDescriptionenableForceNewConnection()Creates a fresh socket connection every time you initialize.setTransports(['websocket'])Forces WebSocket over HTTP polling for better performance on mobile.enableAutoConnect()Automatically tries connecting once the socket is created.setReconnectionAttempts(2)Limits retry attempts to prevent infinite loops.setReconnectionDelay(3000)Waits 3 seconds between retries for stability.

🧰 Step 3: Wrap It in a Service
Encapsulating your socket logic inside a service keeps your architecture clean and testable.

class SocketService {
  late IO.Socket _socket;
  void initSocket() {
    _socket = IO.io(
      AppEnvironment.socketUrl,
      IO.OptionBuilder()
          .enableForceNewConnection()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setReconnectionAttempts(2)
          .setReconnectionDelay(3000)
          .build(),
    );
    if (_socket.connected) _socket.disconnect();
    _socket.connect();
    _socket.onConnect((_) => print("✅ Connected to Socket Server"));
    _socket.onDisconnect((_) => print("❌ Disconnected from Server"));
  }
  void dispose() {
    _socket.disconnect();
  }
}
Now you can call SocketService().initSocket() anywhere in your app — and it will handle reconnections gracefully.

🧭 Step 4: Handle Connection Events
You can listen to lifecycle events to update your app UI or state:

_socket.onConnect((_) => print('🔗 Connected'));
_socket.onDisconnect((_) => print('🚫 Disconnected'));
_socket.onReconnect((data) => print('🔁 Trying to reconnect... (\$data)'));
_socket.onError((error) => print('⚠️ Socket Error: \$error'));
This gives you full visibility into your socket's behavior in real time.

📈 Step 5: Test Your Connection
Try simulating:

Turning airplane mode on/off
Restarting the app
Restarting the backend server
Your app should automatically reconnect within the configured attempts.

🌐 Diagram: Connection Flow
Flow:
App starts → Socket connects → Listens for events → Disconnects (network issue) → Auto-reconnects → Resumes sync

✅ Final Thoughts
With this setup:

You eliminate duplicate socket connections.
You ensure automatic reconnection.
You improve app performance and user trust.
Socket.IO + Flutter = real-time power, simplified ⚡
''',
      category: 'Flutter',
      imageUrl: 'https://ik.imagekit.io/ably/ghost/prod/2021/03/socket-io-logo-1.jpeg?tr=w-1728,q-50',
      publishedDate: DateTime(2024, 11, 18),
      readTime: 5,
      externalUrl: null,
      tags: ['Flutter', 'Socket.IO', 'Realtime',],
    ),
    BlogPost(
      id: '3',
      title: 'State Management in React: A Complete Guide',
      excerpt:
          'Explore different state management solutions in React including Redux, Context API, and modern hooks for building scalable applications.',
      content: '',
      category: 'React',
      imageUrl: '',
      publishedDate: DateTime(2024, 11, 8),
      readTime: 12,
      tags: ['React', 'JavaScript', ],
    ),
    BlogPost(
      id: '4',
      title: 'UI/UX Best Practices for Modern Web Apps',
      excerpt:
          'Discover essential UI/UX principles and design patterns that will help you create intuitive and engaging user interfaces.',
      content: '',
      category: 'Design',
      imageUrl: '',
      publishedDate: DateTime(2024, 10, 28),
      readTime: 6,
      tags: ['UI/UX', 'Design', 'Frontend'],
    ),
  ];

  static List<BlogPost> getAllPosts() => posts;

  static IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'flutter':
        return Icons.phone_android_rounded;
      case 'react':
        return Icons.web_rounded;
      case 'design':
        return Icons.palette_rounded;
      default:
        return Icons.article_rounded;
    }
  }
}