Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062EAC369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 22:32:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64EF940A6F;
	Wed, 16 Apr 2025 00:31:58 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0530E40263
 for <dev@dpdk.org>; Wed, 16 Apr 2025 00:31:55 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 2138F210C451; Tue, 15 Apr 2025 15:31:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2138F210C451
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744756315;
 bh=Z6q0yB2Sna9UfKEF7PDw+i7bR0axvCsba/atAlui1Zw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dJC78bv/hETClUWVVjX2XrqUIcPF4vPvOM2CS58TPmtwlqapHAPmRYxLY5jK3Z9El
 Fs2JJsK6YKrBCidb/wl8Zafzx2QiGBlBHrz32nFeQDjyJMoTm9jLl0h7XxHK8TD2pU
 E0lmwm6uICNacdfZpHRTGtfHxD1LsHGfDOJnw/AM=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 3/4] usertools: parse strings from PE images
Date: Tue, 15 Apr 2025 15:31:36 -0700
Message-Id: <1744756297-21038-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744756297-21038-1-git-send-email-andremue@linux.microsoft.com>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744756297-21038-1-git-send-email-andremue@linux.microsoft.com>
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

Script usertools\dpdk-pmdinfo.py was enhanced to also be able to parse
symbols from sections in PE images.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 usertools/dpdk-pmdinfo.py | 53 +++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/usertools/dpdk-pmdinfo.py b/usertools/dpdk-pmdinfo.py
index 9189a2fdbc..9251c69db9 100755
--- a/usertools/dpdk-pmdinfo.py
+++ b/usertools/dpdk-pmdinfo.py
@@ -37,8 +37,11 @@
 from pathlib import Path
 from typing import Iterable, Iterator, List, Union
 
-import elftools
-from elftools.elf.elffile import ELFError, ELFFile
+if os.name == "nt":
+    import pefile
+else:
+    import elftools
+    from elftools.elf.elffile import ELFError, ELFFile
 
 
 # ----------------------------------------------------------------------------
@@ -114,18 +117,23 @@ def parse_pmdinfo(paths: Iterable[Path], search_plugins: bool) -> List[dict]:
         A list of DPDK drivers info dictionaries.
     """
     binaries = set(paths)
-    for p in paths:
-        binaries.update(get_needed_libs(p))
-    if search_plugins:
-        # cast to list to avoid errors with update while iterating
-        binaries.update(list(get_plugin_libs(binaries)))
+
+    if os.name == "nt":
+        section_name = ".rdata"
+    else:
+        section_name = ".rodata"
+        for p in paths:
+            binaries.update(get_needed_libs(p))
+        if search_plugins:
+            # cast to list to avoid errors with update while iterating
+            binaries.update(list(get_plugin_libs(binaries)))
 
     drivers = []
 
     for b in binaries:
         logging.debug("analyzing %s", b)
         try:
-            for s in get_elf_strings(b, ".rodata", "PMD_INFO_STRING="):
+            for s in get_section_strings(b, section_name, "PMD_INFO_STRING="):
                 try:
                     info = json.loads(s)
                     scrub_pci_ids(info)
@@ -214,7 +222,7 @@ def find_strings(buf: bytes, prefix: str) -> Iterator[str]:
                 # end of string
                 s = view[start:i].tobytes().decode("ascii")
                 if s.startswith(prefix):
-                    yield s[len(prefix):]
+                    yield s[len(prefix) :]
             # There can be byte sequences where a non-printable byte
             # follows a printable one. Ignore that.
             start = None
@@ -233,7 +241,8 @@ def elftools_version():
     return (int(match[1]), int(match[2]))
 
 
-ELFTOOLS_VERSION = elftools_version()
+if os.name != "nt":
+    ELFTOOLS_VERSION = elftools_version()
 
 
 def from_elftools(s: Union[bytes, str]) -> str:
@@ -269,6 +278,30 @@ def get_elf_strings(path: Path, section: str, prefix: str) -> Iterator[str]:
         yield from find_strings(sec.data(), prefix)
 
 
+# ----------------------------------------------------------------------------
+def get_pe_strings(path: Path, section: str, prefix: str) -> Iterator[str]:
+    """
+    Extract strings from a named PE section in a file.
+    """
+    pe = pefile.PE(path)
+    for sec in pe.sections:
+        section_name = sec.Name.decode().strip("\x00")
+        if section_name != section:
+            continue
+        yield from find_strings(sec.get_data(), prefix)
+
+
+# ----------------------------------------------------------------------------
+def get_section_strings(path: Path, section: str, prefix: str) -> Iterator[str]:
+    """
+    Extract strings from a named section in an ELF or PE file.
+    """
+    if os.name == "nt":
+        yield from get_pe_strings(path, section, prefix)
+    else:
+        yield from get_elf_strings(path, section, prefix)
+
+
 # ----------------------------------------------------------------------------
 LDD_LIB_RE = re.compile(
     r"""
-- 
2.49.0.vfs.0.0

