Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971B4C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 20:32:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CD08402F1;
	Thu, 20 Feb 2025 21:32:13 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 946FE402D8
 for <dev@dpdk.org>; Thu, 20 Feb 2025 21:32:04 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id C64E72043DFE; Thu, 20 Feb 2025 12:32:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C64E72043DFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740083523;
 bh=IZPfXX8K+cPGuAK3UECXLsV0ejktNBP9jWcUj4aJmWg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OH89vE6GsgOv/D5Kvipw3prveT68T0dSdgm0TDC4epYph3oSbLxlRMcz7mxKaYnqS
 ubZUZG/NpmwaW1IRnJKCIU12ZAncgKtccsJCUb2+KGWrUTYPEJH1O68p1fnxgGh1sG
 74jbl4URXH+EQIvw/LnInwmdI2Refav4MTKhNLXE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 4/6] devtools: check ms linker map files
Date: Thu, 20 Feb 2025 12:31:46 -0800
Message-Id: <1740083508-6703-5-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740083508-6703-1-git-send-email-andremue@linux.microsoft.com>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1740083508-6703-1-git-send-email-andremue@linux.microsoft.com>
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

MSVC allows alias function names to be exported, but the mechanism is
different than the one used by gcc. It was considered to enhance the logic
in the existing version.map files but that file is also passed to other
tools on Linux, making this challenging. A simpler approach is to have an
optional version.map file to be used only when Microsoft's linker is to be
used. This optional map file is only necessary for libraries that have
versioned code.

Script check-symbol-maps.sh was updated to check these optional files.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 devtools/check-symbol-maps.sh | 49 +++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/devtools/check-symbol-maps.sh b/devtools/check-symbol-maps.sh
index 6121f78ec6..816d52eae0 100755
--- a/devtools/check-symbol-maps.sh
+++ b/devtools/check-symbol-maps.sh
@@ -21,6 +21,21 @@ find_orphan_symbols ()
                 symsrc=${sym#per_lcore_}
             elif echo $sym | grep -q '^__rte_.*_trace_' ; then
                 symsrc=${sym#__}
+            elif echo $map | grep -Eq '_ms_linker.map$' ; then
+                if echo $sym | grep -q '=' ; then
+                    symsrc=$(echo $sym | awk '
+                        {
+                            idx = index($0, "=")
+                            if (idx > 0) {
+                                # Use only what is on the left side of "="
+                                s = substr($0, 0, idx-1)
+                                print s
+                            } else {
+                                print $0
+                            }
+                        }
+                    ')
+                fi
             else
                 symsrc=$sym
             fi
@@ -79,14 +94,32 @@ find_bad_format_maps ()
     abi_version=$(cut -d'.' -f 1 ABI_VERSION)
     next_abi_version=$((abi_version + 1))
     for map in $@ ; do
-        cat $map | awk '
-            /^(DPDK_('$abi_version'|'$next_abi_version')|EXPERIMENTAL|INTERNAL) \{$/ { next; } # start of a section
-            /^}( DPDK_'$abi_version')?;$/ { next; } # end of a section
-            /^$/ { next; } # empty line
-            /^\t(global:|local: \*;)$/ { next; } # qualifiers
-            /^\t[a-zA-Z_0-9]*;( # WINDOWS_NO_EXPORT)?$/ { next; } # symbols
-            /^\t# added in [0-9]*\.[0-9]*$/ { next; } # version comments
-            { print $0; }' || echo $map
+        if echo $map | grep -Eq '_ms_linker.map$';
+        then
+            # ms linker maps are only used for Windows, so there's no reason for
+            # them to allow WINDOWS_NO_EXPORT.
+            # These .map files accept alias function names, like
+            # rte_net_crc_set_alg=rte_net_crc_set_alg_v26;
+            # Note that alias function names are not allowed in normal .map files.
+            cat $map | awk '
+                /^(DPDK_('$abi_version'|'$next_abi_version')|EXPERIMENTAL|INTERNAL) \{$/ { next; } # start of a section
+                /^}( DPDK_'$abi_version')?;$/ { next; } # end of a section
+                /^$/ { next; } # empty line
+                /^\t(global:|local: \*;)$/ { next; } # qualifiers
+                /^\t[a-zA-Z_0-9]*;$/ { next; } # symbols
+                /^\t[a-zA-Z_0-9]*=[a-zA-Z_0-9]*;$/ { next; } # symbols with aliases
+                /^\t# added in [0-9]*\.[0-9]*$/ { next; } # version comments
+                { print $0; }' || echo $map
+        else
+            cat $map | awk '
+                /^(DPDK_('$abi_version'|'$next_abi_version')|EXPERIMENTAL|INTERNAL) \{$/ { next; } # start of a section
+                /^}( DPDK_'$abi_version')?;$/ { next; } # end of a section
+                /^$/ { next; } # empty line
+                /^\t(global:|local: \*;)$/ { next; } # qualifiers
+                /^\t[a-zA-Z_0-9]*;( # WINDOWS_NO_EXPORT)?$/ { next; } # symbols
+                /^\t# added in [0-9]*\.[0-9]*$/ { next; } # version comments
+                { print $0; }' || echo $map
+        fi
     done
 }
 
-- 
2.48.1.vfs.0.0

