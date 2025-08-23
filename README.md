# URL Codec Script (`urlcodec.sh`)

A simple Bash script for encoding and decoding URLs using Perl's `URI::Escape` module. Supports colorized output and optional file logging.

---

## 📦 Features

- ✅ Encode or decode URLs via command-line
- ✅ Handles multiple URLs at once
- ✅ Colored output when running in a terminal
- ✅ Optionally log results to a file

---

## 🚀 Usage

```bash
./urlcodec.sh [options] <url> [<url> ...]
```

### Options

| Option            | Description                                 |
|------------------|---------------------------------------------|
| `-e`, `--encode`  | Encode the next URL (default mode)          |
| `-d`, `--decode`  | Decode the next URL                         |
| `-o <file>`       | Append output (with colors) to a file       |
| `-h`, `--help`    | Show help message                           |

---

## 🧪 Examples

```bash
# Encode a URL
./urlcodec.sh -e "https://example.com/abc?param=1&other=value"

# Decode a URL
./urlcodec.sh -d "https%3A%2F%2Fexample%2Ecom%2Fabc%3Fparam%3D1%26other%3Dvalue"

# Mix encode and decode
./urlcodec.sh -e "https://example.com" -d "https%3A%2F%2Fexample.com"

# Save output to a file
./urlcodec.sh -e "https://example.com" -o output.txt
```

---

## ⚙️ Requirements

- **Bash**
- **Perl** with the `URI::Escape` module

### Install Perl module if missing:

```bash
cpan URI::Escape
```

---

