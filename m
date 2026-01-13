Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562C8D29DE8
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 08:06:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F0844028C;
	Tue, 13 Jan 2026 09:06:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 9D8CF40276
 for <dev@dpdk.org>; Tue, 13 Jan 2026 09:06:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768291597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaeKw++HRJMiCxAuyJIKsPV1Ya4ucP2FhbCCq//DtHg=;
 b=Gw9ta3CbLy8gFbNZNrGEiyuKvfjTDFLN5S3B+tyJ0lL2hWo6as5v3ieqwTGSHCiHDREZwI
 r2GOXkABal1FkxMrhdvg+KKqJ4BFL2EaUChlpP+UtS7++FQQ21B03IyHiDBqQcVhwi6ylw
 vc0K3o2eqZNm1uErr4sTVz8ntJx0msQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-Cc94lqxMNKupAMdXO9V-gA-1; Tue,
 13 Jan 2026 03:06:33 -0500
X-MC-Unique: Cc94lqxMNKupAMdXO9V-gA-1
X-Mimecast-MFC-AGG-ID: Cc94lqxMNKupAMdXO9V-gA_1768291592
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80A7A195605A; Tue, 13 Jan 2026 08:06:32 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.224.210])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B51A819560B2; Tue, 13 Jan 2026 08:06:30 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: andremue@linux.microsoft.com, thomas@monjalon.net,
 bruce.richardson@intel.com
Subject: [PATCH v2] buildtools: add symbol check to Windows
Date: Tue, 13 Jan 2026 09:06:24 +0100
Message-ID: <20260113080624.2230169-1-david.marchand@redhat.com>
In-Reply-To: <20250925130438.3072610-1-david.marchand@redhat.com>
References: <20250925130438.3072610-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LC6Eso4r5yX-vei-HYRoOkuLzxMdjGT9pyjoD-2Fovw_1768291592
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

The symbol check was implemented so far with shell scripts, relying
on objdump and other unix tools preventing it from being run on Windows.

There was also an ask from some maintainers to convert this type of
developer checks to python scripts, to make it easier to extend and
maintain.

The new implementation still performs the four consistency checks:
- symbols exported as experimental but missing __rte_experimental flag,
- symbols flagged as experimental but missing export declaration,
- symbols exported as internal but missing __rte_internal flag,
- symbols flagged as internal but missing export declaration,

The initial implementation was done relying on Claude Code
(asking it to reimplement the existing check after it analysed
the current build flow).

I then cleaned up the python script, removed dumb comments, fixed coding
style, fixed MAINTAINERS, fixed some dumb issues (like definition order in
buildtools/meson.build).

Actual implementation on Windows seems doable now but is left to
an interested party.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since v1:
- asked Claude to fix compatiblity with Python 3.6,
- removed unused field ArchiveMember.size,

---
 MAINTAINERS                   |   5 +-
 buildtools/check-symbols.py   | 324 ++++++++++++++++++++++++++++++++++
 buildtools/check-symbols.sh   |  73 --------
 buildtools/map-list-symbol.sh |  85 ---------
 buildtools/meson.build        |   2 +-
 drivers/meson.build           |   3 -
 lib/meson.build               |   3 -
 7 files changed, 327 insertions(+), 168 deletions(-)
 create mode 100755 buildtools/check-symbols.py
 delete mode 100755 buildtools/check-symbols.sh
 delete mode 100755 buildtools/map-list-symbol.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index d7d8dbdb25..da8df9f946 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -121,15 +121,14 @@ F: Makefile
 F: meson.build
 F: meson_options.txt
 F: config/
-F: buildtools/check-symbols.sh
-F: buildtools/chkincs/
 F: buildtools/call-sphinx-build.py
+F: buildtools/check-symbols.py
+F: buildtools/chkincs/
 F: buildtools/gen-version-map.py
 F: buildtools/get-cpu-count.py
 F: buildtools/get-min-meson-version.py
 F: buildtools/get-numa-count.py
 F: buildtools/list-dir-globs.py
-F: buildtools/map-list-symbol.sh
 F: buildtools/pkg-config/
 F: buildtools/symlink-drivers-solibs.sh
 F: buildtools/symlink-drivers-solibs.py
diff --git a/buildtools/check-symbols.py b/buildtools/check-symbols.py
new file mode 100755
index 0000000000..b595c4a2c0
--- /dev/null
+++ b/buildtools/check-symbols.py
@@ -0,0 +1,324 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+
+"""Check symbol consistency between exports and flags in DPDK."""
+
+import argparse
+import sys
+import re
+import struct
+import io
+from pathlib import Path
+from typing import Dict, Set, List, Optional, Iterator
+from elftools.elf.elffile import ELFFile
+from elftools.elf.sections import SymbolTableSection
+
+
+class ValidationError:
+    """Represents a symbol consistency validation error."""
+
+    def __init__(self, symbol: str, message: str):
+        self.symbol = symbol
+        self.message = message
+
+
+class ArchiveMember:
+    """Represents a member file within an archive."""
+
+    def __init__(self, name: str, data: bytes):
+        self.name = name
+        self.data = data
+
+
+class ArchiveParser:
+    """Pure Python parser for Unix archive (.a) files."""
+
+    MAGIC = b'!<arch>\n'
+    MEMBER_HEADER_SIZE = 60
+
+    def __init__(self, archive_path: Path):
+        self.archive_path = archive_path
+
+    def parse_members(self) -> Iterator[ArchiveMember]:
+        """Parse archive file and yield member files."""
+        try:
+            with open(self.archive_path, 'rb') as f:
+                magic = f.read(8)
+                if magic != self.MAGIC:
+                    raise ValueError(f"Invalid archive magic: {magic}")
+
+                while True:
+                    member = self._parse_member(f)
+                    if member is None:
+                        break
+                    yield member
+
+        except IOError as e:
+            print(f"Error reading archive {self.archive_path}: {e}", file=sys.stderr)
+
+    def _parse_member(self, f) -> Optional[ArchiveMember]:
+        """Parse a single member from the archive."""
+        header_data = f.read(self.MEMBER_HEADER_SIZE)
+        if len(header_data) < self.MEMBER_HEADER_SIZE:
+            return None
+
+        # Parse header fields
+        # Format: name(16) + date(12) + uid(6) + gid(6) + mode(8) + size(10) + end(2)
+        header = struct.unpack('16s12s6s6s8s10s2s', header_data)
+
+        name = header[0].decode('ascii', errors='ignore').rstrip('\x00 ')
+        size_str = header[5].decode('ascii', errors='ignore').rstrip('\x00 ')
+
+        try:
+            size = int(size_str)
+        except ValueError:
+            return None
+
+        if name.startswith('/') or name == '':
+            f.seek(size, 1)
+            if size % 2:
+                f.read(1)
+            return self._parse_member(f)
+
+        data = f.read(size)
+        if len(data) != size:
+            return None
+
+        if size % 2:
+            f.read(1)
+
+        return ArchiveMember(name=name, data=data)
+
+
+class VersionMapParser:
+    """Parse GNU linker version map files to extract symbol sections."""
+
+    def __init__(self, map_file: Path):
+        self.map_file = map_file
+        self.symbols_by_section: Dict[str, Set[str]] = {}
+        self._parse_map_file()
+
+    def _parse_map_file(self):
+        """Parse the version map file and extract symbols by section."""
+        try:
+            with open(self.map_file, 'r', encoding='utf-8') as f:
+                content = f.read()
+        except IOError as e:
+            print(f"Error reading map file {self.map_file}: {e}", file=sys.stderr)
+            sys.exit(1)
+
+        current_section = None
+        in_global_block = False
+
+        for line in content.splitlines():
+            line = line.strip()
+
+            section_match = re.match(r'^(\w+)\s*\{', line)
+            if section_match:
+                current_section = section_match.group(1)
+                self.symbols_by_section.setdefault(current_section, set())
+                in_global_block = False
+                continue
+
+            if line == "global:":
+                in_global_block = True
+                continue
+
+            if line == "};":
+                current_section = None
+                in_global_block = False
+                continue
+
+            if line.startswith("local:"):
+                in_global_block = False
+                continue
+
+            if current_section and in_global_block and line and not line.startswith("local:"):
+                symbol_line = line.split(';')[0].strip()
+                comment_split = symbol_line.split('#')
+                symbol = comment_split[0].strip()
+
+                if symbol and not symbol.startswith('}'):
+                    self.symbols_by_section[current_section].add(symbol)
+
+    def get_symbols_by_section(self, section: str) -> Set[str]:
+        """Get all symbols in a specific section."""
+        return self.symbols_by_section.get(section, set())
+
+    def symbol_in_section(self, symbol: str, section: str) -> bool:
+        """Check if a symbol exists in a specific section."""
+        return symbol in self.get_symbols_by_section(section)
+
+
+class ELFSymbolAnalyzer:
+    """Analyze archive files to extract symbol information from contained objects."""
+
+    def __init__(self, archive_file: Path):
+        self.archive_file = archive_file
+        self.text_symbols: Set[str] = set()
+        self.experimental_symbols: Set[str] = set()
+        self.internal_symbols: Set[str] = set()
+
+        self._analyze_archive_file()
+
+    def _analyze_archive_file(self):
+        """Extract and analyze all object files from archive using native parser."""
+        try:
+            archive_parser = ArchiveParser(self.archive_file)
+
+            for member in archive_parser.parse_members():
+                if member.name.endswith('.o'):
+                    self._analyze_archived_object(member)
+
+        except Exception as e:
+            print(f"Error processing archive {self.archive_file}: {e}", file=sys.stderr)
+            sys.exit(1)
+
+    def _analyze_archived_object(self, member: ArchiveMember):
+        """Analyze a single object file member from archive."""
+        try:
+            elf_data = io.BytesIO(member.data)
+            elffile = ELFFile(elf_data)
+            self._extract_symbols(elffile)
+
+        except Exception as e:
+            print(f"Warning: Error analyzing {member.name}: {e}", file=sys.stderr)
+
+
+    def _extract_symbols(self, elffile: ELFFile):
+        """Extract symbol information from the ELF file."""
+        section_names = {}
+        for i, section in enumerate(elffile.iter_sections()):
+            section_names[i] = section.name
+
+        for section in elffile.iter_sections():
+            if not isinstance(section, SymbolTableSection):
+                continue
+
+            for symbol in section.iter_symbols():
+                symbol_name = symbol.name
+
+                if not symbol_name or symbol['st_shndx'] == 'SHN_UNDEF':
+                    continue
+
+                section_index = symbol['st_shndx']
+                if isinstance(section_index, int) and section_index in section_names:
+                    section_name = section_names[section_index]
+
+                    if section_name.startswith('.text'):
+                        self.text_symbols.add(symbol_name)
+
+                        if section_name == '.text.experimental':
+                            self.experimental_symbols.add(symbol_name)
+                        elif section_name == '.text.internal':
+                            self.internal_symbols.add(symbol_name)
+
+    def symbol_in_text(self, symbol: str) -> bool:
+        """Check if symbol exists in any .text section."""
+        return symbol in self.text_symbols
+
+    def symbol_in_experimental_section(self, symbol: str) -> bool:
+        """Check if symbol exists in .text.experimental section."""
+        return symbol in self.experimental_symbols
+
+    def symbol_in_internal_section(self, symbol: str) -> bool:
+        """Check if symbol exists in .text.internal section."""
+        return symbol in self.internal_symbols
+
+
+class SymbolConsistencyChecker:
+    """Main checker that orchestrates all symbol consistency validations."""
+
+    def __init__(self, map_file: Path, archive_file: Path):
+        self.map_parser = VersionMapParser(map_file)
+        self.elf_analyzer = ELFSymbolAnalyzer(archive_file)
+        self.errors: List[ValidationError] = []
+
+    def check_experimental_consistency(self):
+        """Check consistency between experimental exports and flags."""
+
+        # Check 1: Symbols exported as experimental but not flagged with __rte_experimental
+        for symbol in self.map_parser.get_symbols_by_section("EXPERIMENTAL"):
+            if (self.elf_analyzer.symbol_in_text(symbol) and
+                not self.elf_analyzer.symbol_in_experimental_section(symbol)):
+                self.errors.append(ValidationError(
+                    symbol=symbol,
+                    message=f"{symbol} is not flagged as experimental but is exported as an experimental symbol\n"
+                           f"Please add __rte_experimental to the definition of {symbol}"
+                ))
+
+        # Check 2: Symbols flagged as experimental but not exported
+        for symbol in self.elf_analyzer.experimental_symbols:
+            if not self.map_parser.symbol_in_section(symbol, "EXPERIMENTAL"):
+                self.errors.append(ValidationError(
+                    symbol=symbol,
+                    message=f"{symbol} is flagged as experimental but is not exported as an experimental symbol\n"
+                           f"Please add RTE_EXPORT_EXPERIMENTAL_SYMBOL to the definition of {symbol}"
+                ))
+
+    def check_internal_consistency(self):
+        """Check consistency between internal exports and flags."""
+
+        # Check 3: Symbols exported as internal but not flagged with __rte_internal
+        for symbol in self.map_parser.get_symbols_by_section("INTERNAL"):
+            if (self.elf_analyzer.symbol_in_text(symbol) and
+                not self.elf_analyzer.symbol_in_internal_section(symbol)):
+                self.errors.append(ValidationError(
+                    symbol=symbol,
+                    message=f"{symbol} is not flagged as internal but is exported as an internal symbol\n"
+                           f"Please add __rte_internal to the definition of {symbol}"
+                ))
+
+        # Check 4: Symbols flagged as internal but not exported
+        for symbol in self.elf_analyzer.internal_symbols:
+            if not self.map_parser.symbol_in_section(symbol, "INTERNAL"):
+                self.errors.append(ValidationError(
+                    symbol=symbol,
+                    message=f"{symbol} is flagged as internal but is not exported as an internal symbol\n"
+                           f"Please add RTE_EXPORT_INTERNAL_SYMBOL to the definition of {symbol}"
+                ))
+
+    def run_all_checks(self) -> int:
+        """Run all consistency checks and return exit code."""
+        self.check_experimental_consistency()
+        self.check_internal_consistency()
+
+        for error in self.errors:
+            print(error.message, file=sys.stderr)
+
+        return 1 if self.errors else 0
+
+
+def main() -> int:
+    """Main entry point for the symbol consistency checker."""
+    parser = argparse.ArgumentParser(
+        description="Check symbol consistency between exports and flags in DPDK libraries.",
+        formatter_class=argparse.RawDescriptionHelpFormatter
+    )
+    parser.add_argument(
+        "map_file",
+        type=Path,
+        help="Version map file (e.g., lib_exports.map)"
+    )
+    parser.add_argument(
+        "archive_file",
+        type=Path,
+        help="Archive file to analyze (static library .a file)"
+    )
+
+    args = parser.parse_args()
+
+    if not args.map_file.exists():
+        print(f"Error: Map file {args.map_file} does not exist", file=sys.stderr)
+        return 1
+
+    if not args.archive_file.exists():
+        print(f"Error: Archive file {args.archive_file} does not exist", file=sys.stderr)
+        return 1
+
+    checker = SymbolConsistencyChecker(args.map_file, args.archive_file)
+    return checker.run_all_checks()
+
+
+if __name__ == "__main__":
+    sys.exit(main())
diff --git a/buildtools/check-symbols.sh b/buildtools/check-symbols.sh
deleted file mode 100755
index 0d6745ec14..0000000000
--- a/buildtools/check-symbols.sh
+++ /dev/null
@@ -1,73 +0,0 @@
-#!/bin/sh
-
-# SPDX-License-Identifier: BSD-3-Clause
-
-MAPFILE=$1
-OBJFILE=$2
-
-ROOTDIR=$(readlink -f $(dirname $(readlink -f $0))/..)
-LIST_SYMBOL=$ROOTDIR/buildtools/map-list-symbol.sh
-DUMPFILE=$(mktemp -t dpdk.${0##*/}.objdump.XXXXXX)
-trap 'rm -f "$DUMPFILE"' EXIT
-objdump -t $OBJFILE >$DUMPFILE
-
-ret=0
-
-for SYM in `$LIST_SYMBOL -S EXPERIMENTAL $MAPFILE |cut -d ' ' -f 3`
-do
-	if grep -q "\.text.*[[:space:]]$SYM$" $DUMPFILE &&
-		! grep -q "\.text\.experimental.*[[:space:]]$SYM$" $DUMPFILE &&
-		$LIST_SYMBOL -s $SYM $MAPFILE | grep -q EXPERIMENTAL
-	then
-		cat >&2 <<- END_OF_MESSAGE
-		$SYM is not flagged as experimental but is exported as an experimental symbol
-		Please add __rte_experimental to the definition of $SYM
-		END_OF_MESSAGE
-		ret=1
-	fi
-done
-
-for SYM in `awk '{
-	if ($2 != "l" && $4 == ".text.experimental") {
-		print $NF
-	}
-}' $DUMPFILE`
-do
-	$LIST_SYMBOL -S EXPERIMENTAL -s $SYM -q $MAPFILE || {
-		cat >&2 <<- END_OF_MESSAGE
-		$SYM is flagged as experimental but is not exported as an experimental symbol
-		Please add RTE_EXPORT_EXPERIMENTAL_SYMBOL to the definition of $SYM
-		END_OF_MESSAGE
-		ret=1
-	}
-done
-
-for SYM in `$LIST_SYMBOL -S INTERNAL $MAPFILE |cut -d ' ' -f 3`
-do
-	if grep -q "\.text.*[[:space:]]$SYM$" $DUMPFILE &&
-		! grep -q "\.text\.internal.*[[:space:]]$SYM$" $DUMPFILE
-	then
-		cat >&2 <<- END_OF_MESSAGE
-		$SYM is not flagged as internal but is exported as an internal symbol
-		Please add __rte_internal to the definition of $SYM
-		END_OF_MESSAGE
-		ret=1
-	fi
-done
-
-for SYM in `awk '{
-	if ($2 != "l" && $4 == ".text.internal") {
-		print $NF
-	}
-}' $DUMPFILE`
-do
-	$LIST_SYMBOL -S INTERNAL -s $SYM -q $MAPFILE || {
-		cat >&2 <<- END_OF_MESSAGE
-		$SYM is flagged as internal but is not exported as an internal symbol
-		Please add RTE_EXPORT_INTERNAL_SYMBOL to the definition of $SYM
-		END_OF_MESSAGE
-		ret=1
-	}
-done
-
-exit $ret
diff --git a/buildtools/map-list-symbol.sh b/buildtools/map-list-symbol.sh
deleted file mode 100755
index 962d5f3271..0000000000
--- a/buildtools/map-list-symbol.sh
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2018 David Marchand <david.marchand@redhat.com>
-
-section=all
-symbol=all
-quiet=
-version=
-
-while getopts 'S:s:qV:' name; do
-	case $name in
-	S)
-		[ $section = 'all' ] || {
-			echo 'Cannot list in multiple sections'
-			exit 1
-		}
-		section=$OPTARG
-	;;
-	s)
-		[ $symbol = 'all' ] || {
-			echo 'Cannot list multiple symbols'
-			exit 1
-		}
-		symbol=$OPTARG
-	;;
-	q)
-		quiet='y'
-	;;
-	V)
-		version=$OPTARG
-	;;
-	?)
-		echo 'usage: $0 [-S section] [-s symbol] [-V [version|unset]] [-q]'
-		exit 1
-	;;
-	esac
-done
-
-shift $(($OPTIND - 1))
-
-for file in $@; do
-	cat "$file" |awk '
-	BEGIN {
-		current_section = "";
-		if ("'$section'" == "all" && "'$symbol'" == "all" && "'$version'" == "") {
-			ret = 0;
-		} else {
-			ret = 1;
-		}
-	}
-	/^.*\{/ {
-		if ("'$section'" == "all" || $1 == "'$section'") {
-			current_section = $1;
-		}
-	}
-	/.*}/ { current_section = ""; }
-	/^[^}].*[^:*];/ {
-		if (current_section == "") {
-			next;
-		}
-		if (/^[^}].*[^:*]; # added in /) {
-			symbol_version = $5
-		}
-		if ("'$version'" != "") {
-			if ("'$version'" == "unset" && symbol_version != "") {
-				next;
-			} else if ("'$version'" != "unset" && "'$version'" != symbol_version) {
-				next;
-			}
-		}
-		gsub(";","");
-		if ("'$symbol'" == "all" || $1 == "'$symbol'") {
-			ret = 0;
-			if ("'$quiet'" == "") {
-				print "'$file' "current_section" "$1" "symbol_version;
-			}
-			if ("'$symbol'" != "all") {
-				exit 0;
-			}
-		}
-	}
-	END {
-		exit ret;
-	}'
-done
diff --git a/buildtools/meson.build b/buildtools/meson.build
index 32cea7cff7..629b7d0873 100644
--- a/buildtools/meson.build
+++ b/buildtools/meson.build
@@ -2,7 +2,6 @@
 # Copyright(c) 2017-2019 Intel Corporation
 
 pkgconf = find_program('pkg-config', 'pkgconf', required: false)
-check_symbols = find_program('check-symbols.sh')
 ldflags_ibverbs_static = find_program('options-ibverbs-static.sh')
 
 python3_required_modules = []
@@ -18,6 +17,7 @@ else
     py3 = ['meson', 'runpython']
 endif
 echo = py3 + ['-c', 'import sys; print(*sys.argv[1:])']
+check_symbols = py3 + files('check-symbols.py')
 gen_version_map = py3 + files('gen-version-map.py')
 list_dir_globs = py3 + files('list-dir-globs.py')
 sphinx_wrapper = py3 + files('call-sphinx-build.py')
diff --git a/drivers/meson.build b/drivers/meson.build
index 3fe3be48fb..5f6a665724 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -349,9 +349,6 @@ foreach subpath:subdirs
         endif
 
         if not is_windows and developer_mode
-            # on unix systems check the output of the
-            # check-symbols.sh script, using it as a
-            # dependency of the .so build
             lk_deps += custom_target(lib_name + '.sym_chk',
                     command: [check_symbols, version_map.full_path(), '@INPUT@'],
                     capture: true,
diff --git a/lib/meson.build b/lib/meson.build
index c8f4270868..f13e3310a0 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -303,9 +303,6 @@ foreach l:libraries
     endif
 
     if developer_mode and not is_windows
-        # on unix systems check the output of the
-        # check-symbols.sh script, using it as a
-        # dependency of the .so build
         lk_deps += custom_target(name + '.sym_chk',
                 command: [check_symbols, version_map.full_path(), '@INPUT@'],
                 capture: true,
-- 
2.52.0

