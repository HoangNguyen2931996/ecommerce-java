package entities;

public class Cart {

	private int id_product;
	private String name_product;
	private int quantity;
	private int total_amount;
	private String picture_product;
	private int price_product;
	private String name_brand;
	private int discount_product;
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
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getTotal_amount() {
		return total_amount;
	}
	public void setTotal_amount(int total_amount) {
		this.total_amount = total_amount;
	}
	public String getPicture_product() {
		return picture_product;
	}
	public void setPicture_product(String picture_product) {
		this.picture_product = picture_product;
	}
	public int getPrice_product() {
		return price_product;
	}
	public void setPrice_product(int price_product) {
		this.price_product = price_product;
	}
	public String getName_brand() {
		return name_brand;
	}
	public void setName_brand(String name_brand) {
		this.name_brand = name_brand;
	}
	public int getDiscount_product() {
		return discount_product;
	}
	public void setDiscount_product(int discount_product) {
		this.discount_product = discount_product;
	}
	public Cart(int id_product, String name_product, int quantity, int total_amount, String picture_product,
			int price_product, String name_brand, int discount_product) {
		super();
		this.id_product = id_product;
		this.name_product = name_product;
		this.quantity = quantity;
		this.total_amount = total_amount;
		this.picture_product = picture_product;
		this.price_product = price_product;
		this.name_brand = name_brand;
		this.discount_product = discount_product;
	}
	public Cart() {
		super();
	}
	
}
