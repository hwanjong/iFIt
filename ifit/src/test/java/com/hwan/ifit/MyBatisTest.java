package com.hwan.ifit;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class MyBatisTest {
	@Inject
	private SqlSessionFactory sqlFactory;
	@Inject 
	SqlSession sqlSession;
	
	@Test
	public void testFactory(){
		System.out.println(sqlFactory);
	}
	
	@Test
	public void testSession() throws Exception{
		try{
			SqlSession session = sqlFactory.openSession();
			System.out.println(session);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	@Test
	public void testSession2(){
		try {
			System.out.println("sqlSession : "+sqlSession);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
}
