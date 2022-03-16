-- CODE SECTION / PART: reusable functions ("library" functions)
-------------------------------------------------------

--- function sorted_hash() -- sorted_hash()

local sorted_hash_table_add_pair = function(hash_table, key_value_pair_to_add)
  local key, value
  key, value = key_value_pair_to_add[1],key_value_pair_to_add[2]
  
  -- insert by key
  hash_table.pairs_hash[key] = value
  
  -- sorted key (keep it in synch, see also key removal)
  table.insert(hash_table.sorted_keys, key)
end

local sorted_hash_table_remove_by_key = function(hash_table, key_to_remove)
  
  function remove_by_string_content(hash_table, key_to_remove)
    
    function find_position_of_content(table,what)
      for key,value in pairs(table) do
        if value==what then
          return key
        end
      end
    end
    
    local sorted_index = find_position_of_content(hash_table,key_to_remove)
    table.remove(hash_table, sorted_index)
  end
  
  remove_by_string_content(hash_table.sorted_keys, key_to_remove)
  hash_table.pairs_hash[key_to_remove]=nil
end

local sorted_hash_table_set_pair = function(hash_table, key_value_pair_to_set)
  local key, value
  key, value = key_value_pair_to_set[1],key_value_pair_to_set[2]
  
  local already_present = hash_table.pairs_hash[key]~=nil
    
  if not already_present and value~=nil then
    -- if there is not and is not nil
    sorted_hash_table_add_pair(hash_table,key_value_pair_to_set)
  else
    -- if there is and
    if value==nil then
      -- setting it to "nil" removes it
      sorted_hash_table_remove_by_key(hash_table,key)
    else
      -- if there is set it to a value ("assignment" over-writes, does not add)
      hash_table.pairs_hash[key]=value
    end
  end
  
  return value
end

------------------------------

local insertion_order_iterator = function(ordered_table)
  local accessed_table = ordered_table.sorted_keys
  local table_index = 1
  local size = #accessed_table -- table.getn(t)
  function next() -- closure: accessed_table, table_index, size
    if table_index <= size then -- if valid key
      
      local key, value -- access table
      
      key = accessed_table[table_index]
      value = ordered_table.pairs_hash[key]
      
      table_index = table_index + 1 -- next index
      return key, value -- return key-value pair
    end
    -- else return "nil" value ("nil" stops iteration)
   end
  return next -- return "next" function
end

local prepare = function(input_pairs) -- prepare it (initialization)
  local prepared={sorted_keys={}, pairs_hash={}}
  
  -- input pairs insertion
  local hash_table = prepared
  for index,pair in ipairs(input_pairs) do
    sorted_hash_table_add_pair(hash_table,pair)
  end
  
  -- adds "method" functions (members functions)
  hash_table.iterate = insertion_order_iterator
  hash_table.remove = sorted_hash_table_remove_by_key
  hash_table.set = sorted_hash_table_set_pair
  hash_table.get = function(hash_table, key) return hash_table.pairs_hash[key] end
  hash_table = setmetatable(hash_table, {
    
    -- key-get
    __index=function (indexable_table, key)
      return hash_table:get(key)
    end,
    
    -- key-set
    __newindex = function (indexable_table, key, value)
      return hash_table:set({key,value})
    end,

    -- pairs() iterator
    __pairs = function(a)
    
    
---function my_ipairs(a)

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
end, -- my_ipairs(a)

---return my_ipairs(a)

    ----end,

  }) -- hash_table meta-table
  
  return prepared
end -- prepare()

--- return prepare

--- end -- sorted_hash()

--- return sorted_hash

return prepare
