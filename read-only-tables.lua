-- https://www.lua.org/pil/13.4.5.html
-- with further tests

function readOnly (t)
  local proxy = {}
  local mt = {       -- create metatable
    __index = t,
    __newindex = function (t,k,v)
      error("attempt to update a read-only table", 2)
    end
  }
  setmetatable(proxy, mt)
  return proxy
end

days = readOnly{"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
--days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}

print(days[1])     --> Sunday
--days[2] = "Noday"  --> stdin:1: attempt to update a read-only table

table.insert(days,"insertion-test")
print(days[8]) -- nil when using "readOnly"