package entities;

public class Slide {
	private int id_slide;
	private String des_slide;
	private String pic_slide;
	private int id_product;
	private String name_product;
	private int price_product;
	private int discount_product;
	public int getId_slide() {
		return id_slide;
	}
	public void setId_slide(int id_slide) {
		this.id_slide = id_slide;
	}
	public String getDes_slide() {
		return des_slide;
	}
	public void setDes_slide(String des_slide) {
		this.des_slide = des_slide;
	}
	public String getPic_slide() {
		return pic_slide;
	}
	public void setPic_slide(String pic_slide) {
		this.pic_slide = pic_slide;
	}
	public int getId_product() {
		return id_product;
	}
	public void setId_product(int id_product) {
		this.id_product = id_product;
	}
	public String getName_product() {
		return name_product;
	}
	public void setName_product(String name_product) {
		this.name_product = name_product;
	}
	public int getPrice_product() {
		return price_product;
	}
	public void setPrice_product(int price_product) {
		this.price_product = price_product;
	}
	public int getDiscount_product() {
		return discount_product;
	}
	public void setDiscount_product(int discount_product) {
		this.discount_product = discount_product;
	} 
	
}
