Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AF3C02199
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 02:44:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DD8740395;
	Sat,  8 Feb 2025 03:44:36 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 7D676402EB
 for <dev@dpdk.org>; Sat,  8 Feb 2025 03:44:34 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id A7D149145E; Sat,  8 Feb 2025 10:44:18 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v7 03/28] net/rnp: add log
Date: Sat,  8 Feb 2025 10:43:40 +0800
Message-Id: <1738982645-34550-4-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738982645-34550-1-git-send-email-caowenbo@mucse.com>
References: <1738982645-34550-1-git-send-email-caowenbo@mucse.com>
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
 drivers/net/rnp/rnp_logs.h   | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 drivers/net/rnp/rnp_logs.h

diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 2f34f88..389c6ad 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -72,6 +72,8 @@
 	.remove = rnp_pci_remove,
 };
 
+RTE_LOG_REGISTER_SUFFIX(rnp_init_logtype, init, NOTICE);
+
 RTE_PMD_REGISTER_PCI(net_rnp, rte_rnp_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_rnp, pci_id_rnp_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_rnp, "igb_uio | uio_pci_generic | vfio-pci");
diff --git a/drivers/net/rnp/rnp_logs.h b/drivers/net/rnp/rnp_logs.h
new file mode 100644
index 0000000..078c752
--- /dev/null
+++ b/drivers/net/rnp/rnp_logs.h
@@ -0,0 +1,37 @@
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
+
+#define RNP_PMD_INIT_LOG(level, fmt, args...) \
+	rte_log(RTE_LOG_ ## level, rnp_init_logtype, "%s(): " fmt "\n", \
+			  __func__, ##args)
+#define PMD_INIT_FUNC_TRACE() RNP_PMD_INIT_LOG(DEBUG, " >>")
+#define RNP_PMD_DRV_LOG(level, fmt, args...) \
+	rte_log(RTE_LOG_##level, rnp_init_logtype, \
+			"%s() " fmt "\n", __func__, ##args)
+#define RNP_PMD_LOG(level, fmt, args...) \
+	rte_log(RTE_LOG_##level, rnp_init_logtype, \
+			"rnp_net: (%d) " fmt "\n", __LINE__, ##args)
+#define RNP_PMD_ERR(fmt, args...) \
+	RNP_PMD_LOG(ERR, fmt, ## args)
+#define RNP_PMD_WARN(fmt, args...) \
+	RNP_PMD_LOG(WARNING, fmt, ## args)
+#define RNP_PMD_INFO(fmt, args...) \
+	RNP_PMD_LOG(INFO, fmt, ## args)
+
+#ifdef RTE_LIBRTE_RNP_REG_DEBUG
+#define RNP_PMD_REG_LOG(level, fmt, args...) \
+	rte_log(RTE_LOG_ ## level, rnp_init_logtype, \
+			"%s(): " fmt "\n", __func__, ##args)
+#else
+#define RNP_PMD_REG_LOG(level, fmt, args...) do { } while (0)
+#endif
+
+#endif /* __RNP_LOGS_H__ */
-- 
1.8.3.1

