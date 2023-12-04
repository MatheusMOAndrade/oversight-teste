import React from "react";
import Heading from "../../components/Heading";
import { Alert, Box, Button, Grid, Typography } from "@mui/material";
import ServiceCard from "../../components/ServiceCard";
import BudgetCard from "../../components/BudgetCard";
import { useGetBudgets } from "../../api/budgets";
import Link from "next/link";
import CompanyCard from "../../components/CompanyCard";
import { useGetCompanies } from "../../api/companies";

const Companies = () => {
  const { data } = useGetCompanies();

  const companies = data?.data?.data ?? [];

  console.log("%cXABLAU", "color: blue", companies);

  return (
    <>
      <Box sx={{ display: "flex", gap: 4 }}>
        <Heading title="Empresas" />
        <Link href="/companies/new">
          <Button>Nova Empresa</Button>
        </Link>
      </Box>

      <Grid container spacing={2} sx={{ mt: 2 }}>
        {companies.map((budget) => (
          <Grid key={budget.id} item xs={6}>
            <CompanyCard {...budget} />
          </Grid>
        ))}
      </Grid>
    </>
  );
};

export default Companies;
