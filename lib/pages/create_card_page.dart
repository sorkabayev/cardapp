import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/model.dart';
import '../services/hive_service.dart';
import '../services/service.dart';
import 'add_card.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({Key? key}) : super(key: key);
  static const String id = 'cards_page';

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  bool isLoading = false;
  List<Note> cards = [];
  List<Color> colors = [
    Colors.blue, Colors.yellow, Colors.green, Colors.brown, Colors.indigoAccent, Colors.orange
  ];


  void _apiPostList() {
    setState(() {
      isLoading = true;
    });
    Network.GET(Network.API_GET, Network.paramsEmpty()).then((response) {
      if(response != null) {
        setState(() {
          _showResponse(response);
        });
      } else {
        if (kDebugMode) {
          print("Response is null");
        }
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  void _showResponse(String? response) {
    setState(() {
      isLoading = false;
      if (response != null) {
        cards = Network.parseResponse(response);
      }
    });
  }

  void _apiDeletePost(Note card) {
    setState(() {
      cards.remove(card);
    });
    Network.DELETE(Network.API_DELETE + card.id, Network.paramsEmpty()).then((response) {
      if(response != null) {
        if (kDebugMode) {
          print(response);
        }
        setState(() {
          _apiPostList();
        });
      }
    });
  }

  @override
  void initState() {
    _apiPostList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [

            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [

                  const SizedBox(height: 65,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Good Morning,", style: TextStyle(fontSize: 26),),
                          Text("Eugene", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
                        ],
                      ),

                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/user_image.jpg'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25,),

                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(cards[index].cardNumber),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 25),
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: colors[index]
                            ),
                            child: Column(
                              children: [

                                const SizedBox(height: 15,),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Image.asset('assets/images/grey_image.jpg', height: 35, width: 60, fit: BoxFit.cover,),

                                      const Text("VISA",style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),)

                                    ],
                                  ),
                                ),

                                const SizedBox(height: 25,),

                                Center(
                                  child: Text(cards[index].cardNumber, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
                                ),

                                const SizedBox(height: 30,),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("CARD HOLDER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),),

                                          const SizedBox(height: 5,),

                                          Text(cards[index].cardHolder, style: const TextStyle(color: Colors.white, fontSize: 18),),
                                        ],
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("EXPIRES", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),),

                                          const SizedBox(height: 5,),

                                          Text(cards[index].expiredDate, style: const TextStyle(color: Colors.white, fontSize: 18),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onDismissed: (_) {
                            setState(() {
                              _apiDeletePost(cards[index]);
                            });
                          },
                        );
                      }
                  ),


                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200,
                        border: Border.all(width: 1, color: Colors.grey.shade300)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: (){
                                Navigator.pushReplacementNamed(context, AddCardPage.id);
                              },
                              icon: Icon(Icons.add_box_outlined, size: 40,)
                          ),

                          const SizedBox(height: 5,),
                          const Text("Add new card", style: TextStyle(fontSize: 17),)
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30,),
                ],
              ),
            ),

            isLoading ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Center(child: CircularProgressIndicator())
            ) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}