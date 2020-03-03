package com.codingdojo.dumbassassin.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.dumbassassin.models.BugTag;

@Repository
public interface BugTagRepo extends CrudRepository<BugTag, Long>{
	List<BugTag> findAll();
	
	@Query(value="SELECT * FROM bugs_tags WHERE id=?1 AND id=?2", nativeQuery=true)
	BugTag findBugTag(Long bug_id, Long tag_id);
}
