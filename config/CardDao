package dao;

import domain.Card;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CardDao {

    private final String url;
    private final String user;
    private final String password;

    public CardDao() {
        this.url = "jdbc:mysql://localhost:3306/wonderland_nightmares_db?useSSL=false&serverTimezone=UTC";
        this.user = "root";
        this.password = "";
    }

    // Отримати всі картки
    public List<Card> getAllCards() {
        List<Card> cards = new ArrayList<>();
        String sql = "SELECT * FROM cards";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Card card = new Card();
                card.setCardId(rs.getInt("card_id"));
                card.setCardName(rs.getString("card_name"));
                card.setCharacterType(rs.getString("character_type"));
                card.setDomain(rs.getString("domain"));
                card.setMadnessLevel(rs.getInt("madness_level"));
                card.setAttack(rs.getInt("attack"));
                card.setDefense(rs.getInt("defense"));
                card.setAbility(rs.getString("ability"));
                card.setRarity(rs.getString("rarity"));
                cards.add(card);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cards;
    }

    // Додати нову картку (простий варіант)
    public boolean addCard(Card card) {
        String sql = "INSERT INTO cards (card_name, character_type, domain, madness_level, attack, defense, ability, rarity) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, card.getCardName());
            pstmt.setString(2, card.getCharacterType());
            pstmt.setString(3, card.getDomain());
            pstmt.setInt(4, card.getMadnessLevel());
            pstmt.setInt(5, card.getAttack());
            pstmt.setInt(6, card.getDefense());
            pstmt.setString(7, card.getAbility());
            pstmt.setString(8, card.getRarity());

            int rows = pstmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
