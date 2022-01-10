#!/usr/bin/env sh

container_name="jdt_nvim_container"


main(){
  volume="$1"
  data="$2"
  echo "$volume    $data"
  if [ -z "$(podman ps -q -f name="${container_name}" -f status=running)" ]; then
    # podman run --interactive --name jdt_nvim_container --volume="${volume}" \
    #   localhost/jdt_lsp_container java \
    #   -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    #   -Dosgi.bundles.defaultStartLevel=4 \
    #   -Declipse.product=org.eclipse.jdt.ls.core.product \
    #   -Dlog.protocol=true \
    #   -Dlog.level=ALL -Xms1g \
    #   -jar /app/jdt_lsp/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar \
    #   -configuration /app/jdt_lsp/config_linux/ \
    #   -data "${data}" \
    #   --add-modules=ALL-SYSTEM \
    #   --add-opens java.base/java.util=ALL-UNNAMED \
    #   --add-opens java.base/java.lang=ALL-UNNAMED

  else
    podman exec -it jdt_nvim_container --volume="${volume}" \
      localhost/jdt_lsp_container java \
      -Declipse.application=org.eclipse.jdt.ls.core.id1 \
      -Dosgi.bundles.defaultStartLevel=4 \
      -Declipse.product=org.eclipse.jdt.ls.core.product \
      -Dlog.protocol=true \
      -Dlog.level=ALL -Xms1g \
      -jar /app/jdt_lsp/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar \
      -configuration /app/jdt_lsp/config_linux/ \
      -data "${data}" \
      --add-modules=ALL-SYSTEM \
      --add-opens java.base/java.util=ALL-UNNAMED \
      --add-opens java.base/java.lang=ALL-UNNAMED
  fi
}

main "${@}"
