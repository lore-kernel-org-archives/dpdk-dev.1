Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D96606A324
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MRjrKlg/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E8D24279B;
	Wed, 11 Nov 2026 08:11:23 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011013.outbound.protection.outlook.com
 [40.93.194.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 3928640E18;
 Wed, 11 Nov 2026 08:11:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmyXmkVBNUzEP+77z0SVw1y873VonMfSJJKx8V25zpbyApAAmeyr7B3oU4FK3GUx2EgblXekrY2/Q7eVtdu0EASeTBCi5GKLuMv4MMsQFVy8cLwj7HTg9xNYs0RC5/Oxkdxdfq0D8yL71eJZV5WIkYIvwHkwM5AIG3lUd1PwVeDBewdxXlEt11rqOFPiDuH8ATSC0rNfhq/lxYNeMGgpNjb9ovM/9z0yGuaM2BSGDFSMOuapZk4+HJlFC+ZDUQtyXUP/cezdwbSvLWvXgmmX53U1p0F+Tj4uFC2skfU+m55CT1RJb4eiipLx7ssOQzQ8I8DdevDgkqou3Atcjnhaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIVCb5Y5kHv5tnUvNDkbkLtDFrM485HjPEC4KWlIOLU=;
 b=j0eHey3s1J+vxdwh9MnXVsCbPWiuH3PnaT58edRv8/mU8L9Txbh35xXmoFgk8wbURO8x17/ce3jVi+tYBnuD+TkvsNy8pErDHyOd08TEVT/aDVP7ERmugwelSwtCL/iZwMTgFFRwp/442Gqhnezw/GfoS6M8kDlnlSyOWyt6AvqEPbrxvtJeuATfmuHMa6GrGp0RO4cDLGGkqm5ePGPAHnxDIgMik75YXtf+qbGwAyw4fNBPNyYWgyo1KHBS8HYIOAp5oEUU2XSzpe1dURpu7Q9HQlqDlm7ujYYEipkcV/5kCa43MxY4LMZAAnH2Vj1+rrhhZLDAD63Q4yYhJNi0lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIVCb5Y5kHv5tnUvNDkbkLtDFrM485HjPEC4KWlIOLU=;
 b=MRjrKlg/fTocTOSnJkroIOBLlv3eBtKu9b6/OYUUcg4gVidivjKfqP0w49Ffs29k1NhLpkFSjt3RvvBbosRFncG1oAUVXBgcp1PAr9JrmBu/i60VlRvCdVLBOMSXk1xuItB9usOT5+7HL97+k6NWBxXuDTztuL+/apUYGODuxZ0=
Received: from MN2PR06CA0001.namprd06.prod.outlook.com (2603:10b6:208:23d::6)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 07:11:09 +0000
Received: from IA0PEPF0000003F.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::5a) by MN2PR06CA0001.outlook.office365.com
 (2603:10b6:208:23d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 07:11:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF0000003F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:03 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:07:24 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v3 08/16] raw/ntb: fix Rx of incomplete packets
Date: Wed, 11 Nov 2026 12:36:42 +0530
Message-ID: <982932a9e5c56e733e37b0fda5f90d0bb0101ef1.1794377833.git.raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003F:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aec2414-cb63-4497-6c8a-08df3fc2f61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|4143699003|56012099006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: TQrLB+cfe2RWSej1glxdF1/SWvaFiFUJqWL4T39ebHhC5VbLl/UaOioE5ZQl8jrt8pRjMu3SZ8zh0oAe9PhzViZznvTIkLwP84MKZijjJvjnzO9qO1oZmGtkCTfxob9D2OztDOfiQgV4qkV0GCkYUWg5Uopob4BNXnwdr/WdYUOi/LrovS3KOIFjwGrUm9nDZjcYxpQyR2JqraquGgqJutYd2N2C/VURMtd9KjuvxgfvYcqoYZwMx2wVHYrq8ftRmH2m08ozy/n7n9MwUHRlsWr2S0mVZZ1RMPSxOl2ORcEZqvRE/pPqvjMQPUefixaQyeqQNnUEE5cTllhl4PTQ0ZvTtt5KRcPDMVcvAV6iWt1SlWpr5NrKGdAo3PKjX2PjLHY4Vg3Q+SkDxv4fK0ASW0+GDBISqBcdOGnmaRpQCErB5Dv+QCF2YkwPee9qqScdpNeAY4eMSB1LY9ulAYh3wtu+9jH2XhU1v/DfuBSP2wNsuZW6/y0i9VuZaAm4eGYB0QIx1wltJrXaL/bScGt3VqRVWWki4BwFtko6/R+xM0PvshucMMKpCFWFaHvUexfISEG8u88ujed3MJQ+Wk9WY/glwHMnjgTWuYr3Ac5dniYjwjVeSNvOSzyp+lTbaYsVGxWV62WmSRGPLPK0Vig9FOYWG+k3UOFwlat5jil4VCyM55lxyYsuRWVIeJ5N8s45kEUy38h2BbAIGYpOWt4Wgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(4143699003)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 51f+e9atWYzHHSRdV0qLls4TWPKDE+8MBTc1oOxAa3TKKLfnule0RcqmEvgnR1RXIDz7M1pbkscuSpm0UWLqQdv0SC8k+Z7ZP1TuJQhv25FscDLeRtxehq0FOUVcN/lqyYlxNdntUdf3/h/YkMPaSoLbbAcre7gblXPhpBRJHreate+B7VuaGW9PAB65gszCXPAE87m+s0VKF/VXiuifjyRbx75e02xEWDPfoHwjcwmK57kdOgLiLw3cetXn0wrCEJxHtbTJEXEFaDjBJiEyiaHuc5nkAr9h4HROs4iraAHHK6AIk169v8+slClFYXJ71PuXNn7ucT8Xc7k3BOwGJAU5k1OGblJTB/lAON0JBA/bU7vhVoXWIGJ87JOFnSJThuKGvHlhKnQgHdrtL5zUvjQ35uFQJgOJTL28og9/mXZSIA5bnC1vVKTZotB+PQxT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:09.4784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aec2414-cb63-4497-6c8a-08df3fc2f61d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094
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

When a packet had no EOP descriptor among the ones walked, or when a
refill mbuf could not be allocated in the middle of a packet, the Rx
burst stopped with the packet partially consumed: the ring indexes had
moved, but the mbuf chain was neither returned nor freed, and the
refilled descriptors were not published to the peer if no packet had
been completed before.

The EOP guard also bounded the walk on the ring size rather than on
the descriptors actually published by the peer.

Only take a packet once all of its descriptors have been published,
and allocate its refill mbufs before consuming it, so that the ring
indexes are only advanced for complete packets.

Fixes: 11b5c7daf019 ("raw/ntb: add enqueue and dequeue functions")
Fixes: 5ce50c234ad1 ("raw/ntb: generalize framework for multiple vendors")
Cc: stable@dpdk.org

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index bface8d497..eb562052d8 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -650,13 +650,14 @@ ntb_dequeue_bufs(struct rte_rawdev *dev,
 	struct ntb_rx_queue *rxq = hw->rx_queues[(size_t)context];
 	struct ntb_rx_entry *sw_ring = rxq->sw_ring;
 	struct ntb_desc rx_desc[NTB_MAX_DESC_SIZE];
-	struct rte_mbuf *first, *rxm_t;
+	struct rte_mbuf *new_mbufs[NTB_MAX_DESC_SIZE];
+	struct rte_mbuf *first = NULL, *rxm_t;
 	struct rte_mbuf *prev = NULL;
 	volatile struct ntb_used *rx_item;
 	uint16_t nb_mbufs = 0;
 	uint16_t nb_rx = 0;
 	uint64_t bytes = 0;
-	uint16_t off, last_avail, used_cnt, used_nb;
+	uint16_t off, last_avail, used_cnt, used_nb, nb_segs;
 	int i;
 
 	if (unlikely(dev->started == 0 || hw->peer_dev_up == 0)) {
@@ -673,13 +674,24 @@ ntb_dequeue_bufs(struct rte_rawdev *dev,
 	used_nb = (used_cnt - rxq->last_used) & (rxq->nb_rx_desc - 1);
 	count = RTE_MIN(count, used_nb);
 	for (nb_rx = 0; nb_rx < count; nb_rx++) {
-		i = 0;
-		while (true) {
-			if (unlikely(nb_mbufs >= rxq->nb_rx_desc)) {
-				NTB_LOG(ERR, "Malformed rx stream (no EOP); "
-					"aborting to avoid desc overflow.");
+		/* Only take a packet once the peer has published all of it. */
+		for (nb_segs = 1; ; nb_segs++) {
+			if (nb_segs > used_nb)
 				goto end_of_rx;
-			}
+			rx_item = rxq->rx_used_ring + ((rxq->last_used + nb_segs - 1) &
+						       (rxq->nb_rx_desc - 1));
+			if (rx_item->flags & NTB_FLAG_EOP)
+				break;
+		}
+
+		/* Get the refill mbufs first so a packet is never partially consumed. */
+		if (unlikely(rte_mbuf_raw_alloc_bulk(rxq->mpool, new_mbufs, nb_segs))) {
+			NTB_LOG(ERR, "recv alloc mbuf failed.");
+			goto end_of_rx;
+		}
+		used_nb -= nb_segs;
+
+		for (i = 0; i < nb_segs; i++) {
 			rx_item = rxq->rx_used_ring + rxq->last_used;
 			rxm_t = sw_ring[rxq->last_used].mbuf;
 			rxm_t->data_len = rx_item->len;
@@ -701,15 +713,9 @@ ntb_dequeue_bufs(struct rte_rawdev *dev,
 			rxq->last_used = (rxq->last_used + 1) &
 					 (rxq->nb_rx_desc - 1);
 
-			/* alloc new mbuf */
-			rxm_t = rte_mbuf_raw_alloc(rxq->mpool);
-			if (unlikely(rxm_t == NULL)) {
-				NTB_LOG(ERR, "recv alloc mbuf failed.");
-				goto end_of_rx;
-			}
+			rxm_t = new_mbufs[i];
 			rxm_t->port = rxq->port_id;
 			sw_ring[rxq->last_avail].mbuf = rxm_t;
-			i++;
 
 			/* fill new desc */
 			rx_desc[nb_mbufs].addr =
@@ -718,9 +724,6 @@ ntb_dequeue_bufs(struct rte_rawdev *dev,
 						  RTE_PKTMBUF_HEADROOM;
 			rxq->last_avail = (rxq->last_avail + 1) &
 					  (rxq->nb_rx_desc - 1);
-
-			if (rx_item->flags & NTB_FLAG_EOP)
-				break;
 		}
 		/* update stats */
 		bytes += first->pkt_len;
-- 
2.34.1

