package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import entities.Contact;

@Repository
public class ContactDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	public int addItem(Contact objContact) {
		return jdbcTemplate.update("INSERT INTO contact(name, mail, phone, title, message) VALUES(?, ?, ?, ?, ?)", new Object[]{objContact.getName(), objContact.getMail(), objContact.getPhone(),objContact.getTitle(), objContact.getMessage()});
	}

	public int getSumAll() {
		return jdbcTemplate.queryForObject("SELECT COUNT(*) As total FROM contact", Integer.class);
	}

	public List<Contact> getItems(int offset, int row_count) {
		return jdbcTemplate.query("SELECT * FROM contact", new BeanPropertyRowMapper<Contact>(Contact.class));
	}

	public Contact getItem(int idContact) {
		return jdbcTemplate.queryForObject("SELECT * FROM contact WHERE id_contact = ?", new Object[]{idContact}, new BeanPropertyRowMapper<Contact>(Contact.class));
	}

	public int delItem(int idContact) {
		return jdbcTemplate.update("DELETE FROM contact WHERE id_contact = ?", new Object[]{idContact});
	}

	public Object getItemNew() {
		return jdbcTemplate.queryForObject("SELECT * FROM contact ORDER BY date_created DESC LIMIT 1", new BeanPropertyRowMapper<Contact>(Contact.class));
	}

	public int updateStatus(int idContact) {
		return jdbcTemplate.update("UPDATE contact SET status = 1 WHERE id_contact = ?", new Object[]{idContact});
	}
}
