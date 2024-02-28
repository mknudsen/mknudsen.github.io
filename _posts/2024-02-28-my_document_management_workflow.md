
## Overview

Incoming paper documents are treated as follows:

1. Decide if documents need keeping; shred if not.
1. Decide if the document needs archiving; assign it a serial number if so.
1. Scan documents and upload scans to document management software.
1. Shred documents that do not require long-term archival.

## Deciding on What to Keep

Since with this system scanning and archival is quite cheap, I keep almost everything short of advertizements or useless coverletters at least in digital form.

Everything that *may* be needed for tax purposes or for Germanys mandatory pension scheme I keep on paper as well. This can be anything from employment contracts, pay stubs to school diplomas, which prove you went to school one year rather than doing nothing.

## Scanning solutions 

I use a [Samsung SCX-4623F](https://support.hp.com/de-de/product/details/samsung-scx-4623-laser-multifunction-printer-series/model/17157061). The F is for Fax, whose battery was the only thing that ever needed maintenance in the roughly 10 years I'm using it now. Samsung no longer produces printers and HP bought the support business. It has an [automatic document feeder (ADF)](https://en.wikipedia.org/wiki/Automatic_document_feeder) which is handy when scanning larger volumes of documents. 

### Software

#### scanline

Given the age of the printer I do not even try to run the original software on my moder MacOS device. For most scans I use the command line tool [scanline](https://github.com/klep/scanline) which has various modes for scanning either directly to PDF, JPEG as well as semi-automatic batch mode vs. fully automatic serial scanning. 

````
scanline -mono -jpeg -a4 -name various_receipts .
````

#### PDFScanner

Since my scanner does not have a [duplex automatic document feeder (DADF)](https://en.wikipedia.org/wiki/Automatic_document_feeder), I use a separate scanning software, [PDFScanner](https://apps.apple.com/de/app/pdfscanner/id410968114?mt=12), which has a pseudo-duplex mode that shuffles stacks of document into the correct order, once you scanned both their front and back in stack.

For most documents I am happy with scanlines default 150 DPI resolution and monochrome scans. Adjust where needed for readability. I leave the OCR part to my document management software.

## Document management software

[Paperless-NGX](https://docs.paperless-ngx.com/) is the software in which I manage my documents. It performs optical character recognition, generates a search index, automatically recognizes correspondant, document type and applicable tags and can even monitor your e-mail inbox for new documents.

It can be run locally on your desktop computer, on a server somewhere or on some NAS solutions. Deployment is fully dockerized. I myself use the one provided by the default catalog of [TrueNAS](https://www.truenas.com/), the one provided by the [TrueCharts](https://truecharts.org/) broke one too many times.

Documents are uploaded to a network share from my desktop and afterwards automatically consumed by Paperless, which watches the shares for new files.

OCR is provided in a variety of languages, it's reccomendable to limit yourself to the few your documents actually have, otherwise processing might take a long time.

One vital feature needed for the archival of paper originals is the serial number feature. Paperless will ask you to provide an optional number for each document and will tell you, if a given number has been assigned already. 

## Archiving paper originals

Paper documents I plan to archive are stamped with an incrementing serial number before scanning. I do this by using a paginating stamp aka. Numerateur or Paginierstempel. In my case a [Reiner B6](https://www.reiner.de/index.php?Numeroteur_B6_Numerieren_mit_und_ohne_Text). This improves legibility and uniformity of the serial numbers on the documents and helps with OCR too, should you ever forget to set the serial number in the document management system.  

After scanning they are sorted in a simple bankers box in the order of their serial number.

Should the need to use an original ever arise, the number can be seen on the document after looking it up in the document management system. Sorting them back into order is similarily straight forward.

Archival boxes can be labelled with the serial number range of documents they contain. If the current trend continues, I will only use two archival boxes throughout my lifetime.

## Backup

As nice as a document management system is, it can break down and not having access to the bulk of my documents is a no go for me.

To keep the risk low I [export documents](https://docs.paperless-ngx.com/administration/#exporter) once every night from my paperless instance and periodically sync the dump to my mac. On the mac I can quickly search & use most documents with Finders integrated search features.

````
# export_paperless_kube.sh (run on my NAS)
#!/bin/bash

set -x

NAMESPACE="ix-paperless-ngx"
POD_NAME=$(k3s kubectl get pods -n $NAMESPACE | grep -v "pause\|redis\|postgres" | grep Running | cut -d " " -f 1)

k3s kubectl exec -n ${NAMESPACE} ${POD_NAME} -- document_exporter --delete /export
````

````
# papersync.sh (run on my desktop machine)
#!/bin/bash

set -ueo pipefail

rsync -avz $IP_OF_MY_NAS:/mnt/pool_one/paperless/export/ $HOME/Backups/paperless/.

tar -zcf $HOME/Backups/paperless-"$(date '+%Y-%m-%d').tar.gz" $HOME/Backups/paperless
````

## Enhancements and simplifications

For the time being I'm quite happy with my setup. Several aspects can be downgraded or upgraded, depending on taste, requirements and budget.

### Scanning

#### Upgrade

I have a USB attached ADF scanner. While quite fast, a [network attachd DADF document scanner](https://geizhals.de/?cat=scn&xf=15969_DADF%7E2881_Dokumentenscanner%7E777_LAN%7E778_Direktscan) would be even faster. 

Given paperless is running on my NAS, not even having to boot my computer would save some time. Modern models also scan a bit faster and more reliably than my model, which sometimes messes up the document feed.

#### Downgrade

With modern phones and sufficient lighting, scanning multiple documents after another is likely faster with the phone than with a flatbed scanner. 

With [Scan4Paperless](https://apps.apple.com/de/app/scan4paperless/id1629964055) there are even apps directly uploading scanned documents to a paperless instance.

But apples built in [document scanning feature](https://support.apple.com/HT210336) also works well. With [continuity camera](https://support.apple.com/102332) you can even trigger that feature directly from your mac.

This will be the most practical solution for most people that only digitize documents infrequently. Lighting is key here.

### Document management software

#### Upgrade

I am completely happy with paperless-ngx.  Possibly some dedicated cloud solution would be more accessible to others.

#### Downgrade

The cloud storage provider of your choice like Dropbox, iCloud, Google Documents, can probably do as well as a document repository. 

OCR would need to be handled by the operating system or your scan software and you may need to be more disciplined than I am in naming your files for easy retrieval.

The principle of assigning serial numbers would work just the same. Stamp the document, retrieve in archive box if needed.

Another step down would be keeping all your documents just on your local machine. For me quickly looking up everything from my phone is essential and I cannot imagine entering document metadata on my phone itself.

### Archiving paper originals

#### Upgrade

While bankers boxes are very cheap, they are not very sturdy. If you plan on adding / removing documents for quite some time and it should survive a few moves, investing in nicer system like Leitz Click & Store might be worth it. 

If you don't want to stamp or manually number your documents, paperless also supports recognizins ASN labels. They can be generated by script and printed on labels, so instead of stamping each document you put a sticker on each. This blog describes the process https://margau.net/posts/2023-04-16-paperless-ngx-asn/ . This saves you some time in manually entering the serial number, creating the ASN labels for me is just not worth it, as the stamped numbers are also read by OCR. Given that a paginating stamp is also somewhat pricy, buying some Avery 4731 labels may be more practical for most. 

#### Downgrade

Short of not keeping paper originals in the first place the only cheaper variant would be keeping everything in a big pile. 

For assigning the serial number a sharpie is a good low cost solution.

## Conclusion

With modern hard- and sofware and a bit of discipline, there is no reason to fiddle around with paper chaos or – even worse – wasting time sorting documents into folders. Most smartphones can do 80 % of what's described here and a simple box does the rest.

With this tax season is a non-event and quickly finding the receipt for that lifetime-guaranteed thing you have is a breeze.

## Further Reading

- Hufsky Livings German blog describes a lot of paperless features in depth, see https://hufsky-living.de/?s=Paperless
