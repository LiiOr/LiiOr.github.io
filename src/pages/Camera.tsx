import { useState } from 'react';
import { Camera as CameraIcon, X, Leaf } from 'lucide-react';
import { useTheme } from '@/contexts/ThemeContext';
import { vegetables } from '@/data/vegetables';
import { Vegetable } from '@/types/vegetable';

export default function Camera() {
  const { isDark } = useTheme();
  const [identifiedVegetable, setIdentifiedVegetable] = useState<Vegetable | null>(null);

  const simulateIdentification = () => {
    const randomVegetable = vegetables[Math.floor(Math.random() * vegetables.length)];
    setIdentifiedVegetable(randomVegetable);
  };

  return (
    <div className={`min-h-full ${isDark ? 'bg-gray-900' : 'bg-white'}`}>
      <div className="px-4 pt-10 pb-4">
        <div className="flex items-center mb-2">
          <div className="bg-primary-600 p-3 rounded-full mr-3">
            <Leaf size={28} color="#fff" />
          </div>
          <div>
          <h1 className={`text-3xl font-bold ${isDark ? 'text-white' : 'text-gray-900'}`}>
            Photo Search
          </h1>
          <p className={`text-base ${isDark ? 'text-gray-400' : 'text-gray-600'}`}>
          Découvrez les légumes
        </p>
          </div>
        </div>
        <p className={`text-base mb-6 ${isDark ? 'text-gray-400' : 'text-gray-600'}`}>
          Identify vegetables using your camera
        </p>

        <button
          onClick={simulateIdentification}
          className="w-full bg-primary-600 py-6 rounded-2xl flex items-center justify-center shadow-lg mb-8"
        >
          <CameraIcon size={28} color="#fff" />
          <span className="text-white font-semibold text-lg ml-3">
            Simulate Camera Identification
          </span>
        </button>

        {identifiedVegetable && (
          <div>
            <div className="flex justify-between items-center mb-4">
              <h2 className={`text-xl font-semibold ${isDark ? 'text-white' : 'text-gray-900'}`}>
                Last Identified
              </h2>
              <button onClick={() => setIdentifiedVegetable(null)}>
                <X size={20} color={isDark ? '#9ca3af' : '#6b7280'} />
              </button>
            </div>

            <div
              className={`rounded-xl overflow-hidden shadow-md ${
                isDark ? 'bg-gray-800' : 'bg-white'
              }`}
            >
              {identifiedVegetable.imageUrl && (
                <img
                  src={identifiedVegetable.imageUrl}
                  alt={identifiedVegetable.name}
                  className="w-full h-56 object-cover"
                />
              )}
              <div className="p-4">
                <div className="flex items-center mb-2">
                  <span className="bg-primary-100 px-2 py-1 rounded text-primary-700 text-xs font-semibold">
                    MATCH FOUND
                  </span>
                </div>
                <h3
                  className={`text-2xl font-bold mb-1 ${
                    isDark ? 'text-white' : 'text-gray-900'
                  }`}
                >
                  {identifiedVegetable.name}
                </h3>
                <p
                  className={`text-sm mb-3 italic ${
                    isDark ? 'text-gray-400' : 'text-gray-600'
                  }`}
                >
                  {identifiedVegetable.scientificName}
                </p>
                <p
                  className={`text-base leading-6 ${
                    isDark ? 'text-gray-300' : 'text-gray-700'
                  }`}
                >
                  {identifiedVegetable.description}
                </p>
              </div>
            </div>
          </div>
        )}

        <div className="mt-8 pb-20">
          <h2 className={`text-xl font-semibold mb-4 ${isDark ? 'text-white' : 'text-gray-900'}`}>
           Comment ca marche ?
          </h2>
          <StepCard
            number={1}
            title="Prenez une Photo"
            description="Pointez votre camera vers n'importe quel légume dans votre jardin ou au marché"
            isDark={isDark}
          />
          <StepCard
            number={2}
            title="Obtenez des Résultats Instantanés"
            description="Notre système analyse l'image et identifie le légume"
            isDark={isDark}
          />
          <StepCard
            number={3}
            title="Apprenez & Grandissez"
            description="Accédez à des guides de culture détaillés et des instructions d'entretien"
            isDark={isDark}
          />
        </div>
      </div>
    </div>
  );
}

function StepCard({
  number,
  title,
  description,
  isDark,
}: {
  number: number;
  title: string;
  description: string;
  isDark: boolean;
}) {
  return (
    <div className="flex mb-4">
      <div className="bg-primary-600 w-10 h-10 rounded-full flex items-center justify-center mr-4 flex-shrink-0">
        <span className="text-white font-bold text-lg">{number}</span>
      </div>
      <div className="flex-1">
        <h3
          className={`text-lg font-semibold mb-1 ${
            isDark ? 'text-white' : 'text-gray-900'
          }`}
        >
          {title}
        </h3>
        <p
          className={`text-base ${
            isDark ? 'text-gray-400' : 'text-gray-600'
          }`}
        >
          {description}
        </p>
      </div>
    </div>
  );
}
