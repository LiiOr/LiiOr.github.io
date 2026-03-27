import { useState, useEffect } from 'react';
import { Trash2, Edit2, X, Save, Leaf } from 'lucide-react';
import { useTheme } from '@/contexts/ThemeContext';
import { UserVegetableProfile } from '@/types/vegetable';

// Helper function to calculate estimated harvest date
const calculateHarvestDate = (plantedDate: string, harvestTime: string): string | undefined => {
  if (!plantedDate) return undefined;

  try {
    let planted: Date;
    
    // Check if date is in YYYY-MM-DD format (from date input) or DD/MM/YYYY format
    if (plantedDate.includes('-')) {
      // YYYY-MM-DD format from date input
      planted = new Date(plantedDate);
    } else {
      // DD/MM/YYYY format
      const [day, month, year] = plantedDate.split('/').map(Number);
      if (!day || !month || !year) return undefined;
      planted = new Date(year, month - 1, day);
    }
    
    // Extract days from harvestTime (e.g., "60-85 jours" -> use the max value)
    const daysMatch = harvestTime.match(/(\d+)(?:-(\d+))?\s*jours?/i);
    if (!daysMatch) return undefined;

    // Use the maximum days if range is given, otherwise use the single value
    const days = daysMatch[2] ? parseInt(daysMatch[2]) : parseInt(daysMatch[1]);
    
    // Calculate harvest date
    const harvestDate = new Date(planted);
    harvestDate.setDate(harvestDate.getDate() + days);
    
    // Format as DD/MM/YYYY for display
    const harvestDay = String(harvestDate.getDate()).padStart(2, '0');
    const harvestMonth = String(harvestDate.getMonth() + 1).padStart(2, '0');
    const harvestYear = harvestDate.getFullYear();
    
    return `${harvestDay}/${harvestMonth}/${harvestYear}`;
  } catch (error) {
    console.error('Error calculating harvest date:', error);
    return undefined;
  }
};

// Helper function to convert date to display format
const formatDateForDisplay = (date: string): string => {
  if (!date) return '';
  
  // If it's already in DD/MM/YYYY format, return as is
  if (date.includes('/')) return date;
  
  // Convert from YYYY-MM-DD to DD/MM/YYYY
  try {
    const dateObj = new Date(date);
    const day = String(dateObj.getDate()).padStart(2, '0');
    const month = String(dateObj.getMonth() + 1).padStart(2, '0');
    const year = dateObj.getFullYear();
    return `${day}/${month}/${year}`;
  } catch {
    return date;
  }
};

export default function Collection() {
  const { isDark } = useTheme();
  const [collection, setCollection] = useState<UserVegetableProfile[]>([]);
  const [selectedProfile, setSelectedProfile] = useState<UserVegetableProfile | null>(null);
  const [isEditing, setIsEditing] = useState(false);
  const [editedNotes, setEditedNotes] = useState('');
  const [plantedDate, setPlantedDate] = useState('');

  useEffect(() => {
    loadCollection();
  }, []);

  const loadCollection = () => {
    try {
      const data = localStorage.getItem('collection');
      if (data) {
        const parsed = JSON.parse(data);
        setCollection(parsed);
      }
    } catch (error) {
      console.error('Error loading collection:', error);
    }
  };

  const deleteProfile = (id: string) => {
    if (!window.confirm('Are you sure you want to remove this vegetable from your collection?')) {
      return;
    }

    try {
      const updatedCollection = collection.filter((item) => item.id !== id);
      localStorage.setItem('collection', JSON.stringify(updatedCollection));
      setCollection(updatedCollection);
      setSelectedProfile(null);
    } catch (error) {
      console.error('Error deleting profile:', error);
    }
  };

  const saveEdits = () => {
    if (!selectedProfile) return;

    try {
      // Calculate expected harvest date if planted date is provided
      const expectedHarvest = plantedDate 
        ? calculateHarvestDate(plantedDate, selectedProfile.harvestTime)
        : undefined;

      const updatedProfile = {
        ...selectedProfile,
        notes: editedNotes,
        plantedDate: plantedDate || selectedProfile.plantedDate,
        expectedHarvest: expectedHarvest || selectedProfile.expectedHarvest,
      };

      const updatedCollection = collection.map((item) =>
        item.id === selectedProfile.id ? updatedProfile : item
      );

      localStorage.setItem('collection', JSON.stringify(updatedCollection));
      setCollection(updatedCollection);
      setSelectedProfile(updatedProfile);
      setIsEditing(false);
    } catch (error) {
      console.error('Error saving edits:', error);
    }
  };

  const openProfile = (profile: UserVegetableProfile) => {
    setSelectedProfile(profile);
    setEditedNotes(profile.notes || '');
    setPlantedDate(profile.plantedDate || '');
    setIsEditing(false);
  };

  return (
    <div className={`min-h-full ${isDark ? 'bg-gray-900' : 'bg-white'}`}>
      <div className="px-4 pt-12 pb-20">
        <div className="flex items-center mb-6">
          <div className="bg-primary-600 p-3 rounded-full mr-3">
            <Leaf size={28} color="#fff" />
          </div>
          <div>
          <h1 className={`text-3xl font-bold ${isDark ? 'text-white' : 'text-gray-900'}`}>
            Ma Collection
          </h1>
        <p className={`text-base ${isDark ? 'text-gray-400' : 'text-gray-600'}`}>
          {collection.length} légume{collection.length !== 1 ? 's' : ''} dans votre jardin
        </p>
        </div>
        </div>
      </div>

      <div className="px-4 pb-20">
        {collection.length === 0 ? (
          <div className="flex items-center justify-center py-20">
            <div className="text-center">
              <p className={`text-lg mb-2 ${isDark ? 'text-gray-400' : 'text-gray-600'}`}>
                Your collection is empty
              </p>
              <p className={`text-base ${isDark ? 'text-gray-500' : 'text-gray-500'}`}>
                Search for vegetables and add them to start building your garden
              </p>
            </div>
          </div>
        ) : (
          collection.map((profile) => (
            <button
              key={profile.id}
              onClick={() => openProfile(profile)}
              className={`w-full mb-4 rounded-xl overflow-hidden shadow-md text-left ${
                isDark ? 'bg-gray-800' : 'bg-white'
              }`}
            >
              <img
                src={profile.imageUrl}
                alt={profile.name}
                className="w-full h-40 object-cover"
              />
              <div className="p-4">
                <h2
                  className={`text-xl font-semibold mb-1 ${
                    isDark ? 'text-white' : 'text-gray-900'
                  }`}
                >
                  {profile.name}
                </h2>
                {profile.plantedDate ? (
                  <div className={`text-sm mb-2 ${isDark ? 'text-gray-400' : 'text-gray-600'}`}>
                    <p>🌱 Planté le : {formatDateForDisplay(profile.plantedDate)}</p>
                    {profile.expectedHarvest && (
                      <p className={`${isDark ? 'text-primary-400' : 'text-primary-600'}`}>
                        Récolte estimée dès le : {profile.expectedHarvest}
                      </p>
                    )}
                  </div>
                ) : (
                  <p
                    className={`text-sm mb-2 ${
                      isDark ? 'text-gray-400' : 'text-gray-600'
                    }`}
                  >
                    Ajouté le{' '}
                    {new Date(profile.dateAdded).toLocaleDateString('fr-FR', {
                      day: 'numeric',
                      month: 'short',
                      year: 'numeric',
                    })}
                  </p>
                )}
                {profile.notes && (
                  <p
                    className={`text-sm line-clamp-2 ${
                      isDark ? 'text-gray-300' : 'text-gray-700'
                    }`}
                  >
                    {profile.notes}
                  </p>
                )}
              </div>
            </button>
          ))
        )}
      </div>

      {/* Modal */}
      {selectedProfile && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-end justify-center z-50">
          <div
            className="fixed inset-0"
            onClick={() => setSelectedProfile(null)}
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
                    {selectedProfile.name}
                  </h2>
                  <p
                    className={`text-sm ${
                      isDark ? 'text-gray-400' : 'text-gray-600'
                    }`}
                  >
                    Added on{' '}
                    {new Date(selectedProfile.dateAdded).toLocaleDateString('en-US', {
                      month: 'long',
                      day: 'numeric',
                      year: 'numeric',
                    })}
                  </p>
                </div>
                <button onClick={() => setSelectedProfile(null)}>
                  <X size={24} color={isDark ? '#fff' : '#000'} />
                </button>
              </div>

              {selectedProfile.imageUrl && (
                <img
                  src={selectedProfile.imageUrl}
                  alt={selectedProfile.name}
                  className="w-full h-56 rounded-xl mb-4 object-cover"
                />
              )}

              <div className="mb-6">
                <div className="flex justify-between items-center mb-3">
                  <h3
                    className={`text-lg font-semibold ${
                      isDark ? 'text-white' : 'text-gray-900'
                    }`}
                  >
                    Mes Notes
                  </h3>
                  {!isEditing && (
                    <button onClick={() => setIsEditing(true)}>
                      <Edit2 size={20} color={isDark ? '#4ade80' : '#16a34a'} />
                    </button>
                  )}
                </div>

                {isEditing ? (
                  <>
                    <textarea
                      className={`w-full p-4 rounded-xl mb-3 text-base ${
                        isDark
                          ? 'bg-gray-700 text-white'
                          : 'bg-gray-100 text-gray-900'
                      }`}
                      placeholder="Ajoutez vos notes ici..."
                      value={editedNotes}
                      onChange={(e) => setEditedNotes(e.target.value)}
                      rows={4}
                    />

                    <label
                      className={`block text-base font-medium mb-2 ${
                        isDark ? 'text-white' : 'text-gray-900'
                      }`}
                    >
                      Planté le
                    </label>
                    <input
                      type="date"
                      className={`w-full p-4 rounded-xl mb-4 text-base ${
                        isDark
                          ? 'bg-gray-700 text-white placeholder-gray-400'
                          : 'bg-gray-100 text-gray-900 placeholder-gray-600'
                      }`}
                      placeholder="DD/MM/YYYY"
                      value={plantedDate}
                      onChange={(e) => setPlantedDate(e.target.value)}
                    />

                    <div className="flex gap-3">
                      <button
                        onClick={() => setIsEditing(false)}
                        className={`flex-1 py-3 rounded-xl ${
                          isDark ? 'bg-gray-700' : 'bg-gray-200'
                        }`}
                      >
                        <span
                          className={`font-semibold ${
                            isDark ? 'text-white' : 'text-gray-900'
                          }`}
                        >
                          Annuler
                        </span>
                      </button>
                      <button
                        onClick={saveEdits}
                        className="flex-1 bg-primary-600 py-3 rounded-xl flex items-center justify-center"
                      >
                        <Save size={18} color="#fff" />
                        <span className="text-white font-semibold ml-2">Sauvegarder</span>
                      </button>
                    </div>
                  </>
                ) : (
                  <>
                    {selectedProfile.notes ? (
                      <p
                        className={`text-base leading-6 ${
                          isDark ? 'text-gray-300' : 'text-gray-700'
                        }`}
                      >
                        {selectedProfile.notes}
                      </p>
                    ) : (
                      <p
                        className={`text-base italic ${
                          isDark ? 'text-gray-500' : 'text-gray-500'
                        }`}
                      >
                        Pas encore de notes. Appuyez sur l'icône d'édition pour en ajouter.
                      </p>
                    )}

                    {selectedProfile.plantedDate && (
                      <div className="mt-4">
                        <p
                          className={`text-sm font-medium ${
                            isDark ? 'text-gray-400' : 'text-gray-600'
                          }`}
                        >
                          🌱 Planté le: {formatDateForDisplay(selectedProfile.plantedDate)}
                        </p>
                        {selectedProfile.expectedHarvest && (
                          <p
                            className={`text-sm font-medium mt-2 ${
                              isDark ? 'text-primary-400' : 'text-primary-600'
                            }`}
                          >
                            Récolte estimée dès le : {selectedProfile.expectedHarvest}
                          </p>
                        )}
                      </div>
                    )}
                  </>
                )}
              </div>

              <div className="mb-6">
                <h3
                  className={`text-lg font-semibold mb-3 ${
                    isDark ? 'text-white' : 'text-gray-900'
                  }`}
                >
                  Instructions
                </h3>
                {selectedProfile.careInstructions.map((instruction, idx) => (
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

              <button
                onClick={() => deleteProfile(selectedProfile.id)}
                className="w-full bg-red-600 py-4 rounded-xl flex items-center justify-center"
              >
                <Trash2 size={20} color="#fff" />
                <span className="text-white font-semibold text-base ml-2">
                  Retirer de ma Collection
                </span>
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
