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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="features")
public class Feature {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	//Feature details
	@Size(min=3, max=100, message="Feature name must be between 3 and 100 characters")
	private String featureName;
	private String subjectFiles;
	@Size(min=2, message="Language must be indicate by at least 2 character")
	private String language;
	private String description;
	
	//Feature records
	private String notes;
	//private List<String> activityLog;
	
	//Feature status
	private Boolean shared = true;
	private Boolean completed = false;
	private Integer priority = 1;
	
	//Feature dates
	@Column(updatable=false)
	@DateTimeFormat(pattern = "yyyy-MM-dd @ HH:mm")
	private Date createdAt;
	@DateTimeFormat(pattern = "yyyy-MM-dd @ HH:mm")
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
	
	
	// [RELATIONSHIPS]
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="project_id")
	private Project project;
	
	@OneToMany (mappedBy="feature", cascade=CascadeType.ALL, fetch=FetchType.LAZY)
	private List<Task> tasks;
	
	@OneToMany(mappedBy="feature", cascade=CascadeType.ALL, fetch=FetchType.LAZY)
	private List<Bug> bugs;
	
	@ManyToMany (fetch=FetchType.LAZY)
	@JoinTable(
			name="features_tags",
			joinColumns = @JoinColumn(name="feature_id"),
			inverseJoinColumns = @JoinColumn(name="tag_id")
			)
	private List<Tag> tags;
	

	
	// [CONSTRUCTORS]
	public Feature() {

	}
	
	// [GETTERS/SETTERS]
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getFeatureName() {
		return featureName;
	}
	public void setFeatureName(String featureName) {
		this.featureName = featureName;
	}
	public String getSubjectFiles() {
		return subjectFiles;
	}
	public void setSubjectFiles(String subjectFiles) {
		this.subjectFiles = subjectFiles;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
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
	public Project getProject() {
		return project;
	}
	public void setProject(Project project) {
		this.project = project;
	}
	public List<Task> getTasks() {
		return tasks;
	}
	public void setTasks(List<Task> tasks) {
		this.tasks = tasks;
	}
	public List<Bug> getBugs() {
		return bugs;
	}
	public void setBugs(List<Bug> bugs) {
		this.bugs = bugs;
	}
	public List<Tag> getTags() {
		return tags;
	}
	public void setTags(List<Tag> tags) {
		this.tags = tags;
	}
				
}
