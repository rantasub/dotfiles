if [ -z "${DISPLAY}" ] && [ -n "${XDG_VTNR}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
	export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"

	xinit -- :1 -nolisten tcp vt$XDG_VTNR
fi
