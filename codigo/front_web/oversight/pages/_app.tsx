import { ThemeProvider } from "@mui/material";
import "../styles/globals.css";
import type { AppProps } from "next/app";
import { theme } from "../styles/theme";
import MainLayout from "../components/MainLayout";
import Head from "next/head";
import { QueryClient, QueryClientProvider } from "react-query";
import { useRouter } from "next/router";
import AuthGuard from "../components/auth/AuthGuard";
import { AuthProvider } from "../context/AuthContext";

function MyApp({ Component, pageProps }: AppProps) {
  const queryClient = new QueryClient({
    defaultOptions: {
      queries: {
        refetchOnWindowFocus: false,
      },
    },
  });

  const { pathname } = useRouter();


  console.log('%cXABLAU321213','color: blue',Component.guard );
  return (
    <main>
      <QueryClientProvider client={queryClient}>
        <ThemeProvider theme={theme}>
          <AuthProvider guard={Component.guard ?? true}>
            <AuthGuard guard={Component.guard ?? true}>
              <MainLayout hideNav={pathname === "/login" ||pathname === "/emailbridge"  }>
                <Component {...pageProps} />
              </MainLayout>
            </AuthGuard>
          </AuthProvider>
        </ThemeProvider>
      </QueryClientProvider>
    </main>
  );
}

export default MyApp;
