Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6C1D232CB
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 01:41:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B59D84066C;
	Fri,  9 Jan 2026 02:41:12 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 36BE840279
 for <dev@dpdk.org>; Fri,  9 Jan 2026 02:41:11 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso40460845e9.0
 for <dev@dpdk.org>; Thu, 08 Jan 2026 17:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767922871;
 x=1768527671; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xwtxauwq3rX3P+UDOS+hio477gvEoCy/htLubSiaLo0=;
 b=joS3nDU8R8+W2hVLvGgZtGDU2S9ExLZVFkkivOWrqYfUG6iRZS6gEowfw5/CIrfo8E
 2CHtyz6/9zv7OVYs657ccFDozq4kroYku6PqVQbpbndm/SrfnOMstxJYDWOFNQ8f9UDS
 duCHmOIKLP+Pwaacfo9oLnAtYNUnSjoBPQiTVkNq3bj4E7AKbeZ7iAtAkMY1ww1nqPK1
 ufUbExErEuvF7ulum7WqW25seBmYe7fSNmZR7nfoQdN5g4SGdjXEB9l3ki07h6ea9IlO
 aqXxDElXvkLJON9CBB9MDy8M/JFjfo5lsshaJz7SjjEOCNJeoFd1gQUB2BjvG4a3sJD5
 e/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767922871; x=1768527671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xwtxauwq3rX3P+UDOS+hio477gvEoCy/htLubSiaLo0=;
 b=bby9FrRdLCdrcKS9flXU/zXzFif1IOnnluXmnhYoBIJai8U+qU/voNT+cF5S/zu57s
 Aow3n3mRapntoHwP439nAcTWvf1cRNGBaQ/4NdiT5YtQpsypp/6Qv4wlW81Im3uypKQv
 izhRkMIhuP3CdlFNjeisnb4E2Vh+WA1TO0bMx5KRR4xGWgFIzU0XvbjRoLD1brPxibbJ
 Qh9waUKsZYZ+jveQztehGKVp+tVhw2RvD+IplRW5+29j4IZrkE7yQeUG+mS73eZTiu9o
 i3Viu0NCkxwnvzL5swusIG7+4Jfw7AOEPzdRUpp+5behHNOvz+yqJbVKlZkpvHKWfzfK
 iXxg==
X-Gm-Message-State: AOJu0YwrDO6Ict5gkGQZuRt90JhNhnotqc1I9EwC/iiLkdmAd54GKlFH
 nV85fA9DPAd2r6oH39yXzHL0CRTAqr4gi+dk4HWHqcSCdmpZVR1OC9WwinbPWdF9DlFcz3I/Y6l
 /RO+a
X-Gm-Gg: AY/fxX6Yi8TtiaHYr5AWNC9qmMWqAyMLj0Vjd24T6RN91TRrZRCkzuNdBKee2Aka/L1
 8h69HKB7meupfBEuBR/+XukQ7pl5QHVvlL1NS2FhlQN5JAkn/tdgmBJBagd36IYlm8QpQzmcShY
 f/8qlXDSAvr0Md1DjKITqE+S92VWvsCivIco3W0lIS8AxkfmUyvpzu8yInoJa38O9MMmOc38oIb
 cfuqo14WiMTH2DF+pdE+tIOfsm1NkDDqQ4/Ns6a7JwLdPIT0cRxtPuqTxTzsHlkEb8+wZuJXmIV
 BcAxEgR0UMLZ+nv+bd/yZk6n5/iGknzXhPCUPxG9Sz6nRzudc2TtWP2mzfG/qc5wZm788woyJr2
 a/x/PnCgU0C9LqYr1JHUn+i/MMVoop59ypIIOYtnfBkLb4aSn2vlr1CIqyLfW6lvm16/EdnLBcO
 BQnyzzuG6HkCNN1JhzxchnuwK0eBv2oVjvQceyyEONTJbP9tJuOA==
X-Google-Smtp-Source: AGHT+IFSwbpbgGrY5fF+SmBuYdG9hPf7fBUSG4h64opRw5plrIR12EXAksm6t2cnoyCzlADR5WuPQQ==
X-Received: by 2002:a05:600c:4f87:b0:475:da1a:5418 with SMTP id
 5b1f17b1804b1-47d84b0a9a4mr91521365e9.1.1767922870670; 
 Thu, 08 Jan 2026 17:41:10 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6953fasm176486865e9.5.2026.01.08.17.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 17:41:10 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC] doc: add AGENTS.md for AI-powered code review tools
Date: Thu,  8 Jan 2026 17:41:04 -0800
Message-ID: <20260109014106.398156-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Add a structured reference document that enables AI code review tools
to validate DPDK contributions against project standards. This document
consolidates requirements from multiple sources into a machine-readable
format optimized for automated validation workflows.

The AGENTS.md file synthesizes guidelines from:
- DPDK Contributing Code documentation (patches.rst)
- DPDK Coding Style guidelines (coding_style.rst)
- Linux kernel patch submission process (submitting-patches.rst)
- SPDX License Identifier specification (spdx.org)

Key sections include:
- SPDX license identifier requirements
- Commit message format and tag ordering
- C coding style rules and naming conventions
- Patch validation checklists with severity levels
- Meson build file style requirements

The document provides actionable checklists and concrete examples to
support integration with CI/CD pipelines and automated review systems.
Severity levels (error/warning/info) help tools prioritize feedback
appropriately.

This supports the broader goal of maintaining code quality and
consistency as the project scales, while reducing manual review burden
for maintainers on mechanical style issues.

References:
- https://doc.dpdk.org/guides/contributing/patches.html
- https://doc.dpdk.org/guides/contributing/coding_style.html
- https://www.kernel.org/doc/html/latest/process/submitting-patches.html
- https://spdx.org/licenses/

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 AGENTS.md | 410 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 410 insertions(+)
 create mode 100644 AGENTS.md

diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 0000000000..cfaaa81af3
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,410 @@
+# AGENTS.md - DPDK Code Review Guidelines for AI Tools
+
+This document provides guidelines for AI-powered code review tools when reviewing contributions to the Data Plane Development Kit (DPDK). It is derived from the official DPDK contributor guidelines.
+
+## Overview
+
+DPDK follows a development process modeled on the Linux Kernel. All patches are reviewed publicly on the mailing list before being merged. AI review tools should verify compliance with the standards outlined below.
+
+---
+
+## Source License Requirements
+
+### SPDX License Identifiers
+
+- **Every file must begin with an SPDX license identifier** on the first line (or second line for `#!` scripts)
+- Core libraries and drivers use `BSD-3-Clause`
+- Kernel components use `GPL-2.0`
+- Dual-licensed code uses: `(BSD-3-Clause OR GPL-2.0)`
+
+```c
+/* Correct */
+/* SPDX-License-Identifier: BSD-3-Clause */
+
+/* Incorrect - no boilerplate license text should follow */
+```
+
+- A blank line must follow the license header before any other content
+
+---
+
+## Commit Message Requirements
+
+### Subject Line (First Line)
+
+- **Must capture the area and impact** of the change
+- **~50 characters** recommended length
+- **Lowercase** except for acronyms
+- **Prefixed with component name** (check `git log` for existing components)
+- Use **imperative mood** (instructions to the codebase)
+- **No trailing period** (causes double periods in patch filenames)
+
+```
+# Good examples
+ixgbe: fix offload config option name
+config: increase max queues per port
+net/mlx5: add support for flow counters
+
+# Bad examples
+Fixed the offload config option.    # past tense, has period
+IXGBE: Fix Offload Config           # uppercase
+```
+
+### Commit Body
+
+- Describe the issue being fixed or feature being added
+- Provide enough context for reviewers to understand the purpose
+- Wrap text at **72 characters**
+- **Must end with** `Signed-off-by:` line (real name, not alias)
+- When fixing regressions, include:
+  ```
+  Fixes: abcdefgh1234 ("original commit subject")
+  Cc: original_author@example.com
+  ```
+
+### Required Tags
+
+```
+# For Coverity issues:
+Coverity issue: 12345
+
+# For Bugzilla issues:
+Bugzilla ID: 12345
+
+# For stable release backport candidates:
+Cc: stable@dpdk.org
+
+# For patch dependencies:
+Depends-on: series-NNNNN ("Title of the series")
+```
+
+### Tag Order
+
+```
+Coverity issue:
+Bugzilla ID:
+Fixes:
+Cc:
+
+Reported-by:
+Suggested-by:
+Signed-off-by:
+Acked-by:
+Reviewed-by:
+Tested-by:
+```
+
+Note: Empty line between the first group and `Reported-by:`
+
+---
+
+## C Coding Style
+
+### General Formatting
+
+- **Line length**: Recommended ≤80 characters, acceptable up to 100
+- **Tab width**: 8 characters (hard tabs for indentation, spaces for alignment)
+- **No trailing whitespace** on lines or at end of files
+- Code style must be consistent within each file
+
+### Comments
+
+```c
+/* Most single-line comments look like this. */
+
+/*
+ * VERY important single-line comments look like this.
+ */
+
+/*
+ * Multi-line comments look like this. Make them real sentences. Fill
+ * them so they look like real paragraphs.
+ */
+```
+
+### Header File Organization
+
+Include order (each group separated by blank line):
+1. System/libc includes
+2. DPDK EAL includes
+3. DPDK misc library includes
+4. Application-specific includes
+
+```c
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <rte_eal.h>
+
+#include <rte_ring.h>
+#include <rte_mempool.h>
+
+#include "application.h"
+```
+
+### Header Guards
+
+```c
+#ifndef _FILE_H_
+#define _FILE_H_
+
+/* Code */
+
+#endif /* _FILE_H_ */
+```
+
+### Naming Conventions
+
+- **All external symbols** must have `RTE_` or `rte_` prefix
+- **Macros**: ALL_UPPERCASE
+- **Functions**: lowercase with underscores only (no CamelCase)
+- **Variables**: lowercase with underscores only
+- **Enum values**: ALL_UPPERCASE with `RTE_<ENUM>_` prefix
+- **Struct types**: prefer `struct name` over typedefs
+
+#### Prohibited Terminology
+
+Do not use:
+- `master/slave` → Use: primary/secondary, controller/worker, leader/follower
+- `blacklist/whitelist` → Use: denylist/allowlist, blocklist/passlist
+
+### Indentation and Braces
+
+```c
+/* Control statements - no braces for single statements */
+if (val != NULL)
+        val = realloc(val, newsize);
+
+/* Braces on same line as else */
+if (test)
+        stmt;
+else if (bar) {
+        stmt;
+        stmt;
+} else
+        stmt;
+
+/* Switch statements - don't indent case */
+switch (ch) {
+case 'a':
+        aflag = 1;
+        /* FALLTHROUGH */
+case 'b':
+        bflag = 1;
+        break;
+default:
+        usage();
+}
+
+/* Long conditions - double indent continuation */
+if (really_long_variable_name_1 == really_long_variable_name_2 &&
+                var3 == var4) {
+        x = y + z;
+}
+```
+
+### Function Definitions
+
+```c
+/* Return type on its own line, opening brace on its own line */
+static char *
+function(int a1, int a2, float fl, int a4)
+{
+        /* body */
+}
+```
+
+### Variable Declarations
+
+```c
+int *x;         /* no space after asterisk */
+int * const x;  /* space before type qualifier */
+
+/* Multiple initializers - one per line */
+char a = 0;
+char b = 0;
+
+/* Or only last variable initialized */
+float x, y = 0.0;
+```
+
+### Pointer and NULL Comparisons
+
+```c
+/* Good */
+if (p == NULL)
+if (*p == '\0')
+
+/* Bad */
+if (!p)           /* don't use ! on pointers */
+```
+
+### Return Values
+
+- Object creation/allocation: return pointer, NULL on error, set `rte_errno`
+- Packet burst functions: return number of packets handled
+- Other int-returning functions: 0 on success, -1 on error (or `-errno`)
+- No-error functions: use `void` return type
+- Don't cast `void *` return values
+- Don't parenthesize return values
+
+### Macros
+
+```c
+/* Wrap compound statements in do-while(0) */
+#define MACRO(x, y) do {                                        \
+        variable = (x) + (y);                                   \
+        (y) += 2;                                               \
+} while (0)
+```
+
+Prefer enums and inline functions over macros when possible.
+
+### Structure Layout
+
+- Order members by: use, then size (largest to smallest), then alphabetically
+- New additions to existing structures go at the end (ABI compatibility)
+- Align member names with spaces
+- Avoid `bool` in structures (unclear size, wastes space)
+
+```c
+struct foo {
+        struct foo      *next;          /* List of active foo. */
+        struct mumble   amumble;        /* Comment for mumble. */
+        int             bar;            /* Try to align the comments. */
+};
+```
+
+---
+
+## Code Quality Requirements
+
+### Compilation
+
+- Each commit must compile independently (for `git bisect`)
+- No forward dependencies within a patchset
+- Test with multiple targets, compilers, and options
+- Use `devtools/test-meson-builds.sh`
+
+### Testing
+
+- Add tests to `app/test` unit test framework
+- New API functions must be used in `/app` test directory
+- New device APIs require at least one driver implementation
+
+### Documentation
+
+- Add Doxygen comments for public APIs
+- Update release notes in `doc/guides/rel_notes/` for important changes
+- Code and documentation must be updated atomically in same patch
+
+### ABI Compatibility
+
+- New external functions must be exported properly
+- Follow ABI policy and versioning guidelines
+- Enable ABI checks with `DPDK_ABI_REF_VERSION` environment variable
+
+---
+
+## Patch Validation Checklist
+
+AI review tools should verify:
+
+### Commit Message
+- [ ] Subject line ~50 chars, lowercase (except acronyms)
+- [ ] Component prefix present and valid
+- [ ] Imperative mood used
+- [ ] No trailing period on subject
+- [ ] Body wrapped at 72 characters
+- [ ] `Signed-off-by:` present with real name
+- [ ] `Fixes:` tag present for bug fixes with 12-char SHA
+- [ ] Tags in correct order
+
+### License
+- [ ] SPDX identifier on first line (or second for scripts)
+- [ ] Appropriate license for file type
+- [ ] Blank line after license header
+
+### Code Style
+- [ ] Lines ≤100 characters (prefer ≤80)
+- [ ] Hard tabs for indentation
+- [ ] No trailing whitespace
+- [ ] Proper include order
+- [ ] Header guards present
+- [ ] `rte_`/`RTE_` prefix on external symbols
+- [ ] No prohibited terminology
+- [ ] Proper brace style
+- [ ] Function return type on own line
+- [ ] NULL comparisons use `== NULL`
+
+### Structure
+- [ ] Each commit compiles independently
+- [ ] Code and docs updated together
+- [ ] Tests added/updated as needed
+- [ ] Release notes updated for significant changes
+
+---
+
+## Meson Build Files
+
+### Style Requirements
+
+- 4-space indentation (no tabs)
+- Line continuations double-indented
+- Lists alphabetically ordered
+- Short lists (≤3 items): single line, no trailing comma
+- Long lists: one item per line, trailing comma on last item
+
+```python
+# Short list
+sources = files('file1.c', 'file2.c')
+
+# Long list
+headers = files(
+        'header1.h',
+        'header2.h',
+        'header3.h',
+)
+```
+
+---
+
+## Python Code
+
+- Must comply with PEP8
+- Line length acceptable up to 100 characters
+- Use `pep8` tool for validation
+
+---
+
+## Review Process Notes
+
+### For AI Review Tools
+
+When providing feedback:
+- Reference specific line numbers
+- Cite the relevant guideline section
+- Suggest concrete fixes
+- Prioritize: errors > warnings > style suggestions
+- Flag potential ABI breaks
+- Check for missing documentation updates
+- Verify test coverage for new functionality
+
+### Severity Levels
+
+**Error** (must fix):
+- Missing SPDX license
+- Missing Signed-off-by
+- Compilation failures
+- ABI breaks without proper versioning
+
+**Warning** (should fix):
+- Style violations
+- Missing Fixes tag for bug fixes
+- Documentation gaps
+- Missing tests
+
+**Info** (consider):
+- Minor style preferences
+- Optimization suggestions
+- Alternative approaches
-- 
2.51.0

