package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import entities.Brand;

@Repository
public class BrandDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	public List<Brand> getItems() {
		return jdbcTemplate.query("SELECT * FROM brands", new BeanPropertyRowMapper<Brand>(Brand.class));
	}
	public int addItem(Brand objBrand) {
		return jdbcTemplate.update("INSERT INTO brands(name_brand, picture_brand, des_brand) VALUES(?, ?, ?)", new Object[]{objBrand.getName_brand(), objBrand.getPicture_brand(), objBrand.getDes_brand()});
	}
	public Brand getItem(int idBrand) {
		return jdbcTemplate.queryForObject("SELECT * FROM brands WHERE id_brand = ?", new Object[]{idBrand}, new BeanPropertyRowMapper<Brand>(Brand.class));
	}
	
	public int edit(Brand objBrand) {
		return jdbcTemplate.update("UPDATE brands SET name_brand = ?, picture_brand = ?, des_brand = ? WHERE id_brand = ?", new Object[]{objBrand.getName_brand(), objBrand.getPicture_brand(), objBrand.getDes_brand(), objBrand.getId_brand()});
	}
	public int del(int idBrand) {
		return jdbcTemplate.update("DELETE FROM brands WHERE id_brand = ?",new Object[]{idBrand });
	}
}
