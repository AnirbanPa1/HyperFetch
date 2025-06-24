import 'package:flutter/material.dart';
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
    setState(() => isLoading = true);
    final url = _urlController.text.trim();
    links = await LinkParserService.extractLinks(url);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(title: const Text('HyperFetch')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Enter URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: isLoading ? null : fetchLinks,
              child: Text(isLoading ? 'Fetching...' : 'Fetch Links'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: links.isEmpty
                  ? const Center(child: Text('No links yet.'))
                  : ListView.builder(
                      itemCount: links.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            links[index],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const Icon(Icons.download),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
