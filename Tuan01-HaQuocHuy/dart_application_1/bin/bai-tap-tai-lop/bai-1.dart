import 'dart:io';

void main() {
  stdout.write('Nhập số lượng que kem (>0): ');
  int soLuong = int.parse(stdin.readLineSync()!);

  stdout.write('Nhập giá tiền 1 que kem: ');
  double giaTien = double.parse(stdin.readLineSync()!);

  double tongTien = soLuong * giaTien;
  double thanhTien;

  if (soLuong > 10) {
    thanhTien = tongTien * 0.9; // Giảm 10%
  } else if (soLuong >= 5 && soLuong <= 10) {
    thanhTien = tongTien * 0.95; // Giảm 5%
  } else {
    thanhTien = tongTien;
  }

  print('Số tiền phải trả: ${thanhTien.toStringAsFixed(0)} VNĐ');
}