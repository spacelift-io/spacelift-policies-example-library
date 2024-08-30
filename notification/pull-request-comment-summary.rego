# regal ignore:use-rego-v1
package spacelift

import future.keywords

# regal ignore:line-length
header := sprintf("### Resource changes ([link](%s))\n\n![add](https://img.shields.io/badge/add-%d-brightgreen) ![change](https://img.shields.io/badge/change-%d-yellow) ![destroy](https://img.shields.io/badge/destroy-%d-red) ![import](https://img.shields.io/badge/import-%d-blue) ![move](https://img.shields.io/badge/move-%d-purple) ![forget](https://img.shields.io/badge/forget-%d-b07878) \n\n| Action | Resource | Changes |\n| --- | --- | --- |", [input.run_updated.urls.run, count(added), count(changed), count(deleted), count(imported), count(moved), count(forgotten)])

addedresources := concat("\n", added)

changedresources := concat("\n", changed)

deletedresources := concat("\n", deleted)

importedresources := concat("\n", imported)

movedresources := concat("\n", moved)

forgottenresources := concat("\n", forgotten)

added contains row if {
	some x in input.run_updated.run.changes

	# regal ignore:line-length
	row := sprintf("| Added | `%s` | <details><summary>Value</summary>`%s`</details> |", [x.entity.address, x.entity.data.values])

	# regal ignore:deprecated-builtin
	any([x.action == "added", x.action == "destroy-Before-create-replaced", x.action == "create-Before-destroy-replaced"])
	x.entity.entity_type == "resource"
	not x.moved
}

changed contains row if {
	some x in input.run_updated.run.changes

	# regal ignore:line-length
	row := sprintf("| Changed | `%s` | <details><summary>New value</summary>`%s`</details> |", [x.entity.address, x.entity.data.values])
	x.entity.entity_type == "resource"
	x.action == "changed"
	not x.moved
}

deleted contains row if {
	some x in input.run_updated.run.changes
	row := sprintf("| Deleted | `%s` | :x: |", [x.entity.address])

	# regal ignore:line-length, deprecated-builtin
	any([x.action == "deleted", x.action == "destroy-Before-create-replaced", x.action == "create-Before-destroy-replaced"])
	x.entity.entity_type == "resource"
	not x.moved
}

imported contains row if {
	some x in input.run_updated.run.changes

	# regal ignore:line-length
	row := sprintf("| Imported | `%s` | <details><summary>New value</summary>`%s`</details> |", [x.entity.address, x.entity.data.values])
	x.action == "import"
	x.entity.entity_type == "resource"
	not x.moved
}

moved contains row if {
	some x in input.run_updated.run.changes

	# regal ignore:line-length
	row := sprintf("| Moved | `%s` | <details><summary>New value</summary>`%s`</details> |", [x.entity.address, x.entity.data.values])
	x.entity.entity_type == "resource"
	x.moved
}

forgotten contains row if {
	some x in input.run_updated.run.changes
	row := sprintf("| Forgotten | `%s` | :x: |", [x.entity.address])
	x.action == "forget"
	x.entity.entity_type == "resource"
	not x.moved
}

# regal ignore:line-length
pull_request contains {"commit": input.run_updated.run.commit.hash, "body": replace(replace(concat("\n", [header, addedresources, changedresources, deletedresources, importedresources, movedresources, forgottenresources]), "\n\n\n", "\n"), "\n\n", "\n")} if {
	input.run_updated.run.state == "FINISHED"
	input.run_updated.run.type == "PROPOSED"
}

sample := true
