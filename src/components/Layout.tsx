import { useEffect, useRef } from 'react';
import { Outlet, NavLink, useLocation } from 'react-router-dom';
import { BookOpen, Search, Settings, Sprout } from 'lucide-react';
import { useTheme } from '@/contexts/ThemeContext';

export default function Layout() {
  const { isDark } = useTheme();
  const mainRef = useRef<HTMLDivElement>(null);
  const location = useLocation();

  useEffect(() => {
    // Scroll the main container to top when route changes
    if (mainRef.current) {
      mainRef.current.scrollTop = 0;
    }
  }, [location.pathname]);

  const navItems = [
    { to: '/', icon: Sprout, label: 'Collection' },
    { to: '/search', icon: Search, label: 'Recherche' },
    /*{ to: '/camera', icon: Camera, label: 'Caméra' },*/
    { to: '/tips', icon: BookOpen, label: 'Conseils' },
    { to: '/settings', icon: Settings, label: 'Paramètres' },
  ];

  return (
    <div className={`flex flex-col h-screen ${isDark ? 'bg-gray-900' : 'bg-white'}`}>
      <main ref={mainRef} className="flex-1 overflow-auto">
        <Outlet />
      </main>

      <nav className={`border-t ${isDark ? 'border-gray-800 bg-gray-900' : 'border-gray-200 bg-white'}`}>
        <div className="flex justify-around items-center h-16">
          {navItems.map(({ to, icon: Icon, label }) => (
            <NavLink
              key={to}
              to={to}
              end={to === '/'}
              className={({ isActive }) =>
                `flex flex-col items-center justify-center flex-1 h-full transition-colors ${
                  isActive
                    ? isDark
                      ? 'text-primary-400'
                      : 'text-primary-600'
                    : isDark
                    ? 'text-gray-400'
                    : 'text-gray-600'
                }`
              }
            >
              <Icon size={24} />
              <span className="text-xs mt-1">{label}</span>
            </NavLink>
          ))}
        </div>
      </nav>
    </div>
  );
}
