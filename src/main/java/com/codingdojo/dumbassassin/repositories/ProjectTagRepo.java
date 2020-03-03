package com.codingdojo.dumbassassin.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.codingdojo.dumbassassin.models.ProjectTag;

public interface ProjectTagRepo  extends CrudRepository<ProjectTag, Long>{
	List<ProjectTag> findAll();
	
	@Query(value="SELECT * FROM projects_tags WHERE id=?1 AND id=?2", nativeQuery=true)
	ProjectTag findProjectTag(Long project_id, Long tag_id);
}
