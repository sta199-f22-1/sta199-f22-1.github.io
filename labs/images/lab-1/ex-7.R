ggplot(midwest, aes(x = percollege, y = popdensity, color = percbelowpoverty)) +
  geom_point(alpha = 0.5, size = 2) +
  facet_wrap(~state) +
  theme_minimal() +
  labs(
    title = "Do people with college degrees tend to live in denser areas?",
    x = "% college educated",
    y = "Population density (person / unit area)",
    color = "% below\npoverty line"
  )

ggsave("labs/images/lab-1/ex-7.png", height = 4, width = 7)