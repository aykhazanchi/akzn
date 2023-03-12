---
title: "Netlify Deploys"
date: 2023-03-12T15:15:01+01:00
categories: ["code"]
tags: [code, netlify, hugo, cicd, github]
skills: [CICD, Netlify, Hugo, Bash]
series: []
DisableComments: true
draft: false
---

[Github Link](https://github.com/aykhazanchi/akzn)

This site finally uses automated CICD deployments on push! Here's the roundabout story of how it took way longer than it should have and left me unsatisfied in the end.

Sometime last year I switched to using Hugo for this site. I stopped paying for my wasteful combo of Wordpress + Dreamhost shared hosting that kept having DNS or MySQL issues that resulted in my domain going offline (sometimes for hours). So when I switched to Hugo I switched also to giving [Netlify](https://netlify.com/) a try. 

Alas, Hugo has a [documentation problem](https://news.ycombinator.com/item?id=30527884) and I started out doing everything pretty much the exact opposite way of how I should have been doing things. One of these wrong things was using Git submodules for pulling in open-source themes ([which they themselves _still_ recommend?!](https://gohugo.io/getting-started/quick-start/#commands)). 

Turns out Netlify deploys have a huge amount of confusion/issues with Git submodules and in order to deploy the site to Netlify you have to either package the whole theme into the `themes` directory (which means pushing someone else's work into your own repository) or revert a lot of things to use the theme as a Hugo module. This isn't really explained well anywhere in the Hugo docs but is a problem present on Netlify forums.

So for a while I was pushing to Netlify by building the site locally and using some good-old-bash-engineering to run a deploy. Now that I switched (finally) to using Hugo modules and Netlify deploys my site automatically to production with each commit I actually realize that though this automated CI/CD offers some ease, I actually liked my script a bit better. The thing with the script is that it did a draft deployment first and prompted me before it ran a production deployment. It allowed me just that one last check before a push to prod. With Netlify I have to login each time now to Netlify to check if the deployment finished without any errors. There's also no check for draft deployment first (though maybe this is configurable and I haven't checked). Sometime automation ends up leading to more work 🤷🏻‍♂️🤷🏻‍♂️🤷🏻‍♂️. 

Anyway, here's the script that I was using before.

```bash
# build-and-deploy.sh
rm -rf ./public/akzn.me/*
mkdir -p ./public/
hugo --gc --minify
echo "----------------------------------------------------------"
echo "Running a draft deployment"
echo "Make sure all drafts are set to false in order to publish them"
echo "----------------------------------------------------------"
netlify deploy
echo "----------------------------------------------------------"
read -p "Do you want to proceed with production deploy? (y/n) " yn

case $yn in 
	[yY] ) netlify deploy --prod;
        break;;
	[nN] ) echo exiting...;
		exit;;
	* ) echo invalid response;
esac
```

<br>

---