import 'package:flutter/material.dart';
import 'package:legaltalk/Screen/screen_home.dart';

class Screen_Privacy extends StatefulWidget {
  const Screen_Privacy({super.key});

  @override
  State<Screen_Privacy> createState() => _Screen_PrivacyState();
}

class _Screen_PrivacyState extends State<Screen_Privacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded,), disabledColor: Colors.white),
        title: Center(
          child: Text("นโยบายความเป็นส่วนตัว",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: ListView(
            children: [
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Container(
                      padding: EdgeInsets.all(16.0),
                    child: Text(
                      "นโยบายความเป็นส่วนตัวและการใช้งานข้อมูล\n\n"
                          "ขอข้อมูลส่วนบุคคล:\n\n"
                          "1.การเก็บข้อมูล: เราจะขอข้อมูลส่วนบุคคลเฉพาะเมื่อมีความจำเป็นสำหรับการให้บริการ และจะไม่ขอข้อมูลที่ไม่จำเป็น\n"
                          "2.ประเภทข้อมูล: เราจะอธิบายประเภทข้อมูลที่เราขอและเหตุผลที่เราต้องการข้อมูลนั้น\n"
                          "3.การใช้ข้อมูล: ข้อมูลที่เราเก็บจะใช้เพื่อปรับปรุงประสิทธิภาพของแอพพลิเคชันเท่านั้น และจะไม่ถูกใช้เพื่อวัตถุประสงค์อื่นๆ ที่ไม่เกี่ยวข้องกับการให้บริการ\n"
                          "4.การเข้าถึงข้อมูล: เรามีมาตรการรักษาความปลอดภัยที่เหมาะสมเพื่อป้องกันการเข้าถึงข้อมูลโดยไม่มีอำนาจ\n"
                          "5.การควบคุมข้อมูล: ผู้ใช้สามารถเข้าถึงและแก้ไขข้อมูลส่วนบุคคลของตนได้ตลอดเวลา\n\n"
                          "ขอใช้งานอุปกรณ์:\n\n"
                          "1.การขออนุญาต: เราจะขออนุญาตจากผู้ใช้ก่อนที่จะเข้าถึงฟังก์ชันหรืออุปกรณ์บนโทรศัพท์ เช่น กล้องหรือไมโครโฟน\n"
                          "2.การใช้งาน: แอพพลิเคชันจะใช้อุปกรณ์ของผู้ใช้เฉพาะเพื่อวัตถุประสงค์ที่เกี่ยวข้องกับการให้บริการแอพพลิเคชันเท่านั้น\n"
                          "3.การควบคุม: ผู้ใช้สามารถตั้งค่าสิทธิ์การเข้าถึงอุปกรณ์ในแอพพลิเคชันได้ผ่านการตั้งค่าส่วนตัว\n"
                          "เรามุ่งมั่นที่จะให้บริการแอพพลิเคชันที่มีความปลอดภัยและเชื่อถือได้ และยินดีที่จะตอบสนองต่อคำถามหรือข้อเสนอแนะเกี่ยวกับนโยบายความเป็นส่วนตัวและกฎหมายที่เกี่ยวข้องในแอพพลิเคชันของเรา",
                      style: TextStyle(fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
