import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScreen extends StatefulWidget {
  const InfiniteScreen({Key? key}) : super(key: key);
  static const name = "infinite_screen";

  @override
  State<InfiniteScreen> createState() => _InfiniteScreenState();
}

class _InfiniteScreenState extends State<InfiniteScreen> {

  List<int> images = [1,2,3,4,5];
  bool isLoading = false;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    controller.addListener(() {
        if((controller.position.pixels + 500) >= controller.position.maxScrollExtent) {
          loadNextPage();
        }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future loadNextPage() async {
    if(isLoading) return;    
    isLoading = true;
    if(!mounted) return;
    setState(() { });

    await Future.delayed(const Duration(seconds: 2));
    fiveImages();
    isLoading = false;

    if(!mounted) return;
    setState(() { });
    moveScrollBottom();
  }

  Future onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    if(!mounted) return;

    final last = images.last;
    isLoading = true;
    images.clear();
    images.add(last + 1);
    fiveImages();
    isLoading = false;
    setState(() {
      
    });
  }

  void fiveImages() {
    final lastid = images.last;
    images.addAll(
      [1,2,3,4,5].map((e) => lastid + e)
    );
  }

  void moveScrollBottom() {
    if((controller.position.pixels + 150) <= controller.position.maxScrollExtent) {
      return;
    }

    controller.animateTo(
      controller.position.pixels + 120,
      duration: Duration(milliseconds: 300), 
      curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Inifinite"),
      // ),
      backgroundColor: Colors.black,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: RefreshIndicator(
          onRefresh: () => onRefresh(),
          child: ListView.builder(
            controller: controller,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return FadeInImage(
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                placeholder: AssetImage("assets/jar-loading.gif"), 
                image: NetworkImage(
                  "https://picsum.photos/id/${images[index]}/500/300"
                )
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        child: isLoading ? CircularProgressIndicator() : Icon(Icons.arrow_back),
      ),
    );
  }
}