Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E5606A328
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=B1UcNxZB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0235142D0B;
	Fri,  6 Nov 2026 06:51:31 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011041.outbound.protection.outlook.com
 [40.93.194.41])
 by mails.dpdk.org (Postfix) with ESMTPS id BAB8942DA6;
 Fri,  6 Nov 2026 06:51:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0Fh23SyyF+KeHUVRF3wSayJLbvM3TU5Lf7COXZtIfwddsWvUYu9lKPxHxfDMPafnktGKyyZv9+5Eu/gXhFZ8SWbA/9fKjargmyIoewf8yHNubIjelctjBCFvslhEjeWQbTb80UAUAcX69EQ1MWWvyhBpoBLG7t150x5QYw6tMIvqQDAJh03nPoG1aFZmGbpX6FNGVMqDHChLHIfzqz7LDelyKxOtgZ7vgs4uFv8p78PrX1tePZaxyOyCHyYuKticcioAi3+Ix0OTWibGIFLCZXl5YLl6axzia4KQF0/sFsHRbWkoz9a5+QrqLsp18PDbXE40he0Sj8i+0Es2wHJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIVCb5Y5kHv5tnUvNDkbkLtDFrM485HjPEC4KWlIOLU=;
 b=tWbEfa3aeegRjES1dYBgulWTieKLaSyS8Qrny+k3pKxvcL12+c2ZQexSkQxWCnfIMDsokOWP/SfBfh66HrygQhhGVzRFoYXqm3JuNjBrVOpqP+9jkvNrXNJpgUzVIlQUs8bqQ+MPQZ1sj6M9ZT5hyzWHbv2P6dEO/iL6qi8zZA5gZGFZsO4NdrLJIB3XdVacnOHvtosbBrCjTBCiaDLi+ZpBwWgwvuEA2+IBKW7rZUGH9mqHDFHX1B8ybes9ykdHM1+o6iNJi3dz3lM3J60yLj9G2JZtl3gLxdSym30j47r5fv5ev5kDf1w8kG/AWoEbhB6HbnI0FDtNNIf4NBAJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIVCb5Y5kHv5tnUvNDkbkLtDFrM485HjPEC4KWlIOLU=;
 b=B1UcNxZBmZrFhoaBMRCcP3i93bTHLjqAbm82YwTW8JW2wAH4nLLQY1eKifftu9groVtxnIhhN0wfgtIdoNFGhpra0QVPsGYJAXd4i4dmyqBbColr8uQd4nEkK1KrKQPNgfWm/swT+K6P5jIFCiUZ933d7TM4o6bEqFKcVhJus8o=
Received: from CYXPR02CA0069.namprd02.prod.outlook.com (2603:10b6:930:cd::14)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 05:51:22 +0000
Received: from CY4PEPF000392DA.namprd03.prod.outlook.com
 (2603:10b6:930:cd:cafe::8) by CYXPR02CA0069.outlook.office365.com
 (2603:10b6:930:cd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:51:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DA.mail.protection.outlook.com (10.167.247.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:21 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:19 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v2 08/15] raw/ntb: fix Rx of incomplete packets
Date: Fri, 6 Nov 2026 11:20:38 +0530
Message-ID: <20261106055045.720805-9-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DA:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: e08256b4-a76e-458d-30fa-08df3bc9fc75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261021123027099003|11063799006|261026140227099003|261009223027099003|261028144727099003|261021121427099003|261026121527099003|56012099006|261022105027099003|10067099003|18002099003|261102123227099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Kh+i8DzzZbZvyB7f9SMDzdxlX6HlNvCdQtr1LYUsgv/VoplY16XMNa9GqQT/PZL0UXnkLP3PmYvVnuhk6FsvV45LshyhlJDL1pMU6X2f8Kns0LwxGhW/5p3GYl9c9spwiyL/Zy1E4XMENA9eTkX28eh4tPgMm9LiLmBhKv2zLWlGO2WRQBKcZ5hOjC2CyiilCRbI2TSh71bw84uFHeX6ACaB6o//BQHnLrD5G/4ln9tXkrtJsXQ/9nfbidtGjDpjavge1GOM90sk8M002/aeW6gIEfMKE9TdPEW56C+1SkV5agDkE6KF4nzH5gTI0DyqowXTna40qMsWjWWHos8iW7kWA4MYL+7qj68QFEPcY7tAep1tMp6ym5dNGOxCEMWUYjGXXih0Ipre8qRF+dHFhekzT0KtLu/skyezk1rEJIM0MsfnDzlanwdvH2aFlBe8lj5GuusxoR4R4G/t4SxiUIO2nn/iLAWJr2cNzPhp0OSOeQG/Nim/ezDQfygtyI2gFGFaWNi9aZmjq8PKqRniM4md2eiqnPH4jrSwPyC5wepw42kwOlBKAP6pBS4XTTAJQ66voSeBaLGojXmnzioYaBdbYJq7Dfdja71VyCPaoIqqmdAO3Q5hh11Btl1cIWK2HasM4OtljNtoBzEwQSQk8R56+TgVj5s3+v1rzbx4rzO9NWmmgfBlFpTzrw/C+W3m0FrQtp6J7CYzA8dCcDchjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261021123027099003)(11063799006)(261026140227099003)(261009223027099003)(261028144727099003)(261021121427099003)(261026121527099003)(56012099006)(261022105027099003)(10067099003)(18002099003)(261102123227099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: voyCevdR7yiylZTt54uzQq4aVGyaqGy/ei9ywFevzzgdniSZHWFMFys4xllZxtG8je5M1y3+eAl/qWeZWqvoQu/hzuGXseVy8E7GkNBBIfiNSPzY8EDrR5vOkBEWOdU83mmxA77vwUROgNWXJ1+Q6dfE932KzN5clEce4+mkP+dh7sTIAuFSLjsWCjhHAGji5ud0BrADTrakkqFdRak96P+iWrn00YMZntuXOoIaT956TtjhY3WjMBVemptgKQUX9gxLapM1LmtBoIRnGFN0L4ijAxWmRPQPMmEGhVWD2CSchZBfub7FUiNlhONikel5sUMax2514jtlHJ/bvijyX4AHz6wdxztnXR5D1hoyDrIwBo6G3z2EMG/IdX73HYZDjpKKIfHPfGEx2nzOMLTHcL7z7Ttna4NnCS5qXF0vgjaE0zknWUUPiPlH7KDZ3j7C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:21.9017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e08256b4-a76e-458d-30fa-08df3bc9fc75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933
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

