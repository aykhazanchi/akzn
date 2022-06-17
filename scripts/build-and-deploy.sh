rm -rf ./public/akzn.me/*

mkdir -p ./public/akzn.me

hugo

mv ./public/* ./public/akzn.me/

scp -r ./public/akzn.me akzn:~/
