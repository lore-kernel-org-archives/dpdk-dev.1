Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875C5C02197
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 16:12:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D988340289;
	Wed,  5 Feb 2025 17:12:21 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 9622740270
 for <dev@dpdk.org>; Wed,  5 Feb 2025 17:12:20 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id C6523203718D; Wed,  5 Feb 2025 08:12:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C6523203718D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738771939;
 bh=DkfFW4h/+ZVRD/J3n4entfp6MgdNy1QgBesp2ga4SBI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E4VH3zWJ2IhkbKX/JkTQ92xp1vPtdQc+8/hp1cApAWXzvL2losL5tTTVXQ3M8O6oa
 HPzZOJq8EM6Zt/OJCSwIROwuDAjdSvC1tRaimUEqbu7X7yH3zJ8GPKCr8g+Pr1typB
 F8oobRcYCn7caKIxW3P52P3FjsyfdHwz7Hi7CHJc=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v5] eal: define __SIZEOF_LONG__ when using MSVC
Date: Wed,  5 Feb 2025 08:12:17 -0800
Message-Id: <1738771937-18083-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
References: <1733342995-3722-2-git-send-email-andremue@linux.microsoft.com>
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

Macro __SIZEOF_LONG__ is not standardized and MSVC does not define it.
Therefore the errors below are seen with MSVC:

../lib/mldev/mldev_utils_scalar.c(465): error C2065:
    '__SIZEOF_LONG__': undeclared identifier
../lib/mldev/mldev_utils_scalar.c(478): error C2051:
    case expression not constant

../lib/mldev/mldev_utils_scalar_bfloat16.c(33): error C2065:
    '__SIZEOF_LONG__': undeclared identifier
../lib/mldev/mldev_utils_scalar_bfloat16.c(49): error C2051:
    case expression not constant

The fix is to define __SIZEOF_LONG__ in a common header when
MSVC is used.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 lib/eal/include/rte_compat.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/eal/include/rte_compat.h b/lib/eal/include/rte_compat.h
index 97c1540bd0..6676a1bb13 100644
--- a/lib/eal/include/rte_compat.h
+++ b/lib/eal/include/rte_compat.h
@@ -66,4 +66,9 @@ __attribute__((section(".text.internal")))
 
 #endif
 
+#ifdef RTE_TOOLCHAIN_MSVC
+#define __SIZEOF_LONG__		(sizeof(long))
+#define __SIZEOF_LONG_LONG__	(sizeof(long long))
+#endif
+
 #endif /* _RTE_COMPAT_H_ */
-- 
2.47.2.vfs.0.1

