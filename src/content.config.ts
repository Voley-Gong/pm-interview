import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const questions = defineCollection({
  type: 'content_layer',
  loader: glob({
    pattern: '**/*.md',
    base: new URL('./content/questions', import.meta.url),
  }),
  schema: z.object({
    title: z.string(),
    category: z.enum([
      'product-thinking',
      'requirement-management',
      'user-research',
      'data-metrics',
      'strategy',
      'communication',
      'tech-to-pm',
    ]),
    level: z.number().min(1).max(4),
    tags: z.array(z.string()),
    related: z.array(z.string()).optional(),
    hint: z.string().optional(),
  }),
});

export const collections = { questions };
