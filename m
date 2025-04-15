Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ED5C369B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 01:22:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF7C640430;
	Tue, 15 Apr 2025 03:21:55 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 3027B402D1
 for <dev@dpdk.org>; Tue, 15 Apr 2025 03:21:50 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 47EFA210C431; Mon, 14 Apr 2025 18:21:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47EFA210C431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744680109;
 bh=bec5lRXhEEcXJv+5hpMvXafitbIPd6cqtWYV2uByLeA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sauSgA9ehFhzreYSfoyNWZl8gDQ6b+DI6uPlIaGMjL/XN0mDAICODVVmJpytqcTNJ
 OoLF5lOLR51SOd8m3+9CZonRjAKrO1GiTbdHXrImhFgL82AHRiXVTLdl8Yrl0EHzh6
 XYq80P47+B8yA2GU7imR2amG/9m0KGFMc34eDcgY=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 3/4] usertools: parse strings from PE images
Date: Mon, 14 Apr 2025 18:21:35 -0700
Message-Id: <1744680096-17683-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744680096-17683-1-git-send-email-andremue@linux.microsoft.com>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744680096-17683-1-git-send-email-andremue@linux.microsoft.com>
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
 usertools/dpdk-pmdinfo.py | 55 ++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/usertools/dpdk-pmdinfo.py b/usertools/dpdk-pmdinfo.py
index 9189a2fdbc..9e1ae5b534 100755
--- a/usertools/dpdk-pmdinfo.py
+++ b/usertools/dpdk-pmdinfo.py
@@ -37,8 +37,14 @@
 from pathlib import Path
 from typing import Iterable, Iterator, List, Union
 
-import elftools
-from elftools.elf.elffile import ELFError, ELFFile
+def is_windows():
+    return os.name == 'nt'
+
+if is_windows():
+    import pefile
+else:
+    import elftools
+    from elftools.elf.elffile import ELFError, ELFFile
 
 
 # ----------------------------------------------------------------------------
@@ -114,18 +120,23 @@ def parse_pmdinfo(paths: Iterable[Path], search_plugins: bool) -> List[dict]:
         A list of DPDK drivers info dictionaries.
     """
     binaries = set(paths)
-    for p in paths:
-        binaries.update(get_needed_libs(p))
-    if search_plugins:
-        # cast to list to avoid errors with update while iterating
-        binaries.update(list(get_plugin_libs(binaries)))
+
+    if is_windows():
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
@@ -232,8 +243,8 @@ def elftools_version():
         return (0, 24)
     return (int(match[1]), int(match[2]))
 
-
-ELFTOOLS_VERSION = elftools_version()
+if not is_windows():
+    ELFTOOLS_VERSION = elftools_version()
 
 
 def from_elftools(s: Union[bytes, str]) -> str:
@@ -269,6 +280,30 @@ def get_elf_strings(path: Path, section: str, prefix: str) -> Iterator[str]:
         yield from find_strings(sec.data(), prefix)
 
 
+# ----------------------------------------------------------------------------
+def get_pe_strings(path: Path, section: str, prefix: str) -> Iterator[str]:
+    """
+    Extract strings from a named PE section in a file.
+    """
+    pe = pefile.PE(path)
+    for sec in pe.sections:
+        section_name = sec.Name.decode().strip('\x00')
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
+    if is_windows():
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

