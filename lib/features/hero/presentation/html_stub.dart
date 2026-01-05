// Stub file for non-web platforms
// This file is used when dart:html is not available

class AnchorElement {
  final String? href;
  
  AnchorElement({this.href});
  
  void setAttribute(String name, String value) {
    // No-op on non-web platforms
  }
  
  void click() {
    // No-op on non-web platforms
  }
}

class Blob {
  final List<dynamic> data;
  
  Blob(this.data);
}

class Url {
  static String createObjectUrlFromBlob(Blob blob) {
    // No-op on non-web platforms
    return '';
  }
  
  static void revokeObjectUrl(String url) {
    // No-op on non-web platforms
  }
}

