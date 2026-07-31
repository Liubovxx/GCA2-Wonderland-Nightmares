package dao;

import domain.Card;
import exception.DaoException;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.function.Predicate;

public class JdbcCardDao implements Dao<Card, Integer> {

    private final String url = "jdbc:mysql://localhost:3306/wonderland_nightmares_db?useSSL=false&serverTimezone=UTC";
    private final String user = "root";
    private final String password = "";

    @Override
    public List<Card> getAll() {
        List<Card> cards = new ArrayList<>();
        String sql = "SELECT * FROM cards";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                cards.add(mapRowToCard(rs));
            }
        } catch (SQLException e) {
            throw new DaoException("Failed to fetch all cards from database", e);
        }
        return cards;
    }

    @Override
    public Optional<Card> getById(Integer id) {
        String sql = "SELECT * FROM cards WHERE card_id = ?";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(mapRowToCard(rs));
                }
            }
        } catch (SQLException e) {
            throw new DaoException("Failed to fetch card by ID: " + id, e);
        }
        return Optional.empty(); // Ніколи не повертаємо null (Вимога F3, F10)
    }

    @Override
    public Card insert(Card card) {
        String sql = "INSERT INTO cards (card_name, character_type, domain, madness_level, attack, defense, ability, rarity, market_price) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setString(1, card.getCardName());
            pstmt.setString(2, card.getCharacterType());
            pstmt.setString(3, card.getDomain());
            pstmt.setInt(4, card.getMadnessLevel());
            pstmt.setInt(5, card.getAttack());
            pstmt.setInt(6, card.getDefense());
            pstmt.setString(7, card.getAbility());
            pstmt.setString(8, card.getRarity());
            pstmt.setDouble(9, card.getMarketPrice());

            pstmt.executeUpdate();

            // Отримуємо автоматично згенерований ID (Вимога F4)
            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    card.setCardId(generatedKeys.getInt(1));
                }
            }
            return card;
        } catch (SQLException e) {
            throw new DaoException("Failed to insert card: " + card.getCardName(), e);
        }
    }

    @Override
    public Card update(Integer id, Card card) {
        String sql = "UPDATE cards SET card_name=?, character_type=?, domain=?, madness_level=?, attack=?, defense=?, ability=?, rarity=?, market_price=? WHERE card_id=?";

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
            pstmt.setDouble(9, card.getMarketPrice());
            pstmt.setInt(10, id);

            pstmt.executeUpdate();
            card.setCardId(id);
            return card;
        } catch (SQLException e) {
            throw new DaoException("Failed to update card ID: " + id, e);
        }
    }

    @Override
    public boolean deleteById(Integer id) {
        String sql = "DELETE FROM cards WHERE card_id = ?";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new DaoException("Failed to delete card ID: " + id, e);
        }
    }

    @Override
    public List<Card> findByFilter(Predicate<Card> filter) {
        List<Card> allCards = getAll();
        List<Card> filtered = new ArrayList<>();
        for (Card c : allCards) {
            if (filter.test(c)) {
                filtered.add(c);
            }
        }
        return filtered;
    }

    // Допоміжний метод, щоб не дублювати код зчитування з ResultSet
    private Card mapRowToCard(ResultSet rs) throws SQLException {
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
        card.setMarketPrice(rs.getDouble("market_price"));
        return card;
    }
}
