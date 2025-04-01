import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Forumality",
  description: "Playing with technologies",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body
        className={`antialiased`}
      >
        {children}
      </body>
    </html>
  );
}
