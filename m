Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4791C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 12:01:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1780740661;
	Tue, 22 Jul 2025 14:00:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 80AB640661
 for <dev@dpdk.org>; Tue, 22 Jul 2025 14:00:57 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LNTjP1008051;
 Tue, 22 Jul 2025 05:00:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 9K5/r2Rz8U5GHncTvtFy0YEDsEnGB6fLM9aexgLTVA=; b=CHOR2RNEgD/1wdd+p
 FT77cR0HGcWx9I/9REKBxsMBre+3CJszJfoulQdDVYene8uJTosXAZeu7SrZ6WGJ
 ciAMl9Ua2vloujtSgGzSGbWewYQ9ybI7gaOquq00Kw3fK1TGCeJJrbHGGWVlxDOP
 BQ8URL5IV1dgauzoqPgdb/U7LZnBwy/ULF1m8MnE2qB3L8NMqdutzHZGhEN4kIXF
 nCSkNLuR198H02wD0SsL6JJXLp7UG9/2VYBS24Z2rcRNJJ5smXjKjsikRpl9Q1SW
 UhVEEusM7OMlu8L8j/gfIRTobknouqfxYnNmTH9x6+x01P7sRGB5utOxXtS1iN80
 6yz8Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 481y91sbdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 05:00:56 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 05:00:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 05:00:55 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id BD5173F706C;
 Tue, 22 Jul 2025 05:00:52 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: [PATCH v8 3/8] lib/pmu: reimplement per-arch ops as callbacks
Date: Tue, 22 Jul 2025 14:00:36 +0200
Message-ID: <20250722120041.2718227-4-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722120041.2718227-1-tduszynski@marvell.com>
References: <20250627154107.3405768-1-tduszynski@marvell.com>
 <20250722120041.2718227-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5OCBTYWx0ZWRfX8chiBn8AqJ2k
 pozwxY20hLC9MtmiSZY3Q0jXPwQ2trz7J1EBDgrs9NJSRXaLvtfXV83cg/ZQvMCuMwY02QZY8GD
 mWmGh2BOC08ZV5zZfA/TZMc6a5ODGNWLLEsnYmlER6VfEqzm6GWeUJliwsyymQUsQHEY+EyINvd
 Hb4wZKmOjiQCa4bxRPKymHjLp/h1oGVfmjQeKPH6YTHX/b03qgU6RTIrkBMxl1X51ZAPysEUbdU
 TsONHww4cWVBHL1O2i09TnQbKi2FhotFQxgehz7z34QRlhRYinvP37fybjiR9wctxZqZeA4gIae
 4UdDpFSCEK8F6SACOUHqk+6HKqdPd3FX8HdGawRVOpM9HTBKSflnpLIJ4+5lOcVF7tOcgroAWuU
 EonrLLzZM1aqF1oSXMU1H3+j5uVf0sJbBvdC2Bu57fcWCOr+uPEzqASVIt2VQqpQYW0fT8z8
X-Proofpoint-ORIG-GUID: xMd3V7cvT-wr1tHDL6OxCAwSyR5oowho
X-Proofpoint-GUID: xMd3V7cvT-wr1tHDL6OxCAwSyR5oowho
X-Authority-Analysis: v=2.4 cv=RfGQC0tv c=1 sm=1 tr=0 ts=687f7d78 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=C4pt3Q8vb_h7C6Lo94IA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
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

