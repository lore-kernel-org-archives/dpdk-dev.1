Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E63DC71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 06:54:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B47340B9C;
	Mon, 16 Jun 2025 08:54:14 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6E41E40B9F
 for <dev@dpdk.org>; Mon, 16 Jun 2025 08:54:08 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNVXap027563;
 Sun, 15 Jun 2025 23:54:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
 P/ClFTD6w17i8iK3RYSkpm8pcomJdWiw7+6m6WPaeQ=; b=NSp+32xCCrkxpZy/K
 Vjem2zH0h+WUcCh6RK0ZSThujUrVnK+i5iOtHOVxDBBuMMI1IS7RDAUMau9eCCdL
 f5NaCdE3HA9a4ygxixgoygfFLBUItZMeihXQyGQUy0l01OY7iQyc2cNXrATEDm/6
 KQON0rhjUJkRoQlZqJnbElUuC0CIf1vD+ZWCk7VEQG046HweXPVl6141/OG4+kuP
 6jVxx8etKB0sUAUvCeKRV4LcxeVlVcEPmwQXJ9549U6+FEnw+fTQYcroPgZjpdWz
 wXSfY+DEqa27aDOevfCaVQohi2rR6GOASFGEzX5hvP6eR32U018p6yFsuvBY0RJJ
 EyaiQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47a7wt0kyh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 15 Jun 2025 23:54:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Jun 2025 23:54:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Jun 2025 23:54:03 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id D192E5E6875;
 Sun, 15 Jun 2025 23:54:01 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <dev@dpdk.org>, Tomasz Duszynski <tduszynski@marvell.com>, "Wathsala
 Vithanage" <wathsala.vithanage@arm.com>
CC: <jerinj@marvell.com>, <thomas@monjalon.net>
Subject: [PATCH 3/6] lib/pmu: reimplement per-arch ops as callbacks
Date: Mon, 16 Jun 2025 08:53:38 +0200
Message-ID: <20250616065341.3233106-4-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616065341.3233106-1-tduszynski@marvell.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA0NCBTYWx0ZWRfX5XtUji08Mb0T
 0BJh6C5AFyi3YGCOrMv+JIpiXYYuzJcTKEcIvyjYI+tdKVTaFMH88HeS7JIAzp2LYUe0tp94d80
 adhmVsV2dM3hORg+wIiBcaoZJuqWHdHnUu1Pjzr9WXE4hDganyZX1dWP6LPI3dux+Z6HOH2JF7X
 Y42M6HBjRfGn2Lk1KY6YVx2GE2fi4ewCzjhYr8vJdN1cwJ8BurOG7Pu5iJmHrgOFv0Jk0J5svZc
 CX8XRy01c+DKzcR3rDJQurX8ENDBG4nNVv3L5XPcqTnL2/T9Fz2UR3brUJT1i6O3r/Y/ZF4mD6z
 tcvYIx2d0bk551YFrtToYjf5kpUsUbm/nC7A4+wm3mVOsf/I2vAXhXXXlOPwNULFUkkKb0m4f5I
 SwtJqCWZ1uIMQmnENHru3X3tafqF5hqaxi71gnrk1YUFIVsQn0CnmQgj3zDWuTLTyy6Av/K3
X-Proofpoint-ORIG-GUID: Pp8YgKiV67QSuEFqOgWhIz9OCWC2H3Q3
X-Proofpoint-GUID: Pp8YgKiV67QSuEFqOgWhIz9OCWC2H3Q3
X-Authority-Analysis: v=2.4 cv=OIon3TaB c=1 sm=1 tr=0 ts=684fbf8d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=C4pt3Q8vb_h7C6Lo94IA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_02,2025-06-13_01,2025-03-28_01
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
index 3db1cb242b..929d0478d5 100644
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
+	if (arch_ops && arch_ops->init)
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
+	if (arch_ops && arch_ops->fini)
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
+	if (arch_ops && arch_ops->fixup_config)
+		arch_ops->fixup_config(config);
+}
 
 #endif /* PMU_PRIVATE_H */
-- 
2.34.1

