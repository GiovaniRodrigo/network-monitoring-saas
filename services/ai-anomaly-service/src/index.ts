import express, { Request, Response } from 'express';

const app = express();
const port = process.env.PORT || 3004;

app.use(express.json());

app.get('/health', (req: Request, res: Response) => {
  res.json({ status: 'ok', service: 'ai-anomaly-service' });
});

app.listen(port, () => {
  console.log(`AI Anomaly service listening at http://localhost:${port}`);
});
