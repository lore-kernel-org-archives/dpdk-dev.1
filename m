Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3318C02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 15:04:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14A4442DDC;
	Fri,  7 Feb 2025 16:04:39 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7027842DC1
 for <dev@dpdk.org>; Fri,  7 Feb 2025 16:04:37 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9AE5B210C31D; Fri,  7 Feb 2025 07:04:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9AE5B210C31D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1738940676;
 bh=MjS4E7/WApNEC2QMkZmm+fXcFa+2LVzD2ad6qdt5FKc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V+1wNLyKL7xdPIAGuQoI4tFpg1JzuGA9UZg3mx4K71uO2EtK6F1Pd9k1LqLdbL1q9
 kgDXWAcDUvuR9uwtbT75G1na2G3vrNats+1VEFPzWceDjxZmx3FHi8luYbrrm6YsfM
 +vjT67/S1k36X2L0xHUx9J1RBq62aoCZPD4VElsU=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: dev@dpdk.org
Cc: Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH v6] eal: define __SIZEOF_LONG__ when using MSVC
Date: Fri,  7 Feb 2025 07:04:28 -0800
Message-Id: <1738940668-21653-1-git-send-email-andremue@linux.microsoft.com>
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
 lib/eal/windows/include/rte_os.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/eal/windows/include/rte_os.h b/lib/eal/windows/include/rte_os.h
index d09adeb3b4..c787027866 100644
--- a/lib/eal/windows/include/rte_os.h
+++ b/lib/eal/windows/include/rte_os.h
@@ -56,4 +56,9 @@ struct { \
  */
 typedef long long ssize_t;
 
+#ifdef RTE_TOOLCHAIN_MSVC
+#define __SIZEOF_LONG__		(sizeof(long))
+#define __SIZEOF_LONG_LONG__	(sizeof(long long))
+#endif
+
 #endif /* _RTE_OS_H_ */
-- 
2.47.2.vfs.0.1

