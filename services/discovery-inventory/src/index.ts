import express, { Request, Response } from 'express';

const app = express();
const port = process.env.PORT || 3001;

app.use(express.json());

app.get('/health', (req: Request, res: Response) => {
  res.json({ status: 'ok', service: 'discovery-inventory' });
});

app.listen(port, () => {
  console.log(`Discovery & Inventory service listening at http://localhost:${port}`);
});
