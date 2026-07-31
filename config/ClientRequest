package dto;

public class ClientRequest {
    private String requestType; // Наприклад: "GET_ALL", "GET_BY_ID", "ADD", "UPDATE", "DELETE", "DISCONNECT"
    private String payload;     // JSON-стрічка з даними (наприклад, ID або об'єкт Card)

    public ClientRequest() {}

    public ClientRequest(String requestType, String payload) {
        this.requestType = requestType;
        this.payload = payload;
    }

    public String getRequestType() { return requestType; }
    public void setRequestType(String requestType) { this.requestType = requestType; }

    public String getPayload() { return payload; }
    public void setPayload(String payload) { this.payload = payload; }
}
