package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import entities.Review;

@Repository
public class ReviewDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public int addItem(String name, String email, int score_review, String message, int id_product) {
		return jdbcTemplate.update("INSERT INTO review(name, email, content, score, id_product) VALUES(?, ?, ?, ?, ?)", new Object[]{name, email, message,score_review, id_product});
	}

	public List<Review> getItemsByIdProduct(int idProduct) {
		return jdbcTemplate.query("SELECT * FROM review WHERE id_product = ? ORDER BY date_created DESC", new Object[]{idProduct}, new BeanPropertyRowMapper<Review>(Review.class));
	}

	public int getMaxScoreByidProduct(int idProduct) {
		try{
			return jdbcTemplate.queryForObject("SELECT MAX(score) FROM review WHERE id_product = ?", new Object[]{idProduct}, Integer.class);
		} catch(Exception e){
			return 0;
		}
	}

	public int getSumAll() {
		return jdbcTemplate.queryForObject("SELECT COUNT(*) As total FROM review", Integer.class);
	}

	public List<Review> getItems(int offset, int row_count) {
		return jdbcTemplate.query("SELECT id_review, name, email, content, score, r.id_product, name_product, date_created "
				+ "FROM review As r INNER JOIN products As p ON r.id_product = p.id_product ORDER BY id_review DESC LIMIT ?, ?", new Object[]{offset, row_count}, new BeanPropertyRowMapper<Review>(Review.class));
	}

	public Review getItem(int id_review) {
		return jdbcTemplate.queryForObject("SELECT id_review, name, email, content, score, r.id_product, name_product, date_created "
				+ "FROM review As r INNER JOIN products As p ON r.id_product = p.id_product WHERE id_review = ?",new Object[]{id_review}, new BeanPropertyRowMapper<Review>(Review.class));
	}

	public int delItem(int id_review) {
		return jdbcTemplate.update("DELETE FROM review WHERE id_review = ?", new Object[]{id_review});
	}

	public int delItemsByIdProduct(int idProduct) {
		return jdbcTemplate.update("DELETE FROM review WHERE id_product = ?", new Object[]{idProduct});
	}

	public Review getItemNew() {
		return jdbcTemplate.queryForObject("SELECT id_review, name, email, content, score, r.id_product, name_product, date_created "
				+ "FROM review As r INNER JOIN products As p ON r.id_product = p.id_product ORDER BY date_created DESC LIMIT 1", new BeanPropertyRowMapper<Review>(Review.class));
	}
	
}
