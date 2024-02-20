import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Screen_News extends StatefulWidget {
  const Screen_News({super.key});

  @override
  State<Screen_News> createState() => _Screen_NewsState();
}

Future<void> _launchURL(String url) async {
  final Uri uri = Uri(scheme: "http", host: url);  // แก้ไข URL ตามที่คุณต้องการ
  if (!await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  )){
    throw 'ไม่สามารถเปิดลิงก์ได้: $url';
  }
}



class _Screen_NewsState extends State<Screen_News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(''),
              Text('ข่าว')
            ],
          )
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Text('หมวดหมู่'),
              ),
            ],
          ),
          GestureDetector(
            onTap: (){
              _launchURL('https://www.thaipbs.or.th/news/content/336976');
            },
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Image.network('https://obs.line-scdn.net/0hrEIRTsEQLWp0Kz_40RZSPUx9IRtHTTdjVhljDAQjIwpZBz4-H01-CVcrdEZRTj5oVE5qXFkqJlheT2I6Tg/w1200',
                      width: 90,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text('ช็อกสาวทิ้งบ้านร้าง30ปี เจอเพื่อนบ้านยึดเปิดบริษัท สั่งย้ายเจอเรียกค่าต่อเติม'),
                    subtitle: Text('นางสาวอาย อายุ 27 ปี แฟนสาวของหลานเจ้าของบ้าน ร้องเรียน ช่อง 8 หลังซื้อบ้านเมื่อปี 2534 ต่อมาทิ้งร้างไว้ 30 ปี ล่าสุดวันที่ 1 ก.ย.66 ญาติแฟนหนุ่ม ให้ตนและแฟนหนุ่มเข้าไปดูที่บ้านพักที่ได้ซื้อไว้เพื่อจะทำการรีโนเวตเป็นของขวัญการใช้ชีวิตคู่ระหว่างตนและแฟนหนุ่ม'),
                  ),
                  ListTile(
                    leading: Image.network('https://obs.line-scdn.net/0hvd2xK4TYKUsPATqXbrhWHDdXJTo8ZzNCLW9uKX1UJShwLWkVNG56KCoIJWdyOD0VLzBieHkHJC5wOW5ONQ/w644',
                      width: 90,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text('สมศักดิ์”ไม่ใช่เซียนกฎหมายไม่ขอทำนายอนาคตก้าวไกล'),
                    subtitle: Text('นายสมศักดิ์ เทพสุทิน รองนายกรัฐมนตรี ให้สัมภาษณ์ถึงคำวินิจฉัยของศาลรัฐธรรมนูญกรณีพรรคก้าวไกลนำมาตรา 112 มาหาเสียง จะส่งผลต่อกระทบต่อการเมืองหรือไม่'),
                  ),
                ],

              ),
            ),

          )
        ],
      ),
    );
  }
}