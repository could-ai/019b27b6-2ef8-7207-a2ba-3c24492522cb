import 'package:flutter/material.dart';
import '../services/mock_nlp_service.dart';

class ParagraphScreen extends StatefulWidget {
  const ParagraphScreen({super.key});

  @override
  State<ParagraphScreen> createState() => _ParagraphScreenState();
}

class _ParagraphScreenState extends State<ParagraphScreen> {
  final TextEditingController _inputController = TextEditingController();
  final MockNLPService _nlpService = MockNLPService();
  String _output = '';
  String _selectedOption = 'Sentiment';

  final List<String> _options = [
    'Sentiment',
    'Part of Speech',
    'Correct Spelling',
  ];

  void _processParagraph() {
    final text = _inputController.text.trim();
    if (text.isEmpty) {
      setState(() {
        _output = 'Please enter a paragraph.';
      });
      return;
    }

    String result = '';
    switch (_selectedOption) {
      case 'Sentiment':
        result = _nlpService.analyzeParagraphSentiment(text);
        break;
      case 'Part of Speech':
        result = _nlpService.classifyParagraphPOS(text);
        break;
      case 'Correct Spelling':
        result = _nlpService.correctParagraphSpelling(text);
        break;
    }

    setState(() {
      _output = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paragraph Analysis'),
        backgroundColor: Colors.orange.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter a paragraph:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _inputController,
              maxLines: 8,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Paste your paragraph text here...',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Operation:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedOption,
                  isExpanded: true,
                  items: _options.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedOption = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _processParagraph,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Analyze Paragraph'),
            ),
            const SizedBox(height: 30),
            const Text(
              'Result:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _output.isEmpty ? 'Result will appear here' : _output,
                style: TextStyle(
                  fontSize: 16,
                  color: _output.isEmpty ? Colors.grey : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
