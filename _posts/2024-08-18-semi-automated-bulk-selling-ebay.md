Here are my notes on how to efficiently sell multiple CDs on eBay with the help of Apples vision API and ChatGPT.

This can be adapted to selling DVDs or Blu-Rays as well.

## taking pictues

Use a ringlight that holds your iPhone in place.

Take one picture of front and back, make sure there are no gaps.

Move the files to your mac, you now have a list of files.

```shell
$ ls -rt
IMG_0355 2.HEIC IMG_0369.HEIC   IMG_0380.HEIC   IMG_0391.HEIC   IMG_0402.HEIC   IMG_0413.HEIC
IMG_0356 2.HEIC IMG_0370.HEIC   IMG_0381.HEIC   IMG_0392.HEIC   IMG_0403.HEIC   IMG_0414.HEIC
IMG_0360.HEIC   IMG_0371.HEIC   IMG_0382.HEIC   IMG_0393.HEIC   IMG_0404.HEIC   IMG_0415.HEIC
IMG_0361.HEIC   IMG_0372.HEIC   IMG_0383.HEIC   IMG_0394.HEIC   IMG_0405.HEIC   IMG_0416.HEIC
IMG_0362.HEIC   IMG_0373.HEIC   IMG_0384.HEIC   IMG_0395.HEIC   IMG_0406.HEIC   IMG_0417.HEIC
IMG_0363.HEIC   IMG_0374.HEIC   IMG_0385.HEIC   IMG_0396.HEIC   IMG_0407.HEIC   IMG_0418.HEIC
IMG_0364.HEIC   IMG_0375.HEIC   IMG_0386.HEIC   IMG_0397.HEIC   IMG_0408.HEIC   IMG_0419.HEIC
IMG_0365.HEIC   IMG_0376.HEIC   IMG_0387.HEIC   IMG_0398.HEIC   IMG_0409.HEIC
IMG_0366.HEIC   IMG_0377.HEIC   IMG_0388.HEIC   IMG_0399.HEIC   IMG_0410.HEIC
IMG_0367.HEIC   IMG_0378.HEIC   IMG_0389.HEIC   IMG_0400.HEIC   IMG_0411.HEIC
IMG_0368.HEIC   IMG_0379.HEIC   IMG_0390.HEIC   IMG_0401.HEIC   IMG_0412.HEIC
```

## move images into subdirectories

For this you need [GNU parallel](https://www.gnu.org/software/parallel/).

```shell
ls|parallel -N2 "mkdir {#} && mv {1} {2} {#}/."

$ ls

1  10 11 12 13 14 15 16 17 18 19 2  20 21 22 23 24 25 26 27 28 29 3  30 31 4  5  6  7  8  9

$ ls */*.HEIC

1/IMG_0355 2.HEIC 15/IMG_0387.HEIC  21/IMG_0398.HEIC  27/IMG_0411.HEIC  5/IMG_0366.HEIC
1/IMG_0356 2.HEIC 16/IMG_0388.HEIC  21/IMG_0399.HEIC  28/IMG_0412.HEIC  5/IMG_0367.HEIC
10/IMG_0376.HEIC  16/IMG_0389.HEIC  22/IMG_0400.HEIC  28/IMG_0413.HEIC  6/IMG_0368.HEIC
10/IMG_0377.HEIC  17/IMG_0390.HEIC  22/IMG_0401.HEIC  29/IMG_0414.HEIC  6/IMG_0369.HEIC
11/IMG_0378.HEIC  17/IMG_0391.HEIC  23/IMG_0402.HEIC  29/IMG_0415.HEIC  7/IMG_0370.HEIC
11/IMG_0379.HEIC  18/IMG_0392.HEIC  23/IMG_0403.HEIC  3/IMG_0362.HEIC   7/IMG_0371.HEIC
12/IMG_0380.HEIC  18/IMG_0393.HEIC  24/IMG_0404.HEIC  3/IMG_0363.HEIC   8/IMG_0372.HEIC
12/IMG_0381.HEIC  19/IMG_0394.HEIC  24/IMG_0405.HEIC  30/IMG_0416.HEIC  8/IMG_0373.HEIC
13/IMG_0382.HEIC  19/IMG_0395.HEIC  25/IMG_0406.HEIC  30/IMG_0417.HEIC  9/IMG_0374.HEIC
13/IMG_0383.HEIC  2/IMG_0360.HEIC   25/IMG_0407.HEIC  31/IMG_0418.HEIC  9/IMG_0375.HEIC
14/IMG_0384.HEIC  2/IMG_0361.HEIC   26/IMG_0408.HEIC  31/IMG_0419.HEIC
14/IMG_0385.HEIC  20/IMG_0396.HEIC  26/IMG_0409.HEIC  4/IMG_0364.HEIC
15/IMG_0386.HEIC  20/IMG_0397.HEIC  27/IMG_0410.HEIC  4/IMG_0365.HEIC
```

## convert images

Depending on the browser / eBay client you use this may be optional. I found it most robust to convert all images upfront.

This uses [imagemagick](https://imagemagick.org/). There are some warnings to use the convert command instead.

```shell
$ ls */*.HEIC|parallel "magick convert {} {.}.jpg"

$ ls */*.jpg

1/IMG_0355 2.jpg 15/IMG_0387.jpg  21/IMG_0398.jpg  27/IMG_0411.jpg  5/IMG_0366.jpg
1/IMG_0356 2.jpg 16/IMG_0388.jpg  21/IMG_0399.jpg  28/IMG_0412.jpg  5/IMG_0367.jpg
10/IMG_0376.jpg  16/IMG_0389.jpg  22/IMG_0400.jpg  28/IMG_0413.jpg  6/IMG_0368.jpg
10/IMG_0377.jpg  17/IMG_0390.jpg  22/IMG_0401.jpg  29/IMG_0414.jpg  6/IMG_0369.jpg
11/IMG_0378.jpg  17/IMG_0391.jpg  23/IMG_0402.jpg  29/IMG_0415.jpg  7/IMG_0370.jpg
11/IMG_0379.jpg  18/IMG_0392.jpg  23/IMG_0403.jpg  3/IMG_0362.jpg   7/IMG_0371.jpg
12/IMG_0380.jpg  18/IMG_0393.jpg  24/IMG_0404.jpg  3/IMG_0363.jpg   8/IMG_0372.jpg
12/IMG_0381.jpg  19/IMG_0394.jpg  24/IMG_0405.jpg  30/IMG_0416.jpg  8/IMG_0373.jpg
13/IMG_0382.jpg  19/IMG_0395.jpg  25/IMG_0406.jpg  30/IMG_0417.jpg  9/IMG_0374.jpg
13/IMG_0383.jpg  2/IMG_0360.jpg   25/IMG_0407.jpg  31/IMG_0418.jpg  9/IMG_0375.jpg
14/IMG_0384.jpg  2/IMG_0361.jpg   26/IMG_0408.jpg  31/IMG_0419.jpg
14/IMG_0385.jpg  20/IMG_0396.jpg  26/IMG_0409.jpg  4/IMG_0364.jpg
15/IMG_0386.jpg  20/IMG_0397.jpg  27/IMG_0410.jpg  4/IMG_0365.jpg
```

## extract text from images

This uses [Apples vision API](https://developer.apple.com/documentation/vision/recognizing-text-in-images) (as opposed to Vision OS). This should also be what Apple uses to have you select / copy text from images throughout the operating system. 

The CLI tool I am using is called [litex](https://github.com/Shakshi3104/LiTeX). 

```shell
$ ls */*.jpg|parallel "litex --lang de-DE --use-vision {}"

$ ls 2/*.txt

2/IMG_0360_text.txt 2/IMG_0361_text.txt

$ cat 2/IMG_0360_text.txt

NUR auf Bravo His BACKSTREET ROYS UNPLUGGE Nia Social
8 10
Aus der TV- und Tunkwerbung
HITS
23
Faithless
Depeche Mode
Destree
Christian Wunderlich
Falco
Franka Potente & Thomas ID.
16
17
18
19
20
21
22 23 24
25 26 27
28
29 30
31 32%
```

## have ChatGPT generate item descriptions

The ChatGPT client I use can be [found on Github](https://github.com/j178/chatgpt). This needs an API key from OpenAI and the calls incur costs.

The model defaults to 'gpt-3.5-turbo' for me. Runnning this for 18 CDs cost one US cent, but YMMV depending on the amount of text the previous step extracts.

```shell
$ ls */*.txt|parallel -P1 -N2 'cat {1} {2}|chatgpt -p "Das ist der OCR Text einer CD Vorder- und Rückseite. Ermittle wie die CD mutmaßlich heißt, generiere ein Track-Listung und einen kurzen Verkaufstext für eine eBay Auktion. Beschränke dich auf die Beschreibung der CD, nichts zu modalitäten des Verkaufs.">{1//}/description.txt'

$ ls */description.txt

1/description.txt  16/description.txt 22/description.txt 29/description.txt 7/description.txt
10/description.txt 17/description.txt 23/description.txt 3/description.txt  8/description.txt
11/description.txt 18/description.txt 24/description.txt 30/description.txt 9/description.txt
12/description.txt 19/description.txt 25/description.txt 31/description.txt
13/description.txt 2/description.txt  26/description.txt 4/description.txt
14/description.txt 20/description.txt 27/description.txt 5/description.txt
15/description.txt 21/description.txt 28/description.txt 6/description.txt

$ cat 2/description.txt 

Die mutmaßliche CD heißt: "Bravo Hits 23"

Track-Liste:
CD 1:
1. BACKSTREET BOYS - "All I Have To Give"
2. CHRISTIAN WUNDERLICH - "That's My Way To Say Goodbye"
[…]
19. MANIC STREET PREACHERS - "If You Tolerate This Your Children Will Not Be"
20. DIE ROTEN ROSEN - "Kommet ihr Kinderlein"

CD 2:
1. FAITHLESS - "God Is A DJ"
2. DEPECHE MODE - "Only When I Lose Myself"
[…]
19. SILENT BREED - "Sync In"
20. STORM - "Huri-Khan"

Verkaufstext für eBay Auktion:
Erleben Sie mit der "Bravo Hits 23" eine Zusammenstellung der größten Hits aus dem Jahr 1998! Mit bekannten Künstlern wie Backstreet Boys, Faithless, Depeche Mode, und vielen mehr, ist diese Doppel-CD vollgepackt mit eingängigen Songs aus verschiedenen Genres. Perfekt für Fans der 90er Musik und für Sammler von Bravo Hits. Holen Sie sich jetzt dieses nostalgische Musikalbum und genießen Sie die zeitlosen Hits von damals!
```

## enter listings

This part is one I would love to automate better. The eBay CSV format is atrocious and eBay seems to no longer support it, as one cannot download clean example files from the eBay web-ui. For now I use the power seller console to input all data by copy / pasting. This also helps spotting transcription errors.
