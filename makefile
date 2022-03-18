arch 		   := x86_64
repo_name   := mwglen-arch-repo
arch		   := x86_64
packages    := $(shell ls packages)
built_pkgs  := $(shell echo $(packages) | sed  "s/ /-${arch}.pkg.tar.zst /g")

echo:
	echo $(built_pkgs)

packages/%/$(arch).pkg.tar.zst: $(filter-out *.pkg.tar.zst ,  $(wildcard packages/%/*))
	# Remove old packages
	rm -rf packages/$*/*.pkg.tar.zst
	
	# Make the package
	cd packages/$* && makepkg -c
	
	# Move and rename the package
	mv packages/$*/*.pkg.tar.zst $@ || true

repo: # $(built_pkgs)
	
	## Clean previous build
	rm -rf $(arch)/*
	
	# Build packages
	## repo-add
	## -s: signs the packages
	## -n: only add new packages not already in database
	## -R: remove old package files when updating their entry
	for pkg in $$(find -name '*$(arch).pkg.tar.zst') ; do \
		repo-add -s -n -R $(arch)/mwglen-arch-repo.db.tar.zst $$pkg ; \
	done
	
	# Removing the symlinks
	# find -name '*.db' -or -name '*.files' -or -name '*.sig' -delete
	
	# Renaming the tar.gz files without the extension.
	# mv $(arch)/$(repo_name).db.tar.zst 				$(arch)/$(repo_name).db
	# mv $(arch)/$(repo_name).db.tar.zst.sig 		$(arch)/$(repo_name).db.sig
	# mv $(arch)/$(repo_name).files.tar.zst	 		$(arch)/$(repo_name).files
	# mv $(arch)/$(repo_name).files.tar.zst.sig 	$(arch)/$(repo_name).files.sig
