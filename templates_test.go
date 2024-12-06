package policylib_test

import (
	"io/fs"
	"os"
	"testing"
	"testing/fstest"

	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"

	policylib "github.com/spacelift-io/spacelift-policies-example-library"
)

func TestTemplates(t *testing.T) {
	require.NotPanics(t, func() {
		templates := policylib.Templates()
		require.Greater(t, len(templates), 1, "should have templates")
		assertUniqueNames(t, templates, "template names must be unique")
	}, "embedded templates should not panic")
}

func assertUniqueNames(t *testing.T, templates []policylib.Template, msg string) int {
	set := map[string]bool{}
	for _, template := range templates {
		if set[template.Name] {
			assert.Failf(t, "duplicate template name: "+template.Name, msg)
		}
		set[template.Name] = true
	}
	return len(set)
}

func TestTemplates_Parsing(t *testing.T) {
	tests := []struct {
		name            string
		fs              fs.FS
		wantErr         bool
		wantErrContains string
		wantTemplates   []policylib.Template
	}{
		{
			name:          "empty file system",
			fs:            fstest.MapFS{},
			wantErr:       false,
			wantTemplates: nil,
		},
		{
			name: "no templates",
			fs: fstest.MapFS{
				"noise.txt": {},
			},
			wantErr:       false,
			wantTemplates: nil,
		},
		{
			name: "missing metadata",
			fs: fstest.MapFS{
				"foo.rego": {},
			},
			wantErr:       false,
			wantTemplates: nil,
		},
		{
			name: "empty metadata",
			fs: fstest.MapFS{
				"foo.rego": {},
				"foo.yml":  {},
			},
			wantErr:         true,
			wantErrContains: "EOF",
		},
		{
			name:    "minimal",
			fs:      os.DirFS("./testdata/minimal"),
			wantErr: false,
			wantTemplates: []policylib.Template{
				{
					Name:        "foo",
					Type:        "push",
					Description: "",
					Labels:      nil,
					Body:        "package foo\n",
				},
			},
		},
		{
			name:    "full",
			fs:      os.DirFS("./testdata/full"),
			wantErr: false,
			wantTemplates: []policylib.Template{
				{
					Name:        "foo",
					Type:        "push",
					Description: "something\n",
					Labels:      []string{"foo", "test"},
					Body:        "package foo\n",
				},
			},
		},
		{
			name:            "invalid policy type",
			fs:              os.DirFS("./testdata/invalid-policy-type"),
			wantErr:         true,
			wantErrContains: "type",
		},
		{
			name:            "missing name",
			fs:              os.DirFS("./testdata/missing-name"),
			wantErr:         true,
			wantErrContains: "name",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {

			templates, err := policylib.EParse(tt.fs)

			if tt.wantErr {
				assert.ErrorContains(t, err, tt.wantErrContains, "error should contain expected text")
			} else {
				assert.NoError(t, err, "no error is expected")
				assert.Equal(t, tt.wantTemplates, templates, "templates should match")
			}
		})
	}
}
