# **Study Logger**

#### 1. 제공기능 명세
1) 하루 동안의 학습을 기록하는 기능을 제공 
2) 입력된 로그의 수정 및 삭제를 할 수 있도록 UI 구성 (실수 정정) 
3) 학습인증게시판을 통해 다른 사람들과 학습시간을 비교할 수 있고
   서로의 학습시간을 보면서 상호 동기부여
4) 당일 뿐만 아니라 과거의 학습로그를 조회할 수 있는 페이지 제공

------

## 추가적으로 개선할 사항

#### 1. 폰트 적용

#### 2. 부트스트랩 예제 및 컴포넌트 적용

#### 3. 기존의 단어 수만 세는 것 외에 공백을 제외하거나 포함한 총 글자 수를 세어줌

```java
def result(request): 

​    text = request.GET['fulltext']

​    

​    length = list(text)

​    count = length.count(' ')

​    for x in range(0,count):

​        length.remove(' ')

​    words = text.split()

​    word_dictionary = {}

​    for word in words:

​        if word in word_dictionary:

​            word_dictionary[word] += 1

​        else:

​            word_dictionary[word] = 1

​    return render(request, 'result.html', {'full': text, 'total' : len(words), 'dictionary': word_dictionary.items(), 'textlength': len(length),'totaltextlength': len(text) })

​    

def count(request):

​    full_text = request.GET['fulltext']

​    word_list = full_text.split()

​    return render(request, 'wordcount/count.html', {'fulltext': full_text, 'total': len(word_list) })
```





## Home

![home](https://github.com/DustinYook/DjangoWordCount/blob/master/home.PNG)



## About

![about](https://github.com/DustinYook/DjangoWordCount/blob/master/about.PNG)



## Count

![result](https://github.com/DustinYook/DjangoWordCount/blob/master/count.PNG)
