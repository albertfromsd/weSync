package com.codingdojo.dumbassassin.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.dumbassassin.models.UserProject;

@Repository
public interface UserProjectRepo extends CrudRepository <UserProject, Long>{
	List<UserProject> findAll();
	
	@Query(value="SELECT * FROM users_projects WHERE id=?1 AND id=?2", nativeQuery=true)
	UserProject findUserProject(Long user_id, Long project_id);
}
