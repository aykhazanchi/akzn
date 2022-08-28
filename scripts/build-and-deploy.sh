rm -rf ./public/akzn.me/*
mkdir -p ./public/
hugo --gc --minify
echo "----------------------------------------------------------"
echo "Running a draft deployment"
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
#rsync -av ./public/akzn.me akzn:~/
#scp -r ./public/akzn.me akzn.me:~/
