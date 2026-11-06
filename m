Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4DF606A328
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=m7WxL2xo
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2F5E42DA7;
	Fri,  6 Nov 2026 06:51:19 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
 by mails.dpdk.org (Postfix) with ESMTPS id C3A6E42DA7;
 Fri,  6 Nov 2026 06:51:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0+oRlNNYKFOsDWIk6mOnP/Ha6JKa5uwFMsI/Ce6hys6UJFB0vudsxNkSz5jUBk/aYe6kheHTiiuh0KedZyKphgMgAvDkqkSnCvFJ97iYZ0nUV+Dgs/qf/52RcQEj1RZydrVpmXby19QX/5fiZAMd9x9/U7T/q9sTDlBCGlh9A/KtD3bvXXMjhd+jnIh5XKGjbgIOdXEE+KCnxOKDc4g5qnhFkzfWBjJmS+7CtQksCBdWRC4F0d0RO9DHEktH+LSfYq4g0Z8MGKNjJ3Ng4zqonauIaqPfGNqt1Iows0N6aBN4ArSzbxTqMn1HT1qhZfGvvqqs2J5IfnR+jckoQw/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+N3G32GoVPma6HBJ0BVZi57dISUWmPziqWy2X7iUMjQ=;
 b=oaD92yfcIqzjexdiWxgiLkWOcrJ1x1iznP3GNHdo3om4OcvWtp+D8lz/Tjxu/8ftzoxkldi11B7+WVKHcpoR1Vp7QVI9kSULyKmMroXvS5n7GviE0ohlnJ/C3DZgdk3umNQ1mQEFqBS9EkHQze3UZjTzkGHHX6azzYpAgR8ULiq6Mo1N7ASm/fD3qtuhlhfSsjkcGM1bdzyFouoQ73fI/UY2vhDyT2WDAxRM1Eu7AEdvA+e4YSlxBrMIci8ATHmGY2iYvt8Op93Tc17vhd5LYdpJ/EIlhA+bGgwcMhb5jQlYezh/7TrIhJZqavJyodX9/JywATCMRvhfzGoP0xFOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+N3G32GoVPma6HBJ0BVZi57dISUWmPziqWy2X7iUMjQ=;
 b=m7WxL2xo87B8tZES0/sqFGpcZmra9BT6Tn8u1b4MXqKb+ZR4I4BzxIknA/fGO1zoydFX2VvzZ+cIyZ9hUHvQBYvjWWNpoQkQNETWNRoG1iGsyqJ8XKutucUN5//SeeUsZ0ZiLrkhLjxGU+PTNUr1L1JRjw96TdTPkdL8mkX4Ntw=
Received: from CY5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:930:1e::23)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:51:14 +0000
Received: from CY4PEPF000392D7.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::4b) by CY5PR04CA0030.outlook.office365.com
 (2603:10b6:930:1e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:51:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392D7.mail.protection.outlook.com (10.167.247.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:14 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:11 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v2 05/15] raw/ntb: fix doorbell interrupts with VFIO MSI-X
Date: Fri, 6 Nov 2026 11:20:35 +0530
Message-ID: <20261106055045.720805-6-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
References: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D7:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: a14223c8-3c1c-40a0-0c7d-08df3bc9f7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|22082099003|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261009223027099003|261022105027099003|261021123027099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: /gdE3i4ByA8QKe+Yc805JusXDjaVHw+cU2y8UKDk54DpVwSyib4obQKH+wMduhzAsB0AAlGehAXKWIPciXy8Yr0t7Mp1kn8gv6D+vtnEynby96wzo/D9g6x6V7pvsETiEa3xEPkO4Jy2WHIx0oqFasJ8DlHC9tKliBS6o+gNCQqjTQzeIWcYhIo+2XAmGHXfRtWE8dp8t8jur9esYATkKhiby0fHSnZ0jbYPAP56yJO4yMsxp19Xp+sj34kM2JX6P2gNuQZC9VobbqljHr9Soa9oLqpEjDhP1vcGBM111EIuHSw/ihOT7pb5+iMEg6v5PTL0e//i09Fcq2gU8/sBCsObW4ucf7TzcnoM9ptbeDt4yEuxwwCUPqLa1ZpsjNgV1j7IYAyBbJTcl0zE1mEQiPe8593NGgtgIxbDGhCuPALR/EwMelSOobwkdkZWverluXZ8+rB0yJbtPcKG8HaOfuV0oWQHrS6TkAN5qFYDjWgduTBAgUpX+3gMnTayYBV+ejRlp1iXOr4kiBGik7D7DyxyaSX0xeTsZU1Cyiko2gAsJ5N57aWqb18nch6IU4sxqOzS0vmYL2kqAJSg+mGYLyCdKHEcqP70Soclbg72s6JTZt2mRBkUp+mjLnada5XXVzzvZG6G2WCpwApxNWgc1fSZtyaP8//Bus3ORpUU2ivxLPgy5dCiJWO/Kk7/onSAor2hMIShRvjQamnj7iDe/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261009223027099003)(261022105027099003)(261021123027099003)(261102123227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z0Kx5LcLgJKhzmlJLhTm0qFm6njAekz0f9ERjwKRYP5P6mtXebIxKzQe5cbVr5vaCc/hIKiFu6JaBAvBixdHBzoeI0AHRNgHepqz5aYZ4mkY0FgKRvwH8LisD/NamWEqEOAtjPco6mgcIpQisPQmyrIhlSPGCpAwKw7IHPXjAxIsLE+gd0Qu9kebsBuoT2bXlr5HgQ3dhljkWpCpgDmkPauIpX/dGKr4PAnQ190vjOvrbdtyCivNYYjfdbq122FTgbdRI2Ybri7MnxvBhN3oI57UND0oDu7xB4E7zydWFMDenYF5pPHE9gDEez/6NNkaook5d4jrkkQAhrUx7IOVi2gOR64o6LseQpIhzYd8dKhzsBRLfI+wMONYW3enq7+jyXgSY1AJPY0+xw5FeLMUnL5KGbx++uk5zG7Y9+zDgP4vvS34sPQD+OpiL9o2gMcB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:14.2982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a14223c8-3c1c-40a0-0c7d-08df3bc9f7ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
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

