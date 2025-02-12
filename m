Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EAFC021A4
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 14:36:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00D1542798;
	Wed, 12 Feb 2025 15:36:39 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 257874278C
 for <dev@dpdk.org>; Wed, 12 Feb 2025 15:36:36 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 394DA554A7B; Wed, 12 Feb 2025 22:36:34 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v11 03/28] net/rnp: add log
Date: Wed, 12 Feb 2025 22:36:00 +0800
Message-Id: <1739370987-3989-4-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739370987-3989-1-git-send-email-caowenbo@mucse.com>
References: <1739370987-3989-1-git-send-email-caowenbo@mucse.com>
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

add log function for trace or debug

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 drivers/net/rnp/rnp_ethdev.c |  2 ++
 drivers/net/rnp/rnp_logs.h   | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 drivers/net/rnp/rnp_logs.h

diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index b71226cb84..12cc30e013 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -72,6 +72,8 @@ static struct rte_pci_driver rte_rnp_pmd = {
 	.remove = rnp_pci_remove,
 };
 
+RTE_LOG_REGISTER_SUFFIX(rnp_init_logtype, init, NOTICE);
+
 RTE_PMD_REGISTER_PCI(net_rnp, rte_rnp_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_rnp, pci_id_rnp_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_rnp, "igb_uio | uio_pci_generic | vfio-pci");
diff --git a/drivers/net/rnp/rnp_logs.h b/drivers/net/rnp/rnp_logs.h
new file mode 100644
index 0000000000..c68a5c1028
--- /dev/null
+++ b/drivers/net/rnp/rnp_logs.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef __RNP_LOGS_H__
+#define __RNP_LOGS_H__
+
+#include <rte_log.h>
+
+extern int rnp_init_logtype;
+#define RTE_LOGTYPE_RNP_INIT rnp_init_logtype
+#define RNP_PMD_INIT_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, RNP_INIT, "%s(): ", __func__,  __VA_ARGS__)
+#define PMD_INIT_FUNC_TRACE() RNP_PMD_INIT_LOG(DEBUG, " >>")
+#define RNP_PMD_DRV_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, RNP_INIT, \
+			"%s(): ", __func__, __VA_ARGS__)
+#define RNP_PMD_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, RNP_INIT, \
+			"rnp_net: (%d) ", __LINE__, __VA_ARGS__)
+#define RNP_PMD_ERR(fmt, ...) \
+	RNP_PMD_LOG(ERR, fmt, ## __VA_ARGS__)
+#define RNP_PMD_WARN(fmt, ...) \
+	RNP_PMD_LOG(WARNING, fmt, ## __VA_ARGS__)
+#define RNP_PMD_INFO(fmt, ...) \
+	RNP_PMD_LOG(INFO, fmt, ## __VA_ARGS__)
+
+#ifdef RTE_LIBRTE_RNP_REG_DEBUG
+#define RNP_PMD_REG_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, RNP_INIT, \
+			"%s(): ", __func__, __VA_ARGS__)
+#else
+#define RNP_PMD_REG_LOG(...) do { } while (0)
+#endif
+
+#endif /* __RNP_LOGS_H__ */
-- 
2.34.1

