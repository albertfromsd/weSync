package com.codingdojo.dumbassassin.models;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="users")
public class User {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	// VALIDATIONS (need to add)
	@Column(unique=true)
	@Size(min=4, max=16, message="Username must be between 4 and 16 characters")
	private String username;
	
	@Column(unique=true)
	@Email(message = "Please enter a valid email")
	private String email;
	

	private String password;
	@Transient
	private String confirmPw;
	
	@Column(updatable=false)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date createdAt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date updatedAt;
	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
	}
	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}

	public String prettyCreatedAt(){
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd @ HH:mm");
        if(this.createdAt == null){
            return "No created at date";
        }
        String prettyDate = dateFormat.format(this.createdAt);
        return prettyDate;
        }
	public String prettyUpdatedAt(){
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd @ HH:mm");
        if(this.updatedAt == null){
            return "No updated at date";
        }
        String prettyDate = dateFormat.format(this.updatedAt);
        return prettyDate;
        }
	
	//Currently manytomany because later on, will add network features
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
			name="users_projects",
			joinColumns = @JoinColumn(name="user_id"),
			inverseJoinColumns = @JoinColumn(name="project_id")
			)
	private List<Project> projects;
	
	//Add ManyToMany for Friends List
	
	// [CONSTRUCTORS]
	public User() {
		
	}
	
	// [GETTERS/SETTERS]
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getConfirmPw() {
		return confirmPw;
	}
	public void setConfirmPw(String confirmPw) {
		this.confirmPw = confirmPw;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	public List<Project> getProjects() {
		return projects;
	}
	public void setProjects(List<Project> projects) {
		this.projects = projects;
	}
		
}
