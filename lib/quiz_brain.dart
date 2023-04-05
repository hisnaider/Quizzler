import "questions.dart";

class QuizBrain {
  int _currentQuestion = 0;
  final List<Question> _questionList = [
    Question('A Terra é plana.', false),
    Question('O Sol é uma estrela.', true),
    Question('A água ferve a 100 graus Celsius.', true),
    Question('O Brasil tem 26 estados e um Distrito Federal.', false),
    Question('O código de área do Brasil é +55.', true),
    Question('Os humanos têm 3 pulmões.', false),
    Question('O alfabeto inglês tem 26 letras.', true),
    Question('A Lua é maior que o Sol.', false),
    Question('A Grande Muralha da China é visível do espaço.', false),
    Question('O maior planeta do Sistema Solar é Saturno.', false),
    Question('A água é uma substância composta.', false),
    Question('O tempo é medido em segundos.', true),
    Question('O ponto de ebulição do etanol é maior que o da água.', false),
    Question('A capital da Rússia é Moscou.', true),
    Question('A gravidade é uma força repulsiva.', false),
    Question(
        'O livro "O Senhor dos Anéis" foi escrito por J.K. Rowling.', false),
    Question(
        'O número de átomos em uma molécula é dado pela constante de Avogadro.',
        true),
  ];

  void restartQuiz() {
    _currentQuestion = 0;
  }

  bool nextQuestion() {
    if (_currentQuestion < _questionList.length - 1) {
      _currentQuestion++;
      return true;
    }
    return false;
  }

  bool getAnswer(value) {
    if (value == _questionList[_currentQuestion].answer) return true;
    return false;
  }

  String getQuestion() {
    return _questionList[_currentQuestion].text;
  }

  int getQuestionLenght() {
    return _questionList.length;
  }
}
