Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB4AC77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 04:48:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E276740A80;
	Wed, 25 Jun 2025 06:47:47 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9C6A940A4B
 for <dev@dpdk.org>; Wed, 25 Jun 2025 06:47:46 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P2KKbq011220;
 Tue, 24 Jun 2025 21:47:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 9K5/r2Rz8U5GHncTvtFy0YEDsEnGB6fLM9aexgLTVA=; b=MLuKo3KX2cDKLxu1e
 BQl//CtkZGB2gheONZPjUcEs2JKtIOZsgQ2P5h7nucEA42l2jQnptLYv0KbYY5Wg
 9MZICBll9agDr4Rb4Ks2PhQBtoQb0h/KcyD2/XJhQxH3KfSsUIRl2RgEgjXBd9Mq
 00ubkBc8wftklf3UnGg84YsufVdl8zJrLKyX17RIiwH09styNyJftywCDf5RCSJX
 Y3/Njt1ThA6Z9H0c4frcns3cP16HKctiA+eE67AgUgWTHmkLqSNAZAcXytEDCJAV
 VjfNZs1yrI9HWrt+nR6TNzBNaxx3YG7xiD+PfPwObx4+MWF1MYVPWh3rjx/F4qb5
 XdpoA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47g88707n3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 21:47:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 21:47:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 21:47:43 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 4319A3F705C;
 Tue, 24 Jun 2025 21:47:41 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v5 3/8] lib/pmu: reimplement per-arch ops as callbacks
Date: Wed, 25 Jun 2025 06:47:25 +0200
Message-ID: <20250625044730.2435526-4-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625044730.2435526-1-tduszynski@marvell.com>
References: <20250624122930.1783177-1-tduszynski@marvell.com>
 <20250625044730.2435526-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAzNCBTYWx0ZWRfXyS7j/4o37Ks8
 v7JmfbQBcyCxZuf6nHien6ih6T9oy2orWLpq73x0wmzrvQHjDKyofEx0tj+NXUCUidCxbkhFn++
 CUsiFtRXtS599l9xksk4hHtjH8CV1NNOvh6yBq2CDsY9uo+C4ORpiuBU8q3NXsr34mLpLmpgCZf
 cutKsa5kSp6SQYkdQ5tTWmJo2LqiMAugxcsfDJwZxCk9cNZz+6phi21L1urgqO9ASa1v6jn+Ie9
 5sfDvOmaaKGl80hX01DMwhw+3gWByst9e/8118SaJ4yZt77k428ZXZqAY43O1AHRDpoK//lwZPp
 VJmzIC6t7Fb8S19uhjnAwgyVZdZ3fAs24SuO71h3j+DKx2mhATCCmSYhKdUGqGrCtGctIeP4G3H
 1t0MnOzxG3NAlIQApRjW005TlJ6KJsF64kNrgTJxlQiPvXTXJgHLjrceEjLVP1cNazzkLkmZ
X-Authority-Analysis: v=2.4 cv=EoTSrTcA c=1 sm=1 tr=0 ts=685b7f70 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=C4pt3Q8vb_h7C6Lo94IA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: oj6ya0rPTSkz3CP2PmGkpO9Fz5j6RXAt
X-Proofpoint-GUID: oj6ya0rPTSkz3CP2PmGkpO9Fz5j6RXAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
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

Replace static per-architecture ops with a callback-based ops
structure. This makes architecture-specific PMU implementations more
modular and easier to extend.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/pmu.c         | 17 +----------------
 lib/pmu/pmu_arm64.c   | 19 +++++++++++++------
 lib/pmu/pmu_private.h | 43 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 51 insertions(+), 28 deletions(-)

diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index 46b0b450ac..0709f5e58c 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -40,22 +40,7 @@ struct rte_pmu_event {
 RTE_EXPORT_INTERNAL_SYMBOL(rte_pmu)
 struct rte_pmu rte_pmu;
 
-/* Stubs for arch-specific functions */
-#if !defined(RTE_PMU_SUPPORTED) || defined(RTE_ARCH_X86_64)
-int
-pmu_arch_init(void)
-{
-	return 0;
-}
-void
-pmu_arch_fini(void)
-{
-}
-void
-pmu_arch_fixup_config(uint64_t __rte_unused config[3])
-{
-}
-#endif
+const struct pmu_arch_ops *arch_ops;
 
 static int
 get_term_format(const char *name, int *num, uint64_t *mask)
diff --git a/lib/pmu/pmu_arm64.c b/lib/pmu/pmu_arm64.c
index a23f1864df..3f4f5fa297 100644
--- a/lib/pmu/pmu_arm64.c
+++ b/lib/pmu/pmu_arm64.c
@@ -62,8 +62,8 @@ write_attr_int(const char *path, int val)
 	return 0;
 }
 
-int
-pmu_arch_init(void)
+static int
+pmu_arm64_init(void)
 {
 	int ret;
 
@@ -78,17 +78,24 @@ pmu_arch_init(void)
 	return write_attr_int(PERF_USER_ACCESS_PATH, 1);
 }
 
-void
-pmu_arch_fini(void)
+static void
+pmu_arm64_fini(void)
 {
 	write_attr_int(PERF_USER_ACCESS_PATH, restore_uaccess);
 }
 
-void
-pmu_arch_fixup_config(uint64_t config[3])
+static void
+pmu_arm64_fixup_config(uint64_t config[3])
 {
 	/* select 64 bit counters */
 	config[1] |= RTE_BIT64(0);
 	/* enable userspace access */
 	config[1] |= RTE_BIT64(1);
 }
+
+static const struct pmu_arch_ops arm64_ops = {
+	.init = pmu_arm64_init,
+	.fini = pmu_arm64_fini,
+	.fixup_config = pmu_arm64_fixup_config,
+};
+PMU_SET_ARCH_OPS(arm64_ops)
diff --git a/lib/pmu/pmu_private.h b/lib/pmu/pmu_private.h
index 3db1cb242b..d74f7f4092 100644
--- a/lib/pmu/pmu_private.h
+++ b/lib/pmu/pmu_private.h
@@ -5,20 +5,47 @@
 #ifndef PMU_PRIVATE_H
 #define PMU_PRIVATE_H
 
+/**
+ * Structure describing architecture specific PMU operations.
+ */
+struct pmu_arch_ops {
+	int (*init)(void);
+	void (*fini)(void);
+	void (*fixup_config)(uint64_t config[3]);
+};
+
+extern const struct pmu_arch_ops *arch_ops;
+
+#define PMU_SET_ARCH_OPS(ops) \
+	RTE_INIT(libpmu_set_arch_ops) \
+	{ \
+		arch_ops = &(ops); \
+	}
+
 /**
  * Architecture-specific PMU init callback.
  *
  * @return
  *   0 in case of success, negative value otherwise.
  */
-int
-pmu_arch_init(void);
+static inline int
+pmu_arch_init(void)
+{
+	if (arch_ops != NULL && arch_ops->init != NULL)
+		return arch_ops->init();
+
+	return 0;
+}
 
 /**
  * Architecture-specific PMU cleanup callback.
  */
-void
-pmu_arch_fini(void);
+static inline void
+pmu_arch_fini(void)
+{
+	if (arch_ops != NULL && arch_ops->fini != NULL)
+		arch_ops->fini();
+}
 
 /**
  * Apply architecture-specific settings to config before passing it to syscall.
@@ -27,7 +54,11 @@ pmu_arch_fini(void);
  *   Architecture-specific event configuration.
  *   Consult kernel sources for available options.
  */
-void
-pmu_arch_fixup_config(uint64_t config[3]);
+static inline void
+pmu_arch_fixup_config(uint64_t config[3])
+{
+	if (arch_ops != NULL && arch_ops->fixup_config != NULL)
+		arch_ops->fixup_config(config);
+}
 
 #endif /* PMU_PRIVATE_H */
-- 
2.34.1

