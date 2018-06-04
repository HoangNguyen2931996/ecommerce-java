package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import entities.Cart;
import entities.OrderItem;

@Repository
public class OrderItemDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	public int addOrderItem(Cart objCart, int id_order) {
		return jdbcTemplate.update("INSERT INTO orderitems(id_order, id_product, quantity, total_amount) VALUES(?,?,?,?)", new Object[]{id_order, objCart.getId_product(), objCart.getQuantity(), objCart.getTotal_amount()});
	}
	public List<OrderItem> getItemsByIdOrder(int idOrder) {
		return jdbcTemplate.query("SELECT name_product, price_product, discount_product, quantity, total_amount"
				+ " FROM orderitems As o INNER JOIN products As p ON o.id_product = p.id_product WHERE id_order = ?", new Object[]{idOrder}, new BeanPropertyRowMapper<OrderItem>(OrderItem.class));
	}
	public void delItems(int idOrder) {
		jdbcTemplate.update("DELETE FROM orderitems WHERE id_order = ?", new Object[]{idOrder});
	}
	public List<OrderItem> checkProduct(int idProduct) {
		return jdbcTemplate.query("SELECT * FROM orderitems WHERE id_product =? ", new Object[]{idProduct}, new BeanPropertyRowMapper<OrderItem>(OrderItem.class));
	}
}
