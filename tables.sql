CREATE TABLE "customers" (
  "id" BIGSERIAL PRIMARY KEY,
  "fullName" TEXT NOT NULL,
  "cpf" INTEGER UNIQUE NOT NULL,
  "email" TEXT NOT NULL,
  "password" TEXT NOT NULL
);

CREATE TABLE "customerPhones" (
  "id" BIGSERIAL PRIMARY KEY,
  "customerId" INTEGER REFERENCES "customers"("id") NOT NULL,
  "phone" INTEGER NOT NULL,
  "type" VARCHAR(50) NOT NULL CHECK("type" = 'landline' OR "type" = 'mobile')
);

CREATE TABLE "bankAccount"(
  "id" BIGSERIAL PRIMARY KEY,
  "customerId" INTEGER REFERENCES "customers"("id") NOT NULL,
  "accountNumber" INTEGER NOT NULL,
  "agency" INTEGER NOT NULL,
  "openDate" TIMESTAMP DEFAULT NOW(),
  "closeDate" TIMESTAMP DEFAULT NULL
);

CREATE TABLE "states"(
  "id" BIGSERIAL PRIMARY KEY,
  "name" TEXT NOT NULL
);

CREATE TABLE "cities"(
  "id" BIGSERIAL PRIMARY KEY,
  "name" TEXT NOT NULL,
  "stateId" INTEGER REFERENCES "states"("id") NOT NULL
);

CREATE TABLE "costumerAdressess"(
  "id" BIGSERIAL PRIMARY KEY,
  "customerId" INTEGER REFERENCES "customers"("id") NOT NULL,
  "street" TEXT NOT NULL,
  "number" INTEGER NOT NULL,
  "complement" TEXT,
  "postalCode" INTEGER NOT NULL,
  "cityId" INTEGER REFERENCES "cities"("id") NOT NULL
);

CREATE TABLE "transactions"(
  "id" BIGSERIAL PRIMARY KEY,
  "bankAccountId" INTEGER REFERENCES "bankAccount"("id") NOT NULL,
  "amount" INTEGER NOT NULL,
  "type" TEXT CHECK("type" = 'deposit' OR "type" = 'withdraw') NOT NULL,
  "time" TIMESTAMP DEFAULT NOW() NOT NULL,
  "description" TEXT,
  "cancelled" TIMESTAMP
);

CREATE TABLE "creditCards"(
  "id" BIGSERIAL PRIMARY KEY,
  "bankAccountId" INTEGER REFERENCES "bankAccount"("id") NOT NULL,
  "name" TEXT NOT NULL,
  "number" INTEGER NOT NULL,
  "securityCode" INTEGER NOT NULL,
  "expirationMonth" INTEGER NOT NULL,
  "expirationYear" INTEGER NOT NULL,
  "password" INTEGER NOT NULL,
  "limit" INTEGER NOT NULL
);