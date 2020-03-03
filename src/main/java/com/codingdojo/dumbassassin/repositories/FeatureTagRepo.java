package com.codingdojo.dumbassassin.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.codingdojo.dumbassassin.models.FeatureTag;

public interface FeatureTagRepo extends CrudRepository<FeatureTag, Long>{
	List<FeatureTag> findAll();
	
	@Query(value="SELECT * FROM features_tags WHERE id=?1 AND id=?2", nativeQuery=true)
	FeatureTag findFeatureTag(Long feature_id, Long tag_id);
	
	
	
}
