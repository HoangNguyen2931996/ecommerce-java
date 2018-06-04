package entities;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class Brand {
	
	private int id_brand;
	@NotEmpty
	@Size(min = 4, max = 15)
	private String name_brand;
	private String picture_brand;
	private String des_brand;
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
	public String getPicture_brand() {
		return picture_brand;
	}
	public void setPicture_brand(String picture_brand) {
		this.picture_brand = picture_brand;
	}
	public String getDes_brand() {
		return des_brand;
	}
	public void setDes_brand(String des_brand) {
		this.des_brand = des_brand;
	}
	
}
