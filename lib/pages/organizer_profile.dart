import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_frikiteam/model/Organizer.dart';
import 'package:app_flutter_frikiteam/ui/login_page.dart';

class OrganizerProfile extends StatefulWidget {
  const OrganizerProfile({Key? key}) : super(key: key);

  @override
  State<OrganizerProfile> createState() => _OrganizerProfileState();
}

class _OrganizerProfileState extends State<OrganizerProfile> {

  static Organizer organizer = new Organizer("Abel", "Gutierrez", "https://cdn2.rsvponline.mx/files/rsvp/styles/wide/public/images/main/2016/horentrepre.jpg","abelGuti@gmail.com","abcde");
  bool edit=false;
  bool showPassword=false;
  static String emailEdit = organizer.email;
  static String passwordEdit = organizer.password;
  static String nameEdit = organizer.name;
  static String lastNameEdit = organizer.lastName;

  TextEditingController myControllerEmail = TextEditingController(text: emailEdit);
  TextEditingController myControllerPassword = TextEditingController(text: passwordEdit);
  TextEditingController myControllerName = TextEditingController(text: nameEdit);
  TextEditingController myControllerLastName = TextEditingController(text: lastNameEdit);

  void setShowPassword(){
    showPassword=!showPassword;
    setState(() {});
  }

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
                      Navigator.pushNamedAndRemoveUntil(context,'login', ((route) => false));
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
                              image: NetworkImage(organizer.img)
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
              SizedBox(height: 8,),
              Container(
                  child: edit == true ? inputs():
                  Text(nameEdit+" "+lastNameEdit,textAlign: TextAlign.center,style: TextStyle(fontSize: 18),)
              ),
              SizedBox(
                height: 8,
              ),

            ],
          )
      ),
    );
  }
  Widget inputs(){
    return ElasticInLeft(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name:",style: TextStyle(color: Colors.black45,fontSize: 20,)),
          SizedBox(
            height: 8,
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
            height:8,
          ),
          Text("Last Name:",style: TextStyle(color: Colors.black45,fontSize: 20,)),
          SizedBox(
            height: 8,
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
            height: 8,
          ),
          Text("Email:",style: TextStyle(color: Colors.black45,fontSize: 20,)),
          SizedBox(
            height:8,
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
            height: 8,
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
          ),
          SizedBox( height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: (){
                  edit=!edit;
                  setState(() {
                    myControllerEmail=TextEditingController(text: emailEdit);
                    myControllerPassword=TextEditingController(text: passwordEdit);
                    myControllerName=TextEditingController(text: nameEdit);
                    myControllerLastName=TextEditingController(text: lastNameEdit);
                    showPassword=false;
                  });
                },
                child: Text("Cancel",style: TextStyle(
                  fontSize:18,
                  letterSpacing: 2,
                  color: Colors.purple,
                ),),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2,color: Colors.purple),
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  edit=!edit;
                  setState(() {
                    nameEdit=myControllerName.text;
                    lastNameEdit=myControllerLastName.text;
                    emailEdit=myControllerEmail.text;
                    passwordEdit=myControllerPassword.text;
                  });
                },
                child:Text("Save",style: TextStyle(
                  fontSize:18,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}
