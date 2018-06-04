package entities;

import java.sql.Timestamp;

public class Order {
	private int id_order;
	private String username;
	private String name_receiver;	
	private Timestamp date_order;
	private String address_receiver;
	private String phone_receiver;
	private String email_receiver;
	private String more_infor;
	private int total_order;
	private int id_payment;
	private String name_payment;
	public int getId_order() {
		return id_order;
	}
	public void setId_order(int id_order) {
		this.id_order = id_order;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getName_receiver() {
		return name_receiver;
	}
	public void setName_receiver(String name_receiver) {
		this.name_receiver = name_receiver;
	}
	
	public Timestamp getDate_order() {
		return date_order;
	}
	public void setDate_order(Timestamp date_order) {
		this.date_order = date_order;
	}
	public String getAddress_receiver() {
		return address_receiver;
	}
	public void setAddress_receiver(String address_receiver) {
		this.address_receiver = address_receiver;
	}
	public String getPhone_receiver() {
		return phone_receiver;
	}
	public void setPhone_receiver(String phone_receiver) {
		this.phone_receiver = phone_receiver;
	}
	public String getEmail_receiver() {
		return email_receiver;
	}
	public void setEmail_receiver(String email_receiver) {
		this.email_receiver = email_receiver;
	}
	public String getMore_infor() {
		return more_infor;
	}
	public void setMore_infor(String more_infor) {
		this.more_infor = more_infor;
	}
	public int getTotal_order() {
		return total_order;
	}
	public void setTotal_order(int total_order) {
		this.total_order = total_order;
	}
	public int getId_payment() {
		return id_payment;
	}
	public void setId_payment(int id_payment) {
		this.id_payment = id_payment;
	}
	public String getName_payment() {
		return name_payment;
	}
	public void setName_payment(String name_payment) {
		this.name_payment = name_payment;
	}
}
