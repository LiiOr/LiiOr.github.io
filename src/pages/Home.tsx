import { useState } from 'react';
import { Search, X, Plus, Leaf } from 'lucide-react';
import { useTheme } from '@/contexts/ThemeContext';
import { vegetables } from '@/data/vegetables';
import { Vegetable } from '@/types/vegetable';

export default function Home() {
  const { isDark } = useTheme();
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedVegetable, setSelectedVegetable] = useState<Vegetable | null>(null);
  const [showSuccess, setShowSuccess] = useState(false);

  const filteredVegetables = vegetables.filter(
    (veg) =>
      veg.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      veg.scientificName.toLowerCase().includes(searchQuery.toLowerCase())
  );

  const addToCollection = () => {
    if (!selectedVegetable) return;

    try {
      const existingCollection = localStorage.getItem('collection');
      const collection = existingCollection ? JSON.parse(existingCollection) : [];

      const isAlreadyAdded = collection.some(
        (item: any) => item.id === selectedVegetable.id
      );

      if (!isAlreadyAdded) {
        const newProfile = {
          ...selectedVegetable,
          dateAdded: new Date().toISOString(),
          notes: '',
        };
        collection.push(newProfile);
        localStorage.setItem('collection', JSON.stringify(collection));
        setShowSuccess(true);
        setTimeout(() => {
          setShowSuccess(false);
          setSelectedVegetable(null);
        }, 1500);
      }
    } catch (error) {
      console.error('Error adding to collection:', error);
    }
  };

  return (
    <div className={`min-h-full ${isDark ? 'bg-gray-900' : 'bg-white'}`}>
      <div className="px-4 pt-12 pb-4">
        <div className="flex items-center mb-6">
          <div className="bg-primary-600 p-3 rounded-full mr-3">
            <Leaf size={28} color="#fff" />
          </div>
          <div> 
          <h1 className={`text-3xl font-bold ${isDark ? 'text-white' : 'text-gray-900'}`}>
            Appli du Potager
          </h1>
          <p className={`text-base ${isDark ? 'text-gray-400' : 'text-gray-600'}`}>
            Le compagnon des jardiniers
          </p>
          </div>
        </div>

        <div
          className={`flex items-center px-4 py-3 rounded-xl ${
            isDark ? 'bg-gray-800' : 'bg-gray-100'
          }`}
        >
          <Search size={20} color={isDark ? '#9ca3af' : '#6b7280'} />
          <input
            className={`flex-1 ml-3 text-base bg-transparent outline-none ${
              isDark ? 'text-white placeholder-gray-400' : 'text-gray-900 placeholder-gray-600'
            }`}
            placeholder="Rechercher des légumes..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
          />
          {searchQuery.length > 0 && (
            <button onClick={() => setSearchQuery('')} className="cursor-pointer">
              <X size={20} color={isDark ? '#9ca3af' : '#6b7280'} />
            </button>
          )}
        </div>
      </div>

      <div className="px-4 pb-20">
        {filteredVegetables.map((vegetable) => (
          <button
            key={vegetable.id}
            onClick={() => setSelectedVegetable(vegetable)}
            className={`w-full mb-4 rounded-xl overflow-hidden shadow-md ${
              isDark ? 'bg-gray-800' : 'bg-white'
            }`}
          >
            <img
              src={vegetable.imageUrl}
              alt={vegetable.name}
              className="w-full h-48 object-cover"
            />
            <div className="p-4 text-left">
              <h2
                className={`text-xl font-semibold mb-1 ${
                  isDark ? 'text-white' : 'text-gray-900'
                }`}
              >
                {vegetable.name}
              </h2>
              <p
                className={`text-sm mb-2 italic ${
                  isDark ? 'text-gray-400' : 'text-gray-600'
                }`}
              >
                {vegetable.scientificName}
              </p>
              <div className="flex items-center">
                <span
                  className={`px-3 py-1 rounded-full text-xs font-medium ${
                    vegetable.difficulty === 'facile'
                      ? 'bg-green-100 text-green-700'
                      : vegetable.difficulty === 'moyen'
                      ? 'bg-yellow-100 text-yellow-700'
                      : 'bg-red-100 text-red-700'
                  }`}
                >
                  {vegetable.difficulty.toUpperCase()}
                </span>
                <span
                  className={`ml-3 text-sm ${
                    isDark ? 'text-gray-400' : 'text-gray-600'
                  }`}
                >
                  {vegetable.harvestTime}
                </span>
              </div>
            </div>
          </button>
        ))}
      </div>

      {/* Modal */}
      {selectedVegetable && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-end justify-center z-50">
          <div
            className="fixed inset-0"
            onClick={() => setSelectedVegetable(null)}
          />
          <div
            className={`relative rounded-t-3xl max-h-[90vh] overflow-auto w-full max-w-2xl ${
              isDark ? 'bg-gray-800' : 'bg-white'
            }`}
          >
            <div className="px-6 py-6">
              <div className="flex justify-between items-start mb-4">
                <div className="flex-1">
                  <h2
                    className={`text-2xl font-bold mb-1 ${
                      isDark ? 'text-white' : 'text-gray-900'
                    }`}
                  >
                    {selectedVegetable.name}
                  </h2>
                  <p
                    className={`text-sm italic ${
                      isDark ? 'text-gray-400' : 'text-gray-600'
                    }`}
                  >
                    {selectedVegetable.scientificName}
                  </p>
                </div>
                <button onClick={() => setSelectedVegetable(null)}>
                  <X size={24} color={isDark ? '#fff' : '#000'} />
                </button>
              </div>

              {selectedVegetable.imageUrl && (
                <img
                  src={selectedVegetable.imageUrl}
                  alt={selectedVegetable.name}
                  className="w-full h-56 rounded-xl mb-4 object-cover"
                />
              )}

              <p
                className={`text-base mb-6 leading-6 text-sm${
                  isDark ? 'text-gray-300' : 'text-gray-700'
                }`}
              >
                {selectedVegetable.description}
              </p>

              <div className="mb-6">
                <h3
                  className={`text-lg font-semibold mb-3 ${
                    isDark ? 'text-white' : 'text-gray-900'
                  }`}
                >
                  Informations de culture
                </h3>

                <InfoRow
                  label="Saison de plantation"
                  value={selectedVegetable.plantingSeason.join(', ')}
                  isDark={isDark}
                />
                <InfoRow
                  label="Temps de récolte"
                  value={selectedVegetable.harvestTime}
                  isDark={isDark}
                />
                <InfoRow
                  label="Ensoleillement"
                  value={selectedVegetable.sunlightRequirement}
                  isDark={isDark}
                />
                <InfoRow
                  label="Arrosage"
                  value={selectedVegetable.wateringFrequency}
                  isDark={isDark}
                />
                <InfoRow
                  label="Espacement"
                  value={selectedVegetable.spacing}
                  isDark={isDark}
                />
                <InfoRow
                  label="Type de sol"
                  value={selectedVegetable.soilType}
                  isDark={isDark}
                />
              </div>

              <div className="mb-6">
                <h3
                  className={`text-lg font-semibold mb-3 ${
                    isDark ? 'text-white' : 'text-gray-900'
                  }`}
                >
                  Instructions d'entretien
                </h3>
                {selectedVegetable.careInstructions.map((instruction, idx) => (
                  <div key={idx} className="flex mb-2">
                    <span
                      className={`mr-2 ${
                        isDark ? 'text-primary-400' : 'text-primary-600'
                      }`}
                    >
                      •
                    </span>
                    <span
                      className={`flex-1 ${
                        isDark ? 'text-gray-300' : 'text-gray-700'
                      }`}
                    >
                      {instruction}
                    </span>
                  </div>
                ))}
              </div>

              <div className="mb-6">
                <h3
                  className={`text-lg font-semibold mb-3 ${
                    isDark ? 'text-white' : 'text-gray-900'
                  }`}
                >
                  Plantes amies
                </h3>
                <div className="flex flex-wrap">
                  {selectedVegetable.companionPlants.map((plant, idx) => (
                    <span
                      key={idx}
                      className={`px-3 py-2 rounded-full mr-2 mb-2 text-sm ${
                        isDark ? 'bg-gray-700 text-gray-300' : 'bg-gray-100 text-gray-700'
                      }`}
                    >
                      {plant}
                    </span>
                  ))}
                </div>
              </div>

              <button
                onClick={addToCollection}
                className="w-full bg-primary-600 py-4 rounded-xl flex items-center justify-center shadow-lg mb-4"
              >
                <Plus size={20} color="#fff" />
                <span className="text-white font-semibold text-base ml-2">
                  Ajouter à ma collection
                </span>
              </button>

              {showSuccess && (
                <div className="bg-green-500 py-3 px-4 rounded-xl">
                  <p className="text-white text-center font-medium">
                    Ajouté à votre collection !
                  </p>
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

function InfoRow({
  label,
  value,
  isDark,
}: {
  label: string;
  value: string;
  isDark: boolean;
}) {
  return (
    <div className="flex mb-3">
      <span
        className={`font-medium w-32 ${
          isDark ? 'text-gray-400' : 'text-gray-600'
        }`}
      >
        {label}:
      </span>
      <span className={`flex-1 ${isDark ? 'text-gray-300' : 'text-gray-800'}`}>
        {value}
      </span>
    </div>
  );
}
