package com.wzx.pojo;

import java.util.ArrayList;
import java.util.List;

public class ColorAndSizeExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public ColorAndSizeExample() {
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

        public Criteria andCsidIsNull() {
            addCriterion("csid is null");
            return (Criteria) this;
        }

        public Criteria andCsidIsNotNull() {
            addCriterion("csid is not null");
            return (Criteria) this;
        }

        public Criteria andCsidEqualTo(Integer value) {
            addCriterion("csid =", value, "csid");
            return (Criteria) this;
        }

        public Criteria andCsidNotEqualTo(Integer value) {
            addCriterion("csid <>", value, "csid");
            return (Criteria) this;
        }

        public Criteria andCsidGreaterThan(Integer value) {
            addCriterion("csid >", value, "csid");
            return (Criteria) this;
        }

        public Criteria andCsidGreaterThanOrEqualTo(Integer value) {
            addCriterion("csid >=", value, "csid");
            return (Criteria) this;
        }

        public Criteria andCsidLessThan(Integer value) {
            addCriterion("csid <", value, "csid");
            return (Criteria) this;
        }

        public Criteria andCsidLessThanOrEqualTo(Integer value) {
            addCriterion("csid <=", value, "csid");
            return (Criteria) this;
        }

        public Criteria andCsidIn(List<Integer> values) {
            addCriterion("csid in", values, "csid");
            return (Criteria) this;
        }

        public Criteria andCsidNotIn(List<Integer> values) {
            addCriterion("csid not in", values, "csid");
            return (Criteria) this;
        }

        public Criteria andCsidBetween(Integer value1, Integer value2) {
            addCriterion("csid between", value1, value2, "csid");
            return (Criteria) this;
        }

        public Criteria andCsidNotBetween(Integer value1, Integer value2) {
            addCriterion("csid not between", value1, value2, "csid");
            return (Criteria) this;
        }

        public Criteria andPidIsNull() {
            addCriterion("pid is null");
            return (Criteria) this;
        }

        public Criteria andPidIsNotNull() {
            addCriterion("pid is not null");
            return (Criteria) this;
        }

        public Criteria andPidEqualTo(Integer value) {
            addCriterion("pid =", value, "pid");
            return (Criteria) this;
        }

        public Criteria andPidNotEqualTo(Integer value) {
            addCriterion("pid <>", value, "pid");
            return (Criteria) this;
        }

        public Criteria andPidGreaterThan(Integer value) {
            addCriterion("pid >", value, "pid");
            return (Criteria) this;
        }

        public Criteria andPidGreaterThanOrEqualTo(Integer value) {
            addCriterion("pid >=", value, "pid");
            return (Criteria) this;
        }

        public Criteria andPidLessThan(Integer value) {
            addCriterion("pid <", value, "pid");
            return (Criteria) this;
        }

        public Criteria andPidLessThanOrEqualTo(Integer value) {
            addCriterion("pid <=", value, "pid");
            return (Criteria) this;
        }

        public Criteria andPidIn(List<Integer> values) {
            addCriterion("pid in", values, "pid");
            return (Criteria) this;
        }

        public Criteria andPidNotIn(List<Integer> values) {
            addCriterion("pid not in", values, "pid");
            return (Criteria) this;
        }

        public Criteria andPidBetween(Integer value1, Integer value2) {
            addCriterion("pid between", value1, value2, "pid");
            return (Criteria) this;
        }

        public Criteria andPidNotBetween(Integer value1, Integer value2) {
            addCriterion("pid not between", value1, value2, "pid");
            return (Criteria) this;
        }

        public Criteria andColorValueIsNull() {
            addCriterion("colorValue is null");
            return (Criteria) this;
        }

        public Criteria andColorValueIsNotNull() {
            addCriterion("colorValue is not null");
            return (Criteria) this;
        }

        public Criteria andColorValueEqualTo(String value) {
            addCriterion("colorValue =", value, "colorValue");
            return (Criteria) this;
        }

        public Criteria andColorValueNotEqualTo(String value) {
            addCriterion("colorValue <>", value, "colorValue");
            return (Criteria) this;
        }

        public Criteria andColorValueGreaterThan(String value) {
            addCriterion("colorValue >", value, "colorValue");
            return (Criteria) this;
        }

        public Criteria andColorValueGreaterThanOrEqualTo(String value) {
            addCriterion("colorValue >=", value, "colorValue");
            return (Criteria) this;
        }

        public Criteria andColorValueLessThan(String value) {
            addCriterion("colorValue <", value, "colorValue");
            return (Criteria) this;
        }

        public Criteria andColorValueLessThanOrEqualTo(String value) {
            addCriterion("colorValue <=", value, "colorValue");
            return (Criteria) this;
        }

        public Criteria andColorValueLike(String value) {
            addCriterion("colorValue like", value, "colorValue");
            return (Criteria) this;
        }

        public Criteria andColorValueNotLike(String value) {
            addCriterion("colorValue not like", value, "colorValue");
            return (Criteria) this;
        }

        public Criteria andColorValueIn(List<String> values) {
            addCriterion("colorValue in", values, "colorValue");
            return (Criteria) this;
        }

        public Criteria andColorValueNotIn(List<String> values) {
            addCriterion("colorValue not in", values, "colorValue");
            return (Criteria) this;
        }

        public Criteria andColorValueBetween(String value1, String value2) {
            addCriterion("colorValue between", value1, value2, "colorValue");
            return (Criteria) this;
        }

        public Criteria andColorValueNotBetween(String value1, String value2) {
            addCriterion("colorValue not between", value1, value2, "colorValue");
            return (Criteria) this;
        }

        public Criteria andSizeValueIsNull() {
            addCriterion("sizeValue is null");
            return (Criteria) this;
        }

        public Criteria andSizeValueIsNotNull() {
            addCriterion("sizeValue is not null");
            return (Criteria) this;
        }

        public Criteria andSizeValueEqualTo(String value) {
            addCriterion("sizeValue =", value, "sizeValue");
            return (Criteria) this;
        }

        public Criteria andSizeValueNotEqualTo(String value) {
            addCriterion("sizeValue <>", value, "sizeValue");
            return (Criteria) this;
        }

        public Criteria andSizeValueGreaterThan(String value) {
            addCriterion("sizeValue >", value, "sizeValue");
            return (Criteria) this;
        }

        public Criteria andSizeValueGreaterThanOrEqualTo(String value) {
            addCriterion("sizeValue >=", value, "sizeValue");
            return (Criteria) this;
        }

        public Criteria andSizeValueLessThan(String value) {
            addCriterion("sizeValue <", value, "sizeValue");
            return (Criteria) this;
        }

        public Criteria andSizeValueLessThanOrEqualTo(String value) {
            addCriterion("sizeValue <=", value, "sizeValue");
            return (Criteria) this;
        }

        public Criteria andSizeValueLike(String value) {
            addCriterion("sizeValue like", value, "sizeValue");
            return (Criteria) this;
        }

        public Criteria andSizeValueNotLike(String value) {
            addCriterion("sizeValue not like", value, "sizeValue");
            return (Criteria) this;
        }

        public Criteria andSizeValueIn(List<String> values) {
            addCriterion("sizeValue in", values, "sizeValue");
            return (Criteria) this;
        }

        public Criteria andSizeValueNotIn(List<String> values) {
            addCriterion("sizeValue not in", values, "sizeValue");
            return (Criteria) this;
        }

        public Criteria andSizeValueBetween(String value1, String value2) {
            addCriterion("sizeValue between", value1, value2, "sizeValue");
            return (Criteria) this;
        }

        public Criteria andSizeValueNotBetween(String value1, String value2) {
            addCriterion("sizeValue not between", value1, value2, "sizeValue");
            return (Criteria) this;
        }

        public Criteria andStockIsNull() {
            addCriterion("stock is null");
            return (Criteria) this;
        }

        public Criteria andStockIsNotNull() {
            addCriterion("stock is not null");
            return (Criteria) this;
        }

        public Criteria andStockEqualTo(Integer value) {
            addCriterion("stock =", value, "stock");
            return (Criteria) this;
        }

        public Criteria andStockNotEqualTo(Integer value) {
            addCriterion("stock <>", value, "stock");
            return (Criteria) this;
        }

        public Criteria andStockGreaterThan(Integer value) {
            addCriterion("stock >", value, "stock");
            return (Criteria) this;
        }

        public Criteria andStockGreaterThanOrEqualTo(Integer value) {
            addCriterion("stock >=", value, "stock");
            return (Criteria) this;
        }

        public Criteria andStockLessThan(Integer value) {
            addCriterion("stock <", value, "stock");
            return (Criteria) this;
        }

        public Criteria andStockLessThanOrEqualTo(Integer value) {
            addCriterion("stock <=", value, "stock");
            return (Criteria) this;
        }

        public Criteria andStockIn(List<Integer> values) {
            addCriterion("stock in", values, "stock");
            return (Criteria) this;
        }

        public Criteria andStockNotIn(List<Integer> values) {
            addCriterion("stock not in", values, "stock");
            return (Criteria) this;
        }

        public Criteria andStockBetween(Integer value1, Integer value2) {
            addCriterion("stock between", value1, value2, "stock");
            return (Criteria) this;
        }

        public Criteria andStockNotBetween(Integer value1, Integer value2) {
            addCriterion("stock not between", value1, value2, "stock");
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