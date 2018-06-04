package dao;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.mysql.jdbc.Statement;

import entities.Order;

@Repository
public class OrderDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	public int addOrder(Order objOrder){
		KeyHolder holder = new GeneratedKeyHolder();
		jdbcTemplate.update(new PreparedStatementCreator() {
			
			@Override
			public java.sql.PreparedStatement createPreparedStatement(java.sql.Connection connection) throws SQLException {
				java.sql.PreparedStatement ps =   connection.prepareStatement("INSERT INTO orders(username, name_receiver, address_receiver, phone_receiver, email_receiver, more_infor, total_order, id_payment)"
						+ " VALUES(?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
				ps.setString(1, objOrder.getUsername());
				ps.setString(2, objOrder.getName_receiver());
				ps.setString(3, objOrder.getAddress_receiver());
				ps.setString(4, objOrder.getPhone_receiver());
				ps.setString(5, objOrder.getEmail_receiver());
				ps.setString(6, objOrder.getMore_infor());
				ps.setInt(7, objOrder.getTotal_order());
				ps.setInt(8, objOrder.getId_payment());
				return ps;
			}
		}, holder);
		return holder.getKey().intValue();
	}
	public List<Order> getItems(int offset, int row_count) {
		return jdbcTemplate.query("SELECT * FROM orders As o INNER JOIN payments As p ON o.id_payment = p.id_payment ORDER BY date_order DESC LIMIT ?, ?",new Object[]{offset, row_count}, new BeanPropertyRowMapper<Order>(Order.class));
	}
	public int getSumAll() {
		return jdbcTemplate.queryForObject("SELECT COUNT(*) As total FROM orders", Integer.class);
	}
	public Order getItem(int idOrder) {
		return jdbcTemplate.queryForObject("SELECT * FROM orders As o INNER JOIN payments As p ON o.id_payment = p.id_payment WHERE id_order = ?", new Object[]{idOrder}, new BeanPropertyRowMapper<Order>(Order.class));
	}
	public int delItem(int idOrder) {
		return jdbcTemplate.update("DELETE FROM orders WHERE id_order = ?", new Object[]{idOrder});
	}
	public Order getItemNew() {
		return jdbcTemplate.queryForObject("SELECT * FROM orders ORDER BY date_order DESC LIMIT 1", new BeanPropertyRowMapper<Order>(Order.class));
	}
	public List<Order> searchItems(String from_date, String to_date) {
		return jdbcTemplate.query("SELECT * FROM orders As o INNER JOIN payments As p ON o.id_payment = p.id_payment WHERE date_order BETWEEN ? AND DATE_ADD(?,INTERVAL 1 DAY)",new Object[]{from_date, to_date}, new BeanPropertyRowMapper<Order>(Order.class));
	}
	public Order vieworder(String username){
		try{
			return jdbcTemplate.queryForObject("SELECT * FROM orders WHERE username = ? ORDER BY date_order DESC LIMIT 1",new Object[]{username}, new BeanPropertyRowMapper<Order>(Order.class));
		} catch(EmptyResultDataAccessException e){
			return null;
		}
	}
}
