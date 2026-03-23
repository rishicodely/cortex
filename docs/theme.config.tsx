import type { DocsThemeConfig } from "nextra-theme-docs";

const config: DocsThemeConfig = {
  logo: (
    <span style={{ fontWeight: 700, fontSize: "1.1rem" }}>
      C<span style={{ color: "#7C6FE0" }}>●</span>rtex
    </span>
  ),
  project: {
    link: "https://github.com/ProductionLineHQ/cortex",
  },
  docsRepositoryBase:
    "https://github.com/ProductionLineHQ/cortex/tree/main/docs",
  footer: {
    content: (
      <span>
        MIT {new Date().getFullYear()}{" "}
        <a href="https://www.theproductionline.ai" target="_blank" rel="noopener noreferrer">
          The Production Line
        </a>
      </span>
    ),
  },
  sidebar: {
    defaultMenuCollapseLevel: 1,
  },
  navigation: true,
  darkMode: true,
  primaryHue: 255,
  primarySaturation: 60,
  head: (
    <>
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <meta name="description" content="Cortex documentation — persistent memory for Claude Code" />
      <link rel="icon" href="/favicon.ico" />
    </>
  ),
  useNextSeoProps() {
    return {
      titleTemplate: "%s — Cortex Docs",
    };
  },
};

export default config;
