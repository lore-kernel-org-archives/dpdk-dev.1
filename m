Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7877F606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h791w55K
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C5EE40B9E;
	Wed,  4 Nov 2026 12:20:48 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
 by mails.dpdk.org (Postfix) with ESMTPS id D7DA840A6D;
 Wed,  4 Nov 2026 12:20:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnDl+8ZnX0dYhboe3rLCUcdIMlvUmuRmg53h3jEI5TMQ1IuZObco8kimswM4XHsHlO3/pGL23hFpoaO6e1S1QYJOkx/sENxdJW8Igf1q1pvU6dKVwzRjqvrrkgDwkhj5VCQy9gqcq8cdTlmYPtUcJmPpEoPKh/T90w9sJ5KvZrTCWkVBoPC4Er+xb9G2q2gVi9ZzmgXRIXL9LN/8wolDpJZ5Xj3rmj2EaUW5s477aCmZ1Oz0nx1BGY9VpD3NJUtpeE93B/ga1C7VDLyes7HUm9T5/2wcnffGyLVDyW0wnXKb4yRXZAZcVO8993oxu115WdYQ8UcDaQuCVowsgXOPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rmRcba5v9YQmMWMQH1hi4OaZlu4jZYL/1XyfuwWvMQ=;
 b=dXkmyaL+F5HCE0KVtH3AnT3pji1znw8uK0WLczwUj+h3s6+TKBTsjykrKZW3V0j4F+tCTxhbXV0DwnGN32JFWiz47dPVE96Ig5pjKxU0o/ED1kKCEIJHEtRwMIfT8q36PaLrhJZOwYZk8VxkAotAOU5uCOLJUGYgoSXrnnrXF32HJmGlqzTg6n5QrDLaXu+tuE+j/SZNdTXPqZhKSiXUcNbRG72FkAHHNuWULmnd2Zc2rR3c9q6hh7RFpL3ES0o0QJKMvGE4YbENL1PhMLOt8I52lboGcaKPDhhZOkGA4er7lT2A3StUToXloSLZpV5/c362YZr/owe7T5b+ais41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rmRcba5v9YQmMWMQH1hi4OaZlu4jZYL/1XyfuwWvMQ=;
 b=h791w55KGmFNdYU0Caw/hw9MvZRBwYeI/r4e70YDtQjkFhCSDNyLbd7SH8bv0SqcYuspZ3SiL0NcnCaQ85hhhaonMnTL6f+mRkKqB4/b8AjtwpxHzv8ECJXdrAgpQSrgzwnwg1MvLUsLNJEWcr+m6kbRlD/1LNGynHpKJgvzYD0=
Received: from CH0PR03CA0435.namprd03.prod.outlook.com (2603:10b6:610:10e::9)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 11:20:41 +0000
Received: from BN3PEPF00022BC4.namprd05.prod.outlook.com
 (2603:10b6:610:10e:cafe::31) by CH0PR03CA0435.outlook.office365.com
 (2603:10b6:610:10e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:20:41 +0000
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
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:41 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:38 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>, <stable@dpdk.org>
Subject: [PATCH 08/13] raw/ntb: fix Rx of incomplete packets
Date: Wed, 4 Nov 2026 16:49:56 +0530
Message-ID: <20261104112001.661769-9-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC4:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: a97a8b04-2020-483f-372a-08df3a65a922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261022105027099003|261102123227099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: yZMQuPlbkMc4ipY3hXblhPYEv6gV99UPk9FwMl2tgewV5Irc0qJMCSq0AZVKozDPRFq7FxkNn16xw0vmUcoEukwd0/Hc/ebW0dh4yCAL+OpOpDn8V+R/zifrCWHm5roMxZAoPKwqbbb7VfTkfIfDF4/HofYyn3/BrGV3TR3rKo5Q5hdCELFUikvUSN+HbQfEymr2uC7a1IFyRhw3RTb2klGxexAfZtZ8/THN9almF7GueUzzNEib8DpzezZhNvHQXGCE0tdt0r1iZNJLjifX3ijeO/0M65MaULiYcETVNmva3DrkZr7Jma5u9rXqsMLkvBtoPEP1rluF+9EVOw4WoMj9hMZP5HYN2I6cgTiDNIcAUMreBdy7OBdvBfjoDvpZ/82M+UKJbf7UzsbYh5+1Z2b5myUhREI836ogHDyuaK8ihZRWcyhYDMWXESFMwsgZKr3WNoTYv4e3FqNpME/Sdrkp7EfehlN+PNN5693/4msNWKEzzRGSncH2SgirIaxBfX5EWmrB4L91/VYurw2sfBBwb/7ZqqojjKLXghzfKzannOVUt0q0ZTZALROnHlL10JILg1KZGljvLhmNjEGRSMMVezqeb9DLLgSaSTs8VDUGXJq1l3wK7EnMOpk6vA68LRIGbIaEzFYHdIQs6f9fXCGWgHKDXf9LThQHe2nHNX5g85AiDFnRd3VlQwkkT/ISfvMsujJIVsuxyeYqPaq2hA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X/dX6HZY4YmQUKYCcMcQw8+amYoRmlNimbug/xNEcm/H0gOBXKDmbFNJ+3lhNNpwVRSbeNzcKghM87GBeQm9SD6AW17l+2JPbauJeh7uj1b3SLroQX8O5zyQdwoIbg4BocE2e+dKRYP5scDYPjAg3/ZHlKF5GZG/VOlX1YA+6oPEK71KQSdp2/jL9r3QAUlYM86A3j/yqEwZwOiX1JSJHDRQ02OO+Ib3gQRmq2NmzqUsPUjTyx16gPKp9R3uy27N+rJK5l9MDz04/yN/dF3KIlxyc9A9hsrrSG/ncH+ndXBfjT6LAiyI0jP45DVsV7LhRoCW9ny0IM43ko7yX8pgR6lcbnUsS6zA0LyWhmrrcd68BIApF0U6mto7KUYAKv9IDY1tV0Edq8j77vIWU9Y2zRSHh3oaWxdPttwiMSagktfp0AaPp3Wxv6svVnxzBLbJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:41.3157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a97a8b04-2020-483f-372a-08df3a65a922
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597
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
index d514ed669f..87a35c796c 100644
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

