# Design Options

1. Get rid of individual Room objects and just have Room(s) be all the rooms as a hash, with the key as the room number and the values as an array
2. Remove room array from booking manager and make a class method of rooms. Do
the same with Reservations
3. Get rid of the manager class completely and just use rooms and reservations
with hashes.
