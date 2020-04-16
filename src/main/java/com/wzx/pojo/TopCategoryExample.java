package com.wzx.pojo;

import java.util.ArrayList;
import java.util.List;

public class TopCategoryExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public TopCategoryExample() {
        oredCriteria = new ArrayList<>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andTopCategoryIdIsNull() {
            addCriterion("topCategoryId is null");
            return (Criteria) this;
        }

        public Criteria andTopCategoryIdIsNotNull() {
            addCriterion("topCategoryId is not null");
            return (Criteria) this;
        }

        public Criteria andTopCategoryIdEqualTo(Integer value) {
            addCriterion("topCategoryId =", value, "topCategoryId");
            return (Criteria) this;
        }

        public Criteria andTopCategoryIdNotEqualTo(Integer value) {
            addCriterion("topCategoryId <>", value, "topCategoryId");
            return (Criteria) this;
        }

        public Criteria andTopCategoryIdGreaterThan(Integer value) {
            addCriterion("topCategoryId >", value, "topCategoryId");
            return (Criteria) this;
        }

        public Criteria andTopCategoryIdGreaterThanOrEqualTo(Integer value) {
            addCriterion("topCategoryId >=", value, "topCategoryId");
            return (Criteria) this;
        }

        public Criteria andTopCategoryIdLessThan(Integer value) {
            addCriterion("topCategoryId <", value, "topCategoryId");
            return (Criteria) this;
        }

        public Criteria andTopCategoryIdLessThanOrEqualTo(Integer value) {
            addCriterion("topCategoryId <=", value, "topCategoryId");
            return (Criteria) this;
        }

        public Criteria andTopCategoryIdIn(List<Integer> values) {
            addCriterion("topCategoryId in", values, "topCategoryId");
            return (Criteria) this;
        }

        public Criteria andTopCategoryIdNotIn(List<Integer> values) {
            addCriterion("topCategoryId not in", values, "topCategoryId");
            return (Criteria) this;
        }

        public Criteria andTopCategoryIdBetween(Integer value1, Integer value2) {
            addCriterion("topCategoryId between", value1, value2, "topCategoryId");
            return (Criteria) this;
        }

        public Criteria andTopCategoryIdNotBetween(Integer value1, Integer value2) {
            addCriterion("topCategoryId not between", value1, value2, "topCategoryId");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameIsNull() {
            addCriterion("topCategoryName is null");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameIsNotNull() {
            addCriterion("topCategoryName is not null");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameEqualTo(String value) {
            addCriterion("topCategoryName =", value, "topCategoryName");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameNotEqualTo(String value) {
            addCriterion("topCategoryName <>", value, "topCategoryName");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameGreaterThan(String value) {
            addCriterion("topCategoryName >", value, "topCategoryName");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameGreaterThanOrEqualTo(String value) {
            addCriterion("topCategoryName >=", value, "topCategoryName");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameLessThan(String value) {
            addCriterion("topCategoryName <", value, "topCategoryName");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameLessThanOrEqualTo(String value) {
            addCriterion("topCategoryName <=", value, "topCategoryName");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameLike(String value) {
            addCriterion("topCategoryName like", value, "topCategoryName");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameNotLike(String value) {
            addCriterion("topCategoryName not like", value, "topCategoryName");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameIn(List<String> values) {
            addCriterion("topCategoryName in", values, "topCategoryName");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameNotIn(List<String> values) {
            addCriterion("topCategoryName not in", values, "topCategoryName");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameBetween(String value1, String value2) {
            addCriterion("topCategoryName between", value1, value2, "topCategoryName");
            return (Criteria) this;
        }

        public Criteria andTopCategoryNameNotBetween(String value1, String value2) {
            addCriterion("topCategoryName not between", value1, value2, "topCategoryName");
            return (Criteria) this;
        }

        public Criteria andTypeIsNull() {
            addCriterion("type is null");
            return (Criteria) this;
        }

        public Criteria andTypeIsNotNull() {
            addCriterion("type is not null");
            return (Criteria) this;
        }

        public Criteria andTypeEqualTo(Integer value) {
            addCriterion("type =", value, "type");
            return (Criteria) this;
        }

        public Criteria andTypeNotEqualTo(Integer value) {
            addCriterion("type <>", value, "type");
            return (Criteria) this;
        }

        public Criteria andTypeGreaterThan(Integer value) {
            addCriterion("type >", value, "type");
            return (Criteria) this;
        }

        public Criteria andTypeGreaterThanOrEqualTo(Integer value) {
            addCriterion("type >=", value, "type");
            return (Criteria) this;
        }

        public Criteria andTypeLessThan(Integer value) {
            addCriterion("type <", value, "type");
            return (Criteria) this;
        }

        public Criteria andTypeLessThanOrEqualTo(Integer value) {
            addCriterion("type <=", value, "type");
            return (Criteria) this;
        }

        public Criteria andTypeIn(List<Integer> values) {
            addCriterion("type in", values, "type");
            return (Criteria) this;
        }

        public Criteria andTypeNotIn(List<Integer> values) {
            addCriterion("type not in", values, "type");
            return (Criteria) this;
        }

        public Criteria andTypeBetween(Integer value1, Integer value2) {
            addCriterion("type between", value1, value2, "type");
            return (Criteria) this;
        }

        public Criteria andTypeNotBetween(Integer value1, Integer value2) {
            addCriterion("type not between", value1, value2, "type");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {
        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}