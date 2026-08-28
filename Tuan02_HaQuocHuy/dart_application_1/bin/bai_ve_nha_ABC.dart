abstract class HoaDon {
  late String _maKH;
  late String _tenKH;
  late int _soLuong;
  late double _giaBan;

  // Khởi tạo mặc định
  HoaDon() {
    _maKH = 'KH0000'; _tenKH = 'Khach Hang'; _soLuong = 1; _giaBan = 1000;
  }

  // Khởi tạo có tham số + Validate
  HoaDon.fullPara(String maKH, String tenKH, int soLuong, double giaBan) {
    this.maKH = maKH;
    this.tenKH = tenKH;
    this.soLuong = soLuong;
    this.giaBan = giaBan;
  }

  // Getters & Setters với Regex Validator
  String get maKH => _maKH;
  set maKH(String value) {
    if (RegExp(r'^KH\d{4}$').hasMatch(value)) _maKH = value;
    else throw Exception('Mã KH không hợp lệ (Phải là KH + 4 chữ số)');
  }
  
  String get tenKH => _tenKH;
  set tenKH(String value) {
    if (value.trim().isNotEmpty) _tenKH = value;
    else throw Exception('Tên KH không được để trống');
  }

  int get soLuong => _soLuong;
  set soLuong(int value) {
    if (value > 0) _soLuong = value;
    else throw Exception('Số lượng phải > 0');
  }

  double get giaBan => _giaBan;
  set giaBan(double value) {
    if (value > 0) _giaBan = value;
    else throw Exception('Giá bán phải > 0');
  }

  // Các phương thức trừu tượng / tính toán chung
  double get thueVAT => 0.1 * (_soLuong * _giaBan);
  double tinhChietKhau();
  double tinhTroGia() => 0; // Trợ giá mặc định (Đại lý cấp 1 không có)
  double tinhThanhTien() => (_soLuong * _giaBan) - tinhChietKhau() + thueVAT;

  @override
  String toString() =>
      '[$_maKH] $_tenKH | SL: $_soLuong | Giá: $_giaBan | VAT: $thueVAT | C.Khấu: ${tinhChietKhau()} | T.Giá: ${tinhTroGia()} | Thành Tiền: ${tinhThanhTien()}';
}

// 1. Khách hàng cá nhân
class KHCauNhan extends HoaDon {
  double khoangCach;

  KHCauNhan.fullPara(String maKH, String tenKH, int soLuong, double giaBan, this.khoangCach)
      : super.fullPara(maKH, tenKH, soLuong, giaBan);

  @override
  double tinhChietKhau() {
    double ck = 0;
    if (soLuong >= 3) ck = soLuong * giaBan * 0.05; // 5% trên đơn giá
    if (khoangCach < 10) ck += soLuong * 50000;
    return ck;
  }

  @override
  double tinhTroGia() {
    double tg = soLuong * giaBan * 0.02; // Trợ giá 2% giá bán mỗi sp
    if (soLuong > 2) tg += 100000;
    return tg;
  }
}

// 2. Đại lý cấp 1
class DaiLy extends HoaDon {
  int namHopTac;

  DaiLy.fullPara(String maKH, String tenKH, int soLuong, double giaBan, this.namHopTac)
      : super.fullPara(maKH, tenKH, soLuong, giaBan);

  @override
  double tinhChietKhau() {
    double phanTram = 0.30;
    if (namHopTac > 5) {
      phanTram += (namHopTac - 5) * 0.01;
      if (phanTram > 0.35) phanTram = 0.35; // Tối đa 35%
    }
    return phanTram * (soLuong * giaBan);
  }
}

// 3. Khách hàng công ty
class KHCongTy extends HoaDon {
  int soNhanVien;

  KHCongTy.fullPara(String maKH, String tenKH, int soLuong, double giaBan, this.soNhanVien)
      : super.fullPara(maKH, tenKH, soLuong, giaBan);

  @override
  double tinhChietKhau() {
    if (soNhanVien > 5000) return 0.07 * (soLuong * giaBan);
    if (soNhanVien > 1000) return 0.05 * (soLuong * giaBan);
    return 0;
  }

  @override
  double tinhTroGia() => soLuong * 120000;
}


void main() {
  List<HoaDon> dsHoaDon = [];

  try {
    dsHoaDon.add(KHCauNhan.fullPara('KH0001', 'Nguyen Van A', 4, 10000000, 8)); // SL>2, KC<10
    dsHoaDon.add(KHCauNhan.fullPara('KH0002', 'Tran Thi B', 2, 8000000, 15));  
    dsHoaDon.add(DaiLy.fullPara('KH0003', 'Dai Ly X', 50, 9500000, 7));       // Nam > 5
    dsHoaDon.add(KHCongTy.fullPara('KH0004', 'Cong ty Y', 15, 12000000, 6000)); // NV > 5000
    // Lỗi validate: dsHoaDon.add(KHCauNhan.fullPara('KHSai', 'Loi', -1, 10, 5)); 
  } catch (e) {
    print("Lỗi tạo hóa đơn: $e");
  }

  // Xuất danh sách
  print('--- DANH SÁCH HÓA ĐƠN ---');
  dsHoaDon.forEach(print);

  // Tổng thành tiền & Trợ giá
  double tongThanhTien = dsHoaDon.fold(0, (sum, hd) => sum + hd.tinhThanhTien());
  double tongTroGia = dsHoaDon.fold(0, (sum, hd) => sum + hd.tinhTroGia());
  print('\nTổng thành tiền tất cả HĐ: $tongThanhTien');
  print('Tổng trợ giá công ty hỗ trợ: $tongTroGia');

  // Khách mua nhiều nhất
  int maxSL = dsHoaDon.map((hd) => hd.soLuong).reduce((a, b) => a > b ? a : b);
  print('\n--- KHÁCH HÀNG MUA NHIỀU NHẤT ($maxSL cái) ---');
  dsHoaDon.where((hd) => hd.soLuong == maxSL).forEach(print);

  // Tổng chiết khấu của KH Công Ty
  double ckCongTy = dsHoaDon.whereType<KHCongTy>().fold(0, (sum, hd) => sum + hd.tinhChietKhau());
  print('\nTổng tiền chiết khấu dành riêng cho KH Công Ty: $ckCongTy');

  // Sắp xếp: Tăng dần theo số lượng -> Giảm dần theo thành tiền
  dsHoaDon.sort((a, b) {
    int cmpSL = a.soLuong.compareTo(b.soLuong);
    if (cmpSL != 0) return cmpSL;
    return b.tinhThanhTien().compareTo(a.tinhThanhTien()); // Nghịch đảo để giảm dần
  });
  print('\n--- DANH SÁCH SẮP XẾP ---');
  dsHoaDon.forEach(print);

  // Tìm hóa đơn mã X
  String maTimKiem = 'KH0004';
  print('\n--- TÌM HÓA ĐƠN MÃ: $maTimKiem ---');
  var hdTimThay = dsHoaDon.where((hd) => hd.maKH == maTimKiem).toList();
  if (hdTimThay.isNotEmpty) {
    hdTimThay.forEach(print);
  } else {
    print('Khách hàng lạ');
  }
}