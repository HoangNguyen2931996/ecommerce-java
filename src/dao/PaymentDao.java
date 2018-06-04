package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import entities.Payment;

@Repository
public class PaymentDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public int addItem(Payment objPayment) {
		return jdbcTemplate.update("INSERT INTO payments(name_payment) VALUES(?)", new Object[]{objPayment.getName_payment()});
	}

	public List<Payment> getItems() {
		return jdbcTemplate.query("SELECT * FROM payments", new BeanPropertyRowMapper<Payment>(Payment.class));
	}

	public Payment getItemById(int idPayment) {
		return jdbcTemplate.queryForObject("SELECT * FROM payments WHERE id_payment = ?", new Object[]{idPayment}, new BeanPropertyRowMapper<Payment>(Payment.class));
	}

	public int editItem(Payment objPayment) {
		return jdbcTemplate.update("UPDATE payments SET name_payment = ? WHERE id_payment = ?", new Object[]{objPayment.getName_payment(), objPayment.getId_payment()});
	}

	public int delItem(int idPayment) {
		return jdbcTemplate.update("DELETE FROM payments WHERE id_payment = ?", new Object[]{idPayment});
	}
	
}
