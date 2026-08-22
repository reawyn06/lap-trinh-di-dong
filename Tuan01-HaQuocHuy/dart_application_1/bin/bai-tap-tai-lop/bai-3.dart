import 'dart:io';
import 'dart:math';

bool isPrime(int n) {
  if (n < 2) return false;
  for (int i = 2; i <= sqrt(n); i++) {
    if (n % i == 0) return false;
  }
  return true;
}

void main() {
  stdout.write('Nhập các số nguyên (cách nhau bởi khoảng trắng): ');
  String line = stdin.readLineSync()!;
  List<int> lst = line.split(' ').map((e) => int.parse(e)).toList();

  // a. Xuất danh sách
  print('a. Danh sách vừa nhập: $lst');

  // b. Tính tổng các phần tử
  int tong = lst.fold(0, (sum, item) => sum + item);
  print('b. Tổng các phần tử: $tong');

  // c. Xuất các số nguyên tố
  List<int> listPrime = lst.where((e) => isPrime(e)).toList();
  print('c. Các số nguyên tố: $listPrime');

  // d. Tìm hoặc thêm giá trị
  stdout.write('d. Nhập giá trị bất kỳ: ');
  int val = int.parse(stdin.readLineSync()!);

  if (lst.contains(val)) {
    List<int> viTri = [];
    for (int i = 0; i < lst.length; i++) {
      if (lst[i] == val) viTri.add(i);
    }
    print('Giá trị $val có trong danh sách tại vị trí index: $viTri');
  } else {
    lst.insert(0, val);
    print('Không có $val trong danh sách. Đã thêm vào đầu: $lst');
  }
}