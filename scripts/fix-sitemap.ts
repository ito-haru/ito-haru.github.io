// サイトマップの「…/index.html」を正規URL（末尾スラッシュ）にそろえる。
// Quarto は index.html 付きのURLを出力するが，canonical タグと hreflang は末尾スラッシュのURLを指しているため。
const outDir = Deno.env.get("QUARTO_PROJECT_OUTPUT_DIR") ?? "docs";
const path = `${outDir}/sitemap.xml`;

try {
  const xml = await Deno.readTextFile(path);
  const fixed = xml.replace(
    /<loc>(https:\/\/harutoito\.com(?:\/[^<]*)?)\/index\.html<\/loc>/g,
    "<loc>$1/</loc>",
  );
  await Deno.writeTextFile(path, fixed);
} catch (e) {
  if (!(e instanceof Deno.errors.NotFound)) throw e;
}
