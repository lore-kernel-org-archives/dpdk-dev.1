Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35621C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 19:39:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA8F84026A;
	Fri, 11 Apr 2025 21:39:47 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 048B14025F
 for <dev@dpdk.org>; Fri, 11 Apr 2025 21:39:45 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 272922114DBB; Fri, 11 Apr 2025 12:39:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 272922114DBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744400385;
 bh=B9fzec7y7MI19t+u/qTGyy0BREUup+37BPS+QttFVig=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C1d5kzbyf54udyqKm3dFg095DodoKmwfcPZBLhS3eCXuQ5KS6A49avK1obLuvFGaG
 Yx/j9pRfkwR+KsHvAnpJjnVNSMTIzcdDpy5jJQoQTHqSSCtwUb04csC5IaillCRxSv
 1zs4rwZ8uIjasB9GlJRsDU0bOt615tnl83hAu+h0=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Tyler Retzlaff <roretzla@linux.microsoft.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 1/4] eal: add macro to embed information in binaries
Date: Fri, 11 Apr 2025 12:39:30 -0700
Message-Id: <1744400374-26620-2-git-send-email-andremue@linux.microsoft.com>
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

DPDK uses GCC attribute "used" through macro __rte_used to indicate
that a variable not referenced in the code should be assumed being
used and therefore not be optimized away. This technique is used to embed
information in the binaries, by having crafted information stored in
them.

MSVC offers similar functionality, but it differs significantly: MSVC
requires a pragma to be used to send a command to the linker telling it
explicitly the name of the symbol that should be included (even if not
referenced). As a side-effect, variables called out to be included cannot
be static, otherwise their symbols are not "seen" by the linker. This
restriction requires some DPDK code to be refactored.

To assimilate these requirements/restrictions, macro RTE_INCLUDE is
introduced in this patch.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/eal/common/eal_common_options.c | 2 +-
 lib/eal/include/rte_common.h        | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index b6fff7ec05..8d115a5bd7 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -135,7 +135,7 @@ static const char *default_solib_dir = RTE_EAL_PMD_PATH;
  * Note: PLEASE DO NOT ALTER THIS without making a corresponding
  * change to usertools/dpdk-pmdinfo.py
  */
-static const char dpdk_solib_path[] __rte_used =
+RTE_INCLUDE(const char, dpdk_solib_path)[] =
 "DPDK_PLUGIN_PATH=" RTE_EAL_PMD_PATH;
 
 TAILQ_HEAD(device_option_list, device_option);
diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index a6085dce27..4c5a3b668f 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -231,6 +231,12 @@ typedef uint16_t unaligned_uint16_t;
 /**
  * Force symbol to be generated even if it appears to be unused.
  */
+#ifdef RTE_TOOLCHAIN_MSVC
+#define RTE_INCLUDE(type, name) __pragma(comment(linker, "/include:" RTE_STR(name))) type name
+#else
+#define RTE_INCLUDE(type, name) __attribute__((used)) type name
+#endif
+
 #ifdef RTE_TOOLCHAIN_MSVC
 #define __rte_used
 #else
-- 
2.49.0.vfs.0.0

