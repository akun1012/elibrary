package com.akun.elibrary.dao.imp;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.akun.elibrary.bean.Literature;
import com.akun.elibrary.bean.LiteratureExample;
import com.akun.elibrary.bean.LiteratureExample2;
import com.akun.elibrary.dao.LiteratureDAO;

public class LiteratureDAOImpl extends SqlMapClientDaoSupport implements LiteratureDAO {

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.literature
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public LiteratureDAOImpl() {
        super();
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.literature
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int countByExample(LiteratureExample example) {
        Integer count = (Integer)  getSqlMapClientTemplate().queryForObject("dbo_literature.ibatorgenerated_countByExample", example);
        return count.intValue();
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.literature
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int deleteByExample(LiteratureExample example) {
        int rows = getSqlMapClientTemplate().delete("dbo_literature.ibatorgenerated_deleteByExample", example);
        return rows;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.literature
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int deleteByPrimaryKey(Integer literatureid) {
        Literature key = new Literature();
        key.setLiteratureid(literatureid);
        int rows = getSqlMapClientTemplate().delete("dbo_literature.ibatorgenerated_deleteByPrimaryKey", key);
        return rows;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.literature
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public void insert(Literature record) {
        getSqlMapClientTemplate().insert("dbo_literature.ibatorgenerated_insert", record);
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.literature
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public void insertSelective(Literature record) {
        getSqlMapClientTemplate().insert("dbo_literature.ibatorgenerated_insertSelective", record);
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.literature
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public List selectByExample(LiteratureExample example) {
        List list = getSqlMapClientTemplate().queryForList("dbo_literature.ibatorgenerated_selectByExample", example);
        return list;
    }
    public List selectByExample2(LiteratureExample2 example) {
        List list = getSqlMapClientTemplate().queryForList("dbo_literature.ibatorgenerated_selectByExample2", example);
        return list;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.literature
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public Literature selectByPrimaryKey(Integer literatureid) {
        Literature key = new Literature();
        key.setLiteratureid(literatureid);
        Literature record = (Literature) getSqlMapClientTemplate().queryForObject("dbo_literature.ibatorgenerated_selectByPrimaryKey", key);
        return record;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.literature
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int updateByExampleSelective(Literature record, LiteratureExample example) {
        UpdateByExampleParms parms = new UpdateByExampleParms(record, example);
        int rows = getSqlMapClientTemplate().update("dbo_literature.ibatorgenerated_updateByExampleSelective", parms);
        return rows;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.literature
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int updateByExample(Literature record, LiteratureExample example) {
        UpdateByExampleParms parms = new UpdateByExampleParms(record, example);
        int rows = getSqlMapClientTemplate().update("dbo_literature.ibatorgenerated_updateByExample", parms);
        return rows;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.literature
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int updateByPrimaryKeySelective(Literature record) {
        int rows = getSqlMapClientTemplate().update("dbo_literature.ibatorgenerated_updateByPrimaryKeySelective", record);
        return rows;
    }

    /**
     * This method was generated by Apache iBATIS ibator.
     * This method corresponds to the database table dbo.literature
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    public int updateByPrimaryKey(Literature record) {
        int rows = getSqlMapClientTemplate().update("dbo_literature.ibatorgenerated_updateByPrimaryKey", record);
        return rows;
    }

    /**
     * This class was generated by Apache iBATIS ibator.
     * This class corresponds to the database table dbo.literature
     *
     * @ibatorgenerated Thu Apr 05 15:26:19 CST 2012
     */
    private static class UpdateByExampleParms extends LiteratureExample {
        private Object record;

        public UpdateByExampleParms(Object record, LiteratureExample example) {
            super(example);
            this.record = record;
        }

        public Object getRecord() {
            return record;
        }
    }
    /**
     * 通过图书名搜索数据
     */
   @SuppressWarnings("unchecked")
/* (non-Javadoc)
 * @see com.akun.elibrary.dao.LiteratureDAO#selectByKey(java.lang.String)
 */
@Override
public List<Literature> selectByKey(String key) {
	List list = getSqlMapClientTemplate().queryForList("dbo_literature.selectByKey", key);
    return list;
}
}