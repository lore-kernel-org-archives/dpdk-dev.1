Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8FCC5B543
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 10:10:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1444142EA1;
	Tue, 10 Jun 2025 12:10:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id C601042EA6
 for <dev@dpdk.org>; Tue, 10 Jun 2025 12:10:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749550220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+yf5cA4VGh1JfvQudFwpaFdcsbXzEsrGuoDwYvHIgK4=;
 b=KHKFge6OjFga8CMa8sOtOvj/EpWkBP7kbvxTtL4XqtqyunzxYaCnrWyJLRh/tlEkA5BJiz
 yopGn0vu+aTTQpSn44wzG3FiPhn6L/dzqtd1ms2g0TBIdV/l6bcBeIW9RrZmH+DTj2c3n6
 Z9mpIgKNTOpF4C0QK5CVbm5AO2dGRxk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-bYSBwotENIO9dtKx9OM4sw-1; Tue,
 10 Jun 2025 06:10:17 -0400
X-MC-Unique: bYSBwotENIO9dtKx9OM4sw-1
X-Mimecast-MFC-AGG-ID: bYSBwotENIO9dtKx9OM4sw_1749550216
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49694195608B; Tue, 10 Jun 2025 10:10:16 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.8])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B10B719560A3; Tue, 10 Jun 2025 10:10:14 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Robin Jarry <rjarry@redhat.com>
Subject: [PATCH v6 4/4] usertools: enable pmdinfo with MSVC
Date: Tue, 10 Jun 2025 12:09:47 +0200
Message-ID: <20250610100947.421877-5-david.marchand@redhat.com>
In-Reply-To: <20250610100947.421877-1-david.marchand@redhat.com>
References: <20250610100947.421877-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qlC4WLQMUJioezXxSW_85uGV51At-_j8wnLPU2uVpDs_1749550216
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

From: Andre Muezerie <andremue@linux.microsoft.com>

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
2.49.0

