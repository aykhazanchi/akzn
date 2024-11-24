---
title: "Cloud Resume"
date: 2023-03-12T20:30:14+01:00
categories: ["code"]
tags: [go, resume, aws, aws sam, dynamodb, aws lambda, cloudformation, cloudfront, api gateway]
skills: [AWS, Golang, Cloud Resume, DynamoDB, Infrastructure as Code]
series: []
DisableComments: true
draft: false
---

[My Cloud Resume](https://resume.akznapps.net/)

My resume is now deployed as a cloud resume. For the last two years I've been studying for a master in Distributed Systems @ KTH and I'm now starting to get back into the job search. While looking around to see what would be a good way to keep my [cloud skills updated](/about) while also learning something new, I found the [Cloud Resume Challenge](https://cloudresumechallenge.dev/docs/the-challenge).

The general idea of the challenge is to deploy an HTML version of your resume on the cloud provider of your choice, with a custom domain connected to a CDN distribution, with the requests going through an API gateway to an object storage of some sort. There are also some steps to deploy serverless functions that update a visitor count in a KV database as well as for the entire stack to eventually be automated via an infrastructure as code configuration. 

Note: I modified some of these steps for my liking. Below I describe the process of what I did and what I learned. In the spirit of the challenge not being a tutorial, I won't provide the full code here as it's better and more rewarding to spend some time to figure things yourself. However, there are snippets and I am happy to share the code with someone who needs help or is stuck. Just reach out.

### The Cloud Resume Challenge
```bash
- [ ] 1. Certification
- [x] 2. HTML
- [x] 3. CSS
- [x] 4. Static Website
- [x] 5. HTTPS
- [x] 6. DNS
- [x] 7. Javascript (Frontend visits update)
- [x] 8. Database
- [x] 9. API
- [x] 10. Python
- [x] 11. Tests
- [x] 12. Infrastructure as Code
- [x] 13. Source Control
- [ ] 14. CI/CD (Back end)
- [ ] 15. CI/CD (Front end)
- [x] 16. Blog post
```

### Step 1

I did this challenge on AWS. I think I would repeat this in the future for GCP since GCP feels a bit more mature in terms of UX/documentation but it's partly to test that hypothesis. Either way, I think it's a bit overkill to do an entire certification first but I can see how it might help as otherwise all the technology can get quite confusing. I have a lot of this general knowledge through my [seven years at Oracle](/about) before so I skipped the first step.

### Step 12

Step 12 is actually step 1 because, in true Cloud Engineer fashion 😎, I did this step first as starting with IaC is always a good idea. Unfortunately, this ended up being the largest time-sink for me in the whole process. The reason is that I chose to not use Terraform. I have used Terraform before at work and wanted to try CloudFormation instead. Then I found out there is something else called [AWS Serverless Application Model (SAM)](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html) that is extension of AWS CloudFormation? Sometimes it feels like there are twenty different ways to do something in AWS. SAM, when deployed, creates a CloudFormation stack in the background so I figured I'd try SAM instead. This was a pretty bad (or maybe good) idea in that I spent way too long trying to figure out how to create the SAM templates for each AWS resource. Since the templates are the same as CloudFormation templates I think I would have run into this problem either way. Quite a mess and I think in the future I would stick to Terraform instead. I wasted too much time on Googling around on this and still there are things like ACM certificate creation and some other things that I didn't manage to get working through this.

But one thing that is pretty cool about SAM and maybe also is there with CF is that I can see all the resources of one stack in one place in the CloudFormation console. Not sure this is possible to see in the AWS console with Terraform.

### Steps 2 - 4

I also didn't bother with the HTML/CSS steps. I have a better solution. My resume is a word/PDF doc that is a single source of truth that sits on my local drive and syncs with Google Drive. Each time I edit the docx version of my resume, I create a new PDF in the same location and the PDF gets synced to Google Drive near instantly. The PDF file on Google Drive is shared as a public link and so long as I keep the names of the files the same, the public link serves the new updates near instantly. Since this is a PDF and the point of the challenge is to serve your resume, I render this public PDF link through an HTML iframe in the index.html file that sits in an AWS S3 bucket.

Now, if I update my local resume and create a new PDF the updates will spawn through to Google Drive and therefore also to the cloud resume near instantly. Pretty nifty, I think. 😏

### Steps 5 - 6 

I bought the domain `akznapps.net` with AWS Route53 and I serve the resume through a subdomain `resume.akznapps.net` that is SSL-enabled. This part caused a bunch of issues with AWS SAM as the certificate creation and validation just wouldn't finish through SAM. It didn't error out either. However, first creating and validating the certificate manually allowed SAM to go through and apply it to the CloudFront distribution. I was also building almost all of this in `eu-north-1` where I'm located and then I realized that certs have to be stored in `us-east-1` otherwise SAM/CloudFormation doesn't have access to them. This was quite frustrating and I spent too long on this part for my own liking. Once I enabled the certificates in `us-east-1`, I ran into more issues. found that I had to change my CloudFront distribution to force HTTPS (`redirect-to-https`) otherwise it wouldn't work.

```yaml
        DefaultCacheBehavior:
          ViewerProtocolPolicy: redirect-to-https # had to switch this from 'allow-all' to force certs to work

        ...

        Origins:
          - DomainName: S3EndpointParam
            Id: S3EndpointParam
            CustomOriginConfig:
              OriginProtocolPolicy: https-only # had to switch this from 'allow-all' to force certs to work
```
        

### Steps 7 - 9

This project uses AWS DynamoDB which took a bit to figure out. It's mostly understanding the difference between Items and Attributes and Partition Keys and how they're defined in the SAM template. Took a while to figure this out but it wasn't too bad. What did take long is that I was using `count` as one of the keywords somewhere and DynamoDB was throwing an error. It was related to the fact that somewhere in DynamoDB `count` is a reserved keyword 😩 but either it was not showing it or I was not seeing it (I was doing this stuff late nights so it's possible I was just blind with tiredness).

```yaml
      AttributeDefinitions:
        - AttributeName: "ID" # defines this as a partition key
          AttributeType: "S" 
          # key "visits" is a string, hence 'S'.
          # If you use a number, it's 'N'. So random.
```    

The API Gateway is fairly straightforward as it got created with the SAM Hello World template and provides a staging and prod endpoint.

### Steps 10 - 11

I used Go instead of Python to interact with DynamoDB through the Lambda functions and I also created them using the [pre-built SAM templates](https://docs.aws.amazon.com/lambda/latest/dg/go-image.html). I have two functions - one that increments a counter in DynamoDB with each new visit/refresh and one that reads DynamoDB for the latest number of visits. I've been wanting to play around with Go for a while and thought this was simple enough that I could try it out. Boy, it took a while. If I had done this in Python I probably could have written the code for this in a few minutes or so but it took me a while to figure out with Go. At first the syntax was a bit confusing but then also I spent way too long debugging the DynamoDB keyword issue. At first I thought it was a Go issue or something I was doing wrong in the code. That being said, I've enjoyed what little Go I wrote for this and plan to continue playing with it on the side.

I didn't do much for the tests outside of the template tests that are provided. What I did notice that was kind of interesting is that running Go tests for my _GET function_ was failing to run successfuly because of a module error in my _PUT function_ even though they were sitting in different directories with different `go.mod` files. Not sure what was going on here.

```go
    // Search by Key
    Key: map[string]*dynamodb.AttributeValue{
			"ID": {
				S: aws.String("visits"),
			},
		},
    
    ...
    
    // ExpressionAttribute
    ExpressionAttributeValues: map[string]*dynamodb.AttributeValue{
			":num": {
				N: aws.String("1"),
			},
		},
```

### Step 13 - 15

My frontend is a simple html file with some minor styling so it sits in the same private repo as my backend code. I couldn't for the life of me get Github Actions to work with deploying and syncing this repo because of some issue with Github Actions calling/using AWS credentials. At this point I was spending too many nights on this project and just wanted it out the door. I think sometimes it's easier to just write a makefile or a [good-old bash script](/code/netlify-deploys) instead of over-engineering something 🤷🏻‍♂️. Maybe I'll look at this again in the future when I have time or when I do this with GCP + Terraform.

### Fin

When learning programming or a new framework/technology, Hello World is almost always the starting point. Coming from a cloud/platform engineering background, I have wondered for a while what a "Cloud Hello World" would comprise. I think this is a great challenge to learn about some cloud providers and build some skills around connecting different parts of the "cloud stack" but I think this challenge is a bit too "challenging" to be a good "Cloud Hello World" candidate. I think maybe I just need to get around to compiling my own Cloud Hello World steps. Then again, the "cloud" space itself is so big that maybe there's no good Hello World for it.


<br>