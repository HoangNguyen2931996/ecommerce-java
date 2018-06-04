package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import entities.Picture;
import entities.Product;

@Repository
public class ProductDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	public int addItem(Product objProduct) {
		return jdbcTemplate.update("INSERT INTO products(name_product, price_product,discount_product, preview_product, detail_product, "
				+ "picture_product,status_product,highlight, id_cat, id_brand) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?,?)", new Object[]{objProduct.getName_product(),objProduct.getPrice_product(),objProduct.getDiscount_product() ,objProduct.getPreview_product(), objProduct.getDetail_product(),objProduct.getPicture_product(),objProduct.getStatus_product(),objProduct.getHighlight(), objProduct.getId_cat(), objProduct.getId_brand()});
	}

	public int  getSumAll() {
		return jdbcTemplate.queryForObject("SELECT COUNT(*) As total FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand", Integer.class);
	}

	public List<Product> getItems(int offset, int row_count) {
		return jdbcTemplate.query("SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand ORDER BY id_product DESC LIMIT ?, ?", new Object[]{offset, row_count}, new BeanPropertyRowMapper<Product>(Product.class));
	}

	public Product getItem(int idProduct) {
		return jdbcTemplate.queryForObject("SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE id_product = ?", new Object[]{idProduct}, new BeanPropertyRowMapper<Product>(Product.class));
	}

	public int editItem(Product objProduct) {
		return jdbcTemplate.update("UPDATE products SET name_product = ?, price_product = ?,discount_product= ?, preview_product = ?, detail_product = ?, "
				+ "picture_product = ?,status_product = ?,highlight = ?, id_cat = ?, id_brand = ? WHERE id_product = ?", new Object[]{objProduct.getName_product(), objProduct.getPrice_product(),objProduct.getDiscount_product(), objProduct.getPreview_product(), objProduct.getDetail_product(), objProduct.getPicture_product(),objProduct.getStatus_product(),objProduct.getHighlight(), objProduct.getId_cat(), objProduct.getId_brand(), objProduct.getId_product()});
	}

	public int delItem(int idProduct) {
		return jdbcTemplate.update("DELETE FROM products WHERE id_product = ?", new Object[]{idProduct});
	}

	public Object getItemsByHT() {
		return jdbcTemplate.query("SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE highlight = 1 && status_product = 1 ORDER BY id_product DESC LIMIT 4", new BeanPropertyRowMapper<Product>(Product.class));
	}

	public List<Product> getItemsByLoadHL(int id_lastProduct) {
		return jdbcTemplate.query("SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE highlight = 1 && status_product = 1 && id_product < ? ORDER BY id_product DESC LIMIT 4",new Object[]{id_lastProduct }, new BeanPropertyRowMapper<Product>(Product.class));
	}

	public int getSumByIdCat(int idCat) {
		return jdbcTemplate.queryForObject("SELECT COUNT(*) As total FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE p.id_cat = ? && status_product = 1", new Object[]{idCat}, Integer.class);
	}

	public Object getItemsByIdCat(int idCat, int offset, int row_count) {
		return jdbcTemplate.query("SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE p.id_cat = ? && status_product = 1 ORDER BY id_product DESC LIMIT ?, ?", new Object[]{idCat ,offset, row_count}, new BeanPropertyRowMapper<Product>(Product.class));
	}

	public List<Product> getItemsByDis(int offset) {
		return jdbcTemplate.query("SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE discount_product > 0 && status_product = 1 ORDER BY discount_product DESC LIMIT ?,4", new Object[]{offset } ,new BeanPropertyRowMapper<Product>(Product.class));
	}

	public List<Product> getItemsNew(int offset) {
		return jdbcTemplate.query("SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE status_product = 1 ORDER BY date_created_product DESC LIMIT ?,4", new Object[]{offset } ,new BeanPropertyRowMapper<Product>(Product.class));
	}

	public List<Product> getAllItem() {
		return jdbcTemplate.query("SELECT * FROM products WHERE status_product = 1", new BeanPropertyRowMapper<Product>(Product.class));
	}

	public List<Picture> getItemsByIdPic(int idProduct) {
		return jdbcTemplate.query("SELECT id_picture, name_picture, s.id_picture, name_product"
				+ " FROM slide_picture As s INNER JOIN products As p ON s.id_product = p.id_product WHERE s.id_product = ?", new Object[]{idProduct}, new BeanPropertyRowMapper<Picture>(Picture.class));
	}

	public int addItemPic(int idProduct, String fileName) {
		// TODO Auto-generated method stub
		return jdbcTemplate.update("INSERT INTO slide_picture(name_picture, id_product) VALUES(?, ?)", new Object[]{fileName, idProduct});
	}

	public int editPic(int idPicture, String fileName) {
		return jdbcTemplate.update("UPDATE slide_picture SET name_picture = ? WHERE id_picture = ?", new Object[]{fileName, idPicture});
	}

	public int getSumByIdBrand(int idBrand) {
		return jdbcTemplate.queryForObject("SELECT COUNT(*) As total FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE p.id_brand = ? && status_product = 1", new Object[]{idBrand}, Integer.class);
	}

	public List<Product> getItemsByIdBrand(int idBrand, int offset, int row_count) {
		return jdbcTemplate.query("SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE p.id_brand = ? && status_product = 1 ORDER BY id_product DESC LIMIT ?, ?", new Object[]{idBrand ,offset, row_count}, new BeanPropertyRowMapper<Product>(Product.class));
	}

	public List<Product> getItemsSeller() {
		return jdbcTemplate.query("SELECT p.id_product, name_product, discount_product,picture_product, price_product, name_brand, SUM(quantity) FROM products As p INNER JOIN orderitems As o ON p.id_product=o.id_product INNER JOIN brands As b ON p.id_brand = b.id_brand GROUP BY p.id_product ORDER BY SUM(quantity) DESC LIMIT 10", new BeanPropertyRowMapper<Product>(Product.class));
	}

	public int updateStatus(int id_product, int status) {
		return jdbcTemplate.update("UPDATE products SET status_product = ? WHERE id_product = ?",new Object[]{status, id_product});
	}

	public List<Product> searchItems(String sql) {
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<Product>(Product.class));
	}

	public List<Product> getItemsByTopHT() {
		return jdbcTemplate.query("SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE highlight = 1 && status_product = 1 ORDER BY id_product DESC LIMIT 3", new BeanPropertyRowMapper<Product>(Product.class));
	}

	public List<Product> getItemsByTopSale() {
		return jdbcTemplate.query("SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE discount_product > 0 && status_product = 1 ORDER BY discount_product DESC LIMIT 3",new BeanPropertyRowMapper<Product>(Product.class));
	}

	public List<Product> getItemsByTopSell() {
		return jdbcTemplate.query("SELECT p.id_product, name_product, discount_product,picture_product, price_product, name_brand, SUM(quantity) FROM products As p INNER JOIN orderitems As o ON p.id_product=o.id_product INNER JOIN brands As b ON p.id_brand = b.id_brand GROUP BY p.id_product ORDER BY SUM(quantity) DESC LIMIT 3", new BeanPropertyRowMapper<Product>(Product.class));
	}

	public List<Product> getItemsByKey(String key_word) {
		return jdbcTemplate.query("SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE (name_product LIKE '%"+key_word+"%' OR name_cat LIKE '%"+key_word+"%' OR name_brand LIKE '%"+key_word+"%') && status_product = 1",new BeanPropertyRowMapper<Product>(Product.class));
	}

	public List<Product> getItemsLQ(int idProduct, int id_cat) {
		return jdbcTemplate.query("SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE p.id_cat = ? && p.id_product != ? && status_product = 1 LIMIT 10",new Object[]{id_cat, idProduct},new BeanPropertyRowMapper<Product>(Product.class));
	}

	public List<Product> getItemsPriceByCat(int idCat, int min, int max) {
		return jdbcTemplate.query("SELECT * FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE (price_product >= ? && price_product <= ?) && p.id_cat = ? && status_product = 1",new Object[]{min, max, idCat} ,new BeanPropertyRowMapper<Product>(Product.class));
	}
	public int  getTotalByIdBrand(int idBrand) {
		return jdbcTemplate.queryForObject("SELECT COUNT(*) As total FROM products As p INNER JOIN categories As c ON p.id_cat = c.id_cat"
				+ " INNER JOIN brands As b ON p.id_brand = b.id_brand WHERE p.id_brand = ?",new Object[]{idBrand}, Integer.class);
	}
}
