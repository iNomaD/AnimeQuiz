import urllib.request
import re
import os
from urllib.request import urlretrieve

def GetURL(url):
    s = 'error'
    try:
        f = urllib.request.urlopen(url)
        s = f.read().decode("cp1251")
    except urllib.error.HTTPError:
        s = 'connect error'
    except urllib.error.URLError:
        s = 'url error'
    return s

def parseFromWAurl(waurl):
    #парсим рейтинг
    page1 = GetURL(waurl)
    table = re.findall(r'<tr height=20>.*?</tr>', page1)

    #парсим строку рейтинга
    for row in table:
        position = re.search(r'<b>(?P<position>.*)</b>', row).group('position')
        year = re.search(r'</a> \[(?P<year>.*)\]&nbsp;&nbsp;</td>', row).group('year')
        id = re.search(r'<a href = .*id=(?P<id>.*)".*</a>', row).group('id')
        url = 'http://www.world-art.ru/animation/animation_photos.php?id='+id

        #парсим страницу с фотками
        page2 = GetURL(url)
        name = re.search(r'class=\'h3\'>(?P<name>.*)</a> &#151;', page2).group('name')
        photos = re.search(r'<table><tr><td><table>(?P<photos>.*)</table><br><br>', page2).group('photos')
        photolist = re.findall(r'screenshot_number=\d+', photos);
        print(position + ' ' + name + ' ' +url)

        #<КОСТЫЛЬ>
        if position == '364':
            print('skipp')
            continue
        #</КОСТЫЛЬ>

        #если есть фотки, то создаём папку и записываем название
        if photolist:
            #загружаем 3 фотки
            size = len(photolist)
            if size>3:
                size=3
            if size<3: #если меньше 3, то не сохраняем
                continue

            if not os.path.exists('data'):
                os.mkdir('data')
            if not os.path.exists('data/'+id):
                os.mkdir('data/'+id)
            #open('data/'+id+'/'+name+'.txt', 'tw', encoding='utf-8').close()
            file = open('data/'+id+'/info.txt', 'tw', encoding='utf-8')
            file.write(name+'\n'+year+'\n'+position)
            file.close()

            for index in range(size):
                photourl = 'http://www.world-art.ru/animation/animation_photos.php?id='+id+'&&'+photolist[index]
                page3 = GetURL(photourl)
                imgurl = re.search(r'<img src=\'(?P<img>img/converted_images.*)\' alt=', page3).group('img')
                imgurl = 'http://www.world-art.ru/animation/'+imgurl

                #скачиваем в папку
                destination = imgurl.rsplit('/',1)[1]
                destination = 'data/'+id+'/'+destination
                urlretrieve(imgurl, destination)

parseFromWAurl('http://www.world-art.ru/animation/rating_top.php?limit_1=000')
parseFromWAurl('http://www.world-art.ru/animation/rating_top.php?limit_1=100')
parseFromWAurl('http://www.world-art.ru/animation/rating_top.php?limit_1=200')
parseFromWAurl('http://www.world-art.ru/animation/rating_top.php?limit_1=300')
parseFromWAurl('http://www.world-art.ru/animation/rating_top.php?limit_1=400')
print('Script has finished successfully!')