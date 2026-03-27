import { useEffect, useState } from 'react';
import { Leaf } from 'lucide-react';

interface SplashScreenProps {
  onFinish: () => void;
}

export default function SplashScreen({ onFinish }: SplashScreenProps) {
  const [isVisible, setIsVisible] = useState(true);

  useEffect(() => {
    const timer = setTimeout(() => {
      setIsVisible(false);
      setTimeout(onFinish, 300); // Wait for fade out animation
    }, 3000); // Show splash for 3 seconds

    return () => clearTimeout(timer);
  }, [onFinish]);

  return (
    <div
      className={`fixed inset-0 z-50 flex items-center justify-center bg-primary-600 transition-opacity duration-300 ${
        isVisible ? 'opacity-100' : 'opacity-0'
      }`}
    >
      <div className="flex flex-col items-center">
        {/* Animated Icon */}
        <div className="bg-white p-6 rounded-full mb-6 animate-bounce">
          <Leaf size={64} color="#16a34a" />
        </div>
        
        {/* App Name */}
        <h1 className="text-4xl font-bold text-white mb-2">Main Verte</h1>
        <p className="text-white text-lg opacity-90">L'appli des jardiniers en herbe</p>
      </div>
    </div>
  );
}
