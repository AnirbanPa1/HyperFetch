import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  final String imageUrl;
  const ImagePreview({super.key, required this.imageUrl});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                          // TODO: Implement download logic here
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
    );
  }
}
