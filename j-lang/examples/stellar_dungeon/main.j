# STELLAR DUNGEON
# A small ASCII dungeon map + treasure hunt in J

out("")
out("  *** STELLAR DUNGEON ***")
out("  -----------------------")
out("")

# Dungeon map: each row is a string. # = wall, . = floor, * = treasure, @ = you
str | row0 -> "#########"
str | row1 -> "#.....#.#"
str | row2 -> "#.@.....#"
str | row3 -> "#.....*.#"
str | row4 -> "#########"

list | map -> [row0, row1, row2, row3, row4]

out("  Map:")
out("  +---------+")
for row in map {
    out(concat("  |", row, "|"))
}
out("  +---------+")
out("")
out("  Legend: @ you, . floor, # wall, * treasure")
out("")

# Stats
int | health -> 100
list | loot -> [10, 25, 50, 15]
int | gold -> 0
out(concat("  Health: ", health))
out(concat("  Gold: ", gold))
out("")

# Use language features: sum loot, pipeline
int | total_loot -> sum(loot)
out(concat("  Treasure chests (values): ", loot))
out(concat("  Total loot available: ", total_loot))
gold = gold + total_loot
out("")

# Filter "big" loot (>= 20) for a bonus message
list | big_loot -> filter(loot, |x| x >= 20)
out(concat("  Big finds (>= 20): ", big_loot))
out("")

out("  === FINAL STATS ===")
out(concat("  Health: ", health))
out(concat("  Gold: ", gold))
out("")
out("  Thanks for playing STELLAR DUNGEON!")
out("")
