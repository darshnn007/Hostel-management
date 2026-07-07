# ER Diagram

The following Mermaid diagram represents the relationships declared or implied by the current DDL.

```mermaid
erDiagram
    ADMIN ||--o{ STAFF : supervises
    ADMIN ||--o{ SUGGESTIONS : approves
    STAFF ||--o{ WING : manages
    WING ||--o{ ROOMS : contains
    ROOMS ||--o{ STUDENT : accommodates
    STUDENT ||--o{ ATTENDANCE : has
    STUDENT ||--o{ COMPLAINT : reports
    STAFF ||--o{ COMPLAINT : assigned_to
    STAFF ||--o{ COMPLAINT : solves
    STUDENT ||--o{ OVERNIGHT_LEAVE : requests
    STAFF ||--o{ OVERNIGHT_LEAVE : approves
    STUDENT ||--o{ PARCEL : receives
    STAFF ||--o{ PARCEL : hands_over
    VISITOR ||--o{ SUGGESTIONS : submits
    STUDENT ||--o{ VISITOR : is_visited_by
    VISITOR ||--o{ VISITOR_PAYMENT : makes
    PAYMENT ||--o{ VISITOR_PAYMENT : recorded_as
    STUDENT ||--o{ STUDENT_PAYMENT : makes
    PAYMENT ||--o{ STUDENT_PAYMENT : recorded_as
    STUDENT ||--o{ ROOM_ALLOCATION : receives
    ROOMS ||--o{ ROOM_ALLOCATION : assigned_in
    STUDENT ||--o{ HMC_MEMBER : serves_as
    ROOMS ||--o{ HMC_MEMBER : associated_with
```

## Note

The `STUDENT` to `VISITOR` relationship is logically implied by `Visitor.visited_student_id`, but the current DDL does not explicitly declare its foreign-key constraint.
