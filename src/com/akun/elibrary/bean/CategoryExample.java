package com.akun.elibrary.bean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CategoryExample {

	/**
	 * This field was generated by Apache iBATIS ibator. This field corresponds to the database table dbo.category
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	protected String orderByClause;
	/**
	 * This field was generated by Apache iBATIS ibator. This field corresponds to the database table dbo.category
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	protected List oredCriteria;

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.category
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public CategoryExample() {
		oredCriteria = new ArrayList();
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.category
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	protected CategoryExample(CategoryExample example) {
		this.orderByClause = example.orderByClause;
		this.oredCriteria = example.oredCriteria;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.category
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public void setOrderByClause(String orderByClause) {
		this.orderByClause = orderByClause;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.category
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public String getOrderByClause() {
		return orderByClause;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.category
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public List getOredCriteria() {
		return oredCriteria;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.category
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public void or(Criteria criteria) {
		oredCriteria.add(criteria);
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.category
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public Criteria createCriteria() {
		Criteria criteria = createCriteriaInternal();
		if (oredCriteria.size() == 0) {
			oredCriteria.add(criteria);
		}
		return criteria;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.category
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	protected Criteria createCriteriaInternal() {
		Criteria criteria = new Criteria();
		return criteria;
	}

	/**
	 * This method was generated by Apache iBATIS ibator. This method corresponds to the database table dbo.category
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public void clear() {
		oredCriteria.clear();
	}

	/**
	 * This class was generated by Apache iBATIS ibator. This class corresponds to the database table dbo.category
	 * @ibatorgenerated  Thu Apr 05 15:26:19 CST 2012
	 */
	public static class Criteria {
		protected List criteriaWithoutValue;
		protected List criteriaWithSingleValue;
		protected List criteriaWithListValue;
		protected List criteriaWithBetweenValue;

		protected Criteria() {
			super();
			criteriaWithoutValue = new ArrayList();
			criteriaWithSingleValue = new ArrayList();
			criteriaWithListValue = new ArrayList();
			criteriaWithBetweenValue = new ArrayList();
		}

		public boolean isValid() {
			return criteriaWithoutValue.size() > 0 || criteriaWithSingleValue.size() > 0
					|| criteriaWithListValue.size() > 0 || criteriaWithBetweenValue.size() > 0;
		}

		public List getCriteriaWithoutValue() {
			return criteriaWithoutValue;
		}

		public List getCriteriaWithSingleValue() {
			return criteriaWithSingleValue;
		}

		public List getCriteriaWithListValue() {
			return criteriaWithListValue;
		}

		public List getCriteriaWithBetweenValue() {
			return criteriaWithBetweenValue;
		}

		protected void addCriterion(String condition) {
			if (condition == null) {
				throw new RuntimeException("Value for condition cannot be null");
			}
			criteriaWithoutValue.add(condition);
		}

		protected void addCriterion(String condition, Object value, String property) {
			if (value == null) {
				throw new RuntimeException("Value for " + property + " cannot be null");
			}
			Map map = new HashMap();
			map.put("condition", condition);
			map.put("value", value);
			criteriaWithSingleValue.add(map);
		}

		protected void addCriterion(String condition, List values, String property) {
			if (values == null || values.size() == 0) {
				throw new RuntimeException("Value list for " + property
						+ " cannot be null or empty");
			}
			Map map = new HashMap();
			map.put("condition", condition);
			map.put("values", values);
			criteriaWithListValue.add(map);
		}

		protected void addCriterion(String condition, Object value1, Object value2, String property) {
			if (value1 == null || value2 == null) {
				throw new RuntimeException("Between values for " + property + " cannot be null");
			}
			List list = new ArrayList();
			list.add(value1);
			list.add(value2);
			Map map = new HashMap();
			map.put("condition", condition);
			map.put("values", list);
			criteriaWithBetweenValue.add(map);
		}

		public Criteria andCategoryidIsNull() {
			addCriterion("categoryid is null");
			return this;
		}

		public Criteria andCategoryidIsNotNull() {
			addCriterion("categoryid is not null");
			return this;
		}

		public Criteria andCategoryidEqualTo(String stringIds) {
			addCriterion("categoryid =", stringIds, "categoryid");
			return this;
		}
        
		public Criteria andCategoryidEqualTo(Integer integer) {
			addCriterion("categoryid =", integer, "categoryid");
			return this;
		}
		
		public Criteria andCategoryidNotEqualTo(Integer value) {
			addCriterion("categoryid <>", value, "categoryid");
			return this;
		}

		public Criteria andCategoryidGreaterThan(Integer value) {
			addCriterion("categoryid >", value, "categoryid");
			return this;
		}

		public Criteria andCategoryidGreaterThanOrEqualTo(Integer value) {
			addCriterion("categoryid >=", value, "categoryid");
			return this;
		}

		public Criteria andCategoryidLessThan(Integer value) {
			addCriterion("categoryid <", value, "categoryid");
			return this;
		}

		public Criteria andCategoryidLessThanOrEqualTo(Integer value) {
			addCriterion("categoryid <=", value, "categoryid");
			return this;
		}

		public Criteria andCategoryidIn(List values) {
			addCriterion("categoryid in", values, "categoryid");
			return this;
		}

		public Criteria andCategoryidNotIn(List values) {
			addCriterion("categoryid not in", values, "categoryid");
			return this;
		}

		public Criteria andCategoryidBetween(Integer value1, Integer value2) {
			addCriterion("categoryid between", value1, value2, "categoryid");
			return this;
		}

		public Criteria andCategoryidNotBetween(Integer value1, Integer value2) {
			addCriterion("categoryid not between", value1, value2, "categoryid");
			return this;
		}

		public Criteria andCategorynameIsNull() {
			addCriterion("categoryName is null");
			return this;
		}

		public Criteria andCategorynameIsNotNull() {
			addCriterion("categoryName is not null");
			return this;
		}

		public Criteria andCategorynameEqualTo(String value) {
			addCriterion("categoryName =", value, "categoryname");
			return this;
		}

		public Criteria andCategorynameNotEqualTo(String value) {
			addCriterion("categoryName <>", value, "categoryname");
			return this;
		}

		public Criteria andCategorynameGreaterThan(String value) {
			addCriterion("categoryName >", value, "categoryname");
			return this;
		}

		public Criteria andCategorynameGreaterThanOrEqualTo(String value) {
			addCriterion("categoryName >=", value, "categoryname");
			return this;
		}

		public Criteria andCategorynameLessThan(String value) {
			addCriterion("categoryName <", value, "categoryname");
			return this;
		}

		public Criteria andCategorynameLessThanOrEqualTo(String value) {
			addCriterion("categoryName <=", value, "categoryname");
			return this;
		}

		public Criteria andCategorynameLike(String value) {
			addCriterion("categoryName like", value, "categoryname");
			return this;
		}

		public Criteria andCategorynameNotLike(String value) {
			addCriterion("categoryName not like", value, "categoryname");
			return this;
		}

		public Criteria andCategorynameIn(List values) {
			addCriterion("categoryName in", values, "categoryname");
			return this;
		}

		public Criteria andCategorynameNotIn(List values) {
			addCriterion("categoryName not in", values, "categoryname");
			return this;
		}

		public Criteria andCategorynameBetween(String value1, String value2) {
			addCriterion("categoryName between", value1, value2, "categoryname");
			return this;
		}

		public Criteria andCategorynameNotBetween(String value1, String value2) {
			addCriterion("categoryName not between", value1, value2, "categoryname");
			return this;
		}

		public Criteria andCindexIsNull() {
			addCriterion("cindex is null");
			return this;
		}

		public Criteria andCindexIsNotNull() {
			addCriterion("cindex is not null");
			return this;
		}

		public Criteria andCindexEqualTo(String value) {
			addCriterion("cindex =", value, "cindex");
			return this;
		}

		public Criteria andCindexNotEqualTo(String value) {
			addCriterion("cindex <>", value, "cindex");
			return this;
		}

		public Criteria andCindexGreaterThan(String value) {
			addCriterion("cindex >", value, "cindex");
			return this;
		}

		public Criteria andCindexGreaterThanOrEqualTo(String value) {
			addCriterion("cindex >=", value, "cindex");
			return this;
		}

		public Criteria andCindexLessThan(String value) {
			addCriterion("cindex <", value, "cindex");
			return this;
		}

		public Criteria andCindexLessThanOrEqualTo(String value) {
			addCriterion("cindex <=", value, "cindex");
			return this;
		}

		public Criteria andCindexLike(String value) {
			addCriterion("cindex like", value, "cindex");
			return this;
		}

		public Criteria andCindexNotLike(String value) {
			addCriterion("cindex not like", value, "cindex");
			return this;
		}

		public Criteria andCindexIn(List values) {
			addCriterion("cindex in", values, "cindex");
			return this;
		}

		public Criteria andCindexNotIn(List values) {
			addCriterion("cindex not in", values, "cindex");
			return this;
		}

		public Criteria andCindexBetween(String value1, String value2) {
			addCriterion("cindex between", value1, value2, "cindex");
			return this;
		}

		public Criteria andCindexNotBetween(String value1, String value2) {
			addCriterion("cindex not between", value1, value2, "cindex");
			return this;
		}
	}
}