Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870F606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=H4GqItJ7
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D30440B92;
	Wed,  4 Nov 2026 12:20:40 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012000.outbound.protection.outlook.com
 [40.93.195.0]) by mails.dpdk.org (Postfix) with ESMTPS id 73B344278B;
 Wed,  4 Nov 2026 12:20:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4EhOjJ6z2s/ylBz4mf8GT8M4pD2cfbx4+vTRSY14lomdWYxsvu3fKqEszxSPxRqxEWx7FoKUv3eC886fBY4yFRoIipMK/hU0wPfUxIhW8TnML1KwliKLkuMlGLIDUxpgAyAEkcmzBHN0YPfDVqYxbWp4eEywA7dyWmbuhBgRn10+IRGOtBr/cOKO5kgIP3PRrpDrw2iXaFAUJ74nr7C0Xdi1YY6cRKXTGiS2KM6+ZBcf9wuMYev2wqLLN+3chtOs56tr8rRZ5a3LVWW2mDncTPTQUDYf0grwjQQr8ZzOTP08cdWviKN/9Ah5T5bduD63RVg0Yy9wV2omZCXWr9kbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8kL47486RrCrB8k6C4BcyrAixEvdxFk7nzKlP2qdIc=;
 b=wh8L1t1P1daktVNfMMOJhrMJ6RGUbqe7QVLrwI3t5hE7fC5KellVfVsAZ9LhrlpGGOA/B++ZJZpMoiNkr8hCLauslPvLEl4pxA0kzPDeh0i6B8SOZ2T/iDJtV1mZXL7cALNCWAlckvZsweVUr4vzVuStMclEqI86fNK/dmu4V1EsiAEECT9j9jdtE9K9xvyQnkpZanlv1ojYXN3Zb+zLKSTdlaUr2NtRsSwk34KadYRXbeRxtEAz3YlwKxknnvXGyPRo/aXcNYT4m/LcyonqT0KbW4JQUHBVSNeloeyE8aNXm5KZ2IcNIw9O32X33rLjSh2erunHHLJw1qMMg1Yuew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8kL47486RrCrB8k6C4BcyrAixEvdxFk7nzKlP2qdIc=;
 b=H4GqItJ79koFuYpoQ3weJJT+l2wxq8bZbozM277grRY+/nLuRVz5JFa2AijxGVuixh1Ar/TiDiYw3lFTreC1IQ/gITMcCbCqfB4Sl7GOv/2Wna+pOCzHGR8segxS2poNmz4UV+v2SVg8IKWt+hanvT56EhVQbEbSgaaH5VxT8Us=
Received: from CH0PR03CA0444.namprd03.prod.outlook.com (2603:10b6:610:10e::12)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 11:20:33 +0000
Received: from BN3PEPF00022BC4.namprd05.prod.outlook.com
 (2603:10b6:610:10e:cafe::8b) by CH0PR03CA0444.outlook.office365.com
 (2603:10b6:610:10e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:20:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC4.mail.protection.outlook.com (10.167.248.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:33 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:30 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>, <stable@dpdk.org>
Subject: [PATCH 05/13] raw/ntb: fix doorbell interrupts with VFIO MSI-X
Date: Wed, 4 Nov 2026 16:49:53 +0530
Message-ID: <20261104112001.661769-6-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
References: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC4:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 5572518a-0080-444f-6062-08df3a65a470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|260925022911599003|260925021311599003|260925021911599003|18002099003|22082099003|261102123227099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: zZluaYlQfwUqvTAk47QLVrss34VLBvK7R1BR2gLP6YVdvjGrJe5HfPHf3abBXzfRu0Vt6R+XWaof5vcHqnc5ockU+qh3l5P+3SJ7ViIoMi8gx8Jw/hT7hHNZyUNRnszYTiwY5R/AB8WV9te6tsC6F9KNQFjJzYZ1kFgJEq3wpS5Uz//gkeM510klosh3ekVgH+HAVOi1lryrcPZcBOPz4AJrhdVwbty6t46Lm8jXsuCx9Cy9pdQqOqa528eA+QUijmm7WQDN12l3dG6wRNVpUN6q6a0ZdG0WhTOU6Z4qDl1+ktQi0Ai6bI4Cu+9B/NwWRzxE4cCbPUL+e3nDrPxTgNibr7QWLEDXw1HQlOTlHSn1PeDxnrsVw00hnaAt1i9YGV1+TJcEZ3DEJ6uOlQOLu8aBTT6nTyzEZBA1aao5LxJzylt12bODp5dnWewnfyCei7RIg5ExpYsthfe0KQLm0p29z+hSfNpgj3QtS8z4uTyJOeRSFvdbHHFkB8SmYYYVchYwRD14kZVt3DMpldDhYAY+x3cbuaPjDGiXZnwvpaMfvu+DC/wvc3TljnlG4e63OVTsplSQZDVcbc7RP9uo+xvPxWVV9CK/OqSZjPUWB+F+6km8fVKarkjt2SsKejtvyUGAoVAm7hNoyW282Dcy8vzCeMAEoSL/kvw43hAiHuAEKTpir8K2rwUTRV41RUDIMxbVKxle1xkczbWGy1gJnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(260925022911599003)(260925021311599003)(260925021911599003)(18002099003)(22082099003)(261102123227099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YLvG7Vrc19igh2g7lAF6eEAHbdpgeM1vZZ11Q7U3//Py0sL32jzl+6X1i7WwMWJLDUCTls1OiMvSFnIPldtGWBvz8PKLjb+yFeBUmqePHao5LmFhKmNzm+ehGmR16rRJXotFNJyz3cpbKF6TOoP7UntfzdMwGBWipG6a2ZNATERUNA4c7tlgnUC60mIRYkIsi0iqckacSiKGKCay34ohuoDC16Q/wAzRdXY5CqkcO+xfCIffJBucnZedTWrEz16OnPFEIOIdB89MmpDOJuA2PMa7PHcJFAOboaNM3amaDSDWIZ6WsG2ucErgCocRLpO5F8juVCivReF29VJABjnbnGcDsbi+uSMlFWQlCdN7sqv/uPuVySZUzdQrJCeYTRgaHpJM6dqXvGqJaF8cz8xjRjBwiIqaHhNpQjjgyFjGFQmG2oNjlxETlYrGt66E7fh3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:33.4408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5572518a-0080-444f-6062-08df3a65a470
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
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
index af3fcd832b..a1993121dd 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -11,6 +11,7 @@
 #include <rte_lcore.h>
 #include <rte_cycles.h>
 #include <rte_eal.h>
+#include <rte_errno.h>
 #include <rte_log.h>
 #include <rte_pci.h>
 #include <rte_mbuf.h>
@@ -124,6 +125,74 @@ ntb_dev_intr_handler(void *param)
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
+	rte_free(hw->db_intr_handles);
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
+	hw->db_intr_handles = rte_zmalloc("ntb_db_intr",
+				nb_efd * sizeof(*hw->db_intr_handles), 0);
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
@@ -905,6 +974,8 @@ ntb_dev_close(struct rte_rawdev *dev)
 	    !rte_intr_max_intr_get(intr_handle))
 		return 0;
 
+	ntb_db_intr_unregister(dev);
+
 	/* Clean datapath event and vec mapping */
 	rte_intr_efd_disable(intr_handle);
 	rte_intr_vec_list_free(intr_handle);
@@ -1308,7 +1379,11 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
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
index 0181bec5c9..2787883160 100644
--- a/drivers/raw/ntb/ntb.h
+++ b/drivers/raw/ntb/ntb.h
@@ -219,6 +219,10 @@ struct ntb_hw {
 	struct rte_pci_device *pci_dev;
 	char *hw_addr;
 
+	/* Interrupt handles for the MSI-X doorbell vectors besides vector 0. */
+	struct rte_intr_handle **db_intr_handles;
+	uint16_t nb_db_intr_handles;
+
 	uint8_t peer_dev_up;
 	uint64_t *mw_size;
 	/* remote mem base addr */
-- 
2.34.1

