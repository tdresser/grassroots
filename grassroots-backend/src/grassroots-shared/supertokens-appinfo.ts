import { BACKEND_DOMAIN, FRONTEND_DOMAIN } from "./local-constants";

export const SUPERTOKENS_APPINFO = {
  // learn more about this on https://supertokens.com/docs/references/frontend-sdks/reference#sdk-configuration
  appName: "grassroots",
  apiDomain: BACKEND_DOMAIN,
  websiteDomain: FRONTEND_DOMAIN,
  apiBasePath: "/api/auth",
};
