import { useRouter } from "next/router";
import { appRoutes } from "../routes";
import { useFetchData, useMultimethodMutation } from "../utils/reactQuery";

export const useGetCompanies = () => {
  return useFetchData(appRoutes.companies);
};

export const useGetCompany = (companyId: number) => {
  return useFetchData(appRoutes.companyById, {companyId});
};

export const useCompanyMutations = () => {
  const router = useRouter();

  const companyMutation = useMultimethodMutation(appRoutes.companies);
  const companyByIdMutation = useMultimethodMutation(appRoutes.companyById);

  const addCompany = (data) => {
    companyMutation.mutate(
      { data, method: "POST" },
      {
        onSuccess: () => {
          router.push("/companies");
        },
      }
    );
  };

  const editCompany = (data, id) => {
    companyByIdMutation.mutate(
      { data, method: "PUT", params: { companyId: id } },
      {
        onSuccess: () => {
          router.push("/companies");
        },
      }
    );
  };

  const isLoading = companyMutation.isLoading || companyByIdMutation.isLoading;

  return { addCompany, editCompany, isLoading };
};
