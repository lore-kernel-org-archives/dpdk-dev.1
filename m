Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEFEC369A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 19:40:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7892740DCB;
	Fri, 11 Apr 2025 21:39:51 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6F8974025F
 for <dev@dpdk.org>; Fri, 11 Apr 2025 21:39:46 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 784632116590; Fri, 11 Apr 2025 12:39:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 784632116590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744400385;
 bh=o2j/FqRuo30KpkN/z4Sucz8grAoJ7kOpm1bXwv8OTao=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tBRvfs67BCY/bQ0yieudr6c9OtTyolBiFxETIMONc8ujQsyZd5hMjLCpF6SI4Yxig
 yfaWXnr9XYiSRIlo+vW5nfbnUslsexB8ziAfyK40zFDVcQ6k8vmw8rUO8aQqjTS9y+
 bfvEziWekwT2c3wyEucn+PVmEdKjz+cpE37gBiFQ=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 3/4] usertools: parse strings from PE images
Date: Fri, 11 Apr 2025 12:39:32 -0700
Message-Id: <1744400374-26620-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
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
 usertools/dpdk-pmdinfo.py | 47 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/usertools/dpdk-pmdinfo.py b/usertools/dpdk-pmdinfo.py
index 9189a2fdbc..77789c979c 100755
--- a/usertools/dpdk-pmdinfo.py
+++ b/usertools/dpdk-pmdinfo.py
@@ -40,6 +40,12 @@
 import elftools
 from elftools.elf.elffile import ELFError, ELFFile
 
+def is_windows():
+    return os.name == 'nt'
+
+if is_windows():
+    import pefile
+
 
 # ----------------------------------------------------------------------------
 def main() -> int:  # pylint: disable=missing-docstring
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

