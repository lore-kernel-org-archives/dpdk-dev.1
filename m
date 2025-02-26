Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1C7C021B2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 01:07:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77EF04029F;
	Wed, 26 Feb 2025 02:07:06 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E73DC4027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 02:07:04 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 2BE6420460A9; Tue, 25 Feb 2025 17:07:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BE6420460A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740532024;
 bh=mY2mu0VgwEaPhlQXf0UvYvDqzKiTcPZCicicLnUayyY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pdwfxZr/6XU06Ss5a8PRO9wTaMEfwtDsRwi7fBPLW+nwijUsYLZwVb3H/gGTdWH1s
 uI6s8OzLZthE2m2LwthP7g1hw2LJsmKfxqrX9ehwZ9NV3i2kEow9bwo7bHaNzB0z9t
 ZGtR/o6zsvj+fdV5ReiV4voOaLOHZs+CgAddCfWM=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v2 1/5] eal: make compatible with instruction set updates for
 MSVC
Date: Tue, 25 Feb 2025 17:06:52 -0800
Message-Id: <1740532016-6789-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740532016-6789-1-git-send-email-andremue@linux.microsoft.com>
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

After the instruction set updates for MSVC the error below popped up:

../lib/eal/common/rte_random.c(6): fatal error C1083:
    Cannot open include file: 'x86intrin.h': No such file or directory

The fix is to not include header x86intrin.h with MSVC.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/eal/common/rte_random.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index 8e62578176..9354358818 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -3,8 +3,10 @@
  */
 
 #ifdef __RDSEED__
+#ifndef RTE_TOOLCHAIN_MSVC
 #include <x86intrin.h>
 #endif
+#endif
 #include <unistd.h>
 
 #include <rte_bitops.h>
-- 
2.48.1.vfs.0.0

