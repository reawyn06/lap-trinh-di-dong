import 'dart:io';

// Lớp cha trừu tượng
abstract class PhongThue {
  String maPhong;
  int soNguoi;
  double soDien, soNuoc;

  PhongThue(this.maPhong, this.soNguoi, this.soDien, this.soNuoc);

  double tinhTien(); // Phương thức trừu tượng

  @override
  String toString() =>
      'Mã: $maPhong \t Người: $soNguoi \t Điện: $soDien \t Nước: $soNuoc \t Tiền: ${tinhTien()}';
}

// Lớp Phòng Loại A
class PhongLoaiA extends PhongThue {
  int soNguoiThan;

  PhongLoaiA(String ma, int nguoi, double dien, double nuoc, this.soNguoiThan)
      : super(ma, nguoi, dien, nuoc);

  @override
  double tinhTien() => 1400 + 2 * soDien + 8 * soNuoc + 50 * soNguoiThan;

  @override
  String toString() => super.toString() + ' \t Khách thăm: $soNguoiThan (Loại A)';
}

// Lớp Phòng Loại B
class PhongLoaiB extends PhongThue {
  double giatUi;
  int soMay;

  PhongLoaiB(String ma, int nguoi, double dien, double nuoc, this.giatUi, this.soMay)
      : super(ma, nguoi, dien, nuoc);

  @override
  double tinhTien() => 2000 + 2 * soDien + 8 * soNuoc + giatUi * 5 + soMay * 100;

  @override
  String toString() => super.toString() + ' \t Giặt: $giatUi \t Máy tính: $soMay (Loại B)';
}

void main() async {
  List<PhongThue> dsPhong = [];

  // Đọc file phongthue.txt
  try {
    List<String> lines = await File('lib/phongthue.txt').readAsLines();
    for (String line in lines) {
      List<String> p = line.split('#');
      if (p.isNotEmpty) {
        String ma = p[0].trim();
        int nguoi = int.parse(p[1]);
        double dien = double.parse(p[2]);
        double nuoc = double.parse(p[3]);

        if (ma.startsWith('A')) {
          dsPhong.add(PhongLoaiA(ma, nguoi, dien, nuoc, int.parse(p[4])));
        } else if (ma.startsWith('B')) {
          dsPhong.add(PhongLoaiB(ma, nguoi, dien, nuoc, double.parse(p[4]), int.parse(p[5])));
        }
      }
    }
  } catch (e) {
    print("Lỗi đọc file: $e");
    return;
  }

  // 1. In danh sách phòng
  print('--- DANH SÁCH PHÒNG THUÊ ---');
  dsPhong.forEach(print);

  // 2. Danh sách phòng có số người thuê > 2
  print('\n--- PHÒNG CÓ SỐ NGƯỜI THUÊ > 2 ---');
  dsPhong.where((p) => p.soNguoi > 2).forEach(print);

  // 3. Tổng tiền thu được
  double tongTien = dsPhong.fold(0, (sum, p) => sum + p.tinhTien());
  print('\n--- TỔNG TIỀN PHÒNG THU ĐƯỢC: $tongTien ---');

  // 4. Sắp xếp danh sách giảm dần theo số điện
  dsPhong.sort((a, b) => b.soDien.compareTo(a.soDien));
  print('\n--- DANH SÁCH SẮP XẾP GIẢM DẦN THEO SỐ ĐIỆN ---');
  dsPhong.forEach(print);

  // 5. In danh sách phòng loại A
  print('\n--- DANH SÁCH PHÒNG LOẠI A ---');
  dsPhong.whereType<PhongLoaiA>().forEach(print);
}