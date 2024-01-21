import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';


class TfliteModel extends StatefulWidget {
  const TfliteModel({Key? key}) : super(key: key);

  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  
  late File _image;
  late List _results;
  bool imageSelect=false;
  @override
  void initState()
  {
    super.initState();
    loadModel();
  }
  Future loadModel()
  async {
    Tflite.close();
    String res;
    res=(await Tflite.loadModel(model: "assets/inceptionv3.tflite",labels: "assets/labels.txt"))!;
    print("Models loading status: $res");
  }

  Future imageClassification(File image)
  async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _results=recognitions!;
      _image=image;
      imageSelect=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("রোগ শনাক্তকরণ"),
      ),
      body: ListView(
        children: [
          (imageSelect)?Container(
        margin: const EdgeInsets.all(10),
        child: Image.file(_image),
      )
              :Container(
            margin: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("রোগাক্রান্ত ছবি নির্বাচন করুন",style: TextStyle(color: Colors.black87,fontSize: 25,height: 1.5,fontWeight: FontWeight.bold),),
                SizedBox(width: 15,),
                Image.asset('assets/detectionsample.jpg')]),
      ),
          SingleChildScrollView(
            child: Column(
              children: (imageSelect)?_results.map((result) {
                return Card(
                  child: Container(
                      margin: EdgeInsets.all(5),

                      child: result['label'] == 'LSD'?
                      // Text("রোগ: লাম্পি চর্ম রোগ\n\nতাৎক্ষনিক চিকিৎসাঃ\n(১) আক্রান্ত প্রাণীর ফোস্কা বা গুটি ফেঁটে গেলে Povisep solution বা আয়োডিন মিশ্রণ দিয়ে পরিষ্কার করতে হবে।\n(২) ফোস্কাগুলি না ফাটলে ঐ গুলির উপর (চামড়ার উপরে) Povisep solution বা আয়োডিন দিয়ে রং এর মত প্রলেপ দেয়া যায়। \n(৩) আক্রান্ত প্রাণীকে প্রচুর পানি বা চিটা গুড়ের সরবত খাওয়াতে হবে।\n(৪) বিভিন্ন মিনারেল মিশ্রণ যেমন- ফেরাস সালফেট, কপার সালফেট, কোবাল্ট মিশ্রণ, জিংক মিশ্রণ খাওয়াতে হবে।\n(৫) ভিটামিন-বি ইনজেকশনের মাধ্যমে এবং এন্টিহিসটামিন (Antihistamin), ব্যথানাশক (Painkiller), এন্টিপাইরেটিক (Antipyretic) ঔষধ প্রাণীকে দিতে হবে। প্রয়োজন হলে এন্টিবায়োটিক ব্যবহার করা যেতে পারে।\n\nযত দ্রুত সম্ভব ডাক্তারের পরামর্শ নিন।\n\n\n",style: const TextStyle(color: Colors.black87,fontSize: 25,height: 1.5,fontWeight: FontWeight.bold),): (result['label'] == 'FMD'? Text("রোগ: ফুট অ্যান্ড মাউথ রোগ\n\nভেটেরিনারি চিকিৎসকের পরামর্শে নিন্মলিখিত ব্যবস্থাদি গ্রহণ করা যেতেপারেঃ\n\nপশুর মুখে ও পায়ে ঘা হলে হালকা গরম পানিতে ফিটকিরি গুড়ো করে ১ গ্রাম ১ লিটার পানিতে বা পটাশিয়াম পারম্যাঙ্গানেট ১ গ্রাম/১০ লিটার পানিতে এর যেকোন একটি দ্বারা ক্ষতস্থান পরিস্কার করতে হবে। অতঃপর Sulphanilamide Powder এবং Doxacycline Powder আক্রান্ত স্থান ভালভাবে জীবাণুনাশক দ্বারা ধুয়ে দিনে ২ বার নারিকলে তৈল এর সাথে মিশিয়ে পেষ্ট তৈরী করে লাগাতে হবে।\n\n\n",style: const TextStyle(color: Colors.black87,fontSize: 25,height: 1.5,fontWeight: FontWeight.bold),):(result['label'] == 'IBK'? Text("রোগ: সংক্রামক বোভাইন কেরাটোকনজাংটিভাইটিস রোগ(IBK)",style: const TextStyle(color: Colors.black87,fontSize: 25,height: 1.5,fontWeight: FontWeight.bold),):null))
                      //Text("রোগ: লাম্পি চর্ম রোগ\n\nতাৎক্ষনিক চিকিৎসাঃ\n(১) আক্রান্ত প্রাণীর ফোস্কা বা গুটি ফেঁটে গেলে Povisep solution বা আয়োডিন মিশ্রণ দিয়ে পরিষ্কার করতে হবে।\n(২) ফোস্কাগুলি না ফাটলে ঐ গুলির উপর (চামড়ার উপরে) Povisep solution বা আয়োডিন দিয়ে রং এর মত প্রলেপ দেয়া যায়। \n(৩) আক্রান্ত প্রাণীকে প্রচুর পানি বা চিটা গুড়ের সরবত খাওয়াতে হবে।\n(৪) বিভিন্ন মিনারেল মিশ্রণ যেমন- ফেরাস সালফেট, কপার সালফেট, কোবাল্ট মিশ্রণ, জিংক মিশ্রণ খাওয়াতে হবে।\n(৫) ভিটামিন-বি ইনজেকশনের মাধ্যমে এবং এন্টিহিসটামিন (Antihistamin), ব্যথানাশক (Painkiller), এন্টিপাইরেটিক (Antipyretic) ঔষধ প্রাণীকে দিতে হবে। প্রয়োজন হলে এন্টিবায়োটিক ব্যবহার করা যেতে পারে।\n\nযত দ্রুত সম্ভব ডাক্তারের পরামর্শ নিন।\n\n\n",style: const TextStyle(color: Colors.black87,fontSize: 25,height: 1.5,fontWeight: FontWeight.bold),): (result['label'] == 'FMD'? Text("রোগ: ফুট অ্যান্ড মাউথ রোগ\n\nভেটেরিনারি চিকিৎসকের পরামর্শে নিন্মলিখিত ব্যবস্থাদি গ্রহণ করা যেতেপারেঃ\n\nপশুর মুখে ও পায়ে ঘা হলে হালকা গরম পানিতে ফিটকিরি গুড়ো করে ১ গ্রাম ১ লিটার পানিতে বা পটাশিয়াম পারম্যাঙ্গানেট ১ গ্রাম/১০ লিটার পানিতে এর যেকোন একটি দ্বারা ক্ষতস্থান পরিস্কার করতে হবে। অতঃপর Sulphanilamide Powder এবং Doxacycline Powder আক্রান্ত স্থান ভালভাবে জীবাণুনাশক দ্বারা ধুয়ে দিনে ২ বার নারিকলে তৈল এর সাথে মিশিয়ে পেষ্ট তৈরী করে লাগাতে হবে।\n\n\n",style: const TextStyle(color: Colors.black87,fontSize: 25,height: 1.5,fontWeight: FontWeight.bold),):(result['label'] == 'IBK'? Text("রোগ: সংক্রামক বোভাইন কেরাটোকনজাংটিভাইটিস রোগ",style: const TextStyle(color: Colors.black87,fontSize: 25,height: 1.5,fontWeight: FontWeight.bold),):null))
                      const Text("রোগ: লাম্পি চর্ম রোগ (Lumpy)\nতাৎক্ষনিক প্রাথমিক চিকিৎসাঃ\n১) আক্রান্ত প্রাণীর ফোস্কা বা গুটি ফেঁটে গেলে Povisep solution বা আয়োডিন মিশ্রণ দিয়ে পরিষ্কার করতে হবে।\n২) ফোস্কাগুলি না ফাটলে ঐ গুলির উপর (চামড়ার উপরে) Povisep solution বা আয়োডিন দিয়ে রং এর মত প্রলেপ দেয়া যায়। \n৩) আক্রান্ত প্রাণীকে প্রচুর পানি বা চিটা গুড়ের সরবত খাওয়াতে হবে।\n৪) বিভিন্ন মিনারেল মিশ্রণ যেমন- ফেরাস সালফেট, কপার সালফেট, কোবাল্ট মিশ্রণ, জিংক মিশ্রণ খাওয়াতে হবে।\n(৫) ভিটামিন-বি ইনজেকশনের মাধ্যমে এবং এন্টিহিসটামিন (Antihistamin), ব্যথানাশক (Painkiller), এন্টিপাইরেটিক (Antipyretic) ঔষধ প্রাণীকে দিতে হবে। প্রয়োজন হলে এন্টিবায়োটিক ব্যবহার করা যেতে পারে।\n\n**যত দ্রুত সম্ভব ডাক্তারের পরামর্শ নিন।**\n\n\n",style: TextStyle(color: Colors.black87,fontSize: 25,height: 1.5,fontWeight: FontWeight.bold),): (result['label'] == 'FMD'? Text("রোগ: ক্ষুরা রোগ (Foot and Mouth) \n\nতাৎক্ষনিক প্রাথমিক চিকিৎসাঃ\nভেটেরিনারি চিকিৎসকের পরামর্শে নিন্মলিখিত ব্যবস্থাদি গ্রহণ করা যেতেপারেঃ\n\nপশুর মুখে ও পায়ে ঘা হলে হালকা গরম পানিতে ফিটকিরি গুড়ো করে ১ গ্রাম ১ লিটার পানিতে বা পটাশিয়াম পারম্যাঙ্গানেট ১ গ্রাম/১০ লিটার পানিতে এর যেকোন একটি দ্বারা ক্ষতস্থান পরিস্কার করতে হবে। অতঃপর Sulphanilamide Powder এবং Doxacycline Powder আক্রান্ত স্থান ভালভাবে জীবাণুনাশক দ্বারা ধুয়ে দিনে ২ বার নারিকলে তৈল এর সাথে মিশিয়ে পেষ্ট তৈরী করে লাগাতে হবে।\n\n\n",style: const TextStyle(color: Colors.black87,fontSize: 25,height: 1.5,fontWeight: FontWeight.bold)):(result['label'] == 'IBK'? Text("রোগ: সংক্রামক বোভাইন কেরাটোকনজাংটিভাইটিস রোগ (IBK)\n\nতাৎক্ষনিক প্রাথমিক চিকিৎসাঃ\n১। সংক্রমণ কমাতে আক্রান্ত পশুকে যত দ্রুত সম্ভব আলাদা করুন।\n২। খেয়াল রাখুন চোখে যেন মশা, মাছি এবং অন্যান্য কিটপতঙ্গ বসতে না পারে।\n৩। চোখে যেন সূর্যের তীব্র আলো না পরে।\n৪। চিকিৎসকের পরামর্শ অনুযায়ী ঔষধ ব্যবহার করুন।\n\n\n",style: const TextStyle(color: Colors.black87,fontSize: 25,height: 1.5,fontWeight: FontWeight.bold),):(Text("এটি একটি ইউসুফ",style: const TextStyle(color: Colors.black87,fontSize: 25,height: 1.5,fontWeight: FontWeight.bold),))))

                  ),

                );
              }).toList():[],

            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        tooltip: "Pick Image",
        child: const Icon(Icons.image),
      ),
    );
  }
  Future pickImage()
  async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    File image=File(pickedFile!.path);
    imageClassification(image);
  }
}
