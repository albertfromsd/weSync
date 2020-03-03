package com.codingdojo.dumbassassin.models;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;

@Entity
@Table(name="projects")
public class Project {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	@Size(min=1, max=100, message="Project name must be between 1 and 100 characters")
	private String projectName;
	private String description;
//	private List<String> languages;
	
	//Project status
	private Boolean shared = true;
	private Boolean completed = false;
	private Integer priority = 1;
	
	@Column(updatable=false)
	@DateTimeFormat(pattern = "yyyy-MM-dd @ HH:mm")
	private Date createdAt;
	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
	}
	@DateTimeFormat(pattern = "yyyy-MM-dd @ HH:mm")
	private Date updatedAt;
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
	
	@OneToMany (mappedBy="project", cascade=CascadeType.ALL, fetch=FetchType.LAZY)
	private List<Feature> features;
	
	@OneToMany (mappedBy="project", cascade=CascadeType.ALL, fetch=FetchType.LAZY)
	private List<Bug> bugs;
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(
			name="users_projects",
			joinColumns = @JoinColumn(name="project_id"), 
			inverseJoinColumns = @JoinColumn(name="user_id")
			)
	private List<User> users;
	
	@ManyToMany (fetch=FetchType.LAZY)
	@JoinTable(
			name="projects_tags",
			joinColumns = @JoinColumn(name="project_id"),
			inverseJoinColumns = @JoinColumn(name="tag_id")
			)
	private List<Tag> tags;

	
	// [CONSTRUCTORS]
	public Project() {
		
	}

	// [GETTERS/SETTERS]
	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getProjectName() {
		return projectName;
	}


	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public Boolean getShared() {
		return shared;
	}


	public void setShared(Boolean shared) {
		this.shared = shared;
	}


	public Boolean getCompleted() {
		return completed;
	}


	public void setCompleted(Boolean completed) {
		this.completed = completed;
	}


	public Integer getPriority() {
		return priority;
	}


	public void setPriority(Integer priority) {
		this.priority = priority;
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


	public List<Feature> getFeatures() {
		return features;
	}


	public void setFeatures(List<Feature> features) {
		this.features = features;
	}


	public List<Bug> getBugs() {
		return bugs;
	}


	public void setBugs(List<Bug> bugs) {
		this.bugs = bugs;
	}


	public List<User> getUsers() {
		return users;
	}


	public void setUsers(List<User> users) {
		this.users = users;
	}


	public List<Tag> getTags() {
		return tags;
	}


	public void setTags(List<Tag> tags) {
		this.tags = tags;
	}
			
}
