import 'dart:io';

void main() {
  String input = '';
  int n = 0;

  do {
    stdout.write('Nhập số nguyên dương > 10: ');
    input = stdin.readLineSync()!;
    n = int.tryParse(input) ?? 0;
  } while (n <= 10);

  // a. Đếm số chữ số
  print('a. Số chữ số: ${input.length}');

  // b. Tính tổng các chữ số
  int tongCS = 0;
  for (int i = 0; i < input.length; i++) {
    tongCS += int.parse(input[i]);
  }
  print('b. Tổng các chữ số: $tongCS');

  // c. Kiểm tra chữ số lẻ
  bool coSoLe = false;
  for (int i = 0; i < input.length; i++) {
    if (int.parse(input[i]) % 2 != 0) {
      coSoLe = true;
      break;
    }
  }
  print('c. Có chứa chữ số lẻ không: ${coSoLe ? "Có" : "Không"}');
}