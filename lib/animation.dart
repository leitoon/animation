import 'package:flutter/material.dart';

enum ButtonState {
 init,
 loading,
 done,
}

// ignore: must_be_immutable
class AnimationShopScreen extends StatefulWidget {
  int itemCount;
  AnimationShopScreen({Key? key,
 required this.itemCount}) : super(key: key);


 @override
 State<AnimationShopScreen> createState() => _AnimationShopScreenState
 ();
}


class _AnimationShopScreenState extends State<AnimationShopScreen> {


 bool isAnimating = true;
 ButtonState state = ButtonState.init;
 bool contador = false;
 bool showCounter = false;
 int currentIndex = 0;


 void incrementItem() {
   setState(() {
     widget.itemCount++;
   });
 }


 void decrementItem() {
   setState(() {
     if (widget.itemCount > 0) {
       widget.itemCount--;
     }
   });
 }


 @override
 Widget build(BuildContext context) {
   final size = MediaQuery.of(context).size;
   final isStretched = isAnimating || state == ButtonState.init;
   if (widget.itemCount == 0) {
     showCounter = false;
   }


   return Scaffold(
     body: Center(
       child: GestureDetector(
         onTap: () async {
          
           setState(() {
             state = ButtonState.loading;
           });
           await Future.delayed(const Duration(seconds: 2));
           setState(() {
             state = ButtonState.done;
           });
           await Future.delayed(const Duration(seconds: 1));
           setState(() {
             widget.itemCount++;
             showCounter =
                 true; // Mostrar buidCounter cuando la animación esté completa
             state = ButtonState.init;
           });
         },
         child: AnimatedContainer(
           duration: const Duration(milliseconds: 300),
           curve: Curves.easeIn,
           width: state == ButtonState.init ? 0.482 * size.width : 70,
           onEnd: () => setState(() => isAnimating = !isAnimating),
           height: 0.06 * size.height,
           child: Stack(
             children: [
               Positioned.fill(
                 child: isStretched
                     ? buildButton(size)
                     : biuldSmallButton(state == ButtonState.done),
               ),
               if (showCounter)
                 SizedBox(width: 0.482 * size.width, child: buidCounter(size)),
             ],
           ),
         ),
       ),
     ),
   );
 }


 Widget buidCounter(Size size) {
   return Container(
     width: 0.482 * size.width,
     height: 0.06 * size.height,
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(100),
       border: Border.all(
         color:  Colors.blue, // Color del borde
         width: 1, // Ancho del borde
       ),
     ),
     child: FittedBox(
       fit: BoxFit.contain,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           IconButton(
               icon: const Icon(
                 Icons.remove,
                 size: 25,
                 color: Colors.blue,
               ),
               onPressed: () {
                 decrementItem();
               }), // O cualquier otro widget que desees mostrar en lugar del IconButton
           SizedBox(
             width: 0.05 * size.width,
           ),
           Text(
             '${widget.itemCount}',
             style: const TextStyle(
               color: Color(0xff333333),
               fontWeight: FontWeight.bold,
               fontSize: 16,
             ),
           ),


           SizedBox(
             width: 0.05 * size.width,
           ),
           IconButton(
               icon: const Icon(
                 Icons.add,
                 size: 25,
                 color: Colors.blue,
               ),
               onPressed: () {
                 incrementItem();
               }),
         ],
       ),
     ),
   );
 }


 biuldSmallButton(bool isDone) {
   return Container(
     decoration:
         const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
     child: FittedBox(
       fit: BoxFit.contain,
       child: Padding(
         padding: const EdgeInsets.all(16),
         child: isDone
             ? const Icon(
                 Icons.done,
                 size: 30,
                 color: Colors.white,
               )
             : const Center(
                 child: CircularProgressIndicator(
                   color: Colors.white,
                 ),
               ),
       ),
     ),
   );
 }


 Container buildButton(Size size) {
   return Container(
     height: 0.06 * size.height,
     width: 0.482 * size.width,
     decoration: ShapeDecoration(
       color:  Colors.blue,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(100),
       ),
     ),
     child: FittedBox(
       fit: BoxFit.contain,
       child: Padding(
         padding: const EdgeInsets.all(11.0),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             const Icon(
              Icons.shopping_bag_outlined,
               size: 24,
               color: Colors.white,
             ),
             Text('Buy',
             style: TextStyle
             (
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600
             ),
             )
             
           ],
         ),
       ),
     ),
   );
 }
}


