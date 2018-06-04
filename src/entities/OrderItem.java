package entities;

public class OrderItem {

	private int id_orderitem;
	private int id_order;
	private int id_product;
	private int quantity;
	private int total_amount;
	private String name_product;
	private int price_product;
	private int discount_product;
	public int getId_orderitem() {
		return id_orderitem;
	}
	public void setId_orderitem(int id_orderitem) {
		this.id_orderitem = id_orderitem;
	}
	public int getId_order() {
		return id_order;
	}
	public void setId_order(int id_order) {
		this.id_order = id_order;
	}
	public int getId_product() {
		return id_product;
	}
	public void setId_product(int id_product) {
		this.id_product = id_product;
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
