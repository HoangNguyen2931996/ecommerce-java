package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import entities.User;

@Repository
public class UserDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	public boolean checkUsername(String username) {
		try{
			jdbcTemplate.queryForObject("SELECT * FROM user WHERE username =? ", new Object[]{username}, new BeanPropertyRowMapper<User>(User.class));
			return false;
		}catch (EmptyResultDataAccessException e) {
            return true;
		}
	}
	public int addItem(User objUser) {
		return jdbcTemplate.update("INSERT INTO user(username, fullname, password, phone, email, address, role)"
				+ "VALUES(?, ?, ?, ?, ?, ?, ?)", new Object[]{objUser.getUsername(), objUser.getFullname(), objUser.getPassword(), objUser.getPhone(), objUser.getEmail(), objUser.getAddress(), objUser.getRole()});
	}
	public int getSumAll() {
		return jdbcTemplate.queryForObject("SELECT COUNT(*) As total FROM user", Integer.class);
	}
	public List<User> getItems(int offset, int row_count) {
		return jdbcTemplate.query("SELECT * FROM user LIMIT ?, ?", new Object[]{offset, row_count}, new BeanPropertyRowMapper<User>(User.class));
	}
	public User getItem(int idUser) {
		return jdbcTemplate.queryForObject("SELECT * FROM user WHERE id_user = ?", new Object[]{idUser}, new BeanPropertyRowMapper<User>(User.class));
	}
	public int editItem(User objUser) {
		return jdbcTemplate.update("UPDATE user SET fullname = ?, password = ?, phone = ?, email = ?, address = ?, role = ?"
				+ " WHERE id_user = ?", new Object[]{objUser.getFullname(), objUser.getPassword(),objUser.getPhone(), objUser.getEmail(), objUser.getAddress(), objUser.getRole(), objUser.getId_user()});
	}
	public int delItem(int idUser) {
		return jdbcTemplate.update("DELETE FROM user WHERE id_user = ?", new Object[]{idUser});
	}
	public User getItemByUsername(String username) {
		return jdbcTemplate.queryForObject("SELECT * FROM user WHERE username = ?", new Object[]{username}, new BeanPropertyRowMapper<User>(User.class));
	}
	public User getItemNew() {
		return jdbcTemplate.queryForObject("SELECT * FROM user WHERE role='Admin' ORDER BY id_user DESC LIMIT 1", new BeanPropertyRowMapper<User>(User.class));
	}
}
