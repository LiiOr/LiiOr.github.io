export interface Vegetable {
  id: string;
  name: string;
  scientificName: string;
  description: string;
  plantingSeason: string[];
  harvestTime: string;
  wateringFrequency: string;
  sunlightRequirement: string;
  difficulty: 'facile' | 'moyen' | 'difficile';
  imageUrl?: string;
  careInstructions: string[];
  companionPlants: string[];
  spacing: string;
  soilType: string;
}

export interface UserVegetableProfile extends Vegetable {
  dateAdded: string;
  notes: string;
  plantedDate?: string;
  expectedHarvest?: string;
}
