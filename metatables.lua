local func_example = setmetatable({}, {__index = function (t, k)  -- {} an empty table, and after the comma, a custom function failsafe
  return "key doesn't exist"
end})

local fallback_tbl = setmetatable({   -- some keys and values present, together with a fallback failsafe
  foo = "bar",
  [123] = 456,
}, {__index=func_example})

local fallback_example = setmetatable({}, {__index=fallback_tbl})  -- {} again an empty table, but this time with a fallback failsafe

print(func_example[1]) --> key doesn't exist
print(fallback_example.foo) --> bar
print(fallback_example[123]) --> 456
print(fallback_example[456]) --> key doesn't exist

-----------------------------------------------------

-- index-related meta-methods

local table1=setmetatable({}, {
    __index=function (indexable_table, key)
        print("key-get",key)
    end,
    
    __newindex = function (indexable_table, key, value)
      print("key-set",key,value)
    end,
})

local result=table1["test_key"]
table1["test_key"]="test_value"
