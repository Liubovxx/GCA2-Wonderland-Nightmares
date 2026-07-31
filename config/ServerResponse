package dto;

public class ServerResponse<T> {
    private String status;  // "SUCCESS" або "ERROR"
    private String message; // Наприклад: "Card found successfully" або "Card not found"
    private T data;         // Сам об'єкт (Card, List<Card>, або null якщо помилка)

    public ServerResponse() {}

    public ServerResponse(String status, String message, T data) {
        this.status = status;
        this.message = message;
        this.data = data;
    }

    // Зручні фабричні методи для швидкого створення відповідей
    public static <T> ServerResponse<T> success(String message, T data) {
        return new ServerResponse<>("SUCCESS", message, data);
    }

    public static <T> ServerResponse<T> error(String message) {
        return new ServerResponse<>("ERROR", message, null);
    }

    // Геттери та сеттери
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public T getData() { return data; }
    public void setData(T data) { this.data = data; }
}
