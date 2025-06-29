import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb

class ImagePreview extends StatefulWidget {
  final String imageUrl;
  const ImagePreview({super.key, required this.imageUrl});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  bool _hovering = false;

  void _toggleHover() {
    setState(() => _hovering = !_hovering);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Only enable tap toggle on mobile platforms
        if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS) {
          _toggleHover();
        }
      },
      child: MouseRegion(
        onEnter: (_) {
          // Only enable hover on desktop/web
          if (!kIsWeb &&
              (defaultTargetPlatform == TargetPlatform.android ||
                  defaultTargetPlatform == TargetPlatform.iOS)) {
            return;
          }
          setState(() => _hovering = true);
        },
        onExit: (_) {
          if (!kIsWeb &&
              (defaultTargetPlatform == TargetPlatform.android ||
                  defaultTargetPlatform == TargetPlatform.iOS)) {
            return;
          }
          setState(() => _hovering = false);
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 300,
            width: 300,
            child: Stack(
              children: [
                SizedBox.expand(
                  child: widget.imageUrl.isNotEmpty
                      ? Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Text('Failed to load image'),
                            );
                          },
                        )
                      : const Center(child: Text('No image available')),
                ),

                // hover overlay
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _hovering ? 1.0 : 0.0,
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: IconButton(
                          icon: const Icon(Icons.download, color: Colors.white),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Unimplemented')),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
