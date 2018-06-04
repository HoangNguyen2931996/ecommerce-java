package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import entities.Cat;

@Repository
public class CatDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	public List<Cat> getItems() {
		return jdbcTemplate.query("SELECT * FROM categories", new BeanPropertyRowMapper<Cat>(Cat.class));
	}
	public int addItem(Cat objCat) {
		return jdbcTemplate.update("INSERT INTO categories(name_cat, id_parent) VALUES(?, ?)", new Object[]{objCat.getName_cat(), objCat.getId_parent()});
	}
	public Cat getItem(int idCat) {
		return jdbcTemplate.queryForObject("SELECT * FROM categories WHERE id_cat = ?", new Object[]{idCat}, new BeanPropertyRowMapper<Cat>(Cat.class));
	}
	public List<Cat> checkChild(int idCat){
		return jdbcTemplate.query("SELECT * FROM categories WHERE id_parent = ?", new Object[]{idCat}, new BeanPropertyRowMapper<Cat>(Cat.class));
	}
	public int edit(Cat objCat) {
		return jdbcTemplate.update("UPDATE categories SET name_cat = ?, id_parent = ? WHERE id_cat = ?", new Object[]{objCat.getName_cat(), objCat.getId_parent(), objCat.getId_cat()});
	}
	public int del(int idCat) {
		return jdbcTemplate.update("DELETE FROM categories WHERE id_cat = ?",new Object[]{idCat });
	}
	public void updateItems(int idCat, int idParent) {
		jdbcTemplate.update("UPDATE categories SET id_parent = ? WHERE id_parent = ?", new Object[]{idParent, idCat});
	}
	public int getTotalByIdCat(int id_cat) {
		return jdbcTemplate.queryForObject("SELECT COUNT(*) As total FROM products WHERE id_cat = ?", new Object[]{id_cat}, Integer.class);
	}
}
