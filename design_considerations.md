# HOTEL DESIGN

## Possible Options

1. Get rid of individual Room objects and just have Room(s) be all the rooms as a hash, with the key as the room number and the values as an array
2. Remove room array from booking manager and make a class method of rooms. Do
the same with Reservations
3. Get rid of the manager class completely and just use rooms and reservations
with hashes.

## Rooms
### From specs
- I can reserve a room for a given date range
- About
  - 20 rooms
  - numbered 1 through 20
  - identical
  - costs $200/night
- I can view a list of rooms that are not reserved for a given date range
- I can reserve an available room for a given date range
- I can create a block of rooms
  - To create a block you need a date range, collection of rooms and a discounted room rate
  - collection of rooms should only include rooms that are available for the given date range
  - If a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block
  - I can check whether a given block has any rooms available
  - I can reserve a room from within a block of rooms
  - A block can contain a maximum of 5 rooms
  - I can reserve a room from within a block of rooms
  - When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
  - All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations
### Thoughts amount needs
- Need dates for





### Reservations
- I can access the list of all of the rooms in the hotel
- I can access the list of reservations for a specific date
- I can get the total cost for a given reservation
- last day of a reservation is the checkout day, so the guest should not be charged for that night
- reservation is allowed start on the same day that another reservation for the same room ends

As an administrator, I can reserve a room from within a block of rooms
Constraints
A block can contain a maximum of 5 rooms
When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations
