Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C08C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 04:41:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B14124068E;
	Wed, 23 Jul 2025 06:41:38 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 87F7C40685
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:41:37 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N2fEbp019658;
 Tue, 22 Jul 2025 21:41:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 Q+mwGFtcjQ9tfcGSbfzlVq6mjLI1OUaTQNclfw7Bpw=; b=FgpVNr8xW/X+zQK9b
 o4BVdwYcs6fLtglu7cGjJHbjZ2lfT0OOC2QLNtfGSW+mwI53fgbf2SFodm3XKNiX
 2A8qovAS0TZ4R4oZl/W1hDR8G0+KxKqg3kCvBxEPrimLtQ/OvANAUlDMkqNuA8RK
 3H3etvXJyovMUMk/ZFvRFlbenvX6W5iM7Wv4CiXiGbHWwBCkDGFGdkKOBad6tNs2
 hzxtvqRl6VZbsocKa5Ef9A+v/3DZkV5QyQqZH9oyIrrkkoATL+2IO5YbVSK10T09
 PVKM8LWGzBHoJHr5VGa03zdIEXLKraiWVZ3xRX4dS+qRrrfJLYMDdEMPwBaZObZ4
 54e1Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 482q61063d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 21:41:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 21:41:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 21:41:36 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id F2F973F707E;
 Tue, 22 Jul 2025 21:41:32 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: [PATCH v9 3/8] lib/pmu: reimplement per-arch ops as callbacks
Date: Wed, 23 Jul 2025 06:41:13 +0200
Message-ID: <20250723044118.2962318-4-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723044118.2962318-1-tduszynski@marvell.com>
References: <20250722120041.2718227-1-tduszynski@marvell.com>
 <20250723044118.2962318-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hF_No4CvOmeghog-z4idIfn63zMwfo0D
X-Proofpoint-ORIG-GUID: hF_No4CvOmeghog-z4idIfn63zMwfo0D
X-Authority-Analysis: v=2.4 cv=X9NSKHTe c=1 sm=1 tr=0 ts=68806800 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=C4pt3Q8vb_h7C6Lo94IA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAzNyBTYWx0ZWRfXzfs3dV7Wh6sW
 j7/x21SSykG87NUNoDLISM2BPP/7n83tJge/6zHXMJZuvG8wIt9XNnzC5f2CbGr89ykUGZUKKT3
 wHkFDruymMZ/KOvcXjit8NYzaEKhAObiLaFHXzD4Tdc4oaYNLnuqv9FL/KRLIFgQPumrXp73lrm
 Ufy2ShhAjE1WiugifFfqDIRsZ7DW2xGb99AA3nVLtLgdEgbxbv4cHNgoP68/3JYGRVcQwDHFOzZ
 NjGAtJZo2otA0Q0fNjq9MZMoanSdHU3exG4nM85GreYkwd0VTu4Zq0A1CVL8XiGVkmpgIcsboN4
 A/cfsISR9Iyu8l8+bROaEK7cjdMkAGvRjGuQQnFHFbwHgybEC5f3ArKRwFpWd8w7m35YXey9FJH
 T9dtEWeVZ/OerbKy7WwTRbFBm/81Hg4I/0D2mquY+fBo1IFJ9qjhectPNPjsfz0aalDQBTgg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
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
index 4c7271522a..d8212ca898 100644
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

