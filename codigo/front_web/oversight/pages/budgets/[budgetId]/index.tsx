import React from "react";
import Heading from "../../../components/Heading";
import SubHeading from "../../../components/Subheading";
import { Chip, Divider, Grid } from "@mui/material";
import CardWrapper from "../../../components/CardWrapper";
import Text from "../../../components/Text";
import ServiceCard from "../../../components/ServiceCard";
import { useRouter } from "next/router";
import { useGetBudget } from "../../../api/budgets";
import BudgetServices from "../../../components/BudgetServices";

// "id": "7bd68c7e-9c8f-4acd-9f9a-fb1d9fea3783",
//         "name": "Orçamento do maluco q mora logo ali",
//         "description": "descrição",
//         "incomingMargin": 15,
//         "status": "budgeting",
//         "statusMessage": null,
//         "createdBy": "c4e8ca80-68f4-4d8c-8354-702348d851da",
//         "customerId": "f422266f-e3b8-47f9-9caa-5f024a8cf793",
//         "createdAt": "2023-11-01T12:04:56.776Z",
//         "updatedAt": "2023-11-01T12:04:56.776Z"

const BudgetPage = () => {
  const { query } = useRouter();
  const { budgetId } = query;

  console.log("%cXABLAU", "color: red", query);

  const { data, isLoading } = useGetBudget(budgetId);

  const budget = data?.data?.data ?? {};

  console.log("%cXABLAU", "color: blue", budget);

  return (
    <>
      {isLoading ? (
        ""
      ) : (
        <Grid container spacing={2}>
          <Grid
            item
            xs={12}
            sx={{ display: "flex", justifyContent: "space-between", mb: 2 }}
          >
            <Heading title="Orçamento" subtitle={budget.name} />
            <Chip label={budget.status} color="success" />
          </Grid>
          <Grid item xs={12}>
            <SubHeading title="Dados Básicos" />
          </Grid>

          <Grid item xs={12} md={8}>
            <CardWrapper>
              {/* <Text variant="caption" sx={{ fontWeight: 700 }}>
                Cliente
              </Text>
              <Text variant="body1" sx={{ mb: 1 }}>
                Samara
              </Text> */}

              <Text variant="caption" sx={{ fontWeight: 700 }}>
                Descrição
              </Text>
              <Text variant="body1">{budget.description}</Text>
            </CardWrapper>
          </Grid>

          <Grid item xs={12}>
            <Divider sx={{ m: 0 }} />
          </Grid>
          <Grid item xs={12}>
            <SubHeading title="Serviços" />
          </Grid>
          <BudgetServices budgetId={budgetId} />
        </Grid>
      )}
    </>
  );
};

export default BudgetPage;
