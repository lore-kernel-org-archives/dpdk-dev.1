Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8A606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sxPOYDe9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D7AA4161A;
	Wed, 11 Nov 2026 08:11:21 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
 by mails.dpdk.org (Postfix) with ESMTPS id 9F7C540E18
 for <dev@dpdk.org>; Wed, 11 Nov 2026 08:11:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feT1p8/BzNenF8CKgTditcWyc7P5GihWs43Fz/f3rnG3lf+vZbdHLBk48wTGqcwDt+d46dISwdP8jTP9r/Srqdtr1YCPikb0SS1565864R3HnSADL3hSK8USvT2Br+sJdyfO2wLWln0iXj+22i0F1Sri1s0d22DOvbFHbTY3Z2CSyepL3LbSSttMvH1yDf+aLMjgJoUGj+oujrxL4qDArhh3ueM5mwiHiApROAUEpW69ac4lxZL9GNEVrUrUjBfeJJtnc6JoaJ/5kMCijvraFQPzPaeb/DgnSMnc9gJZqetjhCV42r3o2Lb21BX/dd2RqmyztKOfpgRkYosBT4ZFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86HgpkhCDEpkuttsQqRwdAkQ7k89Fzp7pPl2qV2etN4=;
 b=s0jx6CcucUlfJ43JFbNWJl2gXqCa03eeOr8FLOUSi8uNx8J+gQwBBdY5j4+wT64XMF+e1s7Kmq2wwXHMwYPwlu9QDc6e9Ac+avPC+/8A9cDJMPwyIqGKpaSeuirq5jND+Hhn8v7FDwJWf5CcSoHdKqhbMi0wqqo6j0bUv1IbCiJOPBAoOzAZcQCinG7DN1VJmBchC3Xi6cSrjt2/LgI5HZGIq+sYW3WbWisTSQI9dRDyPrE9a6Ci/hXv4wTGxrxoitGyFAGwnItJ5ypJyajqZGE3kx6Dzg1I6EDZ0rG9WhUgf0JmKnNxVJVmm4yTZGHE1jOWSqBhW9p0QTAu75C0BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86HgpkhCDEpkuttsQqRwdAkQ7k89Fzp7pPl2qV2etN4=;
 b=sxPOYDe9umx1WL+BrvOy+arDoR9wq1vfzaAb15H3JaSpPqLaFP5BzIaDimrUOOgar0lgDHR+EGpbteERNPYOGBS+O7/gyqeJpfaO/pV2ksIg3YrcvUJBKfpy0N8IbQnlRDAo7YYzoxLhbweSTRs1LT6T6XMnsl8ftHGsUeibt98=
Received: from BY3PR10CA0023.namprd10.prod.outlook.com (2603:10b6:a03:255::28)
 by DS7PR12MB9552.namprd12.prod.outlook.com (2603:10b6:8:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:11:09 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::27) by BY3PR10CA0023.outlook.office365.com
 (2603:10b6:a03:255::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 07:11:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:03 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:07:22 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v3 07/16] raw/ntb: remove AMD hardware event handling
Date: Wed, 11 Nov 2026 12:36:41 +0530
Message-ID: <0ebcd89c0b6d2571afb8a3bca849b03833b98ccb.1794377833.git.raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DS7PR12MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb0cd26-c486-43eb-5172-08df3fc2f63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|261009223027099003|10067099003|261026121527099003|261021123027099003|261021121427099003|261102123227099003|11063799006|5023799004|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IJqvIY2hUf29QAxnlffL7LvX9vM3nbF3WcyqvEVGgNHN0MWAtVLCYzxSxfXQxi3a7VK6PGKzeNWhXmX7GTnoZMPSKQ0dIdRq+Mq+RtCznadP9ZU5XFk3B3vloC0v15iKdNNvG5cts5rqjN4azTrHi9ANXc7SFqNI6tqd/AYYgpeXj361CkUt+qasSpq/WtokfcxS2sx9HiQ6FYcgko7yL64s0tN3eJqjdxtsD9ZwqIcm/AbtFVPcr7wITDNltEI+IhDbKdoEg1LxTAmIv9jnTxUYEZVFeEG1SKwUBbOxtqTX0+sYUVWeLviL+2lBoyzAIJELP4E+aXB3dGm4F1gq+6kpTwA8QsRoQh/zKQgP4plgvTSZBDrUTklWj9D0/5AUsVszPRzF/PlEzQEngR5pVCHNQwvc1wAr9PcbN+EKaQsaXY1qk/eu7vNYx0cwM9pvfyaDzk4p1Dg6b/XSzuEFZwrLPGETGmqdEGKllmF3SIaFaWj0KHvPhhPIag3cpfkHK1h3eRv6d8ICEoWriSEy3LpXizA/pMFpuDEzF1Or70Z9iPY4Xhp2VVlvV2pBPCRmmnkZ0wrU2WavpFjC7weTJ2a3bqe01KeV9mLgqEOkHSaAYtp63rqaCv8Wrt0NbE+XARZnI//gsMuWiFSaEywlCXI1xmUxQVoIxc2guQz5dPYoHrv/qcQvymx6/OnKXyE+lGRcl/TT+orKAM9EqXStNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(261009223027099003)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(5023799004)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PkdwHc6/ln5JwRhim85s7/ZO536jWOi705/Yh4sg42O//44fBMamPXdl9NPEKHdmQL6rAGWl9Lo7VVlcln5RVYUXN3etUkrD43MfxS4lKpamfqJ29Y+31XS/hH2YoAR9x7kTnAyi2vjlnZfzwRrzyFinvgR6RO2BK6wzCUYD1FLXY5Po+Kel6Z2wHcJ4vNHO9hbp0787AnRIiHNkENnhwb6X5dAayNxDjQ49H1r8DDwrzswwBw3kxqcIIWnTTCTimoRp7UuI3xyTEXxaaj/Ptn4I20MjNXsrg9ilb0ycL0ZqE+xzkzvHhnkmFB21ATweRYXy/lnYZJ7pYpTOt/h9chgJXnRX1iPoASeWsBk1U7c0Xn5njPQyP1XS1sDxLdy7zaVpIscYtJlQa8C0SysVsP4Hx64xRA8VPg9d0PVyIlMIECS/RQsT73mwLHklHhCP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:09.6122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb0cd26-c486-43eb-5172-08df3fc2f63e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9552
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

