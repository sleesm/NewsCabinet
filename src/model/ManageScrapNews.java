package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ManageScrapNews {
	
	private int scrapCount = 0;

	public int searchScrapNewsIdByURL(Connection conn, String newsUrl) {
		String query = "SELECT INTO newscabinet.scrap_news WHERE url=?";
		ResultSet rs = null;
		try {
			PreparedStatement pstat = conn.prepareStatement(query);
			pstat.setString(1, newsUrl);
			rs = pstat.executeQuery();
			
			return Integer.parseInt(rs.toString());
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
	}
	
	public String insertScrapNewsData(Connection conn, int subcategoryId, NewsData newsData) throws SQLException {
		
		String query = "INSERT INTO newscabinet.scrap_news (subcategory_id, headline, published_date, description, url, scrap_count) VALUES(?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstat = conn.prepareStatement(query);
			pstat.setInt(1, subcategoryId);
			pstat.setString(2, newsData.getHeadline());
			pstat.setString(3, newsData.getPubDate());
			pstat.setString(4, newsData.getDescription());
			pstat.setString(5, newsData.getUrl());
			pstat.setInt(6, ++scrapCount);
			pstat.executeUpdate();
			
			return newsData.getUrl();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
	}
	
	public void insertScrapNewsRelationWithUser(Connection conn, int newsId, String userId, int customCategoryId) {
		
		String query = "INSERT INTO newscabinet.user_scrap_news (user_id, news_id, custom_category_id) VALUES(?, ?, ?)";
		
		try {
			PreparedStatement pstat = conn.prepareStatement(query);
			pstat.setString(1, userId);
			pstat.setInt(2, newsId);
			pstat.setInt(3, customCategoryId);
			pstat.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
