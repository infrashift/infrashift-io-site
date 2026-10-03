export interface Tab {
	key: string;
	label: string;
	href: string;
}

export const tabs: Tab[] = [
	{ key: '1', label: 'home', href: '/' },
	{ key: '2', label: 'projects', href: '/projects/' },
	{ key: '3', label: 'about', href: '/about/' },
	{ key: '4', label: 'contact', href: '/contact/' },
];

const trim = (path: string) => path.replace(/\/+$/, '') || '/';

export const isActive = (tab: Tab, pathname: string) => trim(tab.href) === trim(pathname);
