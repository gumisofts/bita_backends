DROP SCHEMA public CASCADE;

CREATE SCHEMA public;

--@block
SELECT
    *
from
    "user"
order by
    "userId";

--@block
SELECT
    *
from
    "password";

--@block
Alter table "product"
add column "unit" Text;