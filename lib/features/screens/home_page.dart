import 'package:crud_riverpod/Providers/firebase_provider.dart';
import 'package:crud_riverpod/features/controller/idCreatController/creatController.dart';
import 'package:crud_riverpod/models/detialsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/color_bundel.dart';
import '../rpository/idCreatRepository/idCreatRepository.dart';
import 'creat_page.dart';
import 'editing_page.dart';
import 'info_view.dart';
var h;
var w;
var editIndex;
class Figma extends ConsumerStatefulWidget {
  const Figma({super.key});

  @override
 ConsumerState<Figma> createState() => _FigmaState();
}

class _FigmaState extends ConsumerState<Figma> {


   var information;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.deepPurple,
        title: Text("Alaska"),
        actions: const [
          Icon(Icons.more_horiz_sharp),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(

        padding: const EdgeInsets.only(top: 15,right: 15,left: 15),
        child:Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final getDetails = ref.watch(firebaseDataProvider);
            delete(DetailModel detailModel){
              ref.read(CreateControllerProvider).delete(detailModel);

            }

            return getDetails.when(data: (data) {
              return ListView.builder(
                itemCount: data!.length,

                itemBuilder: (context, index) {

                   information=data[index];
                  // ignore: prefer_const_constructors
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  InfoView(data: data[index],),));
                    },
                    child: Stack(
                        children:[
                          Card(
                            child: ListTile(
                              leading:  CircleAvatar(
                                backgroundImage:NetworkImage(information.imageUrl.toString()),
                              ),
                              title: Text(information.firstName.toString()),
                              subtitle: Text(information.email),
                              trailing:
                              IconButton(
                                onPressed: () {
                                  editIndex=information.id;
                                  print(editIndex);
                                  print(data[index]);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditingPage(datas: data[index],),));
                                },
                                icon: Icon(Icons.edit),

                              ),
                            ),


                          ),
                          SizedBox(width: w*0.5,),
                          Positioned(
                            right: w*0.01,
                            //   left: width*0.08,
                            top: w*0.01,
                            child: Container(
                              height: w*0.1,
                              width: w*0.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color:ColorBundle.themeColor,
                              ),
                              child: Center(
                                child: IconButton(onPressed: () {
                                  showDialog(context: context, builder: (context) =>
                                   AlertDialog(
                                    title: Text("Are You delete sure?"),
                                    backgroundColor: ColorBundle.white,

                                      actions: [
                                        Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                             delete(data[index]);
                                             Navigator.pop(context);

                                            }, child: Text("Yes")),
                                         TextButton(
                                             onPressed: () {
                                               Navigator.pop(context);

                                         }, child: Text("No"))
                                       ],
                                     )

                                    ],

                                  ),
                                  );




                                }, icon: const Icon(Icons.delete,color: ColorBundle.white,)),
                              ),
                            ),
                          ),
                        ]
                    ),
                  );
                },
              );
            }, error: (error, stackTrace) => Center(child: Text(error.toString()),),
                loading: () => Center(child: CircularProgressIndicator(),),);
          },

        ),


      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreatPage(datas: information ,),)
          );

        },
        child: Icon(Icons.add_circle,color: Colors.white,size: 55,),

      ),
    );
  }
}




