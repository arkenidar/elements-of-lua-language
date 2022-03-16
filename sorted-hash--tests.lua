-------------------------------------
-- CODE SECTION / PART: TESTING

print("------------TESTS-----------")

function tests()

local input_pairs={
{"nord","north"},
{"sud","south"},
{"ovest","west"},
{"est","east"},
}
print("INPUT PAIRS:")
for index,pair in ipairs(input_pairs) do
  local key, value
  key, value = pair[1],pair[2]
  print(key, value)
end

local prepare_sorted_hash = require("sorted-hash")

local hash_table = prepare_sorted_hash(input_pairs)

print("HASH TABLE (not necessarily sorted in insertion order):")
for key,value in pairs(hash_table.pairs_hash) do
  print(key,value)
end

function my_ipairs(a)

function closure_iter(t)
local i = 0 -- stateful iterator
function iterate1(t)
  i = i + 1
  local v = t.sorted_keys[i]
  local returned = t.pairs_hash[v]
  return v,returned
  --return next(t)
end
return iterate1
end

  ---return iterate1, a, 0
  return closure_iter(a), a, 0
end

local sorted_iteration = function(hash_table)
  ---for key, value in hash_table:iterate() do
  ---for key, value in pairs(hash_table) do
  ---for key, value in next1,hash_table do
  ---for key, value in iterate1(hash_table) do
  ---for key, value in my_ipairs(hash_table) do
  for key, value in pairs(hash_table) do
    print(key, value)
  end
end
print("SORTED HASH TABLE: (sorted in insertion order)")
sorted_iteration(hash_table)


print("REMOVE BY KEY.")
local key_to_remove="nord"
hash_table:remove(key_to_remove)

print("AFTER REMOVAL:")
sorted_iteration(hash_table)

-- TESTS for SET PAIR
hash_table:set({"nord","North, re-added (insertion order)"})
print("AFTER SET-PAIR (add-when-missing case):")
sorted_iteration(hash_table)

hash_table:set({"nord","North, updated (re-insertion order)"})
print("AFTER SET-PAIR (update-existing case):")
sorted_iteration(hash_table)

hash_table:set({"nord",nil})
print("AFTER SET-PAIR (delete case):")
sorted_iteration(hash_table)

-----------------------

print("GET(key) method TEST:")
print("got:", hash_table:get("sud"))

-- access[] TESTs
print("access[] TESTs:")
hash_table["sud"] = "AXIS"
hash_table["nord"] = hash_table["sud"]
sorted_iteration(hash_table)

end -- tests()

tests()
