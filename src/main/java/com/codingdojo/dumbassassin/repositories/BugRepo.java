package com.codingdojo.dumbassassin.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.dumbassassin.models.Bug;
import com.codingdojo.dumbassassin.models.Task;

@Repository
public interface BugRepo extends CrudRepository<Bug, Long>{
	List<Bug> findAll();

	@Query(value="SELECT * FROM bugs WHERE shared=true AND (bug_desc LIKE CONCAT('%', :string, '%') OR error_msg LIKE CONCAT('%', :string, '%') OR notes LIKE CONCAT('%', :string, '%'))", nativeQuery=true)
	List<Bug> findAllByBugDescOrErrorMsgOrNotes(String string);
}
