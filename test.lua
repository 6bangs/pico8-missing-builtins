missing = require('package_missing')

describe("missing -setmetatable-", function()
  it("should set a metatable", function()
    local Test_missing = {}
    Test_missing.__index = Test_missing
    function Test_missing:_init (name)
      self.name = name
    end
    local Test_native = {}
    Test_native.__index = Test_missing
    function Test_native:_init (name)
      self.name = name
    end
    local mt = {
      __call = function (cls, ...)
        local self = setmetatable({}, cls)
        self:_init(...)
        return self
      end
    }

    setmetatable(Test_native, mt)
    missing.setmetatable(Test_missing, mt)
    assert.are.equals(
      getmetatable(Test_native),
      getmetatable(Test_missing)
    )
    assert.truthy(Test_native("native"))
    assert.truthy(Test_missing("missing"))
  end)
end)

describe("missing -getmetatable-", function()
  it("should get a metatable", function()
    local Test = {}
    Test.__index = Test
    local mt = {
      __call = function (cls, ...)
        local self = setmetatable({}, cls)
        return self
      end
    }
    missing.setmetatable(Test, mt)
    assert.are.equals(
      getmetatable(Test),
      missing.getmetatable(Test)
    )
  end)
end)

describe("missing -rawget-", function()
  it("should get raw value", function ()
    local setValue = 125
    local Test = {
      value = setValue
    }
    local defaultValue = "#default"
    local mt = {
      __index = function (tbl, key)
        return defaultValue
      end
    }
    missing.setmetatable(Test, mt)
    assert.are.equals(
      Test.doNotExist,
      defaultValue
    )
    assert.are.equals(
      rawget(Test, 'doNotExist'),
      nil
    )
    assert.are.equals(
      rawget(Test, 'doNotExist'),
      missing.rawget(Test, 'doNotExist')
    )
    assert.are.equals(
      missing.rawget(Test, 'value'),
      setValue
    )
  end)
end)

describe("missing -unpack-", function()
  it("should unpack table", function()
    local unpack_table = {1,2,3,4,5}
    local unpack_i = 0
    local unpack_j = 0
    local a, b, c, d, e, f, g, h = missing.unpack(unpack_table)
    local _a, _b, _c, _d, _e, _f, _g, _h = unpack(unpack_table)
    assert.are.equals(a, _a)
    assert.are.equals(b, _b)
    assert.are.equals(c, _c)
    assert.are.equals(d, _d)
    assert.are.equals(e, _e)
    assert.are.equals(f, _f)
    assert.are.equals(g, _g)
    assert.are.equals(h, _h)
  end)

  it("should unpack table with i as argument", function()
    local unpack_table = {1,2,3,4,5}
    local unpack_i = 3
    local unpack_j = 0
    local a, b, c, d, e, f, g, h = missing.unpack(unpack_table, unpack_i)
    local _a, _b, _c, _d, _e, _f, _g, _h = unpack(unpack_table, unpack_i)
    assert.are.equals(a, _a)
    assert.are.equals(b, _b)
    assert.are.equals(c, _c)
    assert.are.equals(d, _d)
    assert.are.equals(e, _e)
    assert.are.equals(f, _f)
    assert.are.equals(g, _g)
    assert.are.equals(h, _h)
  end)

  it("should unpack table with negative i as argument", function()
    local unpack_table = {1,2,3,4,5}
    local unpack_i = -2
    local unpack_j = 0
    local a, b, c, d, e, f, g, h = missing.unpack(unpack_table, unpack_i)
    local _a, _b, _c, _d, _e, _f, _g, _h = unpack(unpack_table, unpack_i)
    assert.are.equals(a, _a)
    assert.are.equals(b, _b)
    assert.are.equals(c, _c)
    assert.are.equals(d, _d)
    assert.are.equals(e, _e)
    assert.are.equals(f, _f)
    assert.are.equals(g, _g)
    assert.are.equals(h, _h)
  end)

  it("should unpack table with i > #unpack_table as argument", function()
    local unpack_table = {1,2,3,4,5}
    local unpack_i = 8
    local unpack_j = 0
    local a, b, c, d, e, f, g, h = missing.unpack(unpack_table, unpack_i)
    local _a, _b, _c, _d, _e, _f, _g, _h = unpack(unpack_table, unpack_i)
    assert.are.equals(a, _a)
    assert.are.equals(b, _b)
    assert.are.equals(c, _c)
    assert.are.equals(d, _d)
    assert.are.equals(e, _e)
    assert.are.equals(f, _f)
    assert.are.equals(g, _g)
    assert.are.equals(h, _h)
  end)

  it("should unpack table with i and j as argument", function()
    local unpack_table = {1,2,3,4,5}
    local unpack_i = 3
    local unpack_j = 5
    local a, b, c, d, e, f, g, h = missing.unpack(unpack_table, unpack_i, unpack_j)
    local _a, _b, _c, _d, _e, _f, _g, _h = unpack(unpack_table, unpack_i, unpack_j)
    assert.are.equals(a, _a)
    assert.are.equals(b, _b)
    assert.are.equals(c, _c)
    assert.are.equals(d, _d)
    assert.are.equals(e, _e)
    assert.are.equals(f, _f)
    assert.are.equals(g, _g)
    assert.are.equals(h, _h)
  end)

  it("should unpack table with negative i and j as argument", function()
    local unpack_table = {1,2,3,4,5}
    local unpack_i = -1
    local unpack_j = 3
    local a, b, c, d, e, f, g, h = missing.unpack(unpack_table, unpack_i, unpack_j)
    local _a, _b, _c, _d, _e, _f, _g, _h = unpack(unpack_table, unpack_i, unpack_j)
    assert.are.equals(a, _a)
    assert.are.equals(b, _b)
    assert.are.equals(c, _c)
    assert.are.equals(d, _d)
    assert.are.equals(e, _e)
    assert.are.equals(f, _f)
    assert.are.equals(g, _g)
    assert.are.equals(h, _h)
  end)

  it("should unpack table with i > #unpack_table and j as argument", function()
    local unpack_table = {1,2,3,4,5}
    local unpack_i = 10
    local unpack_j = 4
    local a, b, c, d, e, f, g, h = missing.unpack(unpack_table, unpack_i, unpack_j)
    local _a, _b, _c, _d, _e, _f, _g, _h = unpack(unpack_table, unpack_i, unpack_j)
    assert.are.equals(a, _a)
    assert.are.equals(b, _b)
    assert.are.equals(c, _c)
    assert.are.equals(d, _d)
    assert.are.equals(e, _e)
    assert.are.equals(f, _f)
    assert.are.equals(g, _g)
    assert.are.equals(h, _h)
  end)

  it("should unpack table with negative i and negative j as argument", function()
    local unpack_table = {1,2,3,4,5}
    local unpack_i = -1
    local unpack_j = -6
    local a, b, c, d, e, f, g, h = missing.unpack(unpack_table, unpack_i, unpack_j)
    local _a, _b, _c, _d, _e, _f, _g, _h = unpack(unpack_table, unpack_i, unpack_j)
    assert.are.equals(a, _a)
    assert.are.equals(b, _b)
    assert.are.equals(c, _c)
    assert.are.equals(d, _d)
    assert.are.equals(e, _e)
    assert.are.equals(f, _f)
    assert.are.equals(g, _g)
    assert.are.equals(h, _h)
  end)
end)

describe("missing -ipairs-", function()
  it("should iterate a table with i,v as for values", function()
    local test_table = {2,4,8,16,32,64,128,256,512,1024}
    for i,v in ipairs(test_table) do
      assert.are.equals(2^i, v)
    end
    for i,v in missing.ipairs(test_table) do
      assert.are.equals(2^i, v)
    end
  end)
end)
