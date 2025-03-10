pack: clean
	# Create dist dir if not exists
	if [ ! -d dist ]; then mkdir dist; fi
	# Get version code, it should be read from module.prop
	pkg_name=$(shell grep -E '^id=' module.prop | cut -d '=' -f 2) \
	ver_code=$(shell grep -E '^versionCode=' module.prop | cut -d '=' -f 2) \
	inc=1 \
	next_ver_code=$$((ver_code + inc)) \
	# replace <version> in module.prop.tpl \
	# replace <versionCode> in module.prop.tpl \
	sed -e "s/<version>/$$ver/g" \
		-e "s/<versionCode>/$$next_ver_code/g" \
		module.prop.tpl > module.prop && \
	# replace <version> in update.json \
	# replace <versionCode> in module.prop.tpl \
	sed -e "s/<version>/$$ver/g" \
		-e "s/<versionCode>/$$next_ver_code/g" \
		update.json.tpl > update.json && \
	zip -r -9 -q dist/$$pkg_name-$$ver.zip \
		common \
		customize.sh \
		service.sh \
		META-INF \
		module.prop \
		system \
		uninstall.sh; \
	echo "Done! Please checkout dist/$$pkg_name-$$ver.zip"

clean:
	rm -rf dist

.PHONY: pack clean
