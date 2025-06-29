import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hyperfetch/components/image_preview.dart';
import 'package:yaru/yaru.dart';
import '../services/link_parser_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _urlController = TextEditingController();
  List<String> links = [];
  bool isLoading = false;

  void fetchLinks() async {
    if (_urlController.text.isEmpty ||
        !(_urlController.text.startsWith('http://') ||
            _urlController.text.startsWith('https://'))) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a URL')));
      return;
    }
    setState(() => isLoading = true);
    final url = _urlController.text.trim();
    links = await LinkParserService.extractLinks(url);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext ctx) {
    var isMobile = MediaQuery.of(ctx).size.width < 650;

    return Scaffold(
      appBar: Platform.isLinux
          ? YaruWindowTitleBar()
          : AppBar(title: const Text('HyperFetch')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: MediaQuery.of(ctx).size.width < 650
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            isMobile
                ? Column(
                    children: [
                      TextField(
                        controller: _urlController,
                        decoration: const InputDecoration(
                          labelText: 'Enter URL',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      FilledButton(
                        onPressed: isLoading ? null : fetchLinks,
                        child: const Text('Load Images'),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _urlController,
                          decoration: const InputDecoration(
                            labelText: 'Enter URL',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      FilledButton(
                        onPressed: isLoading ? null : fetchLinks,
                        child: const Text('Load Images'),
                      ),
                    ],
                  ),
            const SizedBox(height: 16.0),
            if (isLoading) const CircularProgressIndicator(),
            if (!isLoading && links.isEmpty) const Text('No links found.'),
            if (!isLoading && links.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: links
                        .map((link) => ImagePreview(imageUrl: link))
                        .toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
