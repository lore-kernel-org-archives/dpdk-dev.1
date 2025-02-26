Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB5DC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 21:21:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FEFF4067B;
	Wed, 26 Feb 2025 22:21:16 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C7E884060F
 for <dev@dpdk.org>; Wed, 26 Feb 2025 22:21:12 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id EBA802109CEA; Wed, 26 Feb 2025 13:21:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EBA802109CEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740604871;
 bh=bsmJfipCo7zKd1G8dPZNU7hrrvQoM1vUqF9NRvz+s+U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KDEJhszfLFT0+k6bqcPybKnIKkgd0sg9TsgqotMsOc7hEe27LbiQRigtucBR0PWhT
 5D9lisqk93QgsyhoLhDCI5jzHxEPDOjh/xZl5rdz8b3HCRzzQRGc1bhxBXySnHdb75
 yMQ6fx0nFrRnTJZHeXvzR2BbGqwwCix1BvIFzXXE=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 1/3] eal: make compatible with instruction set updates for
 MSVC
Date: Wed, 26 Feb 2025 13:21:04 -0800
Message-Id: <1740604866-6184-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740604866-6184-1-git-send-email-andremue@linux.microsoft.com>
References: <1740430879-17874-1-git-send-email-andremue@linux.microsoft.com>
 <1740604866-6184-1-git-send-email-andremue@linux.microsoft.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

