import express, { Request, Response } from 'express';

const app = express();
const port = process.env.PORT || 3003;

app.use(express.json());

app.get('/health', (req: Request, res: Response) => {
  res.json({ status: 'ok', service: 'geo-processing' });
});

app.listen(port, () => {
  console.log(`Geo-processing service listening at http://localhost:${port}`);
});
