package core

import (
	"bytes"
	"encoding/base64"

	"github.com/dosco/super-graph/core/internal/crypto"
	"github.com/dosco/super-graph/core/internal/qcode"
	"github.com/dosco/super-graph/jsn"
)

func (sg *SuperGraph) encryptCursor(qc *qcode.QCode, data []byte) ([]byte, error) {
	var keys [][]byte

	for _, s := range qc.Selects {
		if s.Paging.Type != qcode.PtOffset {
			var buf bytes.Buffer

			buf.WriteString(s.FieldName)
			buf.WriteString("_cursor")
			keys = append(keys, buf.Bytes())
		}
	}

	if len(keys) == 0 {
		return data, nil
	}

	from := jsn.Get(data, keys)
	to := make([]jsn.Field, len(from))

	for i, f := range from {
		to[i].Key = f.Key

		if f.Value[0] != '"' || f.Value[len(f.Value)-1] != '"' {
			continue
		}

		var buf bytes.Buffer

		if len(f.Value) > 2 {
			v, err := crypto.Encrypt(f.Value[1:len(f.Value)-1], &sg.encKey)
			if err != nil {
				return nil, err
			}

			buf.WriteByte('"')
			buf.WriteString(base64.StdEncoding.EncodeToString(v))
			buf.WriteByte('"')
		} else {
			buf.WriteString(`null`)
		}

		to[i].Value = buf.Bytes()
	}

	var buf bytes.Buffer

	if err := jsn.Replace(&buf, data, from, to); err != nil {
		return nil, err
	}

	return buf.Bytes(), nil
}

func (sg *SuperGraph) decrypt(data string) ([]byte, error) {
	v, err := base64.StdEncoding.DecodeString(data)
	if err != nil {
		return nil, err
	}
	return crypto.Decrypt(v, &sg.encKey)
}
