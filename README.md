#  ๐ผ ์ ์ ๋ก ๋ณด์ฌ์ฃผ๋ ๋๋ง์ ์ฌ์ง์ฒฉ ๋ง๋ค๊ธฐ

![๊ฐค๋ฌ๋ฆฌ4](https://user-images.githubusercontent.com/85959639/217782016-6479ad8f-a50c-40f0-a36e-f84119f3c67a.gif)


</br>


## ****StatefulWidget ์์ฑ ํ Page View ์ฌ์ฉํด๋ณด๊ธฐ****

```dart
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

- StatefulWidget์ผ๋ก HomeScreen์ ์์ฑํ๋ค.
- PageView๋ฅผ ์ฌ์ฉํ๊ณ , Children: [] ์์ Image.asset๋ฅผ ๋ค ๋์ดํ๋ค.
- ๊ทธ๋ฌ๋ ์๋์ ๊ฐ์ด ์ด๋ฏธ์ง๋ฅผ ๋์ดํ๋ฉด ์ด๋ฏธ์ง๊ฐ ๋ง์ ๋ ๋ฒ๊ฑฐ๋กญ๋ค๋ ๋จ์ ์ด ์๋ค.

### **Page Viewย ์ด๋ฏธ์ง map() ์ฌ์ฉ**

```dart
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

- ์ด์ ์ image.asset์ผ๋ก ๋์ด์ ํ๋ ์ฝ๋๋ฅผ .map()์ ์ฌ์ฉํด ๊ฐ๋ตํ ์ฝ๋๋ฅผ ์์ฑํ๋ค.
- map() ํจ์์ ๊ฒฐ๊ณผ๋ ์ดํฐ๋ฌ๋ธ(iterable)์ ๋ฆฌํดํ๋ค.
- ๊ทธ๋ฌ๋ children:[]์ ์ดํฐ๋ฌ๋ธ์ด ์๋ ๋ฆฌ์คํธ๋ฅผ ์ฌ์ฉํด์ผ ํ๊ธฐ ๋๋ฌธ์ .toList()๋ฅผ ์ฌ์ฉํด์ ๋ฆฌ์คํธ๋ก ๋ณํ์์ผ์ค๋ค.

### **Timer ์ฌ์ฉํด์ ์ค์ ํ ์๊ฐ์ ๋ฐ๋ผ ์ฌ์ง์ฒฉ ๋กค๋ง**

ํ์ด๋จธ๋ฅผ ์ฌ์ฉํ๊ธฐ ์ํด์๋ย **'dart:async' ํจํค์ง**๋ฅผ ์ํฌํธํด์ผ ํ๋ค.

```dart
import 'dart:async';
```

### **initState() ์์ ํ์ด๋จธ(timer) ์ํ(State) ์ค์ ํ๊ธฐ**

- ์๋์ ๊ฐ์ดย **initState()**๋ฅผ ์ ์ธํ๊ณ  ์์ timer๋ฅผ ์์ฑํ๋ค.
- initState()๋ ๋น๋๋ฅผ ํ  ๋ ์ฒ์ 1๋ฒ ์คํํ๊ธฐ ๋๋ฌธ์ย **ํ์ด๋จธ์ ์ํ(State)๋ฅผ ์ง์ **ํ  ์ ์๋ค.
- timer()์ ๋ฐฑ๊ทธ๋ผ์ด๋์์ ๋ฉ์ถ๋ ๋ช๋ น์ด ์์ ๋๊น์ง ๊ณ์์ ์ผ๋ก ์คํ์ด ๋๋ค. ๊ทธ๋ ๊ธฐ ๋๋ฌธ์ ๋ฉ์ถ๋ ๋ช๋ น์ด๋ฅผ ์์ฑํ์ง ์์ผ๋ฉด ๋ฉ๋ชจ๋ฆฌ๋ฅผ ์ก์๋จน์ ์ ์๋ค.
- **timer = Timer.periodic(Duration(seconds: 1), (timer){}**ย ๋ก ๋ช ์ด๋์ ํด๋น ๋ช๋ น์ด๋ฅผ ๋ฐ๋ณตํ ์ง ์ค์ ํ๋ค.

```dart
class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;

  @override
  void initState() {
// TODO: implement initStatesuper.initState();

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print('1์ด');
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

### **dispose() ์์ ํ์ด๋จธ(timer) ์ข๋ฃ ๋ช๋ น ์์ฑํ๊ธฐ**

- HomeScreen์ด๋ผ๋ ์์ ฏ์ด ์์  ์ข๋ฃ๊ฐ ๋  ๋ dispose()๊ฐ ํธ์ถ๋๋๋ฐ, ๊ทธ๋ ํจ๊ป timer()๋ ์ค์ง๋๋๋ก ์ค์ ํ๋ค.
- timer๋ฅผ ์ค์งํ๋ ค๋ฉด .cancel()์ ์ฌ์ฉํ๋๋ฐ, ์ฌ๊ธฐ์ if๋ฌธ์ผ๋ก null ์ฒดํฌ๋ฅผ ํด์คฌ์์๋ timer๋ ์ธ์ํ์ง ๋ชปํดย **! (๋๋ํ)๋ฅผ ์ฌ์ฉํด ํ๋ฒ ๋ null ์ฒดํฌ**๋ฅผ ํด์ค์ผ ํ๋ค.

```dart
  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
// TODO: implement disposesuper.dispose();
  }
```

---

## **PageView์ PageController๋ฅผ ์ฌ์ฉํด timer()์ ๋ฐ๋ผ ์ฌ์ง ๋๊ธฐ๋ ๊ธฐ๋ฅ**

### **PageController ์์ฑํ๊ธฐ**

WebView๋ฅผ ์ฌ์ฉํ์ ๋๋ ์ปจํธ๋กค๋ฌ(Controller) ์น๋ทฐ์์ ์์ฑ์ ํด์คฌ์ผ๋ PageView์์๋ ์ง์  ์ปจํธ๋กค๋ฌ๋ฅผ ์์ฑํ๊ณ  ๋ฃ์ด์ค์ผ ํ๋ค.

```dart
class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController(
    initialPage:0,
  );
}
```

- PageController๋ฅผ ์ ์ธํ๋ค.
- initialPage: 0์ ์ธ๋ฑ์ค(indext) ๊ฐ์ ๋ฃ์ด ๋ช ๋ฒ์งธ ํ์ด์ง๋ฅผ ์ฒ์์ ์คํํ  ๊ฒ์ธ์ง๋ฅผ ์ ํ๋ค.
- ์์ฑํ controller๋ฅผ PageView์ ๋ฃ์ด ์ฌ์ฉ์ ํ๋ฉด PageView๊ฐ ์์ฑ์ด ๋  ๋ ์ปจํธ๋กค๋ฌ๊ฐ ๋ถ์ด PageView๋ฅผ ์กฐ์ขํ  ์ ์๋ค.

### **PageControll๋ก PageView ์กฐ์ขํ๊ธฐ**

ํ์ด์ง๋ฅผ ์กฐ์ขํ  ๋๋ ํ์ฌ ํ์ด์ง๋ฅผ ๊ฐ์ ธ์์ผ ํ๋ค.

```dart
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

**controller.page!.toInt();**ย ๋ฅผ ์ฌ์ฉํด ํ์ฌ ํ์ด์ง๋ฅผ ๊ฐ์ ธ์จ๋ค.

- **page!**๋ฅผ ์ฌ์ฉํจ์ผ๋ก์จ controller๊ฐ PageView์ ๋ถ์ด์ ํ์คํ Page๋ฅผ ๊ฐ์ ธ์ฌ ์ ์์์ ์๋ ค์ค๋ค.
- controller.page๋ย **double ๊ฐ์ ๋ฐํ**ํ๋๋ฐ, ํ ํ์ด์ง์ฉ ํ์คํ ๋์ด๊ฐ์ผ ํ๋ฏ๋ก ์ ์ ๊ฐ์ผ๋ก ๋ณํํ๋ย **toInt();**๋ฅผ ์จ์ค๋ค.
- nextPage๋ ๋ง์ง๋ง ๊ฐ์ ๋๋ฌํ๋ฉด ๋ค์ 0๋ถํฐ ์์ํ๋๋กย **if๋ฌธ**์ ์ค์ ํด์ค๋ค

**controller.animateToPage(page, duration : , curve: );**

์ด๋ค ํ์ด์ง๋ก ์ ๋๋ฉ์ด์์ ์งํํ๋ ์ฝ๋๋ก ์ฒซ ๋ฒ์งธ๋ย **์ด๋ํ๋ ํ์ด์ง**,

๋ ๋ฒ์งธ๋ ์ด๋ํ๋ ํ์ด์ง๊ฐ ์ด๋ํ๋ย **์๋**,

์ธ๋ฒ์งธ๋ ํ์ด์ง์ย **์ ๋๋ฉ์ด์์ด ์ด๋ค ์์ผ๋ก ์คํ๋๋์ง**ย ์ง์ ํ๋ค.

---

## **์ํ๋ฐ ์์ ๋ณ๊ฒฝ**

```dart
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
```

![https://blog.kakaocdn.net/dn/Ego0p/btrYH1G8OfR/9EUb3UhlDa5QfWFN4RDrFK/img.png](https://blog.kakaocdn.net/dn/Ego0p/btrYH1G8OfR/9EUb3UhlDa5QfWFN4RDrFK/img.png)

```dart
SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
```

![https://blog.kakaocdn.net/dn/FZGX7/btrYINuSi9d/SqLQb6ODQc0hU3zk0K8d20/img.png](https://blog.kakaocdn.net/dn/FZGX7/btrYINuSi9d/SqLQb6ODQc0hU3zk0K8d20/img.png)
