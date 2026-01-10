Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F8ED277C1
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 18:00:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75A0240E1B;
	Sat, 10 Jan 2026 19:00:46 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44]) by mails.dpdk.org (Postfix) with ESMTP id 3356B4028E
 for <dev@dpdk.org>; Sat, 10 Jan 2026 19:00:45 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so2901135f8f.3
 for <dev@dpdk.org>; Sat, 10 Jan 2026 10:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768068044;
 x=1768672844; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4LrMWAB5w3rYwS0el6h1e3c2x7yTsxKSx3+F+dKd2U=;
 b=uAm+RAoYZ53ce/6fYNQbpjDtQ5qVTbRrJwnJeAURETTy2XANCIaythnG8V8mouU0aZ
 lDb0auc3MtTo6y4OMVt6j7gGtlt9fl4iRO7b/y6WmTdvk04HMiu57mgsjiAB50ok8hIR
 Q1+SRrg9mMdkP/mlhyGGCNHC3g4wXRmWvn8WLBa+LHkCBtzTYieixjc8PwIyblVqXgvr
 +PDkY/PHRVJq1YidN4MJmwVJPcsA1FqSsNUm2wZbMYdHE56qxwCSGD9n6IfumSY7dcvv
 7m53etjbLlsuj5yLGuff56388TVLXikou94fSZhKo9wZexFfDceXMx5vbkrmXr2w3j73
 QMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768068044; x=1768672844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S4LrMWAB5w3rYwS0el6h1e3c2x7yTsxKSx3+F+dKd2U=;
 b=qA3ZnnF5jZsvSU/nnvSJrzocwykvEaX10+5B7fwC113NTPmVQ5aWKXCBWEp+qYIqAh
 N6zCX37ltdVWLVAs1ihCADFQG80jDVCyQyC4vWnhukC2n861hvKRBmgpm3KyFQb53LnS
 4R0bONJ39FBxyr3EP0Yo5MScsTGMY4N/oCo07oxDVm4zj8zM5F4QA2DwbXLryCZYAss7
 NQm4NJ9pWrQdhukla/9jgToPw6ErJVH4qzPiGhohotVdPWZjkxnTYabLE5NEUhJgdir/
 4vU1Z3vyXsUDfOnUJ+2hFvOoTqUgmPhIF3lj3Olw/unQzn9YrmUoByzkWGAyEwH8NEgx
 TBdg==
X-Gm-Message-State: AOJu0YxrkYGHYi0Bfe2bstWtlCMnb+XYhD0q8lGvpXjuH2bomxvvEUVG
 v9Yt4YT4J/1VKTDUPMxnQn1JFZrpAH/zOSc6vsq2kFdJ7PbfcAqtEkBGEPEwwrLk+OP6ZHBN0vF
 DGwTy
X-Gm-Gg: AY/fxX5NSGj18VySaskeSIAwZ6r2hv7lMvb2dW36wg4cDxI1/540AmVq7QB6DnqtDOj
 6Y4/qSblCIQ/ry17wtnFN2YfmfDpe0vyQ5vH/qCha49Epc9LPm3LErOrW8oWUEusS9x7viT0Uww
 3Fk9POCfOyzQSZ+Dr4XfMLWzUOTUv0cZZwTDsIfQtGFl4qc+zE/CIrzv7JOsHz/sGlSxudJNHqT
 hzWeuu02kv/caTA9EVLuIBBnP9Cv1u5vPJuB3UoBzRhKLs/Gw9aAtUV0FEThG9UMW4beopmfjfW
 PgQog1IYV87DWiOqrFAMB9+6BKj+mItmvYLjjlQ8FHsQJfxIuqPelryee5BFIwuXoKFumR80oDv
 Idj7OhneGDh3+ZTFxfCMaBXZTg0uwpqNF5eTZoUc68kjHYq9N9BOJbM6X+c0sLBQpo6XhGF2bnU
 GsOsRLgiIPU2J7kvj4N6M7BSLpYVZWSGDLoUpytdecbdJ1c2mmmA==
X-Google-Smtp-Source: AGHT+IEqeFDlJ2gQC8kXx0+RtVaFqej0Jw3IefnahVQcT/t+lQtOaaiHd2GCYGM6XCqdUb/F7W2BkQ==
X-Received: by 2002:a05:6000:c8c:b0:432:c39d:102d with SMTP id
 ffacd0b85a97d-432c39d1044mr10731735f8f.0.1768068044102; 
 Sat, 10 Jan 2026 10:00:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e199bsm28834149f8f.16.2026.01.10.10.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jan 2026 10:00:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2] doc: add AGENTS.md for AI-powered code review tools
Date: Sat, 10 Jan 2026 10:00:37 -0800
Message-ID: <20260110180038.11525-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109014106.398156-1-stephen@networkplumber.org>
References: <20260109014106.398156-1-stephen@networkplumber.org>
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
- DPDK validation scripts (check-git-log.sh, checkpatches.sh)
- Linux kernel patch submission process
- SPDX License Identifier specification

Key sections include:
- SPDX license and copyright header requirements
- Commit message format with precise limits (60 char subject,
  75 char body) and tag ordering rules
- C coding style including explicit comparison requirements
- Forbidden tokens table derived from checkpatches.sh
- API tag placement rules for experimental and internal APIs
- Patch validation checklists with severity levels

The forbidden tokens section documents restrictions on deprecated
atomics, logging functions, threading APIs, and compiler built-ins
that are checked by the existing checkpatches.sh infrastructure.

Severity levels (error/warning/info) align with the exit codes and
messaging from check-git-log.sh and checkpatches.sh to help automated
tools prioritize feedback appropriately.

References:
- https://doc.dpdk.org/guides/contributing/patches.html
- https://doc.dpdk.org/guides/contributing/coding_style.html
- devtools/check-git-log.sh
- devtools/checkpatches.sh

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 AGENTS.md | 693 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 693 insertions(+)
 create mode 100644 AGENTS.md

diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 0000000000..9d5a2e1de9
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,693 @@
+# AGENTS.md - DPDK Code Review Guidelines for AI Tools
+
+This document provides guidelines for AI-powered code review tools when reviewing contributions to the Data Plane Development Kit (DPDK). It is derived from the official DPDK contributor guidelines and validation scripts.
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
+Every source file must begin with an SPDX license identifier, followed by the copyright notice, then a blank line before other content.
+
+- SPDX tag on first line (or second line for `#!` scripts)
+- Copyright line immediately follows
+- Blank line after copyright before any code/includes
+- Core libraries and drivers use `BSD-3-Clause`
+- Kernel components use `GPL-2.0`
+- Dual-licensed code uses: `(BSD-3-Clause OR GPL-2.0)`
+
+```c
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 ExampleCorp
+ */
+
+#include <stdio.h>
+```
+
+For scripts:
+```python
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2024 ExampleCorp
+
+import sys
+```
+
+**Do not include boilerplate license text** - the SPDX identifier is sufficient.
+
+---
+
+## Commit Message Requirements
+
+### Subject Line (First Line)
+
+| Rule | Limit |
+|------|-------|
+| Maximum length | **60 characters** |
+| Format | `component: lowercase description` |
+| Case | Lowercase except acronyms |
+| Mood | Imperative (instructions to codebase) |
+| Punctuation | **No trailing period** |
+
+```
+# Good examples
+net/ixgbe: fix offload config option name
+config: increase max queues per port
+net/mlx5: add support for flow counters
+app/testpmd: fix memory leak in flow create
+
+# Bad examples
+Fixed the offload config option.    # past tense, has period, no prefix
+net/ixgbe: Fix Offload Config       # uppercase after colon
+ixgbe: fix something                # wrong prefix, should be net/ixgbe
+lib/ethdev: add new feature         # wrong prefix, should be ethdev:
+```
+
+#### Headline Format Errors (from check-git-log.sh)
+
+The following are flagged as errors:
+- Tab characters in subject
+- Leading or trailing spaces
+- Trailing period (`.`)
+- Punctuation marks: `, ; ! ? & |`
+- Underscores after the colon (indicates code in subject)
+- Missing colon separator
+- No space after colon
+- Space before colon
+
+#### Common Prefix Mistakes
+
+| Wrong | Correct |
+|-------|---------|
+| `ixgbe:` | `net/ixgbe:` |
+| `lib/ethdev:` | `ethdev:` |
+| `example:` | `examples/foo:` |
+| `apps/` | `app/name:` |
+| `testpmd:` | `app/testpmd:` |
+| `test-pmd:` | `app/testpmd:` |
+| `bond:` | `net/bonding:` |
+
+#### Case-Sensitive Terms
+
+These terms must use exact capitalization (from `devtools/words-case.txt`):
+- `Rx`, `Tx` (not `RX`, `TX`, `rx`, `tx`)
+- `VF`, `PF` (not `vf`, `pf`)
+- `MAC`, `VLAN`, `RSS`, `API`
+- `Linux`, `Windows`, `FreeBSD`
+- Check `devtools/words-case.txt` for complete list
+
+### Commit Body
+
+| Rule | Limit |
+|------|-------|
+| Line wrap | **75 characters** |
+| Exception | `Fixes:` lines may exceed 75 chars |
+
+Body guidelines:
+- Describe the issue being fixed or feature being added
+- Provide enough context for reviewers
+- **Do not start the commit message body with "It"**
+- **Must end with** `Signed-off-by:` line (real name, not alias)
+
+### Fixes Tag
+
+When fixing regressions, use the `Fixes:` tag with a 12-character abbreviated SHA:
+
+```
+Fixes: abcdefgh1234 ("original commit subject")
+```
+
+The hash must reference a commit in the current branch, and the subject must match exactly.
+
+**Finding maintainers**: Use `devtools/get-maintainer.sh` to identify the current subsystem maintainer from the `MAINTAINERS` file, rather than CC'ing the original author:
+
+```bash
+git send-email --to-cmd ./devtools/get-maintainer.sh --cc dev@dpdk.org 000*.patch
+```
+
+### Required Tags
+
+```
+# For Coverity issues (required if "coverity" mentioned in body):
+Coverity issue: 12345
+
+# For Bugzilla issues (required if "bugzilla" mentioned in body):
+Bugzilla ID: 12345
+
+# For stable release backport candidates:
+Cc: stable@dpdk.org
+
+# For patch dependencies (in commit notes after ---):
+Depends-on: series-NNNNN ("Title of the series")
+```
+
+### Tag Order
+
+Tags must appear in this order:
+
+```
+Coverity issue:
+Bugzilla ID:
+Fixes:
+Cc:
+                          <-- blank line required here
+Reported-by:
+Suggested-by:
+Signed-off-by:
+Acked-by:
+Reviewed-by:
+Tested-by:
+```
+
+**Tag format**: `Tag-name: Full Name <email@domain.com>`
+
+---
+
+## C Coding Style
+
+### Line Length
+
+| Context | Limit |
+|---------|-------|
+| Source code | **100 characters** |
+| Commit body | **75 characters** |
+
+### General Formatting
+
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
+- **Macros**: ALL_UPPERCASE with `RTE_` prefix
+- **Functions**: lowercase with underscores only (no CamelCase)
+- **Variables**: lowercase with underscores only
+- **Enum values**: ALL_UPPERCASE with `RTE_<ENUM>_` prefix
+
+**Exception**: Driver base directories (`drivers/*/base/`) may use different naming conventions when sharing code across platforms or with upstream vendor code.
+
+#### Prohibited Terminology
+
+Do not use:
+- `master/slave` → Use: primary/secondary, controller/worker, leader/follower
+- `blacklist/whitelist` → Use: denylist/allowlist, blocklist/passlist
+
+### Comparisons and Boolean Logic
+
+```c
+/* Pointers - compare explicitly with NULL */
+if (p == NULL)      /* Good */
+if (p != NULL)      /* Good */
+if (!p)             /* Bad - don't use ! on pointers */
+
+/* Integers - compare explicitly with zero */
+if (a == 0)         /* Good */
+if (a != 0)         /* Good */
+if (!a)             /* Bad - don't use ! on integers */
+
+/* Characters - compare with character constant */
+if (*p == '\0')     /* Good */
+
+/* Booleans - direct test is acceptable */
+if (flag)           /* Good for actual bool types */
+if (!flag)          /* Good for actual bool types */
+```
+
+### Boolean Usage
+
+- Using `bool` type is allowed
+- Prefer `bool` over `int` when a variable or field is only used as a boolean
+- For structure fields, consider if the size/alignment impact is acceptable
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
+
+```c
+struct foo {
+        struct foo      *next;          /* List of active foo. */
+        struct mumble   amumble;        /* Comment for mumble. */
+        int             bar;            /* Try to align the comments. */
+        bool            is_valid;       /* Boolean field is acceptable. */
+};
+```
+
+---
+
+## Forbidden Tokens (from checkpatches.sh)
+
+### Logging
+
+| Forbidden | Preferred | Context |
+|-----------|-----------|---------|
+| `RTE_LOG()` | `RTE_LOG_LINE()` | lib/, drivers/ |
+| `RTE_LOG_DP()` | `RTE_LOG_DP_LINE()` | drivers/ |
+| `rte_log()` | `RTE_LOG_LINE()` | drivers/ |
+| `printf()` | Use RTE logging | lib/, drivers/ |
+| `fprintf(stdout,...)` | Use RTE logging | lib/, drivers/ |
+| `fprintf(stderr,...)` | Use RTE logging | lib/, drivers/ |
+| `RTE_LOG_REGISTER` | `RTE_LOG_REGISTER_DEFAULT` or `RTE_LOG_REGISTER_SUFFIX` | lib/, drivers/ |
+
+### Error Handling
+
+| Forbidden | Preferred | Context |
+|-----------|-----------|---------|
+| `rte_panic()` | Return error codes | lib/, drivers/ |
+| `rte_exit()` | Return error codes | lib/, drivers/ |
+
+### Atomics and Memory Barriers
+
+| Forbidden | Preferred |
+|-----------|-----------|
+| `rte_atomic16/32/64_xxx()` | C11 atomics via `rte_atomic_xxx()` |
+| `rte_smp_mb()` | `rte_atomic_thread_fence()` |
+| `rte_smp_rmb()` | `rte_atomic_thread_fence()` |
+| `rte_smp_wmb()` | `rte_atomic_thread_fence()` |
+| `__sync_xxx()` | `rte_atomic_xxx()` |
+| `__atomic_xxx()` | `rte_atomic_xxx()` |
+| `__ATOMIC_RELAXED` etc. | `rte_memory_order_xxx` |
+| `__rte_atomic_thread_fence()` | `rte_atomic_thread_fence()` |
+
+### Threading
+
+| Forbidden | Preferred |
+|-----------|-----------|
+| `pthread_create()` | `rte_thread_create()` |
+| `pthread_join()` | `rte_thread_join()` |
+| `pthread_detach()` | EAL thread functions |
+| `pthread_setaffinity_np()` | `rte_thread_set_affinity()` |
+| `rte_thread_set_name()` | `rte_thread_set_prefixed_name()` |
+| `rte_thread_create_control()` | `rte_thread_create_internal_control()` |
+
+### Compiler Built-ins and Attributes
+
+| Forbidden | Preferred | Notes |
+|-----------|-----------|-------|
+| `__attribute__` | RTE macros in `rte_common.h` | Except in `lib/eal/include/rte_common.h` |
+| `__alignof__` | C11 `alignof` | |
+| `__typeof__` | `typeof` | |
+| `__builtin_*` | EAL macros | Except in `lib/eal/` and `drivers/*/base/` |
+| `__reserved` | Different name | Reserved in Windows headers |
+| `#pragma` / `_Pragma` | Avoid | Except in `rte_common.h` |
+
+### Format Specifiers
+
+| Forbidden | Preferred |
+|-----------|-----------|
+| `%lld`, `%llu`, `%llx` | `%PRId64`, `%PRIu64`, `%PRIx64` |
+
+### Headers and Build
+
+| Forbidden | Preferred | Context |
+|-----------|-----------|---------|
+| `#include <linux/pci_regs.h>` | `#include <rte_pci.h>` | |
+| `install_headers()` | Meson `headers` variable | meson.build |
+| `-DALLOW_EXPERIMENTAL_API` | Not in lib/drivers/app | Build flags |
+| `allow_experimental_apis` | Not in lib/drivers/app | Meson |
+| `#undef XXX` | `// XXX is not set` | config/rte_config.h |
+| Driver headers (`*_driver.h`, `*_pmd.h`) | Public API headers | app/, examples/ |
+
+### Testing
+
+| Forbidden | Preferred |
+|-----------|-----------|
+| `REGISTER_TEST_COMMAND` | `REGISTER_<suite_name>_TEST` |
+
+### Documentation
+
+| Forbidden | Preferred |
+|-----------|-----------|
+| `http://...dpdk.org` | `https://...dpdk.org` |
+| `//doc.dpdk.org/guides/...` | `:ref:` or `:doc:` Sphinx references |
+| `::  file.svg` | `::  file.*` (wildcard extension) |
+
+---
+
+## API Tag Requirements
+
+### `__rte_experimental`
+
+- Must appear **alone on the line** immediately preceding the return type
+- Only allowed in **header files** (not `.c` files)
+
+```c
+/* Correct */
+__rte_experimental
+int
+rte_new_feature(void);
+
+/* Wrong - not alone on line */
+__rte_experimental int rte_new_feature(void);
+
+/* Wrong - in .c file */
+```
+
+### `__rte_internal`
+
+- Must appear **alone on the line** immediately preceding the return type
+- Only allowed in **header files** (not `.c` files)
+
+```c
+/* Correct */
+__rte_internal
+int
+internal_function(void);
+```
+
+### Alignment Attributes
+
+`__rte_aligned`, `__rte_cache_aligned`, `__rte_cache_min_aligned` may only be used with `struct` or `union` types:
+
+```c
+/* Correct */
+struct __rte_cache_aligned my_struct {
+        /* ... */
+};
+
+/* Wrong */
+int __rte_cache_aligned my_variable;
+```
+
+### Packed Attributes
+
+- `__rte_packed_begin` must follow `struct`, `union`, or alignment attributes
+- `__rte_packed_begin` and `__rte_packed_end` must be used in pairs
+- Cannot use `__rte_packed_begin` with `enum`
+
+```c
+/* Correct */
+struct __rte_packed_begin my_packed_struct {
+        /* ... */
+} __rte_packed_end;
+
+/* Wrong - with enum */
+enum __rte_packed_begin my_enum {
+        /* ... */
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
+- Only update the **current release** notes file
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
+### Commit Message
+
+- [ ] Subject line ≤60 characters
+- [ ] Subject is lowercase (except acronyms from words-case.txt)
+- [ ] Correct component prefix (e.g., `net/ixgbe:` not `ixgbe:`)
+- [ ] No `lib/` prefix for libraries
+- [ ] Imperative mood, no trailing period
+- [ ] No tabs, leading/trailing spaces, or punctuation marks
+- [ ] Body wrapped at 75 characters
+- [ ] Body does not start with "It"
+- [ ] `Signed-off-by:` present with real name and valid email
+- [ ] `Fixes:` tag present for bug fixes with 12-char SHA and exact subject
+- [ ] `Coverity issue:` tag present if Coverity mentioned
+- [ ] `Bugzilla ID:` tag present if Bugzilla mentioned
+- [ ] `Cc: stable@dpdk.org` for stable backport candidates
+- [ ] Tags in correct order with blank line separator
+
+### License
+
+- [ ] SPDX identifier on first line (or second for scripts)
+- [ ] Copyright line follows SPDX
+- [ ] Blank line after copyright before code
+- [ ] Appropriate license for file type
+
+### Code Style
+
+- [ ] Lines ≤100 characters
+- [ ] Hard tabs for indentation, spaces for alignment
+- [ ] No trailing whitespace
+- [ ] Proper include order
+- [ ] Header guards present
+- [ ] `rte_`/`RTE_` prefix on external symbols
+- [ ] No prohibited terminology
+- [ ] Proper brace style
+- [ ] Function return type on own line
+- [ ] Explicit comparisons: `== NULL`, `== 0`, `!= NULL`, `!= 0`
+- [ ] No forbidden tokens (see table above)
+
+### API Tags
+
+- [ ] `__rte_experimental` alone on line, only in headers
+- [ ] `__rte_internal` alone on line, only in headers
+- [ ] Alignment attributes only on struct/union
+- [ ] Packed attributes properly paired
+
+### Structure
+
+- [ ] Each commit compiles independently
+- [ ] Code and docs updated together
+- [ ] Tests added/updated as needed
+- [ ] Current release notes updated for significant changes
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
+- Must comply with formatting standards
+- Use **`black`** for code formatting validation
+- Line length acceptable up to 100 characters
+
+---
+
+## Validation Tools
+
+Run these before submitting:
+
+```bash
+# Check commit messages
+devtools/check-git-log.sh -n1
+
+# Check patch format and forbidden tokens
+devtools/checkpatches.sh -n1
+
+# Check maintainers coverage
+devtools/check-maintainers.sh
+
+# Build validation
+devtools/test-meson-builds.sh
+
+# Find maintainers for your patch
+devtools/get-maintainer.sh <patch-file>
+```
+
+---
+
+## Severity Levels for AI Review
+
+**Error** (must fix):
+- Missing or malformed SPDX license
+- Missing Signed-off-by
+- Subject line over 60 characters
+- Body lines over 75 characters
+- Wrong tag order or format
+- Missing required tags (Fixes, Coverity issue, Bugzilla ID)
+- Forbidden tokens in code
+- `__rte_experimental`/`__rte_internal` in .c files or not alone on line
+- Compilation failures
+- ABI breaks without proper versioning
+
+**Warning** (should fix):
+- Subject line style issues (case, punctuation)
+- Wrong component prefix
+- Missing Cc: stable@dpdk.org for fixes
+- Documentation gaps
+- Missing tests
+- Implicit comparisons (`!ptr` instead of `ptr == NULL`)
+
+**Info** (consider):
+- Minor style preferences
+- Optimization suggestions
+- Alternative approaches
-- 
2.51.0

