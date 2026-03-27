import { useState } from 'react';
import { Lightbulb, Droplets, Sun, Wind, Sprout, Bug, Calendar, ThermometerSun, ChevronDown, ChevronUp, Leaf } from 'lucide-react';
import { useTheme } from '@/contexts/ThemeContext';

export default function Tips() {
  const { isDark } = useTheme();
  const [expandedIndex, setExpandedIndex] = useState<number | null>(null);

  const toggleCategory = (index: number) => {
    setExpandedIndex(expandedIndex === index ? null : index);
  };

  const tips = [
      {
        icon: Sprout,
        title: 'Plantation et semis',
        color: isDark ? '#4ade80' : '#16a34a',
        imageUrl: '',
        tips: [
          'Respectez les distances de plantation pour une bonne circulation d\'air',
          'Plantez en quinconce pour optimiser l\'espace',
          'Durcissez vos semis avant la transplantation',
          'Semez en succession pour une récolte continue'
        ]
      },
    {
      icon: Droplets,
      title: 'Arrosage optimal',
      color: isDark ? '#4ade80' : '#16a34a',
      imageUrl: 'https://www.entretiendejardin.com/wp-content/uploads/2021/08/Tarif-arrosage-manuel-de-jardin-tuyau-arrosage.jpg',
      tips: [
        'Arrosez tôt le matin pour réduire l\'évaporation',
        'Visez le sol, pas les feuilles, pour éviter les maladies',
        'Arrosez en profondeur mais moins souvent pour encourager les racines profondes',
        'Utilisez de l\'eau à température ambiante, jamais glacée'
      ]
    },
    {
      icon: Sun,
      title: 'Ensoleillement',
      color: isDark ? '#4ade80' : '#16a34a',
      imageUrl: '',
      tips: [
        'La plupart des légumes ont besoin de 6-8 heures de soleil direct',
        'Les légumes-feuilles tolèrent mieux l\'ombre partielle',
        'Orientez vos rangs nord-sud pour un ensoleillement uniforme',
        'Utilisez des structures pour créer de l\'ombre si nécessaire'
      ]
    },
    {
      icon: Bug,
      title: 'Protection naturelle',
      color: isDark ? '#4ade80' : '#16a34a',
      imageUrl: 'https://positivr.fr/wp-content/uploads/2024/04/4-astuces-pour-garantir-un-bon-ensoleillement-dans-son-potager.png',
      tips: [
        'Pratiquez la rotation des cultures pour prévenir les maladies',
        'Utilisez les plantes compagnes pour repousser les nuisibles',
        'Encouragez les insectes bénéfiques (coccinelles, abeilles)',
        'Le paillage réduit les mauvaises herbes et conserve l\'humidité'
      ]
    },
    {
      icon: Calendar,
      title: 'Calendrier de jardinage',
      color: isDark ? '#4ade80' : '#16a34a',
      imageUrl: '',
      tips: [
        'Consultez le calendrier lunaire pour les semis',
        'Notez vos dates de plantation et de récolte',
        'Planifiez vos cultures de succession',
        'Tenez un journal de jardinage pour suivre vos succès'
      ]
    },
    {
      icon: Wind,
      title: 'Sol et compost',
      color: isDark ? '#4ade80' : '#16a34a',
      imageUrl: '/paillis.png',
      tips: [
        'Enrichissez votre sol avec du compost maison',
        'Testez le pH de votre sol régulièrement',
        'Ne retournez pas le sol trop profondément',
        'Ajoutez de la matière organique chaque année'
      ]
    },
    {
      icon: ThermometerSun,
      title: 'Gestion du climat',
      color: isDark ? '#4ade80' : '#16a34a',
      imageUrl: '',
      tips: [
        'Protégez vos plants lors des gelées tardives',
        'Utilisez des cloches ou voiles pour prolonger la saison',
        'Paillez pour réguler la température du sol',
        'Aérez les serres par temps chaud'
      ]
    },
    {
        icon: Lightbulb,
        title: 'Astuces générales',
        color: isDark ? '#4ade80' : '#16a34a',
        imageUrl: '',
        tips: [
            'Une récolte régulière stimule la production',
            'Pincez les fleurs des herbes pour prolonger la récolte',
            'Récupérez l\'eau de pluie pour l\'arrosage',
            'Observez vos plantes quotidiennement pour détecter les problèmes tôt'
        ]
    }
  ];

  return (
    <div className={`min-h-full ${isDark ? 'bg-gray-900' : 'bg-white'}`}>
      <div className="px-4 pt-10 pb-10">
        <div className="flex items-center mb-6">
          <div className="bg-primary-600 p-3 rounded-full mr-3">
            <Leaf size={28} color="#fff" />
          </div>
          <div>
            <h1 className={`text-3xl font-bold ${isDark ? 'text-white' : 'text-gray-900'}`}>
              Trucs et astuces
            </h1>
            <p className={`text-base ${isDark ? 'text-gray-400' : 'text-gray-600'}`}>
              Astuces pour réussir votre potager
            </p>
          </div>
        </div>

        <div className="space-y-4">
          {tips.map((category, idx) => {
            const IconComponent = category.icon;
            const isExpanded = expandedIndex === idx;
            return (
              <div
                key={idx}
                className={`rounded-xl shadow-md overflow-hidden ${
                  isDark ? 'bg-gray-800' : 'bg-white'
                }`}
              >
                <button
                  onClick={() => toggleCategory(idx)}
                  className="w-full px-4 py-2 flex items-center justify-between"
                  style={{ backgroundColor: category.color + '15' }}
                >
                  <div className="flex items-center">
                    <div
                      className="p-2 rounded-lg mr-3"
                     /* style={{ backgroundColor: category.color }}*/
                    >
                      <IconComponent size={24} color="#16a34aff" />
                    </div>
                    <h2
                      className={`${
                        isDark ? 'text-white' : 'text-gray-900'
                      }`}
                    >
                      {category.title}
                    </h2>
                  </div>
                  {isExpanded ? (
                    <ChevronUp size={24} color={isDark ? '#9ca3af' : '#6b7280'} />
                  ) : (
                    <ChevronDown size={24} color={isDark ? '#9ca3af' : '#6b7280'} />
                  )}
                </button>
                
                {isExpanded && (
                  <div>
                    {category.imageUrl && (
                      <img
                        src={category.imageUrl}
                        alt={category.title}
                        className="w-full h-48 object-cover"
                      />
                    )}
                    <div className="p-4 border-t" style={{ borderColor: category.color + '30' }}>
                      {category.tips.map((tip, tipIdx) => (
                        <div key={tipIdx} className="flex mb-3 last:mb-0">
                          <span
                            className="mr-3 flex-shrink-0"
                            style={{ color: category.color }}
                          >
                            •
                          </span>
                          <p
                            className={`text-sm leading-relaxed ${
                              isDark ? 'text-gray-300' : 'text-gray-700'
                            }`}
                          >
                            {tip}
                          </p>
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            );
          })}
        </div>

        {/* Bottom Info Card */}
        <div
          className={`mt-6 rounded-xl p-6 ${
            isDark ? 'bg-primary-900/20' : 'bg-primary-50'
          }`}
        >
          <div className="flex items-start">
            <Sprout
              size={24}
              color={isDark ? '#4ade80' : '#16a34a'}
              className="mt-1 mr-3 flex-shrink-0"
            />
            <div>
              <h3
                className={`text-lg font-semibold mb-2 ${
                  isDark ? 'text-primary-400' : 'text-primary-700'
                }`}
              >
                Le saviez-vous ?
              </h3>
              <p
                className={`text-sm leading-relaxed ${
                  isDark ? 'text-gray-300' : 'text-gray-700'
                }`}
              >
                Le compagnonnage végétal n'est pas qu'une légende ! Certaines plantes 
                s'entraident réellement : les tomates protègent les carottes des parasites, 
                tandis que les carottes aèrent le sol pour les tomates. La nature est bien faite !
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
