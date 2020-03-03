package com.codingdojo.dumbassassin.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.dumbassassin.models.Tag;

@Repository
public interface TagRepo extends CrudRepository<Tag, Long>{
	List<Tag> findAll();
}
