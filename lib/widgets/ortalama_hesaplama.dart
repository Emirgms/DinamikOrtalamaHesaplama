import 'package:dinamik_ortalama_hesaplama/constants/app_constants.dart';
import 'package:dinamik_ortalama_hesaplama/helper/data_helper.dart';
import 'package:dinamik_ortalama_hesaplama/model/ders.dart';
import 'package:dinamik_ortalama_hesaplama/widgets/ders_listesi.dart';
import 'package:dinamik_ortalama_hesaplama/widgets/ortalama_goster.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplamaPage extends StatefulWidget {

  const OrtalamaHesaplamaPage({ Key? key}) : super(key: key);

  @override
  _OrtalamaHesaplamaPageState createState() => _OrtalamaHesaplamaPageState();
}

class _OrtalamaHesaplamaPageState extends State<OrtalamaHesaplamaPage> {
   var FormKey =GlobalKey<FormState>();
   double secilenHarfDegeri=4;
   double secilenKrediDegeri=1;
   String girilenDersAdi='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
      title: Center(
        child: Text(Sabitler.baslikText,style:Sabitler.baslikStyle,)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
         children: [
           Row(
             children: [
               Expanded(
                 flex: 2,
                 child: _buildForm(),
               ),
               Expanded(
                 flex: 1,
                 child:OrtalamaGoster(dersSayisi:DataHelper.tumEklenenDersler.length ,ortalama: DataHelper.ortalamaHesapla(),)
               )
             ],
           ),
           Expanded(
             child: DersListesi(
               onDismiss:(index) {
                 setState(() {
                   DataHelper.tumEklenenDersler.removeAt(index);
                 });
               },
             ),
             ),

         ],
      ),

    );
  }

   Widget _buildForm() {
    
    return Form(
     key: FormKey,
        child:
      Column(
        children: [
          Padding(padding:Sabitler.yatayPadding8,child:_buildTextFormField(),),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(padding:Sabitler.yatayPadding8,child:  _buildHarfler(),),
              Padding(padding: Sabitler.yatayPadding8,child: _buildKrediler(),),
              IconButton(
                  onPressed:_dersEkleVeOrtalamaHesapla,
                  icon:Icon(Icons.arrow_forward_ios_sharp),
                color: Sabitler.anaRenk,
                iconSize: 30,

              )
            ],
          )
        ],
      ));
   }

  _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
       setState(() {
         girilenDersAdi=deger!;

       });
      },
      validator: (s){
        if(s!.length<=0) {
          return 'Ders Giriniz';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Matematik',
        border: OutlineInputBorder(
          borderRadius:Sabitler.borderRadius,
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Sabitler.anaRenk.shade100.withOpacity(0.2),
      ),
    );
  }

    _buildHarfler() {
    return Container(
      alignment: Alignment.center,
      padding:Sabitler.dropDownPadding,
      decoration: BoxDecoration(
          borderRadius:Sabitler.borderRadius,
          color: Sabitler.anaRenk.shade100.withOpacity(0.3)
      ),
      child: DropdownButton<double>(
        value: secilenHarfDegeri,
        onChanged: (deger) {
          setState(() {
            secilenHarfDegeri=deger!;

          });

        },
        underline: Container(),
        items: DataHelper.tumDerslerinHarfleri(),

      ),
    );
      }
    _buildKrediler() {
     return Container(
       alignment: Alignment.center,
       padding:Sabitler.dropDownPadding,
       decoration: BoxDecoration(
           borderRadius:Sabitler.borderRadius,
           color: Sabitler.anaRenk.shade100.withOpacity(0.3)
       ),
       child: DropdownButton<double>(
         value: secilenKrediDegeri,
         onChanged: (deger) {
           setState(() {
             secilenKrediDegeri=deger!;

           });

         },
         underline: Container(),
         items: DataHelper.tumDerslerinKredileri(),

       ),
     );
   }

   void _dersEkleVeOrtalamaHesapla() {
    if(FormKey.currentState!.validate()) {
      FormKey.currentState!.save();
      var eklenecekDers = Ders(ad:girilenDersAdi , harfDegeri:secilenHarfDegeri, krediDegeri: secilenKrediDegeri);
      DataHelper.dersEkle(eklenecekDers);
      print(DataHelper.ortalamaHesapla());
      setState(() {

      });
    }

  }

}
