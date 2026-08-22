import 'dart:io';
import 'dart:math';

void main() {
  Random random = Random();
  int nElements = 10;
  List<int> lst = List.generate(nElements, (_) => random.nextInt(96) + 5);

  // a. Xuất danh sách
  print('a. Danh sách ngẫu nhiên: $lst');

  // b. TBC các số lẻ
  List<int> soLe = lst.where((x) => x % 2 != 0).toList();
  if (soLe.isNotEmpty) {
    double tbc = soLe.fold(0, (sum, x) => sum + x) / soLe.length;
    print('b. Trung bình cộng các số lẻ: $tbc');
  } else {
    print('b. Danh sách không có số lẻ.');
  }

  // c. Kiểm tra đối xứng
  List<int> reversedLst = lst.reversed.toList();
  bool isSymmetric = true;
  for (int i = 0; i < lst.length; i++) {
    if (lst[i] != reversedLst[i]) {
      isSymmetric = false;
      break;
    }
  }
  print('c. Danh sách có đối xứng không: ${isSymmetric ? "Có" : "Không"}');

  // d. Kiểm tra sắp xếp tăng dần
  bool isSorted = true;
  for (int i = 0; i < lst.length - 1; i++) {
    if (lst[i] > lst[i + 1]) {
      isSorted = false;
      break;
    }
  }
  print('d. Danh sách có sắp xếp tăng dần không: ${isSorted ? "Có" : "Không"}');

  // e. Tìm phần tử lớn nhất
  int maxVal = lst.reduce(max);
  print('e. Phần tử lớn nhất: $maxVal');

  // f. Tìm số chẵn lớn nhất
  List<int> soChan = lst.where((x) => x % 2 == 0).toList();
  if (soChan.isNotEmpty) {
    print('f. Số chẵn lớn nhất: ${soChan.reduce(max)}');
  } else {
    print('f. Danh sách không có số chẵn.');
  }

  // g. Tìm và xóa giá trị
  stdout.write('g. Nhập một giá trị cần tìm: ');
  int val = int.parse(stdin.readLineSync()!);
  if (lst.contains(val)) {
    lst.removeWhere((x) => x == val);
    print('Đã xóa các phần tử bằng $val. Danh sách mới: $lst');
  } else {
    print('Không tìm thấy.');
  }
}