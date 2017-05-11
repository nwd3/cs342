package dndbModels;

import javax.persistence.*;

/**
 * Created by nwd3 on 5/11/2017.
 */
@Entity
public class Reviews {
    private long reviewId;
    private Long orderNum;
    private Long starReview;
    private String feedback;
    private Orders ordersByOrderNum;

    @Id
    @Column(name = "REVIEW_ID")
    public long getReviewId() {
        return reviewId;
    }

    public void setReviewId(long reviewId) {
        this.reviewId = reviewId;
    }

    @Basic
    @Column(name = "ORDER_NUM")
    public Long getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Long orderNum) {
        this.orderNum = orderNum;
    }

    @Basic
    @Column(name = "STAR_REVIEW")
    public Long getStarReview() {
        return starReview;
    }

    public void setStarReview(Long starReview) {
        this.starReview = starReview;
    }

    @Basic
    @Column(name = "FEEDBACK")
    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Reviews reviews = (Reviews) o;

        if (reviewId != reviews.reviewId) return false;
        if (orderNum != null ? !orderNum.equals(reviews.orderNum) : reviews.orderNum != null) return false;
        if (starReview != null ? !starReview.equals(reviews.starReview) : reviews.starReview != null) return false;
        if (feedback != null ? !feedback.equals(reviews.feedback) : reviews.feedback != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (reviewId ^ (reviewId >>> 32));
        result = 31 * result + (orderNum != null ? orderNum.hashCode() : 0);
        result = 31 * result + (starReview != null ? starReview.hashCode() : 0);
        result = 31 * result + (feedback != null ? feedback.hashCode() : 0);
        return result;
    }
//note this doesn
//    @ManyToOne
//    @JoinColumn(name = "ORDER_NUM", referencedColumnName = "ORDER_NUM")
//    public Orders getOrdersByOrderNum() {
//        return ordersByOrderNum;
//    }
//
//    public void setOrdersByOrderNum(Orders ordersByOrderNum) {
//        this.ordersByOrderNum = ordersByOrderNum;
//    }
}
