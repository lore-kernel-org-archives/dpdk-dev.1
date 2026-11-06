Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD122606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=joVWOQL/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17C4742DA1;
	Fri,  6 Nov 2026 06:51:26 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48]) by mails.dpdk.org (Postfix) with ESMTPS id 1F05442DA1
 for <dev@dpdk.org>; Fri,  6 Nov 2026 06:51:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ku+8579UdxQK8Df4pKdnJOKJlWvqNj+QNeEIZTS+pcPCFbxpP+/I61WT1KJMPmUII4t6/gNulj6g4kRICEpwG7fYSwRh9VzIdplLCYV05sobviP7y+KuyUQMQ4ebmMj9+BM6yhkjdidrnqO6m8F+lYXDLGPA61k3f2G2FMjLfJsP5rOhUWeKWUziPcUVXJH5ATDRyfj0NJ3s28C7u4SqMHvuauzOR21I7A5NJ/IFveJ3OD1z8fEdtfaxCLPTL4C0dwR+OIa5JsZrVj1T6bPRkMbfQtt0PPWEIlF1O8Q8q88tdNC1WaFxMbXDhyaKtAcA1W6baZyPDIntRzvY8NgjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86HgpkhCDEpkuttsQqRwdAkQ7k89Fzp7pPl2qV2etN4=;
 b=jQDLCQd8JoVFwc4GnxOfc4QmcJCwpCojbOwbAxKFcxyg9YzkoZIJhrIvARJ78/2NVlVzax6cmojhW91Jr9UTerrxH2qHjCaWsTkCg4JHauxgrcd1WPBmu0AtZSgAskdPy0UdCXH6YWXOzXrAhGLsRh0A2yTrj4+9JFnTm9Ge3W2IfddfaHGpTa+0L6l2kA1i+Q9+10raq8IjWF2MXE6kt3K2ZtZOfcFdnYYNdYcUO8rJblcnE5qwZMZOfE+9LQNWNKzUFQOZbdwWMmq+L5ZJQzaOdEkxCOijT8VuoXZ1hkbGUL1uPWX1sSVDiztVlcIxv9U3tYyQEaGDUwUWOQbP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86HgpkhCDEpkuttsQqRwdAkQ7k89Fzp7pPl2qV2etN4=;
 b=joVWOQL/6cr0FK0TT2z0kI7UV7onPCqj8g5Et+eINPZQKYJ7nmzfvxfgXs57CUtnhGNXGr99qkFZU+lQpx8GAPU55OXweGFv+3gw3Q1Ir7GjKzW8OYzQIEcmj533WxP73vS7+ilflqsSvleO/buQiHwV0/2GplkocNoIgkVVKXY=
Received: from DSSP221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::15) by
 EAYPR12MB999179.namprd12.prod.outlook.com (2603:10b6:303:2bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:51:20 +0000
Received: from CY4PEPF000392D6.namprd03.prod.outlook.com
 (2603:10b6:8:3d5:cafe::57) by DSSP221CA0003.outlook.office365.com
 (2603:10b6:8:3d5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:51:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392D6.mail.protection.outlook.com (10.167.247.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:19 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:16 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v2 07/15] raw/ntb: remove AMD hardware event handling
Date: Fri, 6 Nov 2026 11:20:37 +0530
Message-ID: <20261106055045.720805-8-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D6:EE_|EAYPR12MB999179:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b89ff4b-6edd-49a6-b0b4-08df3bc9fadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|10067099003|22082099003|6133799003|18002099003|56012099006|11063799006|5023799004|261009223027099003|261021121427099003|261021123027099003|261102123227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: yxDKI1IgQIgyV7uXGXKSBtw3flJg/QM4Rh8df0JY8p0JviHWhhtwzv1LLIqg9a22TpqMWE0P4hQnCcXQfgj6xpD1ZTXXwdBLCO5e4djKtopzDmTrBPTXQXEQt2O2Opq2nhqqaFIXP2lC7U57nVytPFErT205g85EZH6+erTRa4fCf3uky2/lXdqvdOKwp0zRQqX1lP2aYCrYuBgyGJUGgeccLNBlD28hn6rKipSDXFvKcT4yeB5Ms/rzLHd2c3H47SHVvATeoCIswRERjo6Su0iUSsRZlEqYzVRNNcksiTDDgenm51MIeDD0ylFhxVOOpFo+3GOMa+jMimGDHwZlc8TQXemxtSVVFKBMVM0/OCjk+V+xlwvfF7guS1EZ/2aZGJCeF58ucDuGyQyiAhgoQnReHqr3HyuhTTj1LKo6WmJUurKeJ6WbZWJrBghnSwAymG+kyruRHoXoW0uA8bXQGVNrDnF9c07P/W4Rvfka7SwPdUbabm12ZUzfAe/pN5wJh+rCSUDaB+bm1iP+Aj1ZKn/YNsQIVk3/aioHEqQINjMJAwnWhyUunjihMGcWofmIgG4ITFyhRCsbkvc3TqzYJ+balKRI1POFm/A3h/3Gwkw4QlXIUVsZYkmTYZZp5kZueG1MFtWbOz271CsrO0YjbqntAjbEuGhFSYdKXEyUj/Kwx8QhQEXle4JeZhxnuzdB6MLX5fDit4JT0Vb5Apv3Iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(6133799003)(18002099003)(56012099006)(11063799006)(5023799004)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /KymXKQ6pwR1W7GwEJO+fkoQVUSKUJxFcO09MAYIcZmHvs0lwDQ1dRSRSoRg86inWf5sw6Rk5o7inyCb1gulVGZ3rZhYSWEA0vGKBSHBH7UDCjIQyXoGEWoK30f1G34/F54kdNoVUyg1DtnMhT32WQAiPR5M/n0TwBlNieLcAw320gTTVycxltyvx8kLy3OW7uG5mCQhPj0hJkr7+BbUF+Ivo36wL0KdCoUb7BP0OhYr9ItGIQs7txUJDvez2jcpgJFRtz/kTndTONUE1JTs9vXIUjblxOTVqznBQeQWBhGw3y1Rxhcngx8x5V/HR5OcjZfcIvLqHHfbBP7miOBv863VrLweQHD1kFa3io5yds47GRUkTLnJcfqs47SGof+hfonU24qlGR+JHuEIM64m0bDe6q3rtsv2gvi3K7+7/mLMF3bAFQUk32myFI14Dq6e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:19.2246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b89ff4b-6edd-49a6-b0b4-08df3bc9fadc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999179
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
index bde17c3c86..bface8d497 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -120,10 +120,6 @@ ntb_dev_intr_handler(void *param)
 
 	/* Clear other received doorbells. */
 	(*hw->ntb_ops->db_clear)(dev, db_bits);
-
-	/* Let the vendor process any hardware-specific events. */
-	if (hw->ntb_ops->handle_hw_event != NULL)
-		(*hw->ntb_ops->handle_hw_event)(dev);
 }
 
 static void
diff --git a/drivers/raw/ntb/ntb.h b/drivers/raw/ntb/ntb.h
index f867f0323d..f9f5bceede 100644
--- a/drivers/raw/ntb/ntb.h
+++ b/drivers/raw/ntb/ntb.h
@@ -105,8 +105,6 @@ enum ntb_spad_idx {
  * @link_cleanup: Tear down the local scratchpad/translation state so the
  * peer can no longer reach local memory.
  * @mem_align: Base-address alignment required for a memory window memzone of a given length.
- * @handle_hw_event: Optional. Process vendor-specific hardware events from
- * the common interrupt handler. May be NULL.
  */
 struct ntb_dev_ops {
 	int (*ntb_dev_init)(const struct rte_rawdev *dev);
@@ -129,7 +127,6 @@ struct ntb_dev_ops {
 	int (*read_peer_config)(const struct rte_rawdev *dev);
 	void (*link_cleanup)(const struct rte_rawdev *dev);
 	uint64_t (*mem_align)(const struct rte_rawdev *dev, uint32_t mw_id, uint64_t mw_len);
-	void (*handle_hw_event)(const struct rte_rawdev *dev);
 };
 
 struct ntb_desc {
diff --git a/drivers/raw/ntb/ntb_hw_amd.c b/drivers/raw/ntb/ntb_hw_amd.c
index 9b274bc6b9..abb923b384 100644
--- a/drivers/raw/ntb/ntb_hw_amd.c
+++ b/drivers/raw/ntb/ntb_hw_amd.c
@@ -441,7 +441,7 @@ static int
 amd_ntb_vector_bind(const struct rte_rawdev *dev __rte_unused, uint8_t intr __rte_unused,
 		uint8_t msix __rte_unused)
 {
-	/* Each doorbell/event maps to its MSI-X vector by default. */
+	/* Each doorbell maps to its MSI-X vector by default. */
 	return 0;
 }
 
@@ -565,45 +565,6 @@ amd_ntb_link_cleanup(const struct rte_rawdev *dev)
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
@@ -630,5 +591,4 @@ const struct ntb_dev_ops amd_ntb_ops = {
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

