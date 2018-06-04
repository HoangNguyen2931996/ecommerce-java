package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import entities.Slide;

@Repository
public class SlideDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public int addItem(Slide objSlide) {
		return jdbcTemplate.update("INSERT INTO slide(des_slide,pic_slide, id_product) VALUES(?, ?, ?)",new Object[]{objSlide.getDes_slide(), objSlide.getPic_slide(), objSlide.getId_product()});
	}

	public List<Slide> getItems() {
		return jdbcTemplate.query("SELECT s.id_product,name_product, id_slide, pic_slide, des_slide,price_product, discount_product FROM slide As s INNER JOIN products As p"
				+ " ON s.id_product = p.id_product ORDER BY id_slide DESC", new BeanPropertyRowMapper<Slide>(Slide.class));
	}

	public Slide getItem(int idSlide) {
		return jdbcTemplate.queryForObject("SELECT name_product, id_slide, pic_slide, des_slide, s.id_product FROM slide As s INNER JOIN products As p"
				+ " ON s.id_product = p.id_product WHERE id_slide = ?", new Object[]{idSlide}, new BeanPropertyRowMapper<Slide>(Slide.class));
	}

	public int edit(Slide objSlide) {
		return jdbcTemplate.update("UPDATE slide SET des_slide = ?, pic_slide = ?, id_product = ? WHERE id_slide = ?",new Object[]{objSlide.getDes_slide(), objSlide.getPic_slide(), objSlide.getId_product(), objSlide.getId_slide()});
	}

	public int del(int idSlide) {
		return jdbcTemplate.update("DELETE FROM slide WHERE id_slide = ?", new Object[]{idSlide});
	}

	public List<Slide> getItemsByIdProduct(int idProduct) {
		return jdbcTemplate.query("SELECT * FROM slide WHERE id_product = ?", new Object[]{idProduct}, new BeanPropertyRowMapper<Slide>(Slide.class));
	}

	
	
}
