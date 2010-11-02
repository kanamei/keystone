# -*- coding: utf-8 -*-
class Dir


  # TODO
  # replace FileUtils.mkdir_p
  def self.mkdir_r(dirPath)
    folders = dirPath.split('/')
    folderToCreate = ''
    folders.each do |folder|
      folderToCreate += folder + '/'
      if !File.directory?(folderToCreate)
        Dir.mkdir(folderToCreate)
      end
    end
  end  
end