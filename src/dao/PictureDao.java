package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import entities.Picture;

@Repository
public class PictureDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public int addItem(Picture objPicture) {
		return jdbcTemplate.update("INSERT INTO slide_picture(name_picture, id_product) VALUES(?, ?)",new Object[]{objPicture.getName_picture(), objPicture.getId_product()});
	}

	public int getSumAll() {
		return jdbcTemplate.queryForObject("SELECT COUNT(*) As total FROM slide_picture As s INNER JOIN products As p"
				+ " ON s.id_product = p.id_product", Integer.class);
	}

	public List<Picture> getItems(int offset, int row_count) {
		return jdbcTemplate.query("SELECT name_product, id_picture, name_picture FROM slide_picture As s INNER JOIN products As p"
				+ " ON s.id_product = p.id_product ORDER BY id_picture DESC LIMIT ?,?", new Object[]{offset, row_count} ,new BeanPropertyRowMapper<Picture>(Picture.class));
	}

	public Picture getItem(int idPicture) {
		return jdbcTemplate.queryForObject("SELECT s.id_product, name_product, id_picture, name_picture FROM slide_picture As s INNER JOIN products As p"
				+ " ON s.id_product = p.id_product WHERE id_picture = ?", new Object[]{idPicture} ,new BeanPropertyRowMapper<Picture>(Picture.class));
	}

	public int edit(Picture objPicture) {
		return jdbcTemplate.update("UPDATE slide_picture SET name_picture = ?, id_product = ? WHERE id_picture = ?", new Object[]{objPicture.getName_picture(), objPicture.getId_product(), objPicture.getId_picture()});
	}

	public int del(int idPicture) {
		return jdbcTemplate.update("DELETE FROM slide_picture WHERE id_picture = ?", new Object[]{idPicture});
	}

	public List<Picture> searchItems(String sql) {
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<Picture>(Picture.class));
	}

	public List<Picture> getItemsByIdProduct(int idProduct) {
		return jdbcTemplate.query("SELECT * FROM slide_picture WHERE id_product = ?", new Object[]{idProduct}, new BeanPropertyRowMapper<Picture>(Picture.class));
	}
	
}
