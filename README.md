# Black Beard Burguer App

This is an delivery app built to improve my flutter skils at beginning. this app has no commercial porpouses, only for study. That's my first application built in Flutter and helped me a lot to understand how it all works! you can check release section to download the app for Android devices! you can download the admin app for windows too. The admin app receive orders from delivery apps, update menu, add and remove items from menu, and close/open the restaurant!. Black Beard Burguer is a restaurant next to my house and I decided to use their logos and burgers to feel creating a real project!



![Apple 1](https://user-images.githubusercontent.com/86686024/208271358-7a8127ce-0b48-42e6-93a3-c4798f9abc04.png)
![Apple 2](https://user-images.githubusercontent.com/86686024/208271367-431c9881-f807-43da-9f53-566d8d530874.png)
![Apple 3](https://user-images.githubusercontent.com/86686024/208271371-9c086587-6ca7-4c66-baab-1f7b27324b2a.png)
![Apple 4](https://user-images.githubusercontent.com/86686024/208271372-eeb22813-a39f-4f97-92f1-91c91a52b52e.png)


# Database

I decided to use firebase to this project 'cause the flutter and firebase works good together, and firebase has a good and easy to implement database. And the best, firebase has a good free tier, where you can do almost anything.

# API 
When I was building the app for Windows, I realized Firebase doesn't support windows :( so I built an API to have communication between Delivery App and Admin app.  I watched some videos on youtube and created an API in node.js, which I now almost nothing! but you can check that API on Restaurant_API repo

# Functions

In this app you can create an account, log-in on an existing account, add your address, add some burguer to your cart and buy them! when the API confirm the payment, your cart items and your address to receive, go directly to restaurant app (Restaurant_admin).

# Payment

I Also implemented some payment forms, the most interesting payment that I implemented, is PIX, a common payment used in Brazil. To implement this, I used the Mercado Pago API

#State Management

I used BloC to this app because that's the first state management that I Learned, and when I was developing, BloC was the only state management that I knew

# Notes

If you gonna test the app, the payments in PIX gonna generate a copy and paste key with R$ 0.01 to test the payment!

You only can do orders if the store is open, you can open/close store in the admin app

