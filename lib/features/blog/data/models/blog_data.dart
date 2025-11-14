import 'package:flutter/material.dart';
import 'package:my_protfolio/features/blog/data/models/blog_post_model.dart';

class BlogData {
  static final List<BlogPost> posts = [
    BlogPost(
      id: '1',
      title:
          'Mastering Socket.IO in Flutter — Smooth Real-Time Connections with Auto-Reconnect',
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
      imageUrl:
          'https://ik.imagekit.io/ably/ghost/prod/2021/03/socket-io-logo-1.jpeg?tr=w-1728,q-50',
      publishedDate: DateTime(2024, 11, 18),
      readTime: 5,
      externalUrl: null,
      tags: ['Flutter', 'Socket.IO', 'Realtime'],
    ),
    BlogPost(
      id: '2',
      title: 'Getting Started with Game Development Using Flutter & Flame',
      excerpt:
          'Learn how to build 2D games using Flutter and the Flame game engine - a powerful combination for casual and indie game development.',
      content: '''
Most people know Flutter for building apps. But what many developers still don't realize is that Flutter can also be used to build 2D games — thanks to a lightweight game engine called Flame.

If you already know Flutter, you can start building games much faster than you think. This article explains what Flame is, why it's useful, and how you can begin creating simple and fun games with Flutter.

What Is Flame?
Flame is a 2D game engine built on top of Flutter.
Flutter's normal widget system is great for apps, but not ideal for games. Games need things like:

A constant game loop
Fast rendering
Sprite animations
Collision detection
Physics
Player input handling
Flame provides all of this — while still letting you use Flutter for UI like menus, scoreboards, and buttons.

Why Use Flutter + Flame for Games?
1. Easy to learn
If you know Flutter, Flame feels familiar. You don't have to learn a complicated engine like Unity.

2. Perfect for 2D games
Casual games, puzzles, platformers, runners, mini-games — all work great.

3. Fast cross-platform support
One codebase → Android, iOS, Web, Desktop.

4. Flutter UI + Flame gameplay
Game world using Flame.
Menus, settings, profile screens using Flutter.
The combination is smooth and fast.

How Flame Works (Very Simple Explanation)
Flame replaces the "widget rebuild system" with a game loop:

update → render → repeat
update() — game logic (movement, collisions, timers)
render() — drawing sprites on the screen
dt — time difference between frames (keeps movement smooth)
That's it. This loop runs every frame (60–120 FPS).

A Basic Example
Here's what a simple Flame game looks like:

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    add(Player());
  }
}
And a basic player component:

class Player extends SpriteComponent {
  @override
  void update(double dt) {
    position.x += 200 * dt; // move smoothly
  }
}
You get:

Movement
Animation
Physics
Input handling
by adding small components like this.
What You Can Build with Flame
✔ Endless runner
(T-rex game, subway runner type)

✔ Platformer
(Mario-style side scroller)

✔ Tap/Swipe games
(Flappy bird, fruit slicing)

✔ Puzzle games
(Grid/board logic)

✔ Mini-games inside apps
(Rewards, learning games)

Become a member
If your idea is 2D, Flame can probably handle it.

Performance Notes (Simple Truth)
Flame is fast.
It runs smoothly on most devices if you code properly.

Just avoid:

Loading images inside the game loop
Very large image files
Heavy logic inside render()
Too many new objects created every frame
For normal 2D games, Flame handles performance extremely well.

Common Beginner Mistakes
❌ Using Flutter widgets for every game element
✔ Use Flame components for game objects.

❌ Not preloading assets
✔ Load all images/sounds in onLoad().

❌ Skipping delta time
✔ Always multiply movement by dt.

❌ No fixed viewport
✔ Set a virtual game size to support all screen resolutions.

Should You Choose Flame for Your Game?
Choose Flame if:

You want to build a simple or medium-complexity 2D game
You prefer Flutter instead of Unity/Godot
You want quick development and clean UI
You want to publish to Android, iOS, Web easily
Don't choose Flame if you want:

3D games
Very advanced physics
AAA-style graphics
For most indie or casual mobile games, Flame is more than enough.

Conclusion
Flutter + Flame is a powerful, simple, and enjoyable way to build 2D games. You get Flutter's UI strengths plus Flame's game engine features, all in one codebase. If you're a Flutter developer, you already have most of the skills needed to start building games.

Game development doesn't have to be complex — and Flame proves it.
''',
      category: 'Flutter',
      imageUrl:
          'https://miro.medium.com/v2/resize:fit:1400/1*Qyyvx52AjpBRuI8MeZ7cAg.png',
      publishedDate: DateTime.now(),
      readTime: 3,
      externalUrl: null,
      tags: ['Flutter', 'Flame', '2D Games', 'Game Development'],
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
