import { Moon, Sun, Trash2, Info, Leaf } from 'lucide-react';
import { useTheme } from '@/contexts/ThemeContext';

export default function Settings() {
  const { isDark, toggleTheme } = useTheme();

  const clearAllData = () => {
    if (!window.confirm('This will remove all vegetables from your collection. This action cannot be undone.')) {
      return;
    }
    try {
      localStorage.removeItem('collection');
      alert('All data has been cleared');
    } catch (error) {
      alert('Failed to clear data');
    }
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
              Paramètres
            </h1>
            <p className={`text-base ${isDark ? 'text-gray-400' : 'text-gray-600'}`}>
              Gérez vos préférences
            </p>
          </div>
        </div>

        <div className="mb-6">
          <p className="text-sm font-semibold mb-3 uppercase tracking-wide text-gray-500">
            Apparence
          </p>

          <div
            className={`rounded-xl shadow-md ${
              isDark ? 'bg-gray-800' : 'bg-white'
            }`}
          >
            <div className="flex items-center justify-between p-4">
              <div className="flex items-center flex-1">
                {isDark ? (
                  <Moon size={24} color="#4ade80" />
                ) : (
                  <Sun size={24} color="#f59e0b" />
                )}
                <div className="ml-4 flex-1">
                  <p
                    className={`text-base font-semibold ${
                      isDark ? 'text-white' : 'text-gray-900'
                    }`}
                  >
                    Dark Mode
                  </p>
                  <p
                    className={`text-sm ${
                      isDark ? 'text-gray-400' : 'text-gray-600'
                    }`}
                  >
                    {isDark ? 'Activé' : 'Désactivé'}
                  </p>
                </div>
              </div>
              <button
                onClick={toggleTheme}
                className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors ${
                  isDark ? 'bg-primary-600' : 'bg-gray-300'
                }`}
              >
                <span
                  className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
                    isDark ? 'translate-x-6' : 'translate-x-1'
                  }`}
                />
              </button>
            </div>
          </div>
        </div>

        <div className="mb-6">
          <p className="text-sm font-semibold mb-3 uppercase tracking-wide text-gray-500">
            Gestion des données
          </p>

          <div
            className={`rounded-xl shadow-md ${
              isDark ? 'bg-gray-800' : 'bg-white'
            }`}
          >
            <button
              onClick={clearAllData}
              className="w-full flex items-center justify-between p-4 text-left"
            >
              <div className="flex items-center flex-1">
                <Trash2 size={24} color="#ef4444" />
                <div className="ml-4 flex-1">
                  <p
                    className={`text-base font-semibold ${
                      isDark ? 'text-white' : 'text-gray-900'
                    }`}
                  >
                    Effacer toutes les données
                  </p>
                  <p
                    className={`text-sm ${
                      isDark ? 'text-gray-400' : 'text-gray-600'
                    }`}
                  >
                    Supprimer tous les légumes enregistrés
                  </p>
                </div>
              </div>
            </button>
          </div>
        </div>

        <div className="mb-6">
          <p className="text-sm font-semibold mb-3 uppercase tracking-wide text-gray-500">
            À propos
          </p>

          <div
            className={`rounded-xl shadow-md ${
              isDark ? 'bg-gray-800' : 'bg-white'
            }`}
          >
            <div className="p-4">
              <div className="flex items-start mb-4">
                <Info size={24} color={isDark ? '#4ade80' : '#16a34a'} className="mt-1" />
                <div className="ml-4 flex-1">
                  <p
                    className={`text-base font-semibold mb-1 ${
                      isDark ? 'text-white' : 'text-gray-900'
                    }`}
                  >
                    Vegetable Garden App
                  </p>
                  <p
                    className={`text-sm leading-5 ${
                      isDark ? 'text-gray-400' : 'text-gray-600'
                    }`}
                  >
                    Un compagnon pour les jardiniers. Recherchez,
                    identifiez et gérez votre jardin potager en toute simplicité.
                  </p>
                </div>
              </div>

              <div
                className={`border-t pt-4 ${
                  isDark ? 'border-gray-700' : 'border-gray-200'
                }`}
              >
                <p
                  className={`text-sm ${
                    isDark ? 'text-gray-400' : 'text-gray-600'
                  }`}
                >
                  Version 1.0.0
                </p>
              </div>
            </div>
          </div>
        </div>

        <div
          className={`rounded-xl p-6 ${
            isDark ? 'bg-primary-900/20' : 'bg-primary-50'
          }`}
        >
          <h2
            className={`text-lg font-semibold mb-2 ${
              isDark ? 'text-primary-400' : 'text-primary-700'
            }`}
          >
            Growing Tips
          </h2>
          <div className="mb-3">
            <div className="flex mb-2">
              <span
                className={`mr-2 ${
                  isDark ? 'text-primary-400' : 'text-primary-600'
                }`}
              >
                •
              </span>
              <p
                className={`flex-1 text-sm ${
                  isDark ? 'text-gray-300' : 'text-gray-700'
                }`}
              >
                Water your plants early in the morning for best results
              </p>
            </div>
            <div className="flex mb-2">
              <span
                className={`mr-2 ${
                  isDark ? 'text-primary-400' : 'text-primary-600'
                }`}
              >
                •
              </span>
              <p
                className={`flex-1 text-sm ${
                  isDark ? 'text-gray-300' : 'text-gray-700'
                }`}
              >
                Companion planting can improve growth and deter pests
              </p>
            </div>
            <div className="flex">
              <span
                className={`mr-2 ${
                  isDark ? 'text-primary-400' : 'text-primary-600'
                }`}
              >
                •
              </span>
              <p
                className={`flex-1 text-sm ${
                  isDark ? 'text-gray-300' : 'text-gray-700'
                }`}
              >
                Regular harvesting encourages more production
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
