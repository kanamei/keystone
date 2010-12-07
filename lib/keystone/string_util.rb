# -*- coding: utf-8 -*-
module Keystone
  class StringUtil
    def self.int_to_splitted_path(i_value,value_length,base_folder,suffix="")
      file_name = Integer(i_value).to_s
      raise RangeError,"value_length must bigger than 0" if value_length < 1
      raise RangeError, 'i_value length is bigger than value_length' if file_name.size > value_length
      file_name = file_name.rjust(value_length, '0')
      new_path = base_folder.dup
      group_regex = ""
      i = value_length
      group_cnt = 0
      loop do
        group_cnt += 1
        if i > 2
          group_regex << "(\\d\\d\\d)"
          i -= 3
          break if i < 1
        else
          group_regex = "(#{"\\d"*i})" + group_regex
          break
        end
      end
      file_name.gsub(/#{group_regex}/) do |hit|
        1.upto(group_cnt) do |i|
          new_path << "/#{Regexp.last_match[i]}"
        end
      end
      new_path << suffix if suffix != ""
      return new_path
    end
    
    def self.reverse_mail_address(mail)
      if mail.index('@') == nil
        return mail
      end
      user,dom = mail.split('@')
      if dom == nil
        return "@#{user}"
      end
      return dom.split('.').reverse.join(".") + "@" + user
    end
    
    MULTIBYTE_SPACE = [0x3000].pack("U")
    PRESERVED_QUERY_WORDS_RE = /(AND|OR|ANDNOT)/
    #
    # adviced by Mr.morohashi
    #
    def self.serach_string_to_array(query)
      tokens = query.scan(/'([^']*)'|"([^"]*)"|([^\s#{MULTIBYTE_SPACE}]*)/).flatten.reject{|i| i == nil || i == "" }
      tokens.map do |token|
        next unless token
        #token.gsub!(PRESERVED_QUERY_WORDS_RE, $1.downcase) if token =~ PRESERVED_QUERY_WORDS_RE
        token.gsub!(/\A['"]|['"]\z/, '') # strip quatos
        token
      end
    end
    
    #
    #
    # TODO
    def self.downcase_roma_number(st)
      st.tr("ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩ", "ⅰⅱⅲⅳⅴⅵⅶⅷⅸⅹ")
    end

    #
    # making search text for indexing
    #
    def self.to_searchtext(str)
      self.downcase_roma_number(Moji.han_to_zen(
          #Moji.zen_to_han(str,Moji::ZEN_ALNUM | Moji::ZEN_SYMBOL).downcase,Moji::HAN_KATA | Moji::HAN_JSYMBOL).tr("ｰ～／","ー~/")
          Moji.zen_to_han(str,Moji::ZEN_ALNUM | Moji::ZEN_SYMBOL).downcase,Moji::HAN_KATA | Moji::HAN_JSYMBOL)
      )
    end    

    #
    # tagで指定したhtmlタグを削除する
    #
    # erace_all = true でタグのcontentsも丸ごと削除
    #
    def self.remove_html_tag(html,tag,erace_all = false)
      poss = []
      last_hit = 0
      next_check_start = 0
      str = html.clone
      strori = str.clone
      loop do
        pos,size=nil,nil
        if pos = str =~ /(<#{tag}.*?>)/
          size = $1.size
        else
          break
        end
        last_hit = next_check_start + pos
        next_check_start = last_hit + size
        poss << last_hit
        str = str[pos+size..-1]
      end

      poss.reverse!
      str = strori

      poss.each do |pos|
        str1 = str[0..pos-1]
        str2 = str[pos..-1]
        str1 = '' if pos == 0
        if erace_all
          str2.sub!(/<#{tag}.*?>(.*?)<\/#{tag}>/mi){''}
        else
          str2.sub!(/<#{tag}.*?>(.*?)<\/#{tag}>/mi){$1}
        end
        str = str1 + str2
      end
      return str
    end

    #
    #
    # 指定された文字列より[A-z0-9-_.]以外を取り除く
    #
    #
    #
    def to_fileable_st(st)
      st.gsub(/[^\w\-_\.]/,"")
    end
  end
end
