---
title: "The Fight Against Link Rot"
date: 2021-05-05
tags: ["blog", "archiving links"]
draft: true
---
    
Link rot is the term given to the decay of [hyperlinks](https://www.computerhope.com/jargon/h/hyperlink.htm): The accumulation of links leading to broken or dead websites. Link rot a pet peeve of mine and [happens with alarming frequency](https://harvardlawreview.org/2014/03/perma-scoping-and-addressing-the-problem-of-link-and-reference-rot-in-legal-citations/). When surfing the internet I am expecting any link I encounter to work. Link rot shatters these expectations and can make reading frustrating.

Previously, [I experimented with providing archived links for each link present]({{ relref . "why-im-using-a-notation.md }}). This so-called (a) notation provides an alternative, archived link should the primary link rot. In theory, these snapshots of web pages minimise the impact of link rot. Unfortunately, these websites can themselves rot, and these (a) links are cryptic. What would you think and do if you saw a link followed by (a)? Would you click on the link, discover it's dead, and then try the (a) link instead?

The majority of readers don't care whether a link is archived or not (if you do I'm curious to know why). Readers expect links to work all day, every day. How this is done is the website's business and not the user's, it is a matter of infrastructure. By following links with (a) we leak the archiving aspect into the wild. Using an archived page should be built into the links. When the user clicks a link they should arrive at the intended page whether archived or not.

With this in mind, I embarked on a journey to remove these (a) links and build a system to archive links before they rot.

In my naiveté I thought the process would look something like: 1) scanning markdown files checked into git for links, 2) archiving, or downloading them to a web server 3) updating the markdown files with the archived links. After some investigation I came to realise that, as with many things, it's much more complicated than that.

What follows details my design and development log. It is largely inspired by [gwern's own system](https://www.gwern.net/Archiving-URLs).

# The Overall Process

I've identified four primary steps to protect my content from link rot:

1. Extracting links from the articles
2. Archiving those links
3. Checking the blog for broken links
4. Fixing the broken links

To proceed further we must discuss the components which are used in each of these four steps.

## Extracting Links From Articles

The gist of this step is in the name. Find and collate the links present in an article. Because the articles use a pre-defined link format, this becomes a matter of parsing the article content.

## Archiving Links

If we do not archive a link before rot sets in, we have lost our chance. This means archiving is the most core step.

Archiving creates a snapshot of the webpage at a particular point in time. It is these snapshots that we use in later steps to fix the rot. 

There are two main schools of thought here: local and remote caching. 

Before going into the difference between the two, let's clarify what I mean by "cache" here. A cache is a system which holds copies of the links present on my website, but not every link. 

### Remote Caches

The internet has pre-existing archival services available e.g., [Archive.org](https://www.archive.org). These can be slow. Being beyond my control they can also be subject to link rot.

### Local Caches

Services hosted by me. Typically, these are hosted from my computer, but I am considering services hosted services under my control as the same. These methods offer greater control, but at the cost of maintenance, and for hosted services, monetary cost.

Besides remote and local caches, I believe there are two other schools of thought: immediate and delayed caching.

### Immediate Caching

The best example of this would be to archive (cache) browser history as you surf. This reduces the risk of link rot by minimising the time between opening a page and archiving. Increased CPU utilisation is one drawback to this as the archiver is constantly running, and large storage consumption as you cannot easily filter out what is and isn’t useful until later. The impact of this is disproportionately large when one spends most of one’s time browsing for leisure, not research purposes.

### Delayed Caching

An example of this would be to archive the links present when an article is published. Because the time between finding the source and publishing can be anywhere from minutes to years, the risk of links rotting in the meantime can be high. Not only is the risk higher, but once a link is rotten, finding an archived version is very difficult to impossible.

At least your computer performance won't be hampered.

## Checking For Broken Links

This step operates on published articles. Published articles are those which are live on the website. This is in contrast to the extraction step which operates on the files themselves. For example, a book draft on the author’s computer versus the printed book.

The difference lies in what this step does with the links it finds. It tries to visit each webpage reference by the link. If it’s unable to reach the website, it must tell the next step somehow.

This step should be automatically run on a regular interval to keep up with rot.

## Fixing Broken Links

Any links reported as broken by the previous step need to be ‘fixed’. Here ‘fixed’ means the archiving system replaced the rotten link with a cached/archived version. The new, cached version must be publicly accessible to readers.

One important factor to consider here is that the archived page used must be the same one when the article was written: Pages can evolve, hence, when reference dates in bibliographies.

# The Components

{{< figure src="img/2021/archiving/link-archiving.svg title="Components in the link archiving process" >}}

## Blog

Publishing an article involves creating a pull request. On this pull request, the pipeline seen in the sequence diagram is run.

## Archiver Script

{{< figure src="img/posts/2021/archiving/archiver-script.svg" title="The archiver script flow" >}}

As part of this pull request, the [GitHub Actions](https://docs.github.com/en/actions/quickstart) Runner executes a workflow. [This workflow](https://github.com/thomaspaulin/blog.thomaspaulin.me/blob/master/.github/workflows/link-archiver.yml) uses an [Action I have created](https://github.com/thomaspaulin/markdown-link-finder/releases/tag/v1) to scan the modified and added markdown files. This scan looks for any [links](https://www.markdownguide.org/basic-syntax#links) present, checks they are valid, and then it submits any links it finds to the Link Archive.

Initially, this step used [SingleFile](https://github.com/gildas-lormeau/SingleFile), a browser extension which downloads a web page and its dependencies into a... single file. By saving in this manner we can bypass the archive component too and upload directly to S3. In an ideal world I would have run the [SingleFile CLI](https://github.com/gildas-lormeau/SingleFile/tree/master/cli) with [a customised](https://github.com/uBlockOrigin/uBlock-issues/issues/1111) [uBlock Origin](https://ublockorigin.com/) installed as blocking advertisements and disabling [cookie banners](https://www.vox.com/recode/2019/12/10/18656519/what-are-cookies-website-tracking-gdpr-privacy) improves reader experience, [without a negative effect on performance](https://kevin.borgolte.me/files/pdf/www2020-privacy-extensions.pdf). Alas, configuring SingleFile as I desired proved to be much more work than I had anticipated and instead I opted to use an existing piece of archiving software.

## Link Archive

### "Hardware" Used

I've seen people archive taking the local and immediate caching approach. As discussed earlier this approach brings the risk of link rot close to zero, especially when browser history is fed directly into the archiving software. I opted for a more delayed approach for a few reasons. 

The ratio between pages I wish to link and pages I visit is tiny. This means enormous archives for just a handful of links. While storage is cheap, this is a needless expense given how few links I need to archive. 

I don't want to take a performance hit by constantly archiving each web page I open. I must confess I haven't verified how much of an impact this would actually be.

More important than storage and performance implications though is that I use multiple devices. Creating and/or setting up infrastructure to send history from each device to a central archive takes time and complexity. More time than fixing the odd broken link before I publish. Especially given writing these posts is a hobby rather than a full-time position. 

If instead, I opt for one archive on each device I lower complexity, but introduce the challenge of managing and synchronising archives across multiple devices. Perhaps a [Network Attached Storage (NAS)](https://en.wikipedia.org/wiki/Network-attached_storage) which hosts the archive program and receives browser history from each of my devices is a good idea. Indeed, if it’s exposed to the world and accessible when I’m travelling, it is. The drawback of a NAS though is that it requires investment in physical hardware and proper backup discipline, lest I lose the entire archive I add to the rot. 

All these factors led me to rent a [Virtual Private Server (VPS)](https://en.wikipedia.org/wiki/Virtual_private_server). My [Hetzner VPS](https://www.hetzner.com/cloud) (recommended by friends in the known and whom I trust, as well as Reddit) offers the benefit of a NAS that is publicly available without breaking the bank. Because of bandwidth limits, and the storage limited mentioned, I have accepted there will be a delay in finding a source and archiving. Git's pre/post-commit hooks can reduce this delay. I intend to investigate their feasibility in the future.

### Software Used

{{< figure src="img/posts/2021/archiving/nginx-and-bridge.svg" title="Nginx and Archive Box bridge setup" >}}

I chose [Archive Box](https://archivebox.io/) as my archiving software. It bundles SingleFile for downloading entire pages. It also uploads to [[Archive.org](http://archive.org)](https://www.archive.org) to assist with the global digital archiving effort. Should I make changes and include uBlock Origin in the future, by using Archive Box others will also have access to those changes. It seems fair given I receive such features from those who came before.

Another option would be [Archive Team's Warrior project](https://wiki.archiveteam.org/index.php/ArchiveTeam_Warrior) but they intend this to be used for contributing to their archiving project rather than running a specific personal archive.

I used remote caching in the form of existing archiving services when I took the (a) links approach. I found them to be slow and painful to use when writing articles. In addition, I had seen them rot first hand. Local caching offers more control and an improved reader and writer experience once set up.

Therefore, I chose Archive Box. I run it via [Docker Compose](https://docs.docker.com/compose/) for simplicity's sake.

Because Archive Box runs either as a CLI on the local machine, or as a web UI, I needed to build a bridge between its CLI and the workflow on GitHub. I used [Nginx as a reverse proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/) to do this. Nginx calls [an HTTP server written in Go](https://github.com/thomaspaulin/archive-box-bridge), which runs on the same machine as Archive Box, and calls the Archive Box CLI to start the archiving. By evoking an executable (`docker-compose`) I've created an additional attack surface on my VPS. I've tried to adhere to the [principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege) in order to reduce the attack surface's impact.

## Link Checker

A script powered by [Broken Link Checker](https://github.com/stevenvachon/broken-link-checker) runs automatically as a [cron job](https://en.wikipedia.org/wiki/Cron) and crawls the entire blog starting from the [home page](https://blog.thomaspaulin.me/). It checks each link it discovers against an "ignore list" before deciding to proceed. The ignore list contains the hosts considered reliable. The script will not archive links from these hosts, as they have proven themselves stable. An example is Wikipedia. Wikipedia's articles last a long time and their URL format remains consist. Wikipedia's risk (and benefit) comes from publicly editable content, which is in flux.

When the script finds broken, and "unignored" link, it notes down the link. Once crawling completes the script emails me the list of broken links indexed by the blog page they came from.

These links are then checked by me and fixed as per the Link Fixing Process.

For now, there are few enough links that I can review each one. This allows me to err on the side of caution and include false positives: I can check for false positives more reliably than my code can.

This script runs once a month.

## Link Fixing Process

Currently, this is a manual process. I experimented with automating this process. [It ended up taking more time](https://xkcd.com/1205/) than manually replacing the odd link. This is especially true because the running scripts email me exactly what broke. Until the link count on this blog grows substantially, replacing rotten links by hand is sufficient.

The process itself goes something like this:

1. Check whether the link is broken and is not a false positive.
2. Look in Archive Box for the snapshot representing the original link. The latest snapshot may have removed or changed necessary information.
3. Upload the SingleFile page to S3 with S3 set up to serve files publicly.
4. Note down the S3 resource identifier.
5. Update the post's Markdown with the new identifier
6. Create a pull request with the changes and merge it to master

{{< figure src="img/posts/2021/archiving/link-fixing-process.svg" title="Link fixing process" >}}

### Why S3?

The archived links need to be publicly available, otherwise readers cannot visit them. Thus, we require some kind of file server. I considered the following options:

1. A typical web server, hosted on a VPS.
2. The aforementioned Archive services.
3. [IPFS](https://ipfs.io/)
4. Cloud hosted storage ([Amazon Web Services' Simple Storage Service (S3)](https://aws.amazon.com/s3/). 

Since we archive the entire page, including media, the space requirements are potentially large. This equates to higher costs when using a VPS. Higher than I'm willing to pay for a personal website when there are other options to consider.

Existing archive services offer a solution to the storage costs, but are slow and susceptible to rot.

IPFS is a distributed system. This reduces the risk of rot and the space requirements. Unfortunately, it is slow and [browser support of the IPFS protocol is limited](https://brave.com/brave-integrates-ipfs/).

This lead me to Amazon's Simple Storage Service, or S3. S3 can serve files like a web server. Thanks to Amazon's extensive infrastructure, it is fast and low cost. This introduces a dependency on AWS to the archiving system, but my blog already depends AWS, so we did not introduce further dependencies.

# Where To From Here?

First, the system needs to run in the wild for some time to evaluate its performance and maintenance requirements. Once I have a better feeling for how it practically works, I will consider improvements which may include some of:

- Run the archiver script after 90 days for each post. This means keeping track of a schedule for each post. Useful for discussions which take time to settle. 90 days is roughly how long a web page will live.
- Ignore top-level domains for link finding and archiving (e.g. example.com as opposed to example.com/posts/2021/4/28/the-use-of-examples). Top-level domains rarely provide information that would be useful for posts. Linking to them in an article should save the user time and allow them to visit linked companies/services without performing a search.
- Upgrade the bridge to use asynchronous endpoints, and implement a job system. This will allow for scaling improvements as the current implementation is limited by Nginx's `proxy_timeout`.
- Evaluate automation of the link fixing process.
