import 'dart:math';

class MockNLPService {
  // --- Word Operations ---

  String pluralize(String word) {
    final lowerWord = word.toLowerCase();
    
    // Mock check for noun/pronoun
    if (!_isNounOrPronoun(lowerWord)) {
      return "Only be done on nouns";
    }

    // Simple pluralization rules for demo
    if (lowerWord.endsWith('s') || lowerWord.endsWith('x') || lowerWord.endsWith('z') || lowerWord.endsWith('ch') || lowerWord.endsWith('sh')) {
      return '${word}es';
    } else if (lowerWord.endsWith('y') && !['a','e','i','o','u'].contains(lowerWord[lowerWord.length-2])) {
      return '${word.substring(0, word.length - 1)}ies';
    } else {
      return '${word}s';
    }
  }

  String singularize(String word) {
    final lowerWord = word.toLowerCase();

    // Mock check for noun/pronoun
    if (!_isNounOrPronoun(lowerWord)) {
      return "Only be done on nouns";
    }

    // Simple singularization rules for demo
    if (lowerWord.endsWith('ies')) {
      return '${word.substring(0, word.length - 3)}y';
    } else if (lowerWord.endsWith('es') && (lowerWord.length > 3)) {
       // Very basic check, fails for 'types' -> 'typ' but works for 'boxes' -> 'box'
       // Improving slightly for demo:
       if (lowerWord.endsWith('ches') || lowerWord.endsWith('shes') || lowerWord.endsWith('xes')) {
         return word.substring(0, word.length - 2);
       }
       // Fallback
       return word.substring(0, word.length - 1);
    } else if (lowerWord.endsWith('s') && !lowerWord.endsWith('ss')) {
      return word.substring(0, word.length - 1);
    }
    return word; // Already singular or unknown rule
  }

  String getWordType(String word) {
    final lowerWord = word.toLowerCase();
    // Mock dictionary
    if (['run', 'jump', 'eat', 'sleep', 'code', 'write'].contains(lowerWord)) return 'Verb';
    if (['apple', 'car', 'house', 'dog', 'cat', 'computer'].contains(lowerWord)) return 'Noun';
    if (['happy', 'sad', 'fast', 'slow', 'red', 'blue'].contains(lowerWord)) return 'Adjective';
    if (['he', 'she', 'it', 'they', 'we'].contains(lowerWord)) return 'Pronoun';
    
    // Default fallback
    return 'Noun (Assumed)'; 
  }

  String getVerbBaseForm(String word) {
    final lowerWord = word.toLowerCase();
    
    // Check if it's a verb (mock)
    if (!_isVerb(lowerWord)) {
      return "Only be done on verbs";
    }

    if (lowerWord.endsWith('ing')) {
      return word.substring(0, word.length - 3);
    } else if (lowerWord.endsWith('ed')) {
      return word.substring(0, word.length - 2);
    } else if (lowerWord.endsWith('s')) {
      return word.substring(0, word.length - 1);
    }
    return word;
  }

  String getDefinition(String word) {
    // Mock definitions
    return "A brief definition for '$word': A unit of language, consisting of one or more spoken sounds or their written representation.";
  }

  String correctSpelling(String word) {
    final lowerWord = word.toLowerCase();
    // Mock corrections
    Map<String, String> corrections = {
      'teh': 'the',
      'wrod': 'word',
      'helo': 'hello',
      'wrld': 'world',
      'fluter': 'flutter',
    };

    if (corrections.containsKey(lowerWord)) {
      return "Did you mean: ${corrections[lowerWord]}?";
    }
    return "Spelling seems correct.";
  }

  // --- Sentence Operations ---

  String classifySentence(String sentence) {
    List<String> words = sentence.split(' ');
    List<String> classified = [];
    
    for (var w in words) {
      String cleanWord = w.replaceAll(RegExp(r'[^\w\s]'), '');
      String type = getWordType(cleanWord);
      classified.add('$cleanWord ($type)');
    }
    return classified.join(', ');
  }

  String analyzeSentiment(String sentence) {
    final lowerSentence = sentence.toLowerCase();
    if (lowerSentence.contains('good') || lowerSentence.contains('happy') || lowerSentence.contains('excellent') || lowerSentence.contains('love')) {
      return 'Positive';
    } else if (lowerSentence.contains('bad') || lowerSentence.contains('sad') || lowerSentence.contains('terrible') || lowerSentence.contains('hate')) {
      return 'Negative';
    }
    return 'Neutral';
  }

  String checkSentenceErrors(String sentence) {
    List<String> words = sentence.split(' ');
    List<String> corrections = [];
    bool foundError = false;

    Map<String, String> commonErrors = {
      'teh': 'the',
      'dont': 'don\'t',
      'cant': 'can\'t',
      'im': 'I\'m',
    };

    for (var w in words) {
      String cleanWord = w.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
      if (commonErrors.containsKey(cleanWord)) {
        corrections.add(commonErrors[cleanWord]!);
        foundError = true;
      } else {
        corrections.add(w);
      }
    }

    if (foundError) {
      return "Corrected sentence: ${corrections.join(' ')}";
    }
    return "Message is correct";
  }

  // --- Paragraph Operations ---

  String summarizeParagraph(String text) {
    // Mock summary: First sentence + "..."
    List<String> sentences = text.split(RegExp(r'[.!?]'));
    if (sentences.isNotEmpty) {
      return "Summary: ${sentences.first.trim()}.";
    }
    return "Text too short to summarize.";
  }

  String extractKeywords(String text) {
    // Mock keywords: words longer than 5 chars
    List<String> words = text.split(RegExp(r'\s+'));
    Set<String> keywords = {};
    for (var w in words) {
      String clean = w.replaceAll(RegExp(r'[^\w]'), '');
      if (clean.length > 5) {
        keywords.add(clean);
      }
    }
    return "Keywords: ${keywords.join(', ')}";
  }

  String countWords(String text) {
    int count = text.trim().split(RegExp(r'\s+')).length;
    return "Word Count: $count words";
  }

  // --- Helpers ---

  bool _isNounOrPronoun(String word) {
    // Mock check
    // In a real app, this would use a dictionary or NLP model
    // For demo, we assume most things are nouns unless we know they are verbs/adj
    if (_isVerb(word)) return false;
    if (['happy', 'sad', 'fast', 'slow'].contains(word)) return false; // Adjectives
    return true; 
  }

  bool _isVerb(String word) {
    // Mock check
    if (word.endsWith('ing') || word.endsWith('ed')) return true;
    if (['run', 'jump', 'eat', 'sleep', 'code', 'write', 'go', 'do', 'make'].contains(word)) return true;
    return false;
  }
}
