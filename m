Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC4DC77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:58:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2442F40685;
	Fri, 27 Jun 2025 12:57:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 97F934025D
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:57:55 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RA0n1D020090;
 Fri, 27 Jun 2025 03:57:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 9K5/r2Rz8U5GHncTvtFy0YEDsEnGB6fLM9aexgLTVA=; b=hRDwpAuNAxjPmVuXh
 ne9hYPoPsTtpslf7BXE+CheTDBHgagNqWexEcZCIIO0Qp7N0XxqxoYw4Z4PKLI0e
 99SEXAJOvG8VOuQyG/asbeirGphEMdVcP+OlZezlVu8nJsMOBSELgel3SEUQ+4cM
 0Tio1T65BkxplifhVlKLkn9HdV6L9bso0Zx8pMDV/Gl7g9jqCYnK4Gt2pvrZ5LPJ
 b92GTOxOQR3MCgRZha2vJOYXWEhd8lwDkz2LCCNzqv82cFIBJQGnZoITuBOAfPfV
 uxViAGV0oOghi4yuD4hYyOy0j3H0xmvCpagqABuqGdCGLI+8ZwDrwovB3HszTjse
 BcOUA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47hs5c83nm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 03:57:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 03:57:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 03:57:53 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 07A4E5C68E3;
 Fri, 27 Jun 2025 03:57:50 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v6 3/8] lib/pmu: reimplement per-arch ops as callbacks
Date: Fri, 27 Jun 2025 12:57:35 +0200
Message-ID: <20250627105740.3388237-4-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627105740.3388237-1-tduszynski@marvell.com>
References: <20250625044730.2435526-1-tduszynski@marvell.com>
 <20250627105740.3388237-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AyRTD0buZX0A56jgpnTGC83MwiMWfRRd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA4OSBTYWx0ZWRfX0JNVLNPA2dWd
 JHRFroPkoDqrrpZKiXCVVVSbvxoA005I5zt4mKr4A9sxcD3IcnhVTr31V5+mw01DrKxQxZjuuzB
 8cnA5phRWBSJkOTcJdhJ51rApcrAZAViDhblTZKqLAGQhjtbFKFMucvA3HSZj+Zf2jxS5Zr/00R
 ISVWm41TYxYlp+ZnREF7kJ4FMnCrzZtLLhRMbCEvxzJH1e8bLAnm/0QZdzzU+Gq0UX18NqN7gqU
 Q6E3J6a9J3xp2Po61yEW+Gd0m5mQobt61kOYrgZKhBYXH4TZhdDwhIH+ZzMnnDHSvHv7V5q4x9r
 Ol/X3ooNcGLzzUwCg8zvjsbA/To7nrLrybbQCO9pNq5JKfrR0oWGQLkQJQrRzBFfhnththenH8G
 71C3eRhJ3WOU0W4DOZz+aDNIndpouF4JskU9567Q7kkE/PDnsj7m2b2q/sK9sm7lsBgiMwxX
X-Proofpoint-GUID: AyRTD0buZX0A56jgpnTGC83MwiMWfRRd
X-Authority-Analysis: v=2.4 cv=BNOzrEQG c=1 sm=1 tr=0 ts=685e7932 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=C4pt3Q8vb_h7C6Lo94IA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
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

