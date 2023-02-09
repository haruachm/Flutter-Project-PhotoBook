#  🖼 저절로 보여주는 나만의 사진첩 만들기

![갤러리4](https://user-images.githubusercontent.com/85959639/217782016-6479ad8f-a50c-40f0-a36e-f84119f3c67a.gif)


</br>
---

## ****StatefulWidget 생성 후 Page View 사용해보기****

```
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Image.asset('assets/img/img-1.jpeg', fit: BoxFit.cover),
          Image.asset('assets/img/img-2.jpeg', fit: BoxFit.cover),
          Image.asset('assets/img/img-3.jpeg', fit: BoxFit.cover),
        ],
      ),
    );
  }
}
```

- StatefulWidget으로 HomeScreen을 생성한다.
- PageView를 사용하고, Children: [] 안에 Image.asset를 다 나열한다.
- 그러나 아래와 같이 이미지를 나열하면 이미지가 많을 때 번거롭다는 단점이 있다.

### **Page View 이미지 map() 사용**

```
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children:
            [1, 2, 3, 4].map((e) => Image.asset('img-${e}.jpeg')).toList(),
      ),
    );
  }
}
```

- 이전에 image.asset으로 나열을 했던 코드를 .map()을 사용해 간략한 코드를 작성한다.
- map() 함수의 결과는 이터러블(iterable)을 리턴한다.
- 그러나 children:[]은 이터러블이 아닌 리스트를 사용해야 하기 때문에 .toList()를 사용해서 리스트로 변환시켜준다.

### **Timer 사용해서 설정한 시간에 따라 사진첩 롤링**

타이머를 사용하기 위해서는 **'dart:async' 패키지**를 임포트해야 한다.

```
import 'dart:async';
```

### **initState() 안에 타이머(timer) 상태(State) 설정하기**

- 아래와 같이 **initState()**를 선언하고 안에 timer를 생성한다.
- initState()는 빌드를 할 때 처음 1번 실행하기 때문에 **타이머의 상태(State)를 지정**할 수 있다.
- timer()은 백그라운드에서 멈추는 명령이 있을 때까지 계속적으로 실행이 된다. 그렇기 때문에 멈추는 명령어를 작성하지 않으면 메모리를 잡아먹을 수 있다.
- **timer = Timer.periodic(Duration(seconds: 1), (timer){}** 로 몇 초동안 해당 명령어를 반복할지 설정한다.

```
class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;

  @override
  void initState() {
// TODO: implement initStatesuper.initState();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print('1초');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [1, 2, 3, 4, 5, 6, 7, 8]
            .map((e) => Image.asset(
                  'assets/img/img-${e}.jpeg',
                  fit: BoxFit.cover,
                ))
            .toList(),
      ),
    );
  }
}
```

---

### **dispose() 안에 타이머(timer) 종료 명령 작성하기**

- HomeScreen이라는 위젯이 완전 종료가 될 때 dispose()가 호출되는데, 그때 함께 timer()도 중지되도록 설정한다.
- timer를 중지하려면 .cancel()을 사용하는데, 여기서 if문으로 null 체크를 해줬음에도 timer는 인식하지 못해 **! (느낌표)를 사용해 한번 더 null 체크**를 해줘야 한다.

```
  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
// TODO: implement disposesuper.dispose();
  }
```

---

## **PageView에 PageController를 사용해 timer()에 따라 사진 넘기는 기능**

### **PageController 생성하기**

WebView를 사용했을 때는 컨트롤러(Controller) 웹뷰에서 생성을 해줬으나 PageView에서는 직접 컨트롤러를 생성하고 넣어줘야 한다.

```
class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController(
    initialPage:0,
  );
}
```

- PageController를 선언한다.
- initialPage: 0은 인덱스(indext) 값을 넣어 몇 번째 페이지를 처음에 실행할 것인지를 정한다.
- 생성한 controller를 PageView에 넣어 사용을 하면 PageView가 생성이 될 때 컨트롤러가 붙어 PageView를 조종할 수 있다.

### **PageControll로 PageView 조종하기**

페이지를 조종할 때는 현재 페이지를 가져와야 한다.

```
  @override
  void initState() {
// TODO: implement initStatesuper.initState();
    timer:
    Timer.periodic(Duration(seconds: 1), (timer) {
      int currentPage = controller.page!.toInt();
      int nextPage = currentPage + 1;

      if (nextPage > 8) {
        nextPage = 0;
      }
      controller.animateToPage(nextPage,
          duration: Duration(milliseconds: 400), curve: Curves.linear);
    });
  }
```

**controller.page!.toInt();** 를 사용해 현재 페이지를 가져온다.

- **page!**를 사용함으로써 controller가 PageView에 붙어서 확실히 Page를 가져올 수 있음을 알려준다.
- controller.page는 **double 값을 반환**하는데, 한 페이지씩 확실히 넘어가야 하므로 정수 값으로 변환하는 **toInt();**를 써준다.
- nextPage는 마지막 값에 도달하면 다시 0부터 시작하도록 **if문**을 설정해준다

**controller.animateToPage(page, duration : , curve: );**

어떤 페이지로 애니메이션을 진행하는 코드로 첫 번째는 **이동하는 페이지**,

두 번째는 이동하는 페이지가 이동하는 **속도**,

세번째는 페이지의 **애니메이션이 어떤 식으로 실행되는지** 지정한다.

---

## **상태바 색상 변경**

```
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
```

![https://blog.kakaocdn.net/dn/Ego0p/btrYH1G8OfR/9EUb3UhlDa5QfWFN4RDrFK/img.png](https://blog.kakaocdn.net/dn/Ego0p/btrYH1G8OfR/9EUb3UhlDa5QfWFN4RDrFK/img.png)

```
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
```

![https://blog.kakaocdn.net/dn/FZGX7/btrYINuSi9d/SqLQb6ODQc0hU3zk0K8d20/img.png](https://blog.kakaocdn.net/dn/FZGX7/btrYINuSi9d/SqLQb6ODQc0hU3zk0K8d20/img.png)
