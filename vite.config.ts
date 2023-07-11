import { defineConfig } from "vite";
import { svelte } from "@sveltejs/vite-plugin-svelte";
import { zip } from "zip-a-folder"
import webExtension, { readJsonFile } from "vite-plugin-web-extension";

function generateManifest() {
  const manifest = readJsonFile("src/manifest.json");
  const pkg = readJsonFile("package.json");
  return {
    ...manifest,
    description: pkg.description,
    version: pkg.version,
    name: "Cocoma - Cookie Consent Manager",
  };
}

const target = process.env.TARGET || "chrome"

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    svelte(),
    webExtension({
      manifest: generateManifest,
      watchFilePaths: ["package.json", "manifest.json"],
      browser: target
    }),
    {
      name: 'post-build',
      closeBundle: async () => {
        console.log("Zipping extension")
        await zip("dist", `dist-zip/extension-${target}.zip`)
      }
    }
  ],
});