global interface ProductRecommendationPlugin {
    PricebookEntry[] recommend(SObject quote, List<SObject> quoteLines);
}