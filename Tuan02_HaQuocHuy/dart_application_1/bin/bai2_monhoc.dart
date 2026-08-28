import 'dart:io';

abstract class MonHoc {
  String maMH;
  String tenMH;
  int soTC;

  MonHoc(this.maMH, this.tenMH, this.soTC);

  double get dtb; // Hàm get trừu tượng

  String get diemChu {
    if (dtb >= 8.5) return 'A';
    if (dtb >= 7.0) return 'B';
    if (dtb >= 5.5) return 'C';
    if (dtb >= 4.0) return 'D';
    return 'F';
  }

  @override
  String toString() => 'Mã: $maMH \t Tên: $tenMH \t TC: $soTC \t ĐTB: ${dtb.toStringAsFixed(2)} \t Điểm chữ: $diemChu';
}

class LyThuyet extends MonHoc {
  double diemTieuLuan, diemCuoiKy;
  LyThuyet(String ma, String ten, int tc, this.diemTieuLuan, this.diemCuoiKy) : super(ma, ten, tc);
  @override double get dtb => diemTieuLuan * 0.3 + diemCuoiKy * 0.7;
}

class ThucHanh extends MonHoc {
  double kt1, kt2, kt3;
  ThucHanh(String ma, String ten, int tc, this.kt1, this.kt2, this.kt3) : super(ma, ten, tc);
  @override double get dtb => (kt1 + kt2 + kt3) / 3;
}

class DoAn extends MonHoc {
  double diemGVHD, diemGVPB;
  DoAn(String ma, String ten, int tc, this.diemGVHD, this.diemGVPB) : super(ma, ten, tc);
  @override double get dtb => (diemGVHD + diemGVPB) / 2;
}

void main() async {
  List<MonHoc> dsMH = [];

  // Đọc danh sách từ file (Thay thế cho thao tác nhập tay để test nhanh)
  List<String> lines = await File('lib/monhoc.txt').readAsLines();
  for (String line in lines) {
    List<String> p = line.split('#');
    String ma = p[0], ten = p[1], loai = p[3];
    int tc = int.parse(p[2]);

    if (loai == 'LT') dsMH.add(LyThuyet(ma, ten, tc, double.parse(p[4]), double.parse(p[5])));
    if (loai == 'TH') dsMH.add(ThucHanh(ma, ten, tc, double.parse(p[4]), double.parse(p[5]), double.parse(p[6])));
    if (loai == 'DA') dsMH.add(DoAn(ma, ten, tc, double.parse(p[4]), double.parse(p[5])));
  }

  // Xuất danh sách
  print('--- DANH SÁCH MÔN HỌC ---');
  dsMH.forEach(print);

  // Kiểm tra sắp xếp tăng dần theo tên
  bool isSorted = true;
  for (int i = 0; i < dsMH.length - 1; i++) {
    if (dsMH[i].tenMH.compareTo(dsMH[i + 1].tenMH) > 0) {
      isSorted = false; break;
    }
  }
  print('\nDanh sách ĐÃ được sắp xếp theo tên môn học chưa? -> ${isSorted ? "Có" : "Chưa"}');

  // Sắp xếp theo số tín chỉ tăng dần
  dsMH.sort((a, b) => a.soTC.compareTo(b.soTC));
  print('\n--- DANH SÁCH SAU KHI SẮP XẾP TÍN CHỈ TĂNG DẦN ---');
  dsMH.forEach(print);

  // Môn học có tín chỉ cao nhất
  int maxTC = dsMH.map((m) => m.soTC).reduce((a, b) => a > b ? a : b);
  print('\n--- MÔN HỌC CÓ TÍN CHỈ CAO NHẤT ($maxTC) ---');
  dsMH.where((m) => m.soTC == maxTC).forEach(print);

  // Tìm môn học theo tên
  String searchName = "Tri tue nhan tao"; // Bạn có thể dùng stdin.readLineSync() nếu làm dạng CLI
  print('\n--- TÌM MÔN HỌC: "$searchName" ---');
  var found = dsMH.where((m) => m.tenMH.toLowerCase() == searchName.toLowerCase()).toList();
  if (found.isNotEmpty) {
    found.forEach(print);
  } else {
    print('Không tìm thấy môn $searchName. (Code thêm mới nếu cần vào dsMH)');
  }

  // Tín chỉ trung bình
  double avgTC = dsMH.fold(0, (sum, m) => sum + m.soTC) / dsMH.length;
  print('\n--- TÍN CHỈ TRUNG BÌNH: ${avgTC.toStringAsFixed(2)} ---');
}