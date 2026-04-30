import express, { Request, Response } from 'express';

const app = express();
const port = process.env.PORT || 3002;

app.use(express.json());

app.get('/health', (req: Request, res: Response) => {
  res.json({ status: 'ok', service: 'traffic-collector' });
});

app.listen(port, () => {
  console.log(`Traffic Collector service listening at http://localhost:${port}`);
});
