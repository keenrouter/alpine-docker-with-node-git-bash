`gh act -W '.github/workflows/build-major.yml' --secret-file .env --var-file .env`

`gh act -W '.github/workflows/build-major.yml' --secret-file .env --var-file .env --var LOCAL_PUSH=true`