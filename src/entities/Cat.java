package entities;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class Cat {
	private int id_cat;
	@NotEmpty
	@Size(min = 4, max = 15)
	private String name_cat;
	private int id_parent;
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
	public int getId_parent() {
		return id_parent;
	}
	public void setId_parent(int id_parent) {
		this.id_parent = id_parent;
	}
	
}
