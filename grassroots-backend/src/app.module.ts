import { Logger, Module, UnauthorizedException } from "@nestjs/common";
import { AppController } from "./app.controller";
import { AppService } from "./app.service";
import { ContactModule } from "./contact/contact.module";
import { SuperTokensModule } from "supertokens-nestjs";
import Session from "supertokens-node/recipe/session";
import EmailPassword from "supertokens-node/recipe/emailpassword";
//import Dashboard from "supertokens-node/recipe/dashboard";

import { APP_GUARD } from "@nestjs/core";
import { SuperTokensAuthGuard } from "supertokens-nestjs";
import { TypeOrmModule } from "@nestjs/typeorm";
import { POSTGRES_CONFIG } from "./constants";
import { SUPERTOKENS_APPINFO } from "./grassroots-shared/supertokens-appinfo";
import { ContactEntityOutDTO } from "./grassroots-shared/contact.dto.entity";
import { SUPERTOKENS_PATH } from "./grassroots-shared/local-constants";

const logger = new Logger("AppModule");
@Module({
  imports: [
    TypeOrmModule.forRoot({
      ...POSTGRES_CONFIG,
      entities: [ContactEntityOutDTO],
    }),
    ContactModule,
    SuperTokensModule.forRoot({
      framework: "express",
      supertokens: {
        connectionURI: SUPERTOKENS_PATH,
      },
      appInfo: SUPERTOKENS_APPINFO,
      recipeList: [
        EmailPassword.init(), // initializes signin / sign up features
        Session.init({
          //getTokenTransferMethod: () => 'header',
          errorHandlers: {
            // eslint-disable-next-line @typescript-eslint/require-await
            onUnauthorised: async (message, request, response, userContext) => {
              logger.log(
                "Supertokens: unauthorized: ",
                JSON.stringify(message, null, 2),
              );
              void request;
              //logger.log(JSON.stringify(response, null, 2));
              void response;
              void userContext;
              // TODO: Write your own logic and then send a 401 response to the frontend

              throw new UnauthorizedException();
            },
          },
        }),
        //Dashboard.init(),
      ],
    }),
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_GUARD,
      useClass: SuperTokensAuthGuard,
    },
  ],
})
// eslint-disable-next-line @typescript-eslint/no-extraneous-class
export class AppModule {}
