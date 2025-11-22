import { Outlet, NavLink } from 'react-router-dom';
import { Home, Camera, BookOpen, Settings } from 'lucide-react';
import { useTheme } from '@/contexts/ThemeContext';

export default function Layout() {
  const { isDark } = useTheme();

  const navItems = [
    { to: '/', icon: Home, label: 'Accueil' },
    { to: '/camera', icon: Camera, label: 'Caméra' },
    { to: '/collection', icon: BookOpen, label: 'Collection' },
    { to: '/settings', icon: Settings, label: 'Paramètres' },
  ];

  return (
    <div className={`flex flex-col h-screen ${isDark ? 'bg-gray-900' : 'bg-white'}`}>
      <main className="flex-1 overflow-auto">
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
