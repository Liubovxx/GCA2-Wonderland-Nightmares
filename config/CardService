package service;

import dao.CardDao;
import domain.Card;
import java.util.List;

public class CardService {

    private final CardDao cardDao;

    public CardService() {
        this.cardDao = new CardDao();
    }

    public List<Card> getAllCards() {
        return cardDao.getAllCards();
    }

    public boolean addCard(Card card) {
        if (card.getCardName() == null || card.getCardName().trim().isEmpty()) {
            return false;
        }
        return cardDao.addCard(card);
    }
}
