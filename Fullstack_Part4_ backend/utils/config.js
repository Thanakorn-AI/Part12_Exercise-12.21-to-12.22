// Fullstack_Part5/Fullstack_Part4_ backend/utils/config.js
require('dotenv').config();

const PORT = process.env.PORT || 3003;
const MONGODB_URI =
  process.env.NODE_ENV === 'test'
    ? process.env.TEST_MONGODB_URI
    : process.env.MONGODB_URI;

console.log('Connecting to:', MONGODB_URI);

module.exports = { MONGODB_URI, PORT };
