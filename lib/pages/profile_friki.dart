import 'package:app_flutter_frikiteam/ui/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_frikiteam/model/Friki.dart';
import 'package:app_flutter_frikiteam/model/Organizer.dart';
class ProfileFriki extends StatefulWidget {
  const ProfileFriki({Key? key}) : super(key: key);
  @override
  State<ProfileFriki> createState() => _ProfileFrikiState();
}

class _ProfileFrikiState extends State<ProfileFriki> {
  static Friki friki=new Friki("Renzo", "Romero", "https://t2.pb.ltmcdn.com/es/posts/3/0/1/como_saber_si_le_gustas_a_una_persona_por_whatsapp_5103_orig.jpg","sergiogg1259@gmail.com","123456789");
  bool edit=false;
  bool showPassword=false;
  static String emailEdit=friki.email;
  static String passwordEdit=friki.password;
  static String nameEdit=friki.name;
  static String lastNameEdit=friki.lastName;
  static List<Organizer> organizers=[
    Organizer("Luis","García","https://lamenteesmaravillosa.com/wp-content/uploads/2018/09/hombre-creido-pensando-que-sabe.jpg","luis@gmail.com","luisito"),
    Organizer("Maria","Lara","https://img.freepik.com/foto-gratis/retrato-hermoso-mujer-joven-posicion-pared-gris_231208-10760.jpg?w=2000","maria@gmail.com","maria123"),
    Organizer("Luciana","Herrera","https://portal.andina.pe/EDPfotografia3/Thumbnail/2022/03/08/000851626W.jpg","lucia@gmail.com","lucia789"),
    Organizer("Diego","Rogriguez","https://st2.depositphotos.com/2931363/6511/i/600/depositphotos_65116237-stock-photo-happy-young-man-in-shirt.jpg","diego@gmail.com","diego789"),
  ];
  void setShowPassword(){
    showPassword=!showPassword;
    setState(() {});
  }
  TextEditingController myControllerEmail = TextEditingController(text: emailEdit);
  TextEditingController myControllerPassword = TextEditingController(text: passwordEdit);
  TextEditingController myControllerName = TextEditingController(text: nameEdit);
  TextEditingController myControllerLastName = TextEditingController(text: lastNameEdit);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 5,bottom: 12,left: 10,right: 10),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(right: 10),
              alignment: Alignment.topRight,
        /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> const MainFriki())
        );*/
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> const LoginPage())
                  );
                },
                child: Icon(Icons.exit_to_app,color: Colors.red,size: 35,),
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 5,bottom: 2),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.3,
                    height: MediaQuery.of(context).size.width*0.3,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4,color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2.0,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.2),
                        )
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(friki.img)
                      )
                    ),
                    alignment: Alignment.center,
                  ),
                  Positioned(bottom: 0,right: 0,child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 4,
                        color: Colors.white
                      ),
                      color: Colors.blue,
                    ),
                    child: GestureDetector(
                      child:Icon(Icons.edit,color: Colors.white,),
                      onTap: (){
                        edit=!edit;
                        setState(() {
                          myControllerEmail=TextEditingController(text: emailEdit);
                          myControllerPassword=TextEditingController(text: passwordEdit);
                          myControllerName=TextEditingController(text: nameEdit);
                          myControllerLastName=TextEditingController(text: lastNameEdit);
                          showPassword=false;
                        });
                      },
                    )
                  )),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child:edit==true?inputs():
              Text(friki.name+" "+friki.lastName,textAlign: TextAlign.center,style: TextStyle(fontSize: 18),)
            ),
            SizedBox(height: 20,),
            Text("Organizadores Seguidos", style: TextStyle(color: Colors.purple,
                fontSize: 25.0,
                fontWeight: FontWeight.bold)),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.15,
              color:Colors.purple,
              padding: EdgeInsets.only(top: 5,bottom: 5),
              child: ListView.builder(
                scrollDirection : Axis . horizontal ,
                itemBuilder: (context,index){
                  final _organizer=organizers[index];
                  return imageOrganizer(_organizer.img);
                },
                itemCount: organizers.length,
              ),
            ),
          ],
        )
      ),
    );
  }
  Widget inputs(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Name:",style: TextStyle(color: Colors.black45,fontSize: 20,)),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xFFC6C6C6),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(0,2),
              )]
          ),
          height: 50,
          child: TextField(
            keyboardType: TextInputType.name,
            controller: myControllerName,
            cursorColor: Colors.purple,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(Icons.account_circle,color: Colors.purple),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Last Name:",style: TextStyle(color: Colors.black45,fontSize: 20,)),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xFFC6C6C6),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(0,2),
              )]
          ),
          height: 50,
          child: TextField(
            keyboardType: TextInputType.name,
            controller: myControllerLastName,
            cursorColor: Colors.purple,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(Icons.account_circle,color: Colors.purple),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Email:",style: TextStyle(color: Colors.black45,fontSize: 20,)),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFFC6C6C6),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0,2),
            )]
          ),
          height: 50,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: myControllerEmail,
            cursorColor: Colors.purple,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(Icons.email,color: Colors.purple),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Contraseña:",style: TextStyle(color: Colors.black45,fontSize: 20,)),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Color(0xFFC6C6C6),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(0,2),
              )]
          ),
          height: 50,
          child: TextField(
            obscureText: !showPassword,
            keyboardType: TextInputType.visiblePassword,
            enableSuggestions: false,
            autocorrect: false,
            controller: myControllerPassword,
            cursorColor: Colors.purple,
            style: TextStyle(color: Colors.black),
            decoration:InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top:14),
              prefixIcon: Icon(Icons.lock,color: Colors.purple),
              suffixIcon: IconButton(
                icon: !showPassword?Icon(Icons.visibility_off):Icon(Icons.visibility),
                onPressed:setShowPassword,
              )
            ),
          ),
        )
      ],
    );
  }
}
class imageOrganizer extends StatelessWidget {
  final String img;
  const imageOrganizer(this.img,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height:50,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(img)
          )
      ),
    );
  }
}
