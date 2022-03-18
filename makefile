arch 		   := x86_64
repo_name   := mwglen-arch-repo
arch		   := x86_64
packages    := $(shell ls packages | sed  's/ /\n/g' \
					| awk '{print "packages/" $$1 "/$(arch).pkg.tar.zst"}')

.PHONY: list_packages
list_packages:
	echo $(packages)

packages/%/$(arch).pkg.tar.zst: $(filter-out *.pkg.tar.zst ,  $(wildcard packages/%/*))
	# Remove old packages
	rm -rf packages/$*/*.pkg.tar.zst
	
	# Make the package
	cd packages/$* && makepkg -sc
	
	# Move and rename the package
	mv packages/$*/*.pkg.tar.zst $@ || true

.PHONY: repo
repo: $(packages)
	
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
	rm *.db *.files *.files.sig *.db.sig
	
	# Renaming the tar.gz files without the extension.
	mv $(arch)/$(repo_name).db.tar.zst 				$(arch)/$(repo_name).db
	mv $(arch)/$(repo_name).db.tar.zst.sig 		$(arch)/$(repo_name).db.sig
	mv $(arch)/$(repo_name).files.tar.zst	 		$(arch)/$(repo_name).files
	mv $(arch)/$(repo_name).files.tar.zst.sig 	$(arch)/$(repo_name).files.sig
