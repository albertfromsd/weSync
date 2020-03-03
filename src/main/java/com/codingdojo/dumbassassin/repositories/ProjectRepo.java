package com.codingdojo.dumbassassin.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.dumbassassin.models.Project;

@Repository
public interface ProjectRepo extends CrudRepository<Project, Long>{
	List<Project> findAll();
	
	@Query(value="SELECT * FROM projects WHERE shared=true AND (project_name LIKE CONCAT('%', :string, '%') OR description LIKE CONCAT('%', :string, '%'))", nativeQuery=true)
	List<Project> findAllByProjectNameOrDescription(String string);

}
