BEGIN;
Create Table If Not Exists"filetb"(
"filetbId" SERIAL Primary Key
,"url" Text not null 
,"isAbsolute" boolean  default false
);
Create Table If Not Exists"user"(
"userId" SERIAL Primary Key
,"firstName" Text  
,"lastName" Text  
,"phoneNumber" Text  
,"email" Text  
,"createdAt" timestamp  default now()
,"updatedAt" timestamp  default now()
);
Create Table If Not Exists"password"(
"passwordId" SERIAL Primary Key
,"password" Text  
,"emailOtp" Text  
,"phoneOtp" Text  
,"userId" integer not null 
);
Create Table If Not Exists"userinterestandinteraction"(
"userinterestandinteractionId" SERIAL Primary Key
,"catagoryId" integer not null 
,"userId" integer not null 
);
Create Table If Not Exists"catagory"(
"catagoryId" SERIAL Primary Key
,"name" Text not null 
,"desc" Text  
);
Create Table If Not Exists"brand"(
"brandId" SERIAL Primary Key
,"name" Text not null 
,"catagoryId" integer  
,"desc" Text  
);
Create Table If Not Exists"address"(
"addressId" SERIAL Primary Key
,"lat" Real  
,"lng" Real  
,"plusCode" Text  
,"sublocality" Text  
,"locality" Text  
,"admin1" Text  
,"admin2" Text  
,"country" Text  
);
Create Table If Not Exists"shop"(
"shopId" SERIAL Primary Key
,"name" Text not null 
,"ownerId" integer not null 
,"addressId" integer not null 
,"catagoryId" integer  
,"logo" Text  
,"bgImage" Text  
,"createdAt" timestamp  default now()
);
Create Table If Not Exists"shopprefrences"(
"shopprefrencesId" SERIAL Primary Key
,"shopId" integer  
,"isAvailableOnline" boolean  default true
,"notifyNewProduct" boolean  default false
,"receiveOrder" boolean  default false
);
Create Table If Not Exists"shopacitiviy"(
"shopacitiviyId" SERIAL Primary Key
,"userId" integer not null 
,"action" Text  
);
Create Table If Not Exists"shopreview"(
"shopreviewId" SERIAL Primary Key
,"userId" integer not null 
,"shopId" integer not null 
);
Create Table If Not Exists"product"(
"productId" SERIAL Primary Key
,"name" Text not null 
,"buyingPrice" Real not null 
,"sellingPrice" Real not null 
,"quantity" integer not null default '0'
,"desc" Text  
);
Create Table If Not Exists"like"(
"likeId" SERIAL Primary Key
,"productId" integer not null 
);
Create Table If Not Exists"follow"(
"followId" SERIAL Primary Key
,"shopId" integer not null 
,"userId" integer not null 
);
Create Table If Not Exists"order"(
"orderId" SERIAL Primary Key
,"status" Text  
,"type" Text  
,"msg" Text  
,"shopId" integer not null 
,"userId" integer not null 
);
Create Table If Not Exists"items"(
"itemsId" SERIAL Primary Key
,"productId" integer not null 
,"quantity" integer not null default '0'
,"orderId" integer  
,"createdAt" timestamp  default now()
);
Create Table If Not Exists"notification"(
"notificationId" SERIAL Primary Key
,"userId" integer not null 
,"timestamp" timestamp not null 
,"title" Text not null 
,"content" Text not null 
,"type" Text not null 
);
Create Table If Not Exists"giftcard"(
"giftcardId" SERIAL Primary Key
,"couponId" Text not null 
,"ownerId" integer not null 
,"createdById" integer  
,"productId" integer  
,"shopId" integer  
,"redeemed" boolean  default false
,"expireDate" timestamp  
);
Create Table If Not Exists"blocked"(
"blockedId" SERIAL Primary Key
,"userId" integer  
,"shopId" integer  
,"productId" integer  
,"endDate" timestamp  
);
Create Table If Not Exists"policy"(
"policyId" SERIAL Primary Key
,"number" integer  
,"detail" Text  
,"createdAt" timestamp not null default now()
);
Create Table If Not Exists"report"(
"reportId" SERIAL Primary Key
,"policyId" integer  
,"shopId" integer not null 
,"userId" integer not null 
,"violatorId" integer  
,"productId" integer  
,"desc" Text  
);
ALTER TABLE "password" ADD CONSTRAINT password_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId");
ALTER TABLE "userinterestandinteraction" ADD CONSTRAINT userinterestandinteraction_catagory_catagory_fk FOREIGN KEY ("catagoryId") REFERENCES "catagory" ("catagoryId");
ALTER TABLE "userinterestandinteraction" ADD CONSTRAINT userinterestandinteraction_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId");
ALTER TABLE "brand" ADD CONSTRAINT brand_catagory_catagory_fk FOREIGN KEY ("catagoryId") REFERENCES "catagory" ("catagoryId");
ALTER TABLE "shop" ADD CONSTRAINT shop_owner_user_fk FOREIGN KEY ("ownerId") REFERENCES "user" ("userId");
ALTER TABLE "shop" ADD CONSTRAINT shop_address_address_fk FOREIGN KEY ("addressId") REFERENCES "address" ("addressId");
ALTER TABLE "shop" ADD CONSTRAINT shop_catagory_catagory_fk FOREIGN KEY ("catagoryId") REFERENCES "catagory" ("catagoryId");
ALTER TABLE "shopprefrences" ADD CONSTRAINT shopprefrences_shop_shop_fk FOREIGN KEY ("shopId") REFERENCES "shop" ("shopId");
ALTER TABLE "shopacitiviy" ADD CONSTRAINT shopacitiviy_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId");
ALTER TABLE "shopreview" ADD CONSTRAINT shopreview_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId");
ALTER TABLE "shopreview" ADD CONSTRAINT shopreview_shop_shop_fk FOREIGN KEY ("shopId") REFERENCES "shop" ("shopId");
ALTER TABLE "like" ADD CONSTRAINT like_product_product_fk FOREIGN KEY ("productId") REFERENCES "product" ("productId");
ALTER TABLE "follow" ADD CONSTRAINT follow_shop_shop_fk FOREIGN KEY ("shopId") REFERENCES "shop" ("shopId");
ALTER TABLE "follow" ADD CONSTRAINT follow_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId");
ALTER TABLE "order" ADD CONSTRAINT order_shop_shop_fk FOREIGN KEY ("shopId") REFERENCES "shop" ("shopId");
ALTER TABLE "order" ADD CONSTRAINT order_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId");
ALTER TABLE "items" ADD CONSTRAINT items_product_product_fk FOREIGN KEY ("productId") REFERENCES "product" ("productId");
ALTER TABLE "items" ADD CONSTRAINT items_order_order_fk FOREIGN KEY ("orderId") REFERENCES "order" ("orderId");
ALTER TABLE "notification" ADD CONSTRAINT notification_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId");
ALTER TABLE "giftcard" ADD CONSTRAINT giftcard_owner_user_fk FOREIGN KEY ("ownerId") REFERENCES "user" ("userId");
ALTER TABLE "giftcard" ADD CONSTRAINT giftcard_createdBy_user_fk FOREIGN KEY ("createdById") REFERENCES "user" ("userId");
ALTER TABLE "giftcard" ADD CONSTRAINT giftcard_product_product_fk FOREIGN KEY ("productId") REFERENCES "product" ("productId");
ALTER TABLE "giftcard" ADD CONSTRAINT giftcard_shop_shop_fk FOREIGN KEY ("shopId") REFERENCES "shop" ("shopId");
ALTER TABLE "blocked" ADD CONSTRAINT blocked_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId");
ALTER TABLE "blocked" ADD CONSTRAINT blocked_shop_shop_fk FOREIGN KEY ("shopId") REFERENCES "shop" ("shopId");
ALTER TABLE "blocked" ADD CONSTRAINT blocked_product_product_fk FOREIGN KEY ("productId") REFERENCES "product" ("productId");
ALTER TABLE "report" ADD CONSTRAINT report_policy_policy_fk FOREIGN KEY ("policyId") REFERENCES "policy" ("policyId");
ALTER TABLE "report" ADD CONSTRAINT report_shop_shop_fk FOREIGN KEY ("shopId") REFERENCES "shop" ("shopId");
ALTER TABLE "report" ADD CONSTRAINT report_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId");
ALTER TABLE "report" ADD CONSTRAINT report_violator_user_fk FOREIGN KEY ("violatorId") REFERENCES "user" ("userId");
ALTER TABLE "report" ADD CONSTRAINT report_product_product_fk FOREIGN KEY ("productId") REFERENCES "product" ("productId");
ALTER TABLE "user" ADD CONSTRAINT user_phoneNumber_unique UNIQUE ("phoneNumber");
ALTER TABLE "user" ADD CONSTRAINT user_email_unique UNIQUE ("email");
ALTER TABLE "catagory" ADD CONSTRAINT catagory_name_unique UNIQUE ("name");
ALTER TABLE "brand" ADD CONSTRAINT brand_name_unique UNIQUE ("name");
ALTER TABLE "shop" ADD CONSTRAINT shop_addressId_unique UNIQUE ("addressId");
ALTER TABLE "shopprefrences" ADD CONSTRAINT shopprefrences_shopId_unique UNIQUE ("shopId");
COMMIT;
