Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE7606A321
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hE2DaOVd
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91AFC410D4;
	Wed, 11 Nov 2026 08:11:14 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
 by mails.dpdk.org (Postfix) with ESMTPS id 70AE04029B;
 Wed, 11 Nov 2026 08:11:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4RfANR0gFia/4L8NB5ZX1BXFrDlVoddLNrs5vqcAZ3rDSMqkfYTZWQbCOTBj9Qdn1F+YnN/eEhBPZBETtjsNx59XJvQ5FQ8jb+44hHS9yocw4LgY0FJFGBY+hoSfHC1CVUkFy06DEgMZBTfXe9V2YlXvLb02A5P1L2r3T2HhASwcv1YA/qvhb5HEvAW5tQ5aC/SeipO95APtmXNrQVY3uKRsmq3/+nyIfThfPeBLzLQDi/1dm/I3CX/5WfJO5fAfwgYZ383/xPpf75n/mXxjkJPpWdp352buKtel7QfrU6ZE/8G00qlPQ+0DqaB5WKcNLxWQG7uvBg4tIQ2Pytksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N3G32GoVPma6HBJ0BVZi57dISUWmPziqWy2X7iUMjQ=;
 b=Q8IVBjmvhyaHhDyORywMRkSutdiyRvo7oGQ0bHLRmq/Xzl8E7mlc79nea3BCvQ9EINWe4pC7hEHgUnmQPxoDCbJQ9ua4HWYK+YUN81tqhGlM4Jr7sFXdWBehhgPZfNPloHsTF+NdVeuyCuVwsDqWMKVpBzo95ejx1YJJ8FZOOgO4U9yQkgS9LoyVYjS2/RNVZ6iN2FBoMJ2usJTeCMwmbZ9eYmKl8z8ZH6dYE5/unU3+PjOE7KKykWIQBtbsuWe8srOAqaT8n0xVHtGGw+ytdBsyGkDNPQ0ojM72KmDblryp9pbyD6imLmq94z1uCzhp+jUaCFm6wSgob7uWSdDiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N3G32GoVPma6HBJ0BVZi57dISUWmPziqWy2X7iUMjQ=;
 b=hE2DaOVdxICouGX5+FXvrTwqyRV7fI2W8DjCta8/jQEnmi4MVOcLI4CptBZDSmXzRdc2aQanumNh9r9WhLBe94kqjYlZVHmMjKLrmwN/WyI+2AobUlG7kTn53SLhRsDDKGFqLbiqIdrBn3p3buw+5XveDCiIANHMhUGoQs38KV4=
Received: from CH0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:610:e7::10)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 07:11:06 +0000
Received: from BL2PEPF000352D3.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::a) by CH0PR03CA0215.outlook.office365.com
 (2603:10b6:610:e7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 07:11:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352D3.mail.protection.outlook.com (10.167.254.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:03 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:07:17 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v3 05/16] raw/ntb: fix doorbell interrupts with VFIO MSI-X
Date: Wed, 11 Nov 2026 12:36:39 +0530
Message-ID: <83edd90427001205d0ad8b44fe06e10dda83f3d2.1794377833.git.raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794377833.git.raghavendra.ningoji@amd.com>
References: <20261106055045.720805-1-raghavendra.ningoji@amd.com>
 <cover.1794377833.git.raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D3:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: c7afba9d-8977-4db4-ee7e-08df3fc2f448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|4143699003|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gHVyqsXmvEBjGxinNLcp6w7ckaDLUDvjOzR1jVnDDD+iJ8qcDWt8EKdO9wciYPmnTCtzAzrBPSp9hqDyMvYeSoDiV2UVvpiKkgjSAQWYeqKZzD7N6pumxDKuLwcNbmW9z8AXjvkIkQgNSO6XuXw4Aemt/KPlf21+UUSvcvfKKg5W0wBUPo8QfuUeuepuSgOAe9AO94p65IALkixKq2yyt6Jg9GJKq2TGvzCnHypMv2fT15BMsg9gH3Pee9r4JsigHfFGyrBU9jZZxsMWe9mAEd9pxLTNKUIluQcyKuB0wbSFd5KXMyCPWb32f9/s00nvD6hfcnZ8FxjM7Nc6mlB8yULmyeh/l3iue0B6ow+2nfbFUIx31V2h4l1nh5OO5V3uyBNpIIyQkBtX9eeobH/kpx/6mK9gqlMUynr2dUdpvmFnsBJgAPHW3htFlI03OkkQuhDfmWz10g9//JsAdFVni1uasXFL3kP0j5fimAwTWb+FUQrmf16o07jy4Jchx0gMJvD8i5DZRDVXEAyGYHj/eldq0QYjB2vGqC0jVRwgHSJxFSvqxuHCwcWoHOC+f4zA+CNxtFXX3n1IM0PxQrA0nhXowWK3qT0zmqqRgpnzYXpMikXVCLfJy3VK5tk7XBHOinm0Zqw2bPNU1Da/9UIUQTX5mXkyoXfx/jHzGpM7kOwXtWhQavtJE2E1klNFoviBCT1st8eV5sIzFeThhTRMIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fFxmDgY5Yb43WvPiRC7ghdYfcoyDaMbYmLIVy2gEqRrfgbXshkKChHrB/FH+FZ/FbcMw9wBW/gKiJ/yfK0VK15/R/YpBtFcwKUZfoGGEXdOITE7Im99o3GA7SHP1i6c+bo6Fqzif8d0jPaJ9of43616XkXQIRfTP96kFo6uNdNZeybh+yyT6IdWZ3mQKp2mmfwiAf+tW20Pill2/CsI1zJlSHCu0tWeRrrHHz6e/blZ2Ks5gfA0uOhDbbqbbnXUXqJnVxpUeA2ShzkZfki1TT4BE2DCgFR0Voel4glTX9RUUxBQKFa09wavfVXwWVLquX7qZa+++hKSQ3CEvpQOjojYXhuUqLCFa46y0DoZbCSHnLIEPmAqCsHfkz8UAQ+7JvFrXeSpvEqNvHZkFP6HSAojAlpNB+SxcUrHPvtMq7KGuQsHiSEYdv4xcYAuCOHLs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:06.4181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7afba9d-8977-4db4-ee7e-08df3fc2f448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With VFIO MSI-X, each doorbell raises its own vector. Vector 0 is
signalled on the PCI device interrupt handle while the others are
signalled on the eventfds created by rte_intr_efd_enable(), but the
interrupt handler was only registered on the device interrupt handle.

As a result, doorbells other than DB0 were only noticed when DB0 fired
at the same time. In particular, the DB1 rung by the peer in its
dev_stop was never handled, the peer never got the DB2 answer and had
to wait for the 1s timeout.

Register the interrupt handler on each doorbell eventfd as well.

Fixes: 62012a76811e ("raw/ntb: add handshake process")
Cc: stable@dpdk.org

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 77 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/raw/ntb/ntb.h |  4 +++
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 5985604cce..bde17c3c86 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -3,6 +3,7 @@
  */
 #include <stdint.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
 #include <errno.h>
 
@@ -11,6 +12,7 @@
 #include <rte_lcore.h>
 #include <rte_cycles.h>
 #include <rte_eal.h>
+#include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_pci.h>
 #include <rte_mbuf.h>
@@ -124,6 +126,73 @@ ntb_dev_intr_handler(void *param)
 		(*hw->ntb_ops->handle_hw_event)(dev);
 }
 
+static void
+ntb_db_intr_unregister(struct rte_rawdev *dev)
+{
+	struct ntb_hw *hw = dev->dev_private;
+	struct rte_intr_handle *handle;
+	uint16_t i;
+
+	for (i = 0; i < hw->nb_db_intr_handles; i++) {
+		handle = hw->db_intr_handles[i];
+		rte_intr_callback_unregister_sync(handle,
+						  ntb_dev_intr_handler, dev);
+		/* The eventfd is owned by the PCI device interrupt handle. */
+		rte_intr_fd_set(handle, -1);
+		rte_intr_instance_free(handle);
+	}
+	free(hw->db_intr_handles);
+	hw->db_intr_handles = NULL;
+	hw->nb_db_intr_handles = 0;
+}
+
+/*
+ * With MSI-X, only vector 0 is serviced through the PCI device interrupt
+ * handle. Each other doorbell raises its own vector, signalled on the
+ * eventfds created by rte_intr_efd_enable(): register the handler on them.
+ */
+static int
+ntb_db_intr_register(struct rte_rawdev *dev,
+		     struct rte_intr_handle *intr_handle)
+{
+	struct ntb_hw *hw = dev->dev_private;
+	int nb_efd = rte_intr_nb_efd_get(intr_handle);
+	struct rte_intr_handle *handle;
+	int i, ret;
+
+	hw->db_intr_handles = calloc(nb_efd, sizeof(*hw->db_intr_handles));
+	if (hw->db_intr_handles == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < nb_efd; i++) {
+		handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+		if (handle == NULL) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		hw->db_intr_handles[hw->nb_db_intr_handles++] = handle;
+
+		if (rte_intr_type_set(handle, RTE_INTR_HANDLE_VFIO_MSIX) ||
+		    rte_intr_fd_set(handle,
+				    rte_intr_efds_index_get(intr_handle, i))) {
+			ret = -rte_errno;
+			goto err;
+		}
+
+		ret = rte_intr_callback_register(handle,
+						 ntb_dev_intr_handler, dev);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	NTB_LOG(ERR, "Failed to register doorbell interrupt %d.", i + 1);
+	ntb_db_intr_unregister(dev);
+	return ret;
+}
+
 static int
 ntb_queue_conf_get(struct rte_rawdev *dev,
 		   uint16_t queue_id,
@@ -902,6 +971,8 @@ ntb_dev_close(struct rte_rawdev *dev)
 	    !rte_intr_max_intr_get(intr_handle))
 		return 0;
 
+	ntb_db_intr_unregister(dev);
+
 	/* Clean datapath event and vec mapping */
 	rte_intr_efd_disable(intr_handle);
 	rte_intr_vec_list_free(intr_handle);
@@ -1305,7 +1376,11 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 	 * by default for intel gen3. They are mapped to msix vec 1-32,
 	 * and hardware intr is mapped to 0. Map all to 0 for uio.
 	 */
-	if (!rte_intr_cap_multiple(intr_handle)) {
+	if (rte_intr_cap_multiple(intr_handle)) {
+		ret = ntb_db_intr_register(dev, intr_handle);
+		if (ret)
+			return ret;
+	} else {
 		for (i = 0; i < hw->db_cnt; i++) {
 			ret = (*hw->ntb_ops->vector_bind)(dev, i, 0);
 			if (ret)
diff --git a/drivers/raw/ntb/ntb.h b/drivers/raw/ntb/ntb.h
index 31bf0f3260..f867f0323d 100644
--- a/drivers/raw/ntb/ntb.h
+++ b/drivers/raw/ntb/ntb.h
@@ -222,6 +222,10 @@ struct ntb_hw {
 	struct rte_pci_device *pci_dev;
 	char *hw_addr;
 
+	/* Interrupt handles for the MSI-X doorbell vectors besides vector 0. */
+	struct rte_intr_handle **db_intr_handles;
+	uint16_t nb_db_intr_handles;
+
 	uint8_t peer_dev_up;
 	uint64_t mw_size[NTB_MAX_MW];
 	/* remote mem base addr */
-- 
2.34.1

