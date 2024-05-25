package com.coor.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;

public class FileUtils {
  public static String uploadFile(String uploadFolder, String uploadDateFolder, MultipartFile uploadFile) {
    String uploadFileName = "";
    File uploadFolderPath = new File(uploadFolder, uploadDateFolder);
    if (!uploadFolderPath.exists())
      uploadFolderPath.mkdirs(); 
    String uploadClientFileName = uploadFile.getOriginalFilename();
    UUID uuid = UUID.randomUUID();
    uploadFileName = String.valueOf(uuid.toString()) + "_" + uploadClientFileName;
    try {
      File saveFile = new File(uploadFolderPath, uploadFileName);
      uploadFile.transferTo(saveFile);
      if (checkImageType(saveFile)) {
        FileOutputStream thumnail = new FileOutputStream(new File(uploadFolderPath, "s_" + uploadFileName));
        Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumnail, 100, 100);
        thumnail.close();
      } 
    } catch (Exception ex) {
      ex.printStackTrace();
    } 
    return uploadFileName;
  }
  
  public static String getFolder() {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Date date = new Date();
    String str = sdf.format(date);
    return str.replace("-", File.separator);
  }
  
  private static boolean checkImageType(File saveFile) {
    boolean isImage = false;
    try {
      String contentType = Files.probeContentType(saveFile.toPath());
      isImage = contentType.startsWith("image");
    } catch (Exception ex) {
      ex.printStackTrace();
    } 
    return isImage;
  }
  
  public static ResponseEntity<byte[]> getFile(String uploadPath, String fileName) throws IOException {
    ResponseEntity<byte[]> entity = null;
    File file = new File(uploadPath, fileName);
    if (!file.exists())
      return entity; 
    HttpHeaders headers = new HttpHeaders();
    headers.add("Content-Type", Files.probeContentType(file.toPath()));
    entity = new ResponseEntity(FileCopyUtils.copyToByteArray(file), (MultiValueMap)headers, HttpStatus.OK);
    return entity;
  }
  
  public static void deleteFile(String uploadPath, String folderName, String fileName) {
    (new File((String.valueOf(uploadPath) + folderName + "/" + fileName).replace('/', File.separatorChar))).delete();
    (new File((String.valueOf(uploadPath) + folderName + "/" + "s_" + fileName).replace('/', File.separatorChar))).delete();
  }
}
