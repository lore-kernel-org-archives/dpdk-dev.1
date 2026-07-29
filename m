Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4285AC53200
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 23:44:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50A7D40272;
	Thu, 30 Jul 2026 01:44:31 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 673B540144
 for <dev@dpdk.org>; Thu, 30 Jul 2026 01:44:30 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-ca7bea5e5b3so1152648a12.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 16:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785368669;
 x=1785973469; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MNCoV+9wDn7R4iWeFsTD4z61yPKsCahWtPWT87Yybxg=;
 b=ekPc/kj4p1R0k0waHSjbyV/e+AOoCBvbx7dkkHGHLPbaJqfaSDbZ4BejJ+SIS7QWvQ
 hSkFjcvvwbJV94+ZVN4Iaf4P51WfiRP+h2Uop1ne2Z06Cq5fDBXRtgtUWxonvsMvSMJ1
 WvcTYqfm51rflyR/QPWTRePK439OdPB0KVa9ZgxPjfqvgrLCcLdAxKtLgvpund6zPv5h
 MkF7iEvGgpK93HaR5srw/+BjEpd9DDquY1JtDMt2nISvPtBvWm8M1qzIt0pWGt2qoA5C
 JqvLTXijzPGVAl2RJQnDOf4pgCGM8shzNB/T0IjrQpeJXEet+njYpjsERqBoK4Lozoft
 GHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785368669; x=1785973469;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MNCoV+9wDn7R4iWeFsTD4z61yPKsCahWtPWT87Yybxg=;
 b=g6/EI8RjuIsaK+iRC1xaPRoHldJj0NDrv3j9vxNu4yRPBeB5rNBbVIeqfT2mfR8fRx
 gm4rn+khqW/WTsr6nChPfaU5R7i+88ZA0gFtHK+p99DpU+ALwN+SYxZvdsRVRxk9n6ls
 88pdy8nb1vGa6a2RXfiFiyPxHIVWZ+JngN+m6OR2WkAXguts1BhDHSUqKsxsjgjATS2r
 KIxSwokq5AWROf8YZVABBsNwoNIr4ZnsyOvmTSU7HsJEm3DhcuqqanyBKdwdIwL8GxsS
 F4xvHzu8ic6N/wbiyie3eBe+F7KjhqndEP4PNrZvFzCTPVAfCubyXIsZb3+jebOwFK0q
 DiJg==
X-Gm-Message-State: AOJu0Yx8JzRSoPfIyb0HLx746d+0BSM+BO8hgauPZ4P6gjaWe8xelAJG
 Bw/LHQXrClLl5XYHn0/JQ8LaexYbJHAnRVUk/PiTT+6614xIFy22PyPzazsnippgaY3BLmvlQIm
 AqXc3
X-Gm-Gg: AR+sD11fMoa1eHLs86+/lr/0K92MJvjldTe56wBScNF1LhKxURPzHPT/VOOxnexIlKf
 pYioYnozp8IG+nlwFk8PQMGHOY0kx7W3s/IG8m2XjKR6GcIXqk/75EpLy3asZEpMcBDhnS2E9g6
 9KRUcbELka/2lI32DGNWV4NkyZzjZSvpgayMOOj0aW5Gp6Nn0loe0Ud8Di/XQc75Zau2mnNGpsH
 wMNuwguBZhQGpy6Qi4KwUmrhkGLRAQdnBi6n8gLz0W3PLSlhKktI/wojB4bxcPDw401w0uNvcTY
 YoXKm7hgzsusm5fQUfQS0VdvZok1JokiWZW239nsJMqQn56Ot4Owr25p//Tym4Hx8teus8oi+NZ
 96HDfXtPD8V3qhGnyBYFkUHuVbZaZlV02JKL22P/wm2RILsVqUV1+Volk3VzkcYOqnhG9j87W9X
 ObbhlcxWgDdf3Yps6NRcBsH3uBMFanWqeNwqGXn52+d/ZAUx4BC1ARXGDZX48yzrEHIW0eg18nJ
 aiuxgm7nusY8DRT1WipcKpX2cb3qnbdSKlPpg==
X-Received: by 2002:a05:6300:6715:b0:3bf:983d:e9b4 with SMTP id
 adf61e73a8af0-3c900519cddmr187972637.33.1785368669308; 
 Wed, 29 Jul 2026 16:44:29 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e72643a12sm20990463c88.5.2026.07.29.16.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 16:44:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] devtools: add script to find orphan documentation files
Date: Wed, 29 Jul 2026 16:44:26 -0700
Message-ID: <20260729234426.329795-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

Removing an example or a library leaves its images behind, since the
figure directive that referenced them goes away with the guide text in
the same commit. These files then sit in the tree unnoticed until
somebody audits the doc directory by hand.

Add a script that builds a reference graph from the Sphinx directives,
roles and toctrees, then reports every text and image file with no path
from a documentation root. Sphinx source directories are found by
looking for a meson.build that runs sphinx-build, so both the guides
and the DTS API docs are covered without a hardcoded list.

Returns non-zero when any leftovers are found, so it could
be run from CI.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 devtools/check-doc-orphans.py | 212 ++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100755 devtools/check-doc-orphans.py

diff --git a/devtools/check-doc-orphans.py b/devtools/check-doc-orphans.py
new file mode 100755
index 0000000000..cfa78994e6
--- /dev/null
+++ b/devtools/check-doc-orphans.py
@@ -0,0 +1,212 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+"""
+Report orphaned documentation source and image files.
+
+Removing an example or a library leaves its images behind. Walk the doc
+tree, build a reference graph from the Sphinx directives, roles and
+toctrees, then list every text and image file that no longer has a path
+from a documentation root.
+"""
+
+import argparse
+import os
+import re
+import sys
+from pathlib import Path
+
+# Files reported when unreachable.
+TEXT_SUFFIXES = {".rst"}
+IMAGE_SUFFIXES = {".svg", ".png", ".jpg", ".jpeg", ".gif", ".dot"}
+CANDIDATE_SUFFIXES = TEXT_SUFFIXES | IMAGE_SUFFIXES
+
+# Files scanned for references but never reported. Build glue and
+# configuration are always graph roots; .txt and .ini are generated or
+# picked up by wildcard (nics/features/*.ini), so the absence of a
+# reference to them means nothing.
+ROOT_SUFFIXES = {".py", ".build", ".md", ".in", ".css", ".txt", ".ini"}
+
+# Kept on purpose although the documentation build has no use for them.
+# The horizontal logo is used outside the repository. Paths are relative
+# to the documentation directory.
+IGNORE = {"logo/DPDK_logo_horizontal_tag.png"}
+
+# Directives whose argument is a file name.
+DIRECTIVE_RE = re.compile(
+    r"^\s*\.\.\s+"
+    r"(?:figure|image|include|literalinclude|graphviz)"
+    r"::\s*(\S.*?)\s*$"
+)
+# Directive option naming a file, such as the :file: of csv-table.
+OPTION_RE = re.compile(r"^\s*:file:\s*(\S+)\s*$")
+# Cross reference to another document or to a downloadable file.
+ROLE_RE = re.compile(r":(?:doc|download):`([^`]*)`")
+TOCTREE_RE = re.compile(r"^(\s*)\.\.\s+toctree::\s*$")
+# Bare path in a non-rst file, such as html_logo in conf.py.
+PATH_RE = re.compile(
+    r"[\w./-]+\.(?:" + "|".join(s[1:] for s in sorted(CANDIDATE_SUFFIXES)) + r")\b"
+)
+
+
+def toctree_entries(lines):
+    """Yield the document names listed in every toctree block."""
+    i = 0
+    while i < len(lines):
+        match = TOCTREE_RE.match(lines[i])
+        i += 1
+        if not match:
+            continue
+        outer = len(match.group(1))
+        while i < len(lines):
+            line = lines[i]
+            if line.strip() and len(line) - len(line.lstrip()) <= outer:
+                break
+            entry = line.strip()
+            if entry and not entry.startswith(":"):
+                yield entry
+            i += 1
+
+
+def targets(path):
+    """Yield the raw reference targets found in one file."""
+    if path.suffix in IMAGE_SUFFIXES:
+        return  # image metadata names unrelated files
+    try:
+        text = path.read_text(encoding="utf-8", errors="replace")
+    except OSError as err:
+        sys.exit(f"{path}: {err.strerror}")
+    if path.suffix not in TEXT_SUFFIXES:
+        yield from PATH_RE.findall(text)
+        return
+    lines = text.splitlines()
+    for line in lines:
+        match = DIRECTIVE_RE.match(line) or OPTION_RE.match(line)
+        if match:
+            yield match.group(1)
+    for match in ROLE_RE.finditer(text):
+        yield match.group(1)
+    for entry in toctree_entries(lines):
+        # A toctree entry has no suffix, and :glob: allows patterns.
+        yield entry if "*" in entry else entry + ".rst"
+
+
+def resolve(target, path, srcdir):
+    """Yield the files one target can refer to."""
+    # Roles use "title <target>", docutils includes use <standard.txt>.
+    if target.endswith(">"):
+        target = target[target.rfind("<") + 1 : -1]
+    if not target or target.startswith(("http:", "https:", "mailto:")):
+        return
+    # A leading / is relative to the Sphinx source directory.
+    base = srcdir if target.startswith("/") else path.parent
+    target = target.lstrip("/")
+    if "*" in target:
+        yield from (found.resolve() for found in base.glob(target))
+    else:
+        yield (base / target).resolve()
+
+
+def collect(docdir):
+    """Return the candidate files, the graph roots and the source dirs."""
+    candidates, roots, srcdirs = set(), set(), set()
+    for dirpath, dirnames, filenames in os.walk(docdir):
+        dirnames[:] = [d for d in dirnames if not d.startswith(".")]
+        here = Path(dirpath).resolve()
+        for name in filenames:
+            path = here / name
+            if path.suffix in CANDIDATE_SUFFIXES:
+                candidates.add(path)
+            elif path.suffix in ROOT_SUFFIXES:
+                roots.add(path)
+        # A directory built by sphinx-build is a documentation root.
+        # Sphinx starts from index.rst there whether meson names it or not.
+        build = here / "meson.build"
+        if not build.is_file():
+            continue
+        if "sphinx" in build.read_text(encoding="utf-8", errors="replace"):
+            srcdirs.add(here)
+            if (here / "index.rst").is_file():
+                roots.add(here / "index.rst")
+    return candidates, roots, srcdirs
+
+
+def walk_graph(candidates, roots, srcdirs, docdir):
+    """Return the reachable files, and the targets that do not exist."""
+    missing = {}
+    seen = set()
+    queue = list(roots)
+    while queue:
+        path = queue.pop()
+        if path in seen:
+            continue
+        seen.add(path)
+        srcdir = next((p for p in path.parents if p in srcdirs), docdir)
+        for target in targets(path):
+            for hit in resolve(target, path, srcdir):
+                if hit in candidates or hit in roots:
+                    queue.append(hit)
+                elif hit.suffix in CANDIDATE_SUFFIXES and not hit.is_file():
+                    missing.setdefault(hit, path)
+    return seen, missing
+
+
+def main():
+    """Scan the doc tree and report what nothing refers to."""
+    parser = argparse.ArgumentParser(description=__doc__)
+    parser.add_argument(
+        "docdir", nargs="?", type=Path, help="documentation directory (default: ../doc)"
+    )
+    parser.add_argument(
+        "-a",
+        "--all",
+        action="store_true",
+        help="include the files that are ignored on purpose",
+    )
+    parser.add_argument(
+        "-m",
+        "--missing",
+        action="store_true",
+        help="also report references to files not present",
+    )
+    parser.add_argument(
+        "-v",
+        "--verbose",
+        action="store_true",
+        help="report the number of files examined",
+    )
+    args = parser.parse_args()
+
+    docdir = args.docdir or Path(__file__).resolve().parent.parent / "doc"
+    if not docdir.is_dir():
+        sys.exit(f"{docdir}: not a directory")
+    docdir = docdir.resolve()
+    top = docdir.parent
+
+    candidates, roots, srcdirs = collect(docdir)
+    if not srcdirs:
+        sys.exit(f"{docdir}: no sphinx source directory found")
+
+    seen, missing = walk_graph(candidates, roots, srcdirs, docdir)
+    if not args.all:
+        seen |= {docdir / name for name in IGNORE}
+    unused = sorted(candidates - seen)
+
+    for path in unused:
+        print(f"orphan {path.relative_to(top)}")
+    if args.missing:
+        for path, referrer in sorted(missing.items()):
+            print(
+                f"missing {path.relative_to(top)} "
+                f"(referenced by {referrer.relative_to(top)})"
+            )
+    if args.verbose:
+        print(
+            f"{len(candidates)} files examined, {len(unused)} orphaned", file=sys.stderr
+        )
+    return 1 if unused or (args.missing and missing) else 0
+
+
+if __name__ == "__main__":
+    sys.exit(main())
-- 
2.53.0

