Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34A606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 07:34:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C720A402C4;
	Thu, 26 Nov 2026 08:34:43 +0100 (CET)
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com
 [115.124.28.169])
 by mails.dpdk.org (Postfix) with ESMTPS id 8894E40284
 for <dev@dpdk.org>; Thu, 26 Nov 2026 08:34:41 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06727728|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0150593-0.000301697-0.984639;
 FP=17464928631013247120|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033037034254; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.kAe1Yqx_1795678477; 
Received: from
 dimonzhao-1.NEBULA-MATRIX.COM(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.kAe1Yqx_1795678477 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:34:37 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 01/11] net/nbl: prepare common interfaces for draco
Date: Thu, 26 Nov 2026 15:34:18 +0800
Message-ID: <20261126073430.3168813-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
References: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add draco PCI IDs, product identification and PF/VF detection.
Introduce placeholder HW, channel and resource callbacks in the
product core operations table for subsequent patches to implement.

Return -ENOTSUP from the HW initialization placeholder until the
draco backend is available.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_core.c                | 43 ++++++++++++++++++++++-
 drivers/net/nbl/nbl_core.h                | 10 ++++++
 drivers/net/nbl/nbl_ethdev.c              |  9 +++++
 drivers/net/nbl/nbl_include/nbl_include.h |  1 +
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index 6a823e9..ae0632e 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -4,6 +4,35 @@
 
 #include "nbl_core.h"
 
+static int nbl_hw_init_draco_snic(void *adapter __rte_unused)
+{
+	/* Keep probing disabled until the Draco HW layer is implemented. */
+	return -ENOTSUP;
+}
+
+static void nbl_hw_remove_draco_snic(void *adapter __rte_unused)
+{
+}
+
+static int nbl_res_init_draco(void *adapter __rte_unused,
+			      struct rte_eth_dev *eth_dev __rte_unused)
+{
+	return 0;
+}
+
+static void nbl_res_remove_draco(void *adapter __rte_unused)
+{
+}
+
+static int nbl_chan_init_draco(void *adapter __rte_unused)
+{
+	return 0;
+}
+
+static void nbl_chan_remove_draco(void *adapter __rte_unused)
+{
+}
+
 const struct nbl_product_core_ops nbl_product_core_ops[NBL_PRODUCT_MAX] = {
 	[NBL_LEONIS_TYPE] = {
 		.hw_init	= nbl_hw_init_leonis_snic,
@@ -13,6 +42,14 @@ const struct nbl_product_core_ops nbl_product_core_ops[NBL_PRODUCT_MAX] = {
 		.chan_init	= nbl_chan_init_leonis,
 		.chan_remove	= nbl_chan_remove_leonis,
 	},
+	[NBL_DRACO_TYPE] = {
+		.hw_init	= nbl_hw_init_draco_snic,
+		.hw_remove	= nbl_hw_remove_draco_snic,
+		.res_init	= nbl_res_init_draco,
+		.res_remove	= nbl_res_remove_draco,
+		.chan_init	= nbl_chan_init_draco,
+		.chan_remove	= nbl_chan_remove_draco,
+	},
 };
 
 static const struct nbl_product_core_ops *
@@ -28,6 +65,9 @@ static void nbl_init_func_caps(const struct rte_pci_device *pci_dev, struct nbl_
 	if (pci_dev->id.device_id >= NBL_DEVICE_ID_M18110 &&
 	    pci_dev->id.device_id <= NBL_DEVICE_ID_M18100_VF)
 		caps->product_type = NBL_LEONIS_TYPE;
+	else if (pci_dev->id.device_id >= NBL_DEVICE_ID_M18305 &&
+		 pci_dev->id.device_id <= NBL_DEVICE_ID_M18305_VF)
+		caps->product_type = NBL_DRACO_TYPE;
 }
 
 int nbl_core_init(struct nbl_adapter *adapter, struct rte_eth_dev *eth_dev)
@@ -41,7 +81,8 @@ int nbl_core_init(struct nbl_adapter *adapter, struct rte_eth_dev *eth_dev)
 	common->eth_dev = eth_dev;
 	nbl_init_func_caps(pci_dev, &adapter->caps);
 
-	common->is_vf = (pci_dev->id.device_id == NBL_DEVICE_ID_M18100_VF);
+	common->is_vf = (pci_dev->id.device_id == NBL_DEVICE_ID_M18100_VF ||
+			 pci_dev->id.device_id == NBL_DEVICE_ID_M18305_VF);
 
 	product_base_ops = nbl_core_get_product_ops(adapter->caps.product_type);
 
diff --git a/drivers/net/nbl/nbl_core.h b/drivers/net/nbl/nbl_core.h
index 0c58b4c..3eceda2 100644
--- a/drivers/net/nbl/nbl_core.h
+++ b/drivers/net/nbl/nbl_core.h
@@ -32,6 +32,16 @@
 #define NBL_DEVICE_ID_M18120_LX_BASE_T_OCP	(0x3412)
 #define NBL_DEVICE_ID_M18100_VF			(0x3413)
 
+#define NBL_DEVICE_ID_M18305			(0x3502)
+#define NBL_DEVICE_ID_M18305_LX			(0x3503)
+#define NBL_DEVICE_ID_M18305_BASE_T		(0x3504)
+#define NBL_DEVICE_ID_M18305_LX_BASE_T		(0x3505)
+#define NBL_DEVICE_ID_M18305_OCP		(0x3506)
+#define NBL_DEVICE_ID_M18305_LX_OCP		(0x3507)
+#define NBL_DEVICE_ID_M18305_BASE_T_OCP		(0x3508)
+#define NBL_DEVICE_ID_M18305_LX_BASE_T_OCP	(0x3509)
+#define NBL_DEVICE_ID_M18305_VF			(0x350a)
+
 #define NBL_MAX_INSTANCE_CNT 516
 
 #define NBL_ADAPTER_TO_HW_MGT(adapter)		((adapter)->core.hw_mgt)
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
index 5a7d826..f714fdc 100644
--- a/drivers/net/nbl/nbl_ethdev.c
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -133,6 +133,15 @@ static const struct rte_pci_id pci_id_nbl_map[] = {
 	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18120_BASE_T_OCP) },
 	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18120_LX_BASE_T_OCP) },
 	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18100_VF) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18305) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18305_LX) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18305_BASE_T) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18305_LX_BASE_T) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18305_OCP) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18305_LX_OCP) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18305_BASE_T_OCP) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18305_LX_BASE_T_OCP) },
+	{ RTE_PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18305_VF) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index ba99b9f..08566ca 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -70,6 +70,7 @@ enum {
 
 enum nbl_product_type {
 	NBL_LEONIS_TYPE,
+	NBL_DRACO_TYPE,
 	NBL_PRODUCT_MAX,
 };
 
-- 
2.53.0

