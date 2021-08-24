# My-SQL-Project
Đây là một project nho nhỏ em đã làm (nhóm 2 người)
- Thời gian thực hiện : 1,5 tháng
- Project này sử dụng ngôn ngữ SQL để thực hiện những thao tác quản lý cơ bản của một thư viện
- Trước tiên đi vào cụ thể,trong file PDF em đã mô tả những mối quan hệ giữa con người (bao gồm nhân viên và khách hàng) ,
các đầu sách,các chi nhánh thư viện bằng mô hình ERD cũng như mô hình quan hệ được chuyển từ mô hình ERD.
- Sau đó là các dữ liệu mẫu cụ thể để dễ hình dung thao tác quản lý thư viện
- Các thao tác quản lý này bao gồm :Trigger Thêm / Xóa nhân viên , quản lý số lượng nhân viên tại các thư viện chi nhánh (branch) , 
quản lý số lượng sách , quản lý khách hàng mượn sách
- Kèm theo đó là những ràng buộc nhất định như là ở thao tác nhân viên cũng như khách hàng phải đầy đủ thông tin thiết yếu và hợp lệ ,...
- Để hiện thực hóa việc quản lý thư viện hơn , project còn có những hàm dựa trên ngày mượn sách của khách hàng sau đó tính ra hạn trả sách (14 ngày),
hàm đếm những sách đã được mượn/sách 
chưa được mượn

Những điều cố gắng khi làm project này:
- Việc tạo dữ liệu mẫu không chỉ đơn giản là dữ liệu , mà còn phải tạo mối liên kết giữa các thực thể , cũng như thao tác liên quan đến CSDL,
tạo nên 1 CSDL mang tính liên kết chặt chẽ về mặt dữ liệu và những ràng buộc,điều kiện sao cho hợp lý

- Về hướng phát triển,CSDL có thể được mở rộng thêm bằng cách thêm dữ liệu
mới.Việc thêm dữ liệu mới cũng có nghĩa là cần 1 số ràng buộc.Ta cũng có thể linh
hoạt cập nhật,chỉnh sửa dữ liệu mà không cần quan tâm đến việc trùng lắp hoặc lỗi
vì đã được cài đặt ràng buộc.Kèm theo đó,nếu nhiều người sử dụng CSDL,ta có thể
thực hiện tạo một số tài khoản đăng nhập với những phân quyền nhất định.
