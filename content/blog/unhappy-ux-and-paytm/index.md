---
title: Unhappy UX and Paytm
date: 2018-03-16
thumbnail: blog/unhappy-ux-and-paytm/images/
images: ["blog/unhappy-ux-and-paytm/images/"]
categories: ["general"]
tags: ["design", "digital-india", "digital-payments", "fintech", "india", "messy-ux", "mobile-design", "paytm", "technology", "ui-ux", "unhappy-ux", "upi"]
series: []
DisableComments: true
draft: false
---

When I returned to India I’d never used Paytm but I’d heard a lot about it. With an overnight [demonetization](https://en.wikipedia.org/wiki/2016_Indian_banknote_demonetisation) and [scan-to-pay QR codes](https://blog.paytm.com/accepting-payments-from-your-customers-through-paytm-qr-code-is-easier-than-ever-13ed06d8a4ba) located everywhere, Paytm has become the most recognizable digital payments company in India. It is now a bank, a mall, and a financial service provider. But I struggled with Paytm for over a week trying to figure out how to use the app. This is what the home screen looks like when you first open it.

\[gallery ids="1801,1802,1806,1807,1808" columns="5" size="large"\]

Clunky and overwhelming would be an understatement. The home screen scrolls further down quite a bit and is routinely interspersed with ads. There are numerous irrelevant things on it for a first time user. When you sign up the app registers your phone number as your login credential. However, to do any transactions you need to link your bank account which was the first big hurdle I ran into. There’s no prompt for this during sign-up and it’s not immediately evident where to do this. Tapping the standard Android menu icon (three horizontal lines in the top-left) produces a long list of actions for which I don’t have much context. I’d heard you have to “add money” to your Paytm wallet so I tap the first “recharge” option thinking it meant recharging your wallet and that it would prompt me to link a bank before recharging. That wasn't it. I looked around some more but gave up on the app soon after.

I came back to it some days later and after a few more attempts finally learned that the bank account setup is reached through the smiley face in the top-right corner which is barely visible with all the other noise in the app. Even going to this profile section reveals a list of actions I have zero knowledge or context about (even today after months of use). One would think Paytm ought to ship a PDF guide to its user alongside the app download.

### Paytm Transactions, or what I like to call the game of 'Where is My Money?'

Twice now I’ve lost money reloading Paytm through the Uber integration. Reloading PayTM wallet through Uber isn’t stable. This isn’t a network issue — something that is genuinely an issue in India. To book an Uber using Paytm you need a minimum balance in your wallet of Rs 325. When it’s below that Uber offers an integration to help you reload your balance. While doing this the transaction failed for me in the processing stage. This led to the money getting debited from my bank account but not showing up in the Paytm wallet. To Paytm’s credit, they are quick to confirm failed transactions and immediately informed me via text. Once they were able to confirm that the amount had been debited from my account they sent me a confirmation message. However, even though the transaction was confirmed by Paytm, the balance credited in the wallet didn’t reflect the correct amount.

\[caption id="attachment\_1794" align="aligncenter" width="345"\]![Image showing a text message with Paytm balance short of Rs. 350](images/IMG_20180315_233135_767-544x1024.jpg) Paytm balance short of Rs. 350\[/caption\]

To raise this issue I ran into another conundrum. What category does this issue fit in? It’s not in any of the following: _Managing my Paytm account_, _Recharge and Bill Payments_,  _Fund Transfer Issues_. Most surprisingly, it's not even under _Adding money to wallet_ which is exactly what it's doing (reloading money in your wallet). I found the transaction listed under _Payments using Wallet_ where there is a separate tab for “Added”. This list seems to be entirely different from the list of transactions located under the _Adding money to wallet_ option listed above even though from an end-user perspective both are doing the same thing. It doesn’t make sense why half of my transactions for adding money to the Paytm wallet would be in different sections varying on how the money was added (through Paytm vs third-party integration).

Further I found out that if you run into the peculiar case where your transaction went through successfully but your updated balance is incorrect, there seems to be no way to reach Paytm to correct this. The "suggestion" I get from their support channel is simply to go back and check my balance.

\[gallery ids="1796,1797,1810,1798" columns="4" size="large"\]

(At least I haven’t figured out their UI enough to know how to do this so if you know please guide me.)

I’ve been thinking a lot about such apps offering unhappy and irksome user experiences. I’ve had a similar experience in the past while trying to get a refund from Uber but at least in that case I was dealing with a customer service rep. I don’t even know how to try with Paytm’s preset responses other than to reach out over social media which is far from a viable support option for most people in India.

In India, where large swathes of the population are now reliant on digital solutions like Paytm to combat earlier issues of demonetization, financial access, and exclusivity, this messy UX coupled with the hard-to-reach customer support end up isolating the people from the service. The problems of transactions may not be frequent though they [exist in numbers](https://timesofindia.indiatimes.com/companies/transaction-issues-on-paytm-continue/articleshow/56141117.cms) but the overall confusing experience is not [uncommon](https://telecomtalk.info/paytm-customer-issue/123126/). The person who runs the lunch cafeteria at my workplace at Oracle no longer accepts Paytm. He lost Rs. 1000 in a transaction that showed successful on the customer’s phone but never ended up getting credited to his account. Unable to get his money back or figure out how to raise his issue he stopped accepting Paytm altogether. Who do you go to?

Confusion creates room for ambiguity which in turn reduces trust, and trust is arguably the most important criteria for a financial services company. Paytm can maybe afford this inconvenience right now as there is no equal player in the industry as yet. BHIM and Google Tez have nowhere near the same penetration while Whatsapp payments is still in beta. Frustrating experiences such as these that should be easy to resolve for a company like Paytm end up causing a lack of trust in the technology and in digital solutions in general. And a lack of trust in a service where there is high dependency (everyone needs to transfer money) results in customers jumping ship to where they get better service. Or at least products that don't further confuse them.

I have yet to see Whatsapp payments in action but I've heard people mention its simplicity. Like BHIM it is built on the [Unified Payments Interface (UPI)](http://cashlessindia.gov.in/upi.html)\[1\] so there is also no need for an intermediary "wallet" -- money moves directly between accounts. Once Whatsapp payments rolls out country-wide it will become the biggest direct competitor to Paytm simply on the merit of its large user base. Then it will likely come down to which service provides a more intuitive and comfortable experience to the customer.

 

* * *

\[1\] Paytm also has a Paytm BHIM UPI option now which offers a different way to pay than the regular payment option causing further confusion as to why there are two different options on the home screen to do the same thing.

<br>

---