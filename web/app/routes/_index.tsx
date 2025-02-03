import type { MetaFunction } from "@remix-run/node";

export const meta: MetaFunction = () => {
	return [
		{ title: "Loki" },
		{ name: "description", content: "Welcome to Loki!" },
	];
};

export default function Index() {
	return (
		<div className="flex h-screen p-4 font-mono">
			<div className="flex flex-col gap-8">
				<header>
					<h1 className="leading text-2xl font-bold text-gray-800 dark:text-gray-100">
						Loki
					</h1>
				</header>
				<p className="leading-6 text-gray-700 dark:text-gray-200">WIP</p>
				<a href="https://github.com/hehk/loki" className="underline">
					Github
				</a>
			</div>
		</div>
	);
}
