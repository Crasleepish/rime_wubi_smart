--[[
用于分号临时英文模式的翻译器
--]]
function semicolon_eng_translator(input, seg)
  local s=input:sub(seg.start, seg._end)
  if ( s:sub(1,1)==";" and s:len()>1) then
    yield(Candidate("eng", seg.start, seg._end, s:sub(2), ""))
  end
end


function single_char_first_filter(input)
  local l = {}
  for cand in input:iter() do
    if (utf8.len(cand.text) == 1) then
      yield(cand)
    else
      table.insert(l, cand)
    end
  end
  for i, cand in ipairs(l) do
    yield(cand)
  end
end



function date_translator(input, seg)
  -- 如果输入串为 `date` 则翻译
  if (input == "date") then
    --[[ 用 `yield` 产生一个候选项
         候选项的构造函数是 `Candidate`，它有五个参数：
          - type: 字符串，表示候选项的类型
          - start: 候选项对应的输入串的起始位置
          - _end:  候选项对应的输入串的结束位置
          - text:  候选项的文本
          - comment: 候选项的注释
     --]]
    yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "日期"))
    --[[ 用 `yield` 再产生一个候选项
         最终的效果是输入法候选框中出现两个格式不同的当前日期的候选项。
    --]]
    yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "日期"))
  end
end
