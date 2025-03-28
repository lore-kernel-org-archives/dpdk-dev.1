Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117ECC28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:15:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A243B402A7;
	Fri, 28 Mar 2025 06:15:06 +0100 (CET)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by mails.dpdk.org (Postfix) with ESMTP id AEDC040649
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:15:03 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138896t68j0h
X-QQ-Originating-IP: gWX0Opd/H29fHPuKfH1JVIdve8i5lDBA4hSGYm+tldU=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:14:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13051775033469771554
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v17 03/29] net/rnp: add log
Date: Fri, 28 Mar 2025 05:14:18 +0000
Message-Id: <20250328051444.1019208-4-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328051444.1019208-1-caowenbo@mucse.com>
References: <20250328051444.1019208-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NojR6Ao/DkEDqlB4fpElmTkGoe1/3oBZuPzQSZneljQvyCN138wZr/Xi
 tryXz1sLCdoSDUJqEJQ78hmf3nJmdYg9fYHHWaA+7+A430DDBgCylTRMr+19Uu/g3LyadPO
 ZyhEwHaoJESAUyeQSXg43x/icoLBrRXo6y1/4pQp8ZohXvJqmCFQPmUMECUJR71ZELhWtBJ
 Xjx7QO0H8awmY5DHru0O1iyTBzSEfxc6CUwlMkABAKAAF+7gxiP9m0kOB0JfNfucwK3NJwh
 M4jdz0BOusG3tDDoQO1nMroe148PX16g4xDLf9R1s/Kul6sx5XIALHtqtxxwdfTAfXmO++M
 KN91yasYV0K1SrgNSR78DjIwLWgOTwvpqTwherMEkuqPL/86C5X0aLlYHyX3TCa9jqeskfF
 6qgA0Z6ln+NKuTIu79EOYvnPTa80neVXhKso/8DWMXf4CwptImjmTc16iCuyBVsbsEgiez8
 An+ZNa43QAmOfwkAPEpaS/OmNpfYClvXFdJVs+HH3Js8vMcTsgRBTbrATdIWw8ZbENWmH69
 +E07YcGUwRO4HDcadAJL2AlwKRZWLwel/qpx67MpNUiQ4qZvTeSw+wraIAKIWVLu2WM3JWQ
 7BN+d9+nvnpiToQoVh0cwkZw2IasvQH6xvRhzpxz/7s/tbJjj02i0bAi7QtYtBgDnuO+ozu
 p2GxXn/c5wR0ZI/4sBeOBYyHyPo2aW/+pfuMBjzxcyplSNP+ucgjLmA4UjLa8mf9MsH5eSN
 NqEr3FXVTUUAESRnaTf9cQIN64MOCHUpGKylhacibocVmKpoq3Vlg+X46OG6i5am8lfSd35
 ZcT6gjFzFYOpZHUDTn11DTipFyphpQU5DbNQMUoVn4HME72DBNcxC3xv6u7ofuHRF/Xpdvr
 9eXYKSx6mkaTuMxp0eU7qQY2HnC28U6NNrIkOQhyETSLCnvJSRFJGf7vpEQXl3k6BKPBFgT
 RTNLCKoxr4SoFSRYqYHxG38mS2Wvh2I4b52vVU5ixcCGH0CXCxzLaS2yBkIorefl8kiMdWz
 ULgI+CZw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
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
index e2eb80ba69..7fe93edcf6 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -64,6 +64,8 @@ static struct rte_pci_driver rte_rnp_pmd = {
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
2.25.1

