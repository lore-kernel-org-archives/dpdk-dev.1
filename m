Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA877C3ABAA
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 14:57:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D16254025D;
	Mon,  5 May 2025 16:57:52 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8545C4003C
 for <dev@dpdk.org>; Mon,  5 May 2025 16:57:51 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 64CD22115DC1; Mon,  5 May 2025 07:57:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 64CD22115DC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1746457070;
 bh=dV45KeSUtrGDuD5F/uxMJSObJRqzhitaaleNaNuYFFg=;
 h=From:To:Cc:Subject:Date:From;
 b=B7a0NYsjgL/yag8qRfQ27F1Uetk9odnILhEfgFk94p5Rr7B9eA+PCZBxovZAZR8cO
 dURPIOf3ENcj9D+11kkEt5eihHKywTBerZjCGpkgw4NDk5OjX4JzJ7+SpT7WG7q17e
 fsZvEl90SgkO2UT76fS5boxLO4z9ofqSDUgTBsVg=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] common/mlx5: use intrinsics instead of inline assembly
Date: Mon,  5 May 2025 07:57:42 -0700
Message-Id: <1746457062-8502-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

When compiling with MSVC the errors below are hit because msvc does not
support inline assembly:

1)
../drivers/common/mlx5/mlx5_common.c(86): warning C4013: '__asm__'
    undefined; assuming extern returning int
../drivers/common/mlx5/mlx5_common.c(87): error C2143: syntax error:
     missing ')' before ':'

2)
../drivers/net/mlx5/mlx5_txpp.c(510): error C2065: '__asm__':
    undeclared identifier
../drivers/net/mlx5/mlx5_txpp.c(510): error C2143: syntax error:
    missing ';' before 'volatile'

The fix for (1) is to use compiler intrinsic __cpuid and for (2)
intrinsic _InterlockedCompareExchange128 can be used.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/common/mlx5/mlx5_common.c | 13 +++++++++++--
 drivers/net/mlx5/mlx5_txpp.c      | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index 4f25127582..e1ce17559d 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -75,9 +75,18 @@ static inline void mlx5_cpu_id(unsigned int level,
 				unsigned int *eax, unsigned int *ebx,
 				unsigned int *ecx, unsigned int *edx)
 {
+#ifdef RTE_TOOLCHAIN_MSVC
+	int data[4];
+	__cpuid(data, level);
+	*eax = data[0];
+	*ebx = data[1];
+	*ecx = data[2];
+	*edx = data[3];
+#else
 	__asm__("cpuid\n\t"
-		: "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx)
-		: "0" (level));
+	: "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx)
+	: "0" (level));
+#endif
 }
 #endif
 
diff --git a/drivers/net/mlx5/mlx5_txpp.c b/drivers/net/mlx5/mlx5_txpp.c
index e6d3ad83e9..5bbaf668e6 100644
--- a/drivers/net/mlx5/mlx5_txpp.c
+++ b/drivers/net/mlx5/mlx5_txpp.c
@@ -486,6 +486,20 @@ mlx5_txpp_cq_arm(struct mlx5_dev_ctx_shared *sh)
 }
 
 #if defined(RTE_ARCH_X86_64)
+#ifdef RTE_TOOLCHAIN_MSVC
+static inline int
+mlx5_atomic128_compare_exchange(rte_int128_t *dst,
+				rte_int128_t *exp,
+				const rte_int128_t *src)
+{
+	return (int)_InterlockedCompareExchange128(
+		(int64_t volatile *)dst,
+		src->val[1], /* exchange high */
+		src->val[0], /* exchange low */
+		(int64_t *)exp /* comparand result */
+	);
+}
+#else
 static inline int
 mlx5_atomic128_compare_exchange(rte_int128_t *dst,
 				rte_int128_t *exp,
@@ -510,6 +524,7 @@ mlx5_atomic128_compare_exchange(rte_int128_t *dst,
 	return res;
 }
 #endif
+#endif
 
 static inline void
 mlx5_atomic_read_cqe(rte_int128_t *from, rte_int128_t *ts)
-- 
2.49.0.vfs.0.2

