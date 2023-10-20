// Challenge goals:
// Using everything we learned, make a Dictionary class with the following methods:

// add: 단어를 추가함.
// get: 단어의 정의를 리턴함.
// delete: 단어를 삭제함.
// update: 단어를 업데이트 함.
// showAll: 사전 단어를 모두 보여줌.
// count: 사전 단어들의 총 갯수를 리턴함.
// upsert 단어를 업데이트 함. 존재하지 않을시. 이를 추가함. (update + insert = upsert)
// exists: 해당 단어가 사전에 존재하는지 여부를 알려줌.
// bulkAdd: 다음과 같은 방식으로. 여러개의 단어를 한번에 추가할 수 있게 해줌. [{"term":"김치", "definition":"대박이네~"}, {"term":"아파트", "definition":"비싸네~"}]
// bulkDelete: 다음과 같은 방식으로. 여러개의 단어를 한번에 삭제할 수 있게 해줌. ["김치", "아파트"]

// Requirements:
// Use class
// Use typedefs
// Use List
// Use Map

// https://replit.com/@hin6150/Flutter01#main.dart

void main() {
  var dictionary = Dictionary();
  // Shell -> dart run --enable-asserts main.dart

  // Test add and get
  dictionary.add(term: 'test', definition: '테스트');
  assert(dictionary.get('test') == '테스트');

  // Test non-existing word with exists
  assert(dictionary.exists('nonexistent') == false);

  // Test bulkAdd and exists
  dictionary.bulkAdd([
    {'term': 'term1', 'definition': 'definition1'},
    {'term': 'term2', 'definition': 'definition2'},
  ]);
  assert(dictionary.exists('term1') == true);
  assert(dictionary.exists('term2') == true);

  // Test delete
  dictionary.delete('test');
  assert(dictionary.get('test') == '존재하지 않음');

  // Test count
  assert(dictionary.count() == 2);

  // Test update
  dictionary.update(term: 'term1', definition: '업데이트된 definition1');
  assert(dictionary.get('term1') == '업데이트된 definition1');

  // Test upsert
  dictionary.upsert(term: 'term1', definition: '다시 업데이트');
  assert(dictionary.get('term1') == '다시 업데이트');

  // Test bulkDelete
  dictionary.bulkDelete(['term1', 'term2']);
  assert(dictionary.count() == 0);

  // Test showAll
  dictionary.bulkAdd([
    {'term': 'term1', 'definition': 'definition1'},
    {'term': 'term2', 'definition': 'definition2'},
  ]);
  dictionary.showAll(); // 출력: [{term1: definition1}, {term2: definition2}]
}

typedef DictionaryType =  Map<String, String>;

class Dictionary implements DictionaryMethods {

  List<DictionaryType> dictionary = [];

  
  @override
  void add({required String term, required String definition}) {
    exists(term) ? print('추가 실패') : dictionary.add({term: definition});
  }


  @override
  void bulkAdd(List<DictionaryType> words) {
    words.forEach((word) {
      add(term: word["term"].toString(), definition: word["definition"].toString());
    });
  }

  @override
  void bulkDelete(List<String> words) {
    words.forEach((word) {
      delete(word);
    });
  }

  @override
  int count() {
    return dictionary.length;
  }

  @override
  void delete(String word) {
    dictionary.removeWhere((map) => map.containsKey(word));
  }

  @override
  bool exists(String word) {
    return dictionary.any((map) => map.containsKey(word));
  }

  @override
  String get(String word) {
      DictionaryType findedValue = dictionary.firstWhere((map) => map.containsKey(word), orElse: () => {});
      return findedValue.isNotEmpty ? findedValue[word].toString() : '존재하지 않음';
    }

  @override
 void showAll() {
    print(dictionary);
  }

  @override
  void update({required String term, required String definition}) {
    DictionaryType findedValue = dictionary.firstWhere((map) => map.containsKey(term), orElse: () => {});
    if(findedValue.isNotEmpty){
      findedValue[term] = definition;
    } else {
      print('업데이트 실패');
    }
  }

  @override
  void upsert({required String term, required String definition}) {
    DictionaryType findedValue = dictionary.firstWhere((map) => map.containsKey(term), orElse: () => {});
    if(findedValue.isNotEmpty){
      findedValue[term] = definition;
    } else {
      add(term: term, definition: definition);
    }
  }
}

abstract class DictionaryMethods {
  void add({required String term, required String definition});
  void bulkAdd(List<DictionaryType> words);
  void bulkDelete(List<String> words);
  int count();
  void delete(String word);
  bool exists(String word);
  String get(String word);
  void showAll();
  void update({required String term, required String definition});
  void upsert({required String term, required String definition});
}
