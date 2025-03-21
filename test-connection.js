#!/usr/bin/env node

const { Client } = require('pg');

const POSTGRES_URL = process.env.POSTGRES_URL;
console.log(POSTGRES_URL);

(async () => {
    const client = new Client({
        user: 'postgres',
        host: 'postgres-chatbot',
        database: 'postgres',
        password: 'postgres',
        port: 5432,
    });

    try {
        await client.connect();
        console.log('Connection succeeded.');
    } catch (error) {
        console.error('Connection failed:', error);
        process.exit(1);
    } finally {
        await client.end();
    }
})();