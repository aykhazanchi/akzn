rm -rf ./public/akzn.me/*
mkdir -p ./public/akzn.me
hugo -D
mv ./public/* ./public/akzn.me/
netlify deploy
#rsync -av ./public/akzn.me akzn:~/
#scp -r ./public/akzn.me akzn.me:~/
