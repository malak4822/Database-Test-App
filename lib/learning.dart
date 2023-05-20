void main() {
  String question = '';
  String question1 = "Podaj imię i nazwisko";
  String question2 = "Ile to jest 7 dodać 9 ?";
  String question3 = "Ile to jest 2 dodać 4 ?";
  String question4 = "Ile to jest 2 razy 9 ?";
  String question5 = "Ile to jest 18 podzielić na 9 ?";

  askQuestion(String quest) {
    return print(quest);
  }

  int i = 1;
  while (i < 5) {
    askQuestion(question + i.toString());
    ++i;
  }

  // String imie = stdin.readLineSync() ?? "Brak";

  // int odp1 = int.parse(stdin.readLineSync() ?? '');
  // int odp2 = int.parse(stdin.readLineSync() ?? '');
  // int odp3 = int.parse(stdin.readLineSync() ?? '');
  // int odp4 = int.parse(stdin.readLineSync() ?? '');
}
