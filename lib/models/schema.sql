BEGIN;
Create Table If Not Exists"filetb"(
"filetbId" SERIAL Primary Key
,"url" Text not null 
,"isAbsolute" boolean  default false
,"size" Real  
,"hasDependent" boolean  default false
,"createdAt" timestamp  default now()
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
,"isEmailVerified" boolean  default false
,"isPhoneVerified" boolean  default false
,"userId" integer not null 
);
Create Table If Not Exists"emailchangerequest"(
"emailchangerequestId" SERIAL Primary Key
,"newEmail" Text not null 
,"userId" integer not null 
,"createdAt" timestamp  default now()
,"token" Text not null 
,"expiresAt" timestamp  
);
Create Table If Not Exists"phonechangerequest"(
"phonechangerequestId" SERIAL Primary Key
,"newPhone" Text not null 
,"userId" integer not null 
,"token" Text not null 
,"createdAt" timestamp  default now()
,"expiresAt" timestamp  
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
Create Table If Not Exists"unit"(
"unitId" SERIAL Primary Key
,"name" Text not null 
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
Create Table If Not Exists"business"(
"businessId" SERIAL Primary Key
,"name" Text not null 
,"ownerId" integer not null 
,"addressId" integer not null 
,"catagoryId" integer  
,"logoId" integer  
,"bgImage" Text  
,"createdAt" timestamp  default now()
);
Create Table If Not Exists"businessprefrences"(
"businessprefrencesId" SERIAL Primary Key
,"businessId" integer not null 
,"isAvailableOnline" boolean  default true
,"notifyNewProduct" boolean  default false
,"receiveOrder" boolean  default false
);
Create Table If Not Exists"businessacitivity"(
"businessacitivityId" SERIAL Primary Key
,"businessId" integer not null 
,"userId" integer  
,"action" Text  
);
Create Table If Not Exists"businessreview"(
"businessreviewId" SERIAL Primary Key
,"userId" integer not null 
,"businessId" integer not null 
);
Create Table If Not Exists"businessemploye"(
"businessemployeId" SERIAL Primary Key
,"userId" integer not null 
,"businessId" integer not null 
,"createdAt" timestamp  default now()
);
Create Table If Not Exists"businesspermission"(
"businesspermissionId" SERIAL Primary Key
,"name" Text not null 
);
Create Table If Not Exists"hasbusinesspermission"(
"hasbusinesspermissionId" SERIAL Primary Key
,"employeeId" integer not null 
,"businessId" integer not null 
,"permissionId" integer not null 
,"createdAt" timestamp  default now()
);
Create Table If Not Exists"product"(
"productId" SERIAL Primary Key
,"name" Text not null 
,"productUId" Text not null 
,"costPrice" Real not null 
,"sellingPrice" Real not null 
,"quantity" Real not null default '0'
,"businessId" integer not null 
,"brandId" integer  
,"catagoryId" integer  
,"unitId" integer  
,"expireDate" timestamp  
,"manDate" timestamp  
,"desc" Text  
);
Create Table If Not Exists"like"(
"likeId" SERIAL Primary Key
,"productId" integer not null 
);
Create Table If Not Exists"follow"(
"followId" SERIAL Primary Key
,"businessId" integer not null 
,"userId" integer not null 
);
Create Table If Not Exists"order"(
"orderId" SERIAL Primary Key
,"status" Text  
,"type" Text  
,"msg" Text  
,"businessId" integer not null 
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
,"businessId" integer  
,"redeemed" boolean  default false
,"expireDate" timestamp  
);
Create Table If Not Exists"blocked"(
"blockedId" SERIAL Primary Key
,"userId" integer  
,"businessId" integer  
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
,"businessId" integer not null 
,"userId" integer not null 
,"violatorId" integer  
,"productId" integer  
,"desc" Text  
);
ALTER TABLE "password" ADD CONSTRAINT password_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId") on Delete cascade;
ALTER TABLE "emailchangerequest" ADD CONSTRAINT emailchangerequest_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId") on Delete cascade;
ALTER TABLE "phonechangerequest" ADD CONSTRAINT phonechangerequest_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId") on Delete cascade;
ALTER TABLE "userinterestandinteraction" ADD CONSTRAINT userinterestandinteraction_catagory_catagory_fk FOREIGN KEY ("catagoryId") REFERENCES "catagory" ("catagoryId") on Delete NO ACTION;
ALTER TABLE "userinterestandinteraction" ADD CONSTRAINT userinterestandinteraction_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId") on Delete cascade;
ALTER TABLE "brand" ADD CONSTRAINT brand_catagory_catagory_fk FOREIGN KEY ("catagoryId") REFERENCES "catagory" ("catagoryId") on Delete cascade;
ALTER TABLE "business" ADD CONSTRAINT business_owner_user_fk FOREIGN KEY ("ownerId") REFERENCES "user" ("userId") on Delete cascade;
ALTER TABLE "business" ADD CONSTRAINT business_address_address_fk FOREIGN KEY ("addressId") REFERENCES "address" ("addressId") on Delete restrict;
ALTER TABLE "business" ADD CONSTRAINT business_catagory_catagory_fk FOREIGN KEY ("catagoryId") REFERENCES "catagory" ("catagoryId") on Delete set null;
ALTER TABLE "business" ADD CONSTRAINT business_logo_filetb_fk FOREIGN KEY ("logoId") REFERENCES "filetb" ("filetbId") on Delete NO ACTION;
ALTER TABLE "businessprefrences" ADD CONSTRAINT businessprefrences_business_business_fk FOREIGN KEY ("businessId") REFERENCES "business" ("businessId") on Delete NO ACTION;
ALTER TABLE "businessacitivity" ADD CONSTRAINT businessacitivity_business_business_fk FOREIGN KEY ("businessId") REFERENCES "business" ("businessId") on Delete cascade;
ALTER TABLE "businessacitivity" ADD CONSTRAINT businessacitivity_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId") on Delete set null;
ALTER TABLE "businessreview" ADD CONSTRAINT businessreview_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId") on Delete NO ACTION;
ALTER TABLE "businessreview" ADD CONSTRAINT businessreview_business_business_fk FOREIGN KEY ("businessId") REFERENCES "business" ("businessId") on Delete NO ACTION;
ALTER TABLE "businessemploye" ADD CONSTRAINT businessemploye_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId") on Delete cascade;
ALTER TABLE "businessemploye" ADD CONSTRAINT businessemploye_business_business_fk FOREIGN KEY ("businessId") REFERENCES "business" ("businessId") on Delete cascade;
ALTER TABLE "hasbusinesspermission" ADD CONSTRAINT hasbusinesspermission_employee_businessemploye_fk FOREIGN KEY ("employeeId") REFERENCES "businessemploye" ("businessemployeId") on Delete cascade;
ALTER TABLE "hasbusinesspermission" ADD CONSTRAINT hasbusinesspermission_business_business_fk FOREIGN KEY ("businessId") REFERENCES "business" ("businessId") on Delete cascade;
ALTER TABLE "hasbusinesspermission" ADD CONSTRAINT hasbusinesspermission_permission_businesspermission_fk FOREIGN KEY ("permissionId") REFERENCES "businesspermission" ("businesspermissionId") on Delete cascade;
ALTER TABLE "product" ADD CONSTRAINT product_business_business_fk FOREIGN KEY ("businessId") REFERENCES "business" ("businessId") on Delete cascade;
ALTER TABLE "product" ADD CONSTRAINT product_brand_brand_fk FOREIGN KEY ("brandId") REFERENCES "brand" ("brandId") on Delete set null;
ALTER TABLE "product" ADD CONSTRAINT product_catagory_catagory_fk FOREIGN KEY ("catagoryId") REFERENCES "catagory" ("catagoryId") on Delete set null;
ALTER TABLE "product" ADD CONSTRAINT product_unit_unit_fk FOREIGN KEY ("unitId") REFERENCES "unit" ("unitId") on Delete set null;
ALTER TABLE "like" ADD CONSTRAINT like_product_product_fk FOREIGN KEY ("productId") REFERENCES "product" ("productId") on Delete cascade;
ALTER TABLE "follow" ADD CONSTRAINT follow_business_business_fk FOREIGN KEY ("businessId") REFERENCES "business" ("businessId") on Delete cascade;
ALTER TABLE "follow" ADD CONSTRAINT follow_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId") on Delete cascade;
ALTER TABLE "order" ADD CONSTRAINT order_business_business_fk FOREIGN KEY ("businessId") REFERENCES "business" ("businessId") on Delete cascade;
ALTER TABLE "order" ADD CONSTRAINT order_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId") on Delete cascade;
ALTER TABLE "items" ADD CONSTRAINT items_product_product_fk FOREIGN KEY ("productId") REFERENCES "product" ("productId") on Delete cascade;
ALTER TABLE "items" ADD CONSTRAINT items_order_order_fk FOREIGN KEY ("orderId") REFERENCES "order" ("orderId") on Delete set null;
ALTER TABLE "notification" ADD CONSTRAINT notification_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId") on Delete NO ACTION;
ALTER TABLE "giftcard" ADD CONSTRAINT giftcard_owner_user_fk FOREIGN KEY ("ownerId") REFERENCES "user" ("userId") on Delete restrict;
ALTER TABLE "giftcard" ADD CONSTRAINT giftcard_createdBy_user_fk FOREIGN KEY ("createdById") REFERENCES "user" ("userId") on Delete set null;
ALTER TABLE "giftcard" ADD CONSTRAINT giftcard_product_product_fk FOREIGN KEY ("productId") REFERENCES "product" ("productId") on Delete set null;
ALTER TABLE "giftcard" ADD CONSTRAINT giftcard_business_business_fk FOREIGN KEY ("businessId") REFERENCES "business" ("businessId") on Delete set null;
ALTER TABLE "blocked" ADD CONSTRAINT blocked_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId") on Delete set null;
ALTER TABLE "blocked" ADD CONSTRAINT blocked_business_business_fk FOREIGN KEY ("businessId") REFERENCES "business" ("businessId") on Delete set null;
ALTER TABLE "blocked" ADD CONSTRAINT blocked_product_product_fk FOREIGN KEY ("productId") REFERENCES "product" ("productId") on Delete set null;
ALTER TABLE "report" ADD CONSTRAINT report_policy_policy_fk FOREIGN KEY ("policyId") REFERENCES "policy" ("policyId") on Delete set null;
ALTER TABLE "report" ADD CONSTRAINT report_business_business_fk FOREIGN KEY ("businessId") REFERENCES "business" ("businessId") on Delete cascade;
ALTER TABLE "report" ADD CONSTRAINT report_user_user_fk FOREIGN KEY ("userId") REFERENCES "user" ("userId") on Delete cascade;
ALTER TABLE "report" ADD CONSTRAINT report_violator_user_fk FOREIGN KEY ("violatorId") REFERENCES "user" ("userId") on Delete set null;
ALTER TABLE "report" ADD CONSTRAINT report_product_product_fk FOREIGN KEY ("productId") REFERENCES "product" ("productId") on Delete set null;
ALTER TABLE "user" ADD CONSTRAINT user_phoneNumber_unique UNIQUE ("phoneNumber");
ALTER TABLE "user" ADD CONSTRAINT user_email_unique UNIQUE ("email");
ALTER TABLE "catagory" ADD CONSTRAINT catagory_name_unique UNIQUE ("name");
ALTER TABLE "brand" ADD CONSTRAINT brand_name_unique UNIQUE ("name");
ALTER TABLE "unit" ADD CONSTRAINT unit_name_unique UNIQUE ("name");
ALTER TABLE "business" ADD CONSTRAINT business_addressId_unique UNIQUE ("addressId");
ALTER TABLE "businessprefrences" ADD CONSTRAINT businessprefrences_businessId_unique UNIQUE ("businessId");
COMMIT;
