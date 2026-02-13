---
layout: post
title: 'Creating posts for jekyll / github.io from Inoreader'
---

I am long time user of Inoreader and have just setup this github.io page (again) based on Jekyll.

Since Google Reader I am looking for a quick way to share interesting articles to my blog. Luckily Inoreader and GitHub have the extension points to make that possible.

### configurie sharing service

On Inoreader select any one article and click the top right dropdown next to the already existing sharing buttons. Then click *configure*.

Deselect *Shorten URLs before sharing* then click *Add custom site*.

Now you can name your service and configure how to pass the article data through a URL. Inoreader supports multiple placeholders:

> http://you.wordpress.com/wp-admin/press-this.php?u=[URL]&t=[TITLE]&s=[CONTENT]
> 
> To send an article to your Wordpress blog
> 
> URL Variables:
> 
> [TITLE], [TITLE_NOENC], [URL], [CONTENT], [SOURCE]

To figure out what the URL has to look like, we need to understand how GitHub expects the data to look.

### parameterizing the post

GitHub.com lets you create a new file by [opening the corresponding URL](https://stackoverflow.com/questions/27778095/github-url-to-create-new-file-with-specific-name):

> You can set the parameter filename in the URL. You can even add some content to the new file. For instance, to create a new file called newtest.py with default value PUT YOUR CODE HERE, use the following URL:
>
> https://github.com/Pithikos/C-Thread-Pool/new/master/tests?filename=newfile.py&value=PUT%20YOUR%20CODE%20HERE

Now you basically need to combine the two and create a new-post URL appropriate for your setup. This should work for all sorts of github-based workflows and not be limited to Jekyll or github.io specifically.
                               
A minimum viable jekyll-post looks as follows:

````markdown
---
layout: post
title: 'TITLE'
---
[TITLE](URL)
````



https://github.com/mknudsen/mknudsen.github.io/new/master/?filename=_posts/2022-XX-YY-[TITLE].md&value=[[TITLE]]([URL])

title: '[TITLE]'

I have not found a way to neatly input the current date into the filename or slugify the title automatically.
