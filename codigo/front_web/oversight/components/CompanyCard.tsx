import React from "react";
import CardWrapper from "./CardWrapper";
import { Box, Chip } from "@mui/material";
import Text from "./Text";
import HandymanIcon from "@mui/icons-material/Handyman";
import { useRouter } from "next/router";

const CompanyCard = ({ name, email, cnpj, id }) => {
  const router = useRouter();

  console.log('%cXABLAU','color: blue', name, email, cnpj, id );

  return (
    <CardWrapper onClick={() => router.push(`/companies/${id}/edit`)}>
      <Box
        sx={{
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
          cursor: "pointer",
        }}
      >
        <Box>
          <Box>
            <Text variant="h6">{name}</Text>
            <Text variant="body2">
              <strong>CNPJ:</strong> {cnpj} / <strong>email:</strong> {email}
            </Text>
          </Box>
        </Box>
        <Text variant="h5" sx={{ mr: 2 }}>
          {/* R$22 */}
        </Text>
      </Box>
    </CardWrapper>
  );
};

export default CompanyCard;
