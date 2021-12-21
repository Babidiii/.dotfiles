FROM docker.io/openjdk:16-alpine3.13

WORKDIR /app
COPY ./jdt_lsp/ ./jdt_lsp/
# RUN wget "https://download.eclipse.org/jdtls/snapshots/jdt-language-server-1.8.0-202112170540.tar.gz" && mkdir jdt_lsp && tar xf ./jdt-language-server-1.8.0-202112170540.tar.gz -C jdt_lsp

# ENTRYPOINT["java", "-Declipse.application=org.eclipse.jdt.ls.core.id1", "-Dosgi.bundles.defaultStartLevel=4", "-Declipse.product=org.eclipse.jdt.ls.core.product", "-Dlog.protocol=true", "-Dlog.level=ALL", "-Xms1g", "-jar", "/app/jdt_lsp/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar", "-configuration", "/app/jdt_lsp/config_linux/", "-data", "~/.cache/jdt_lsp_workspaces/test"]
# java -Declipse.application=org.eclipse.jdt.ls.core.id1 -Dosgi.bundles.defaultStartLevel=4 -Declipse.product=org.eclipse.jdt.ls.core.product -Dlog.protocol=true -Dlog.level=ALL -Xms1g -jar /app/jdt_lsp/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar -configuration /app/jdt_lsp/config_linux/ -data ~/.cache/jdt_lsp_workspaces/test
