Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148B606A335
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pBImE+mb
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CE95427AC;
	Wed,  4 Nov 2026 12:20:50 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011035.outbound.protection.outlook.com
 [40.93.194.35]) by mails.dpdk.org (Postfix) with ESMTPS id 8831040DF5
 for <dev@dpdk.org>; Wed,  4 Nov 2026 12:20:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmMOGtRvRPFUkXRYhVegK+51i7chp/85s1wQLMjbDKwl4qi3DqwQVYUinpSXCLtFwkcghSkqvPzwBPwNayXx4QpKyt23BqPdmi2xjVt4Ot1Yftah884o539yl/1OF0z2tRvpoUzGvPSbD0CQ1lUcIdBqXNm8ZDKfy29w9XzvA6tNTyegFmEN18KAxqiNo6Lx5N0Mecj2u3Elr9ySln0tNhrg1y8rjkwntOWsg2dcqtK6Wanpp/ArIJXjNf62+3kMlr9iUi3nlCz4/cgVex3KmEXhXjJ6Dh3vr34NsTS94o/GzmaXBoJEkZg4Wgfa+IAqaFRr0WSMCa+6LQd0cyhvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HghoHGqNqB/Ud0mWoRhFDcR5YdOc1HNHvzbB/8ktk4=;
 b=Zj9aCQKKiJWC9cRcLpikSc1MjIps3K5G3qB6HdG+Q2vymr5ea3RPnDpMhFfYfWahCIrwRcQu6p0PnCY8YNIw6gh0MSTkbMN1qRsAWjhLNa792ayyHXEAHngu+vWP5KkVT4ag05PfYM33124bHsBhDAF3Rqiv6cZgsbk6fdpToBA4yV6pHr3UOlScuhhz8IEhFq8YhjvxvVaYwHn73nRiWZiocfA3VFl4OylVB7YJHDRy1so/CDdjVBSKvf//rzAWMWpnjv0EjJiFydfCOkC9/BlJTlxH+y7UDHhdfJxsRjtAb7+PR8k45Sk02v3CTSFiB3cilq5im7xxdqka/Q8gMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HghoHGqNqB/Ud0mWoRhFDcR5YdOc1HNHvzbB/8ktk4=;
 b=pBImE+mbMjelbUsjF5lSmNG/O6O1xnDDUGa++Q4bLpqNAK6TuzTRC5OruQydrFfxcli+R3QJ2GPqHg5NSdFK/QaA07wFsVjYpBeOH/XV0X4a2vSReAuf2mp2KXrCtyv9lMC7b9ut/GbUryRVbkTt4+XfjRvGt0cNFk5aTo8GkBk=
Received: from CH0PR03CA0444.namprd03.prod.outlook.com (2603:10b6:610:10e::12)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 11:20:40 +0000
Received: from BN3PEPF00022BC4.namprd05.prod.outlook.com
 (2603:10b6:610:10e:cafe::42) by CH0PR03CA0444.outlook.office365.com
 (2603:10b6:610:10e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:20:40 +0000
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
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:40 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:35 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
Subject: [PATCH 07/13] raw/ntb: remove AMD hardware event handling
Date: Wed, 4 Nov 2026 16:49:55 +0530
Message-ID: <20261104112001.661769-8-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC4:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: aab3a943-f6c8-4d14-909c-08df3a65a8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|10067099003|261102123227099003|22082099003|18002099003|56012099006|5023799004|11063799006|261026121527099003|261021121427099003|261009223027099003|260925021311599003|261021123027099003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: 36RupF2YtQcuZU1AO33p77H22BW2suRnW2JtTWE6ymHBX9r3tMTy/4VSSz/josIRNgba1TygFzm7inHEZFsZXz+bblAbSG6OZ59vB9F09WEQ8anDQ/l8mqNQUtMqgEcTJZx8ibKfoaWnkN9TFH4gMdwYLRpCByucr8xVyla7cw1AwbqCvmV5jI3/0dbEqDaCi6rp2d7EHx5DrL+HyAsl1t0NbZZ7Y6MB0MZPVwXmDa7taw18fDrqDJSgefuPRu/g+VQFDH0n7swkI+W9hs67FwdpAdmWmyzqkiFPmTLPHAqQ/oBht3phhKYlTnxsXHPOOg4frq7TsQUr0W/7ulhlOett7unrPzJXGEeFuPvAPCJRuJ4Q4dwqZq87HX7yXp++R8QlnfLSaq3rcd/h2kHOXeHWZmxUi49PMSICNBSTZWvSEPOPrrj9Xb+G9hjqMS/6d/vRK338tQjc3zPXNtVlqc6a9GLHh66pA9Qd4WfgI9S4Za4WhPJMQ/4S2Ibu6kennulsjkNk2c4w3Dh4s5jQG6Y2YKts80+WBwuBOK0moe7APKLz5QPIO1CNmocNhN/ZR0KJTWlV368PqUr9Tf17Ji8KZ+Pg7TuG874+yEKNcuYXAhDhZNL6A+vphYHxN8y8GCUWogEAOCbVjY9ven8N5JX0BjcG86vnkd7Q7SB9KLeDwfmNRAfBt8rM4dvFfyxBWy+vAQwcy135XBdmTVxmBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(261102123227099003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(261026121527099003)(261021121427099003)(261009223027099003)(260925021311599003)(261021123027099003)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZLt69ixun6GI/J28S8zYoi4YYqg9zjsfW7em9PgLTRepJoL7bMvoefwQE1Vd94h9e7o91BDFVqOpnumWbanLdVE8g3L27mwLmZB6gMI8+xXet0DH0LY3FP/lvj8AOqRj2JBxdKyAUpATSgDP20myjg7+XvaAgCgTZlIO76jm5kJ+9HwjfqJs6GfxWZETzI3+trrN3bEHapxYNsc2l/I2ONVmg3uWqqSGjTGrKNEvjT6lh90eRPWZJ8mi/GCCW6hZLsPAXf+JR51mhIKy8403GnvVXUhRdaFqz/SX+7/QB6RIGfT8P9HCbUnQeE5okUa1j54j3D6jXwGzDZYxEHnmKRdcd8SdfnjIdi0VSvR2pY/0wQw6TtGvj5FOB9spLcbpWoYfPFTnIxZzZUxLZJg+6DRXGLzfKZDTkEklfjfcNzCsPaJrRmLDMh8bBoKp6k5W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:40.6625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab3a943-f6c8-4d14-909c-08df3a65a8be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
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

The AMD hardware event handler could never run: the event interrupts
were never unmasked, their MSI-X vectors were never enabled and the
handler was only reached when no known doorbell was pending.
It also mishandled several simultaneous events and never cleared
the interrupt status.

Remove it, together with the now unused vendor operation and
register definitions, and document that hardware events are not
handled.

Fixes: d6dc5a7f8b06 ("raw/ntb: support AMD NTB")

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 doc/guides/rawdevs/ntb.rst   |  4 ++++
 drivers/raw/ntb/ntb.c        |  4 ----
 drivers/raw/ntb/ntb.h        |  3 ---
 drivers/raw/ntb/ntb_hw_amd.c | 42 +-----------------------------------
 drivers/raw/ntb/ntb_hw_amd.h | 21 ------------------
 5 files changed, 5 insertions(+), 69 deletions(-)

diff --git a/doc/guides/rawdevs/ntb.rst b/doc/guides/rawdevs/ntb.rst
index 37328cd9e6..c4ad2f05c4 100644
--- a/doc/guides/rawdevs/ntb.rst
+++ b/doc/guides/rawdevs/ntb.rst
@@ -53,6 +53,10 @@ The AMD NTB hardware exposes two memory windows (BAR23 and BAR45),
 The scratchpad bank is split into two disjoint 8-register sets, one owned by each side,
 so the driver uses a packed handshake layout that fits within 8 registers.
 
+The AMD NTB hardware events (link up/down, peer reset, power state changes)
+are not handled: a peer going away is only detected through the doorbell
+handshake done when the peer device is stopped.
+
 The AMD NTB uses an outbound translation window:
 a write to a memory window offset is forwarded to ``(base | offset)`` in the peer's memory
 rather than ``(base + offset)``.
diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index a1993121dd..d514ed669f 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -119,10 +119,6 @@ ntb_dev_intr_handler(void *param)
 
 	/* Clear other received doorbells. */
 	(*hw->ntb_ops->db_clear)(dev, db_bits);
-
-	/* Let the vendor process any hardware-specific events. */
-	if (hw->ntb_ops->handle_hw_event != NULL)
-		(*hw->ntb_ops->handle_hw_event)(dev);
 }
 
 static void
diff --git a/drivers/raw/ntb/ntb.h b/drivers/raw/ntb/ntb.h
index 2787883160..2434997e84 100644
--- a/drivers/raw/ntb/ntb.h
+++ b/drivers/raw/ntb/ntb.h
@@ -102,8 +102,6 @@ enum ntb_spad_idx {
  * @link_cleanup: Tear down the local scratchpad/translation state so the
  * peer can no longer reach local memory.
  * @mem_align: Base-address alignment required for a memory window memzone of a given length.
- * @handle_hw_event: Optional. Process vendor-specific hardware events from
- * the common interrupt handler. May be NULL.
  */
 struct ntb_dev_ops {
 	int (*ntb_dev_init)(const struct rte_rawdev *dev);
@@ -126,7 +124,6 @@ struct ntb_dev_ops {
 	int (*read_peer_config)(const struct rte_rawdev *dev);
 	void (*link_cleanup)(const struct rte_rawdev *dev);
 	uint64_t (*mem_align)(const struct rte_rawdev *dev, uint32_t mw_id, uint64_t mw_len);
-	void (*handle_hw_event)(const struct rte_rawdev *dev);
 };
 
 struct ntb_desc {
diff --git a/drivers/raw/ntb/ntb_hw_amd.c b/drivers/raw/ntb/ntb_hw_amd.c
index 64075501c2..47e4979619 100644
--- a/drivers/raw/ntb/ntb_hw_amd.c
+++ b/drivers/raw/ntb/ntb_hw_amd.c
@@ -445,7 +445,7 @@ static int
 amd_ntb_vector_bind(const struct rte_rawdev *dev __rte_unused, uint8_t intr __rte_unused,
 		uint8_t msix __rte_unused)
 {
-	/* Each doorbell/event maps to its MSI-X vector by default. */
+	/* Each doorbell maps to its MSI-X vector by default. */
 	return 0;
 }
 
@@ -569,45 +569,6 @@ amd_ntb_link_cleanup(const struct rte_rawdev *dev)
 		amd_ntb_mw_set_trans(dev, i, 0, 0);
 }
 
-/* Handle link/power-management events and acknowledge the SMU. Invoked from
- * the common interrupt handler when no inter-device doorbell is pending.
- */
-static void
-amd_ntb_handle_hw_event(const struct rte_rawdev *dev)
-{
-	struct ntb_hw *ntb = dev->dev_private;
-	uint32_t event, ack;
-
-	event = rte_read32((char *)ntb->hw_addr + AMD_INTSTAT_OFFSET);
-	event &= AMD_EVENT_INTMASK;
-	if (event == 0)
-		return;
-
-	switch (event) {
-	case AMD_PEER_FLUSH_EVENT:
-		NTB_LOG(INFO, "Peer flush event.");
-		break;
-	case AMD_PEER_D0_EVENT:
-		ack = rte_read32((char *)ntb->hw_addr + AMD_PMESTAT_OFFSET);
-		if (ack & 0x1)
-			NTB_LOG(INFO, "D0 wakeup completed for NTB.");
-		/* fall through to ack the SMU */
-		/* Falls through. */
-	case AMD_PEER_RESET_EVENT:
-	case AMD_LINK_DOWN_EVENT:
-	case AMD_PEER_D3_EVENT:
-	case AMD_PEER_PMETO_EVENT:
-	case AMD_LINK_UP_EVENT:
-		ack = rte_read32((char *)ntb->hw_addr + AMD_SMUACK_OFFSET);
-		ack |= event;
-		rte_write32(ack, (char *)ntb->hw_addr + AMD_SMUACK_OFFSET);
-		break;
-	default:
-		NTB_LOG(ERR, "Unknown interrupt event 0x%" PRIx32, event);
-		break;
-	}
-}
-
 static uint64_t
 amd_ntb_get_mem_align(const struct rte_rawdev *dev __rte_unused, uint32_t mw_id __rte_unused,
 		uint64_t mw_len)
@@ -634,5 +595,4 @@ const struct ntb_dev_ops amd_ntb_ops = {
 	.read_peer_config	= amd_ntb_read_peer_config,
 	.link_cleanup		= amd_ntb_link_cleanup,
 	.mem_align		= amd_ntb_get_mem_align,
-	.handle_hw_event	= amd_ntb_handle_hw_event,
 };
diff --git a/drivers/raw/ntb/ntb_hw_amd.h b/drivers/raw/ntb/ntb_hw_amd.h
index b03aed7d08..8fffa24348 100644
--- a/drivers/raw/ntb/ntb_hw_amd.h
+++ b/drivers/raw/ntb/ntb_hw_amd.h
@@ -16,7 +16,6 @@
 #define AMD_MW_COUNT			2
 #define AMD_DB_COUNT			16
 #define AMD_SPAD_COUNT			16
-#define AMD_MSIX_VECTOR_COUNT		24
 
 /* Peer register window: peer register = primary offset + 0x400. */
 #define AMD_PEER_OFFSET			0x400
@@ -37,10 +36,6 @@
 #define AMD_DBREQ_OFFSET		0x454	/* Doorbell request. */
 #define AMD_DBMASK_OFFSET		0x45C	/* Doorbell mask. */
 #define AMD_DBSTAT_OFFSET		0x460	/* Doorbell status. */
-#define AMD_INTMASK_OFFSET		0x470	/* Interrupt mask. */
-#define AMD_INTSTAT_OFFSET		0x474	/* Interrupt status. */
-#define AMD_PMESTAT_OFFSET		0x480	/* PME status. */
-#define AMD_SMUACK_OFFSET		0x4A0	/* SMU control (PSMU_ACK). */
 
 /* Link Status Register (0x408) bits, spec Table 5. */
 #define AMD_SIDE_MASK			(1 << 0) /* 0: primary, 1: secondary. */
@@ -50,22 +45,6 @@
 #define AMD_SMM_REG_CTL			(1 << 20)
 #define AMD_PMM_REG_CTL			(1 << 21)
 
-/* Interrupt Status/Mask event bits, spec Table 7. */
-#define AMD_PEER_FLUSH_EVENT		(1 << 0)
-#define AMD_PEER_RESET_EVENT		(1 << 1)
-#define AMD_PEER_D3_EVENT		(1 << 2)
-#define AMD_PEER_PMETO_EVENT		(1 << 3)
-#define AMD_PEER_D0_EVENT		(1 << 4)
-#define AMD_LINK_UP_EVENT		(1 << 5)
-#define AMD_LINK_DOWN_EVENT		(1 << 6)
-#define AMD_EVENT_INTMASK		(AMD_PEER_FLUSH_EVENT | \
-					 AMD_PEER_RESET_EVENT | \
-					 AMD_PEER_D3_EVENT | \
-					 AMD_PEER_PMETO_EVENT | \
-					 AMD_PEER_D0_EVENT | \
-					 AMD_LINK_UP_EVENT | \
-					 AMD_LINK_DOWN_EVENT)
-
 /* PCIe link status decoding (link speed/width). */
 #define AMD_LNK_STA_SPEED_MASK		0x000f
 #define AMD_LNK_STA_WIDTH_MASK		0x03f0
-- 
2.34.1

