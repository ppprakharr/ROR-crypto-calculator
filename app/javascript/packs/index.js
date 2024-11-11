import React from 'react';
import { createRoot } from 'react-dom/client';
import PropTypes from 'prop-types';
import App from '../components/App';

document.addEventListener('DOMContentLoaded', () => {
  const rootElement = document.createElement('div');
  document.body.appendChild(rootElement);
  const root = createRoot(rootElement); // Use createRoot instead of ReactDOM.render

  root.render(<App/>);
});
