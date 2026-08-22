import 'dart:io';

void main() {
  // a. Nhập và xuất chuỗi
  stdout.write('a. Nhập vào 1 chuỗi: ');
  String s = stdin.readLineSync()!;
  print('Chuỗi vừa nhập: $s');

  // b. Đếm kí tự nguyên âm
  String vowels = 'aeiouAEIOUáàảãạăắằẳẵặâấầẩẫậéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵ';
  int countVowels = 0;
  for (int i = 0; i < s.length; i++) {
    if (vowels.contains(s[i])) {
      countVowels++;
    }
  }
  print('b. Số kí tự nguyên âm: $countVowels');

  // c. Đếm số từ
  List<String> words = s.trim().split(RegExp(r'\s+'));
  int wordCount = (s.trim().isEmpty) ? 0 : words.length;
  print('c. Số từ trong chuỗi: $wordCount');

  // d. Kiểm tra chuỗi đối xứng
  String sClean = s.replaceAll(' ', '').toLowerCase();
  String sReversed = sClean.split('').reversed.join('');
  print('d. Chuỗi có đối xứng không: ${sClean == sReversed ? "Có" : "Không"}');

  // e. Đảo ngược từ trong chuỗi
  String reversedWords = words.reversed.join(' ');
  print('e. Đảo ngược từ: $reversedWords');
}