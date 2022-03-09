function list_iterator (accessed_table)
  local table_index = 1
  local size = #accessed_table -- table.getn(t)
  function next() -- closure: accessed_table, table_index, size
    if table_index <= size then -- if valid key
      local key, value = table_index, accessed_table[table_index] -- access table
      table_index = table_index + 1 -- next index
      return key, value -- return key-value pair
    end
    -- else return "nil" value ("nil" stops iteration)
   end
  return next -- return "next" function
end

for key, value in list_iterator({10,20}) do
  print(key, value)
end
