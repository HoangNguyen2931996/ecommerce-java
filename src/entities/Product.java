package entities;

import java.sql.Timestamp;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;


public class Product {
	
	private int id_product;
	@NotEmpty
	@Size(min = 4, max = 30)
	private String name_product;
	@Min(1000000)
	@Max(100000000)
	private int price_product;
	private int discount_product;
	@NotEmpty
	@Size(min =10, max=255)
	private String preview_product;
	private String detail_product;
	private String picture_product;
	private Timestamp date_created_product;
	private int status_product;
	private int highlight;
	private int id_cat;
	private String name_cat;
	private int id_brand;
	private String name_brand;
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
	public String getPreview_product() {
		return preview_product;
	}
	public void setPreview_product(String preview_product) {
		this.preview_product = preview_product;
	}
	public String getDetail_product() {
		return detail_product;
	}
	public void setDetail_product(String detail_product) {
		this.detail_product = detail_product;
	}
	public String getPicture_product() {
		return picture_product;
	}
	public void setPicture_product(String picture_product) {
		this.picture_product = picture_product;
	}
	
	public Timestamp getDate_created_product() {
		return date_created_product;
	}
	public void setDate_created_product(Timestamp date_created_product) {
		this.date_created_product = date_created_product;
	}
	public int getStatus_product() {
		return status_product;
	}
	public void setStatus_product(int status_product) {
		this.status_product = status_product;
	}
	
	public int getHighlight() {
		return highlight;
	}
	public void setHighlight(int highlight) {
		this.highlight = highlight;
	}
	public int getId_cat() {
		return id_cat;
	}
	public void setId_cat(int id_cat) {
		this.id_cat = id_cat;
	}
	public String getName_cat() {
		return name_cat;
	}
	public void setName_cat(String name_cat) {
		this.name_cat = name_cat;
	}
	public int getId_brand() {
		return id_brand;
	}
	public void setId_brand(int id_brand) {
		this.id_brand = id_brand;
	}
	public String getName_brand() {
		return name_brand;
	}
	public void setName_brand(String name_brand) {
		this.name_brand = name_brand;
	}
}
