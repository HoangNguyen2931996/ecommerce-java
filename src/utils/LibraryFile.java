package utils;

public class LibraryFile {
	
	public static String rename(String fileName){
		String[] arrImg =  fileName.split("\\.");
		String duoiFileImg = arrImg[arrImg.length - 1];
		String nameFile = "";
		for (int i  = 0;i< (arrImg.length - 1) ; i++) {
			if(i == 0){
				nameFile = arrImg[i];
			}else{
				nameFile += "-"+arrImg[i];
			}
		}
		nameFile = nameFile + "-"+System.nanoTime() +"."+duoiFileImg;
		return nameFile;
	}
/*	public static String addNameFile(List<String> fileNames){
		String str = "";
		if(fileNames == null || fileNames.size() == 0){
			return "";
		}
		for (String objFileNames : fileNames) {
			str = str+"/"+ objFileNames;
		}
		return str;
	}
	public List<String> splitString(String str){
		str = str.replaceFirst("/", "");
		String[] alStr = str.split("/");
		List<String> fileNames = new ArrayList<String>();
		for (String string : alStr) {
			fileNames.add(string);
		}
		return fileNames;
	}*/
}
