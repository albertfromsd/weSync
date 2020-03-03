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
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="bugs")
public class Bug {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	//bug desciptors
	private String errorMsg;
	private String bugDesc;
	private String notes;
//	private List<String> activityLog;
	
	//Feature status
	private Boolean shared;
	private Boolean inProgress;

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
	@JoinColumn(name="task_id")
	private Task task;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="feature_id")
	private Feature feature;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="project_id")
	private Project project;
	
	@OneToMany (mappedBy="bug", cascade=CascadeType.ALL, fetch=FetchType.LAZY)
	private List<Solution> solution;
	
	@ManyToMany (fetch=FetchType.LAZY)
	@JoinTable(
			name="bugs_tags",
			joinColumns = @JoinColumn(name="bug_id"),
			inverseJoinColumns = @JoinColumn(name="tag_id")
			)
	private List<Tag> tags;

	
	//[CONSTRUCTORS]
	public Bug() {
		
	}
	
	// [GETTERS/SETTERS]
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public String getBugDesc() {
		return bugDesc;
	}
	public void setBugDesc(String bugDesc) {
		this.bugDesc = bugDesc;
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
	public Boolean getInProgress() {
		return inProgress;
	}
	public void setInProgress(Boolean inProgress) {
		this.inProgress = inProgress;
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
	public Task getTask() {
		return task;
	}
	public void setTask(Task task) {
		this.task = task;
	}
	public Feature getFeature() {
		return feature;
	}
	public void setFeature(Feature feature) {
		this.feature = feature;
	}
	public Project getProject() {
		return project;
	}
	public void setProject(Project project) {
		this.project = project;
	}
	public List<Solution> getSolution() {
		return solution;
	}
	public void setSolution(List<Solution> solution) {
		this.solution = solution;
	}
	public List<Tag> getTags() {
		return tags;
	}
	public void setTags(List<Tag> tags) {
		this.tags = tags;
	}
		
}
