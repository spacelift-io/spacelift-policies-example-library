package policylib

import (
	"embed"
	"errors"
	"fmt"
	"io"
	"io/fs"
	"strings"

	"gopkg.in/yaml.v3"
)

//go:embed examples
var embeddedTemplates embed.FS

func Templates() []Template {
	results, err := parse(embeddedTemplates)
	if err != nil {
		panic("policylib: " + err.Error())
	}
	return results
}

type Template struct {
	Name        string
	Type        string
	Description string
	Labels      []string
	Body        string
}

func parse(f fs.FS) ([]Template, error) {
	var result []Template
	err := fs.WalkDir(f, ".", func(path string, _ fs.DirEntry, err error) error {
		if err != nil {
			return err
		}

		const yml = ".yml"
		if !strings.HasSuffix(path, yml) {
			return nil
		}

		meta, err := f.Open(path)
		if err != nil {
			return err
		}
		defer func() { _ = meta.Close() }()

		body, err := f.Open(strings.TrimSuffix(path, yml) + ".rego")
		if err != nil {
			return err
		}
		defer func() { _ = body.Close() }()

		template, err := newTemplateFrom(meta, body)
		result = append(result, template)
		if err != nil {
			return fmt.Errorf("parse %v: %w", path, err)
		}
		return nil
	})

	if err != nil {
		return nil, fmt.Errorf("templates: %w", err)
	}

	return result, nil
}

func newTemplateFrom(metaData, policy io.Reader) (Template, error) {
	var meta struct {
		Name        string   `yaml:"name"`
		Description string   `yaml:"description"`
		Type        string   `yaml:"type"`
		Labels      []string `yaml:"labels"`
	}

	err := yaml.NewDecoder(metaData).Decode(&meta)
	if err != nil {
		return Template{}, fmt.Errorf("decode meta data: %w", err)
	}

	body, err := io.ReadAll(policy)
	if err != nil {
		return Template{}, fmt.Errorf("read template body: %w", err)
	}

	result := Template{
		Name:        meta.Name,
		Type:        meta.Type,
		Description: meta.Description,
		Labels:      meta.Labels,
		Body:        string(body),
	}

	return result, result.Validate()
}

func (t Template) Validate() error {
	if t.Name == "" {
		return errors.New("validate: name cannot be empty")
	}
	if _, ok := acceptedPolicyTypes[t.Type]; !ok {
		return fmt.Errorf("validate: unknown policy type %q", t.Type)
	}
	if t.Body == "" {
		return errors.New("validate: body cannot be empty")
	}
	return nil
}

var acceptedPolicyTypes = map[string]struct{}{
	"unknown":        {},
	"login":          {},
	"access":         {},
	"stack_access":   {},
	"git_push":       {},
	"push":           {},
	"initialization": {},
	"plan":           {},
	"terraform_plan": {},
	"task":           {},
	"task_run":       {},
	"trigger":        {},
	"approval":       {},
	"notification":   {},
}
