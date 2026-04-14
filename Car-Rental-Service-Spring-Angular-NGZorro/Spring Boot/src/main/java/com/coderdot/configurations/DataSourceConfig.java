package com.coderdot.configurations;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import javax.sql.DataSource;
import java.net.URI;

/**
 * Builds a DataSource that works with Railway's PostgreSQL plugin automatically.
 *
 * Railway provides DATABASE_URL in the form:
 *   postgresql://user:password@host:port/database
 *
 * Falls back to individual PGHOST / PGPORT / PGDATABASE / PGUSER / PGPASSWORD
 * vars if DATABASE_URL is not present (local docker-compose uses hardcoded defaults).
 */
@Configuration
public class DataSourceConfig {

    @Value("${DATABASE_URL:}")
    private String databaseUrl;

    @Value("${PGHOST:localhost}")
    private String pgHost;

    @Value("${PGPORT:5432}")
    private String pgPort;

    @Value("${PGDATABASE:rentacar}")
    private String pgDatabase;

    @Value("${PGUSER:postgres}")
    private String pgUser;

    @Value("${PGPASSWORD:}")
    private String pgPassword;

    @Bean
    @Primary
    public DataSource dataSource() throws Exception {
        if (databaseUrl != null && !databaseUrl.isBlank()) {
            // Normalise postgres:// → postgresql:// and strip any leading jdbc: prefix
            String normalised = databaseUrl
                    .replaceFirst("^jdbc:", "")
                    .replaceFirst("^postgres://", "postgresql://");

            URI uri = new URI(normalised);
            String[] userInfo = uri.getUserInfo() != null
                    ? uri.getUserInfo().split(":", 2)
                    : new String[]{"", ""};

            String jdbcUrl = "jdbc:postgresql://" + uri.getHost() + ":" + uri.getPort() + uri.getPath();

            return DataSourceBuilder.create()
                    .url(jdbcUrl)
                    .username(userInfo[0])
                    .password(userInfo.length > 1 ? userInfo[1] : "")
                    .build();
        }

        // Fallback: individual PG variables (docker-compose or custom setup)
        String jdbcUrl = "jdbc:postgresql://" + pgHost + ":" + pgPort + "/" + pgDatabase;
        return DataSourceBuilder.create()
                .url(jdbcUrl)
                .username(pgUser)
                .password(pgPassword)
                .build();
    }
}
