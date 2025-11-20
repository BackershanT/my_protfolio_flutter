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
_socket.onReconnect((data) => print('🔁 Trying to reconnect... (' + data.toString() + ')'));
_socket.onError((error) => print('⚠️ Socket Error: ' + error.toString()));
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
    BlogPost(
      id: '3',
      title:
          'Fastlane for Flutter: The Missing Piece You Didn\'t Know You Needed',
      excerpt:
          'Discover why Fastlane is essential for professional Flutter app deployment and how it transforms your release workflow.',
      content: '''
Most Flutter developers think their job ends when the UI is done.

They're wrong.

Shipping the app — properly, repeatedly, without breaking things — is harder than writing widgets.

That's where Fastlane comes in.

This blog breaks down:

What Fastlane actually is
Why Flutter developers need it
How it changes your release workflow
How it fits into a real CI/CD system
No marketing talk. Only reality.

Flutter builds apps. Fastlane ships them.

Flutter handles:

UI rendering
Business logic
App packaging
Fastlane handles:

App Store & Play Store automation
Signing, certificates, provisioning
Versioning, builds, and deployments
Think of it like this:

Flutter → Builds the app  
Fastlane → Gets the app to users

You can build a Ferrari,
but if you don't know how to get it onto the road… what's the point?

Why Flutter developers struggle with releases

Let's be brutally honest.

Most Flutter devs:

Manually upload APK/AAB files
Forget to increment version codes
Break signing every few months
Share certificates insecurely
Waste time on repetitive release steps
And the worst part?

They think that's normal.

It's not.

It's amateur workflow.

What Fastlane actually does for your Flutter app

Fastlane automates everything around releasing your app:

1. One command releases your app

Instead of 15 manual steps:

fastlane deploy

And your app:

Builds
Signs
Uploads
Submits to stores
2. Versioning without human error

Fastlane auto-increments:

Android versionCode
iOS CFBundleVersion
No more "why is Play Store rejecting this build?" moments.

3. Signing without daily suffering

Certificates and keystores are a nightmare.

Become a member

Fastlane manages them using:

Secure storage
match for team access
Automatic renewal flows
You stop worrying about lost certificates.

4. Works perfectly with CI/CD

When using GitHub Actions:

Push to main → GitHub Actions → Fastlane → App Stores

Zero manual effort.
Zero forgotten steps.

How Fastlane fits into a real Flutter pipeline

Here's what a professional pipeline looks like:

Developer writes code

       ↓

Pushes to GitHub

       ↓

GitHub Actions triggers

       ↓

Flutter builds the app

       ↓

Fastlane executes release

       ↓

App Store & Play Store receive the build

This is how real teams ship apps weekly or daily — not once in 3 months.

Does Fastlane affect Flutter code?

No.

Fastlane doesn't touch:

Widgets
State management
Performance
App logic
It only affects how your app moves from your machine to your users' devices.

That's a critical layer Flutter doesn't handle.

Real talk: Should every Flutter dev use Fastlane?

If you are:

✅ Working on real production apps
✅ Wanting proper CI/CD
✅ Planning to work in teams
✅ Interested in scalable workflow

Then yes — you absolutely should.

If you're just doing hobby apps or college projects?

Probably not yet.

Final thought

Flutter helps you build fast.
Fastlane helps you ship smart.

Without Fastlane, you'll always be:

Slow
Error-prone
Manual
With Fastlane, your releases become:

Automated
Consistent
Professional
That's the difference between a coder and an engineer.
''',
      category: 'Flutter',
      imageUrl: 'https://miro.medium.com/1*Uyc-j33p4oE4s4-Zjn5--g.png',
      publishedDate: DateTime.now(),
      readTime: 3,
      externalUrl: '',
      tags: ['Flutter', 'Fastlane', 'CI/CD', 'Deployment'],
    ),
    BlogPost(
      id: '4',
      title: 'UX Pilot: How AI is Changing the Way We Design Interfaces',
      excerpt:
          'Discover how AI-powered design assistant UX Pilot is transforming the UI/UX design process and what it means for designers.',
      content: '''
Design used to be slow.
Not because designers aren't creative — but because the process around design was painfully manual.

Wireframes.
Components.
Layouts.
Revisions.
Again and again.

Now tools like UX Pilot are changing that.

This blog breaks down what UX Pilot is, how it actually works, and where it helps or fails — without hype, just reality.

What is UX Pilot?
UX Pilot is an AI-powered design assistant that helps you generate UI/UX layouts, components, and design structures based on natural language input.

Instead of starting from a blank Figma file, you start with a prompt like:

"Design a modern crypto dashboard with dark theme and minimal colors."

And UX Pilot generates:

Layout suggestions
Component structure
Wireframe-level UI
Sometimes even full design screens
You're not designing from scratch anymore.
You're directing the design.

That's the shift.

Why UX Pilot Actually Matters
Most AI design tools fail because they try to replace designers.

UX Pilot doesn't.

It assists, speeds up, and removes the boring part of designing:

White screen paralysis
Repetitive layout setup
Basic component placements
UI brainstorming
It helps you go from:

Idea → Layout → Base Design
10x faster than traditional workflows.

How UX Pilot Works in Real Life (Not Marketing Version)
Most people imagine:

"I give a prompt, I get a perfect design."

Wrong.

This is the real workflow:

You give UX Pilot a prompt
It generates rough UI layouts
You refine prompts and regenerate
You pick the best structure
You still fine-tune with your design knowledge
So no — it doesn't replace your brain.
It just removes repetitive effort.

Where UX Pilot Is Actually Powerful
Here's where UX Pilot makes sense:

✅ 1. Early-Stage Ideation
When you don't know how your app should look yet, UX Pilot helps you explore:

Different layout options
Different UX structures
Different design directions
Instead of sketching manually, you iterate with AI.

✅ 2. Wireframe Generation
Generating low-fidelity wireframes is boring and time consuming.

Become a member
UX Pilot does it in minutes.

You then:

Refine spacing
Adjust hierarchy
Finalize UX flow
✅ 3. Rapid MVP Design
If you're building:

A startup MVP
A hackathon project
A quick client prototype
UX Pilot can give you usable layouts fast, so you focus on logic and user flow instead of pixel perfection.

Where UX Pilot Fails (Because It's Not Magic)
Let's be brutally honest.

UX Pilot is not good for:

❌ Complex enterprise UX
❌ Deep accessibility-based designs
❌ Advanced microinteractions
❌ Highly custom brand identities

AI tools don't understand:

Business logic deeply
Real user psychology
Cultural UI nuances
Product ecosystem complexity
You still need human intelligence for that.

UX Pilot vs Traditional UI Designing
Traditional DesignUX Pilot DesignManual layout planningAI-assisted layout creationSlower iterationsFaster iterationsRequires lot of initial thinkingHelps with initial thinkingHigh controlHigh speed, medium controlDesigner creates everythingDesigner edits and directs

UX Pilot doesn't remove designers —
It changes their role from creator to curator.

Real Impact on Designers
Designers scared of AI are looking at it wrong.

UX Pilot doesn't kill designers.
It kills designers who refused to evolve.

The future designer will:

Use AI for base layouts
Use human judgment for experience
Focus on psychology, storytelling, and usability
Not drawing rectangles all day.
Should You Use UX Pilot?
Brutally honest answer:

Use UX Pilot if:
✅ You want to speed up workflow
✅ You understand UX principles already
✅ You're working on web/app prototypes
✅ You want to explore ideas faster

Don't use it if:
❌ You rely on it for design thinking
❌ You don't understand UX fundamentals
❌ You expect polished final products

Final Thoughts
UX Pilot is not a replacement.

It's a multiplier.

Bad designers will generate bad AI designs faster.
Good designers will create better designs even faster.

The tool doesn't decide the outcome.
The mind using it does.
''',
      category: 'Design',
      imageUrl: 'https://uxpilot.ai/assets/images/what-is-uxpilot.png',
      publishedDate: DateTime.now(),
      readTime: 3,
      externalUrl: '',
      tags: ['AI', 'UX', 'UI', 'Design Tools', 'Figma'],
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
