Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3995C021AA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 01:40:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9112140B8F;
	Wed, 19 Feb 2025 02:40:14 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6D3AA40A72
 for <dev@dpdk.org>; Wed, 19 Feb 2025 02:40:08 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 7852820376F2; Tue, 18 Feb 2025 17:40:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7852820376F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739929207;
 bh=WIB1zKAOcAUJR6VwipN7vUUSZf0oVNUn2AdoDvNhh7g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bgEijBriZwIuFzTY+l185ujtssDJeNxuZFXHmCMIcg32wPS77wj+AHsrsgqoSMS7z
 /w7q8ywOF8XuLsgdJZ225DVSgl659cm3V9OgNzNuVPAGrR7xM1pudRMTV/mCiiTcUu
 wFWgbxFXXz3GAQpYkUIjUtqUWaRPvJgzW6g8A7bM=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 3/5] eal: update versioning macros
Date: Tue, 18 Feb 2025 17:39:56 -0800
Message-Id: <1739929198-28432-4-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739929198-28432-1-git-send-email-andremue@linux.microsoft.com>
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1739929198-28432-1-git-send-email-andremue@linux.microsoft.com>
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

When compiling with MSVC the error below shows up due to function
versioning:

../lib/net/rte_net_crc.c(418): error C2061: syntax error:
    identifier '__attribute__'

MSVC allows alias function names to be exported, but the mechanism is
different than the one used by gcc. It was considered to enhance the logic
in the existing version.map files but that file is also passed to other
tools on Linux, making this challenging. A simpler approach is to have an
optional version.map file to be used only when Microsoft's linker is to be
used. This optional map file is only necessary for libraries that have
versioned code.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/eal/include/rte_function_versioning.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/eal/include/rte_function_versioning.h b/lib/eal/include/rte_function_versioning.h
index eb6dd2bc17..aa3165a659 100644
--- a/lib/eal/include/rte_function_versioning.h
+++ b/lib/eal/include/rte_function_versioning.h
@@ -82,6 +82,13 @@
  */
 #define MAP_STATIC_SYMBOL(f, p)
 
+/*
+ * MAP_STATIC_BASE_SYMBOL
+ * Has the same purpose as MAP_STATIC_SYMBOL, but takes a base function name
+ * instead of the whole function prototype. It is used to support MSVC.
+ */
+#define MAP_STATIC_BASE_SYMBOL(b, p)
+
 #else
 /*
  * No symbol versioning in use
@@ -90,7 +97,19 @@
 #define VERSION_SYMBOL_EXPERIMENTAL(b, e)
 #define __vsym
 #define BIND_DEFAULT_SYMBOL(b, e, n)
+
+#ifdef RTE_TOOLCHAIN_MSVC
+#define MAP_STATIC_SYMBOL(f, p)
+#define MAP_STATIC_BASE_SYMBOL(b, p) __pragma(comment(linker, "/alternatename:" #b "=" #p))
+/*
+ * version.map file should also be updated with "b=p;", like
+ *     rte_net_crc_set_alg=rte_net_crc_set_alg_v26;
+ */
+#else
 #define MAP_STATIC_SYMBOL(f, p) f __attribute__((alias(RTE_STR(p))))
+#define MAP_STATIC_BASE_SYMBOL(b, p)
+#endif
+
 /*
  * RTE_BUILD_SHARED_LIB=n
  */
-- 
2.48.1.vfs.0.0

