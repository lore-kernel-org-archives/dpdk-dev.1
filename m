Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90F606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=elQsz+i8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F68340BA3;
	Mon,  9 Nov 2026 17:09:47 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010050.outbound.protection.outlook.com
 [52.101.193.50])
 by mails.dpdk.org (Postfix) with ESMTPS id C85CA40270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:09:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X13Ti7HVru8T8BHzsHp+nosE2yEv1L54QkJPCE38jNJIMIVwpP7cN76UTk7KK33QUIZAimRTX2zbIMqPLcvFT9yTaV5o8+Unc6DfZAACztdC7n8FoEC1e8djReIHAM7HYwaf27AFkjDqKNtdPhJKQ1k6Sbv00SRWf5pPO0p5FwUz41TwnWFIlM1uehgFQlBQy6RaIEO6weNZjU9/zv/etFyw0vDhTQtFyNYKLxtytuwQNUKwVpnjoWqoq7qWNwPJGUKlQQm6Bh52HTIvRn2a8OB+fq0friYFtM/QIydohQGWI/u/Y9ZKc0su/n50wSIDTuNEDMq9hPoviN0UHmZJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxOBUp8/htgCx2RZ0K7anAwVmjzkigCspglkf77Y+jk=;
 b=mCW1okYuxbfCuDcc5FwYEtiQZLtmn1o6W3evN7bKfNkOXDm10wH0fKBJgVVuP3DeFBN6n4vMKkRzb7jnhAGRaEtaMppMM4Mj2nJo4uc+TD/9XNVuSON+jVx2+e9sv0dCsZtGH+lntN8W+F9kpRv4Ri5tOI0xXuC5cy6X+W5g3IW18+K3VjdO7k7UtHx0Jz4Dg6lO3R51xS64/g8TCjt3/eHU6LiFCwgtKJdynVhj+og6toTu8ZGPIiwvxoZCn94ScTuFln1G4DYdaY41u8DLNu72fwJP7litjrF+GPvi9YgxaE9rhu1bT8oJ36MkRaaiFvieyCoO8H02YZdkVhbgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxOBUp8/htgCx2RZ0K7anAwVmjzkigCspglkf77Y+jk=;
 b=elQsz+i8Brsqubz+oBid7kvp/0621MfLqoorfoJWRVf45CL4Y08kniYUSYC9JCKZv3f14M9n27eIUjX37Sz/MJeLRwqgzfWc79cDv/OL9rTGRq4nTT7QOATzJAg7nHdVNPO3fDEmBK/UyRcsIQDrXqKjvi1Kl0yhJhosJj/a1niteq9/AlwE+bUIHSX3KNPGVxEb8mDWQ8CoB7/iHsY4cT1CQINqeRDN9D5BM+WhBrm44uZiV4+qRt9N7/uA0P7CRoEZUdokW9/zzAnIKn1KaLzbf1XJdmunh8Q0h6qRr3NiuoxenHDw5/W5I0peHTWpfdXFH59AP8Gc6WUkCOxmeg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CH3PR03MB7411.namprd03.prod.outlook.com (2603:10b6:610:197::16)
 by DS1PR03MB7942.namprd03.prod.outlook.com (2603:10b6:8:222::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 16:09:42 +0000
Received: from CH3PR03MB7411.namprd03.prod.outlook.com
 ([fe80::66:2169:186c:d088]) by CH3PR03MB7411.namprd03.prod.outlook.com
 ([fe80::66:2169:186c:d088%5]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 16:09:41 +0000
From: "Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com>
To: dev@dpdk.org
Cc: ferruh.yigit@intel.com, stephen@networkplumber.org, rtice@cisco.com,
 cheryl.bansal@altera.com, nanditha.jayarajan@altera.com,
 "Subhransu S. Prusty" <subhransu.sekhar.prusty@altera.com>
Subject: [RFC 2/4] net/mcdma: add Rx and Tx packet burst paths
Date: Tue, 10 Nov 2026 00:09:24 +0800
Message-Id: <20261109160926.800828-3-subhransu.sekhar.prusty@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109160926.800828-1-subhransu.sekhar.prusty@altera.com>
References: <20261109160926.800828-1-subhransu.sekhar.prusty@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::26) To CH3PR03MB7411.namprd03.prod.outlook.com
 (2603:10b6:610:197::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR03MB7411:EE_|DS1PR03MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: b07f6e65-98ee-40a1-f3db-08df3e7bdc98
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|261021121427099003|261022113327099003|261022105027099003|261021123027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|261026121527099003|10067099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 6BYxv9ylzht05eHS2K3nGqpgpWkXsjA4yvntqO4PRPLpwf9oRijCUG4m/DBUcCrljQRbestoiDNxXeO6Bai+Gtt2efG0GSGa9UP7oORvHEGDCqzIuoxmF5JMRiZS3YZHjAjbtYW9+QPm1JXEm7CPyaDYGwlRukEv3SHW9GCLg55RGppMbC7CW39mszGjD2TFlXfxRVh4VHF20fVeCizm6HrHzzJD5XVtTGX8aWXzOmc2P1mMeBTictgjjFiPSHmNn+a0266O4K4I7qEiXq5XVhSeZcIkOw5lJFwsuvM6m7AQMp3UoutWTBNYdfK1xUUbiWaO5zhQGV6yjoQ7Lji9BavSVkyMn12IroFKCa0n4o68Y+5WpIgaGsX5HqM6MjEcLywsTSb1XUTb/rUgc8rSiDD5pADj7K4E8T4aHLNnOiO0Lml+BQj1BJJpMYpTEW4UnaGp27BRGonQNVgRr80PCLJkuLqW4tDoNBQ3TKyyCmjDr8Q2Wxesj6PbiZC7/UjXGzaY0g19PPxmzeOaY/2SokfMN8J/1dT2BqndIaCY51HzRw9KH8Wtfyfg0WjxGS/D2/Ohjh2zsgegICyI78GoUvD2k4D5weOj/MCIifGBqIWTrkPaIQEnkY8s8WNae6fTNWHhG710/dWYitpJroFc2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR03MB7411.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(261021121427099003)(261022113327099003)(261022105027099003)(261021123027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261026121527099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XxUK3lrEkC4s8OpWlvFZhwHNnhwJucQ0YRKU4jY3kjt03GjPIxxjLBLr3HrP?=
 =?us-ascii?Q?iLonav4jZvfVlTKlFbes9L8KlUYjhWYixAB1GL8idvl/yxh6B8bRAg95wt1u?=
 =?us-ascii?Q?Nrfd4kE9R/cgVQqdIeL2sjTTj6BtC3ZsRxqXZRUF04V1AueDAbyPGD8HfZG3?=
 =?us-ascii?Q?xVdVsdb+E1wme4FWnLbLIpaE5lLhwRYW++S0LpJ2oMK6yz+ru5Be8nl5bvFH?=
 =?us-ascii?Q?cdJml+G44+HcbMT9quOuj6MiYFIEPjrlZSQCdvfVQrN99p6CqLrXL2VweQKl?=
 =?us-ascii?Q?xwTCb2Z22XHUde+KDS+yNQ6h86+zKOKbQMP4ho+qhvu1DV2KrZbwc8UhGNz3?=
 =?us-ascii?Q?nMo4rERn5hTrrMhSj8HOs72qpSKBpXG8VrgQi/gXbVVADxHexq7/frEjeDT2?=
 =?us-ascii?Q?P4ZCVfjGnVBef7vg0mxju6NK6tul2sdo3Z72U+zkccpSGyUOgAxr66znlD0D?=
 =?us-ascii?Q?yxt/Jm3eHcBCEEbSx36Rqpp6fF4sZtY1qAMR3sScCViOWPbl6you2/gm9FcL?=
 =?us-ascii?Q?iCaDtMSuWOGmEEAfCz+XLYlkTjRVtdUZjiWO2rkKp5q0ldaEu1XNCFnAg+ES?=
 =?us-ascii?Q?YKIHmzXr8k/W35XUo0iobvtTVjWtOh9igYcFaguXZahUpInhrKcnwYz4IBi+?=
 =?us-ascii?Q?ZJ0c0Q663ScnJ/Bp1/8AqUBxjEogbSnw+5uRwb7gs/dc9XO8T1W3+pz8fl6h?=
 =?us-ascii?Q?tD02LbpqpRdvWz1Xp6/hCAemfebGDjBJRAFExiGAbVWOwWjEqqZlIwzOPUDu?=
 =?us-ascii?Q?jpJCF6WcjOjfZ71FyUqXRm1WXL/vhIsKIO9/viBFFwHE3AUVpGlEhu8Ck6zK?=
 =?us-ascii?Q?T6qyduMz/xR2g4c4rjWPoZrcSSEKsn7WMlU1uRo+35GVrKed0OolD+YUHF/R?=
 =?us-ascii?Q?ZgH64IAv53D0WtHcCqyS5+KBgPqPbzUmgOJIIHGJCe3Fl64NfwobGRLkd7Me?=
 =?us-ascii?Q?a1Az+2HsVsRAiAVbBCOJoyZQC8mtWpqaNCag+zgrF/3f70Hd6yrkcicTCeXv?=
 =?us-ascii?Q?v/ahH35Hgtl0OwdG1OKF+sPaMSE08bRYvMsD9o5OeNtSVcXdZl4DME5eOWcE?=
 =?us-ascii?Q?tkK9egndY0QtA6sEpGuF1CECi4Vs5VwpJU/lx8mx1V/xI4xiC4Oebu9pBvFE?=
 =?us-ascii?Q?zysp8ZdQSF0+jX3+DsIIVktgD+ooWOS4EF61UlmHCArpSbfnyRttKcMdHmWz?=
 =?us-ascii?Q?Q4+sjy9sc+hK1Ip8G03FJADqwuz4Uut6iDiOdSI1kobRqM58KifhxbkMgXaP?=
 =?us-ascii?Q?bhIHjpUR7bHq5KMa2HE8zhaA6YjpNyNjPICGQcLnBgLdN/1Ganf7fUtmQXEh?=
 =?us-ascii?Q?y1Ugi4sWw6YU6rjRQNyufZn1X7tdNJDLhwze0bKvuP95Ll3TWyqPw2ddrId0?=
 =?us-ascii?Q?dg2hI5mbg0XoE/lDhXpYaZbbPGbWPj7w0a07lL0QueKVkEHe4YKUSQjXIDOP?=
 =?us-ascii?Q?IXmZP0UgOaYoRI4l0Xb12ogT4IhJEymZPWKvJb0wRRBwI3D2nVz00Qoqd+vO?=
 =?us-ascii?Q?8QGH0DBn4595SyuFzm3djb56LrwE1IK0itFf9nar82mNvfUam3TjYlcSqVlW?=
 =?us-ascii?Q?/RQFtxqDepOvAAJ4jMjHeDAf/+VH9eyyTo35uLNa/o76Tqo5bAiAihNV6RIO?=
 =?us-ascii?Q?M7fmOqixbOuWYGZ8U+hjZ8fxqQPG97FvKFL4sxjQJ8fwLFoJM9xzyDNfStiM?=
 =?us-ascii?Q?jUgsxdUDjP7WXMEWNzTHUk+SK+Hl/rohm/jlLMF+QC3yY5PaiOjL7imaShKF?=
 =?us-ascii?Q?mFT0hw1xFCmmM3l3FwGf8/Zo4nZVLSCDuWzIEj3D3cXJQkXqD+SC?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07f6e65-98ee-40a1-f3db-08df3e7bdc98
X-MS-Exchange-CrossTenant-AuthSource: CH3PR03MB7411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 16:09:41.8290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irbw+Gs4Fng94lAuVeW7O60lHJA/NSMGK9MrwR6to+hzZ/KCMHWDF1XNfuaJBtCsbgEyhDBifgeNXNuK44JAdWE98lAkk0mp1AAW9NHuz5n03FhC+2Vy0PpKqPCBdyz9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7942
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the datapath burst handlers that drive H2D and D2H descriptor
queues. Tx prepares multi-segment mbuf chains on the software ring,
programs data and link descriptors (including page-boundary links),
updates the QCSR tail pointer, and completes finished requests. Rx
reaps completed descriptors, refills buffers, and delivers mbufs to
the application.

Wire the burst callbacks into the ethdev operations table and build
mcdma_eth_rxtx.c as part of librte_net_mcdma.

Co-developed-by: Cheryl Bansal <cheryl.bansal@altera.com>
Signed-off-by: Cheryl Bansal <cheryl.bansal@altera.com>
Signed-off-by: Subhransu S. Prusty <subhransu.sekhar.prusty@altera.com>
---
 drivers/net/altera/mcdma/mcdma_eth.h      |   2 +
 drivers/net/altera/mcdma/mcdma_eth_ops.c  |   2 +
 drivers/net/altera/mcdma/mcdma_eth_rxtx.c | 401 ++++++++++++++++++++++
 drivers/net/altera/mcdma/meson.build      |   1 +
 4 files changed, 406 insertions(+)
 create mode 100644 drivers/net/altera/mcdma/mcdma_eth_rxtx.c

diff --git a/drivers/net/altera/mcdma/mcdma_eth.h b/drivers/net/altera/mcdma/mcdma_eth.h
index c3b74474c10c..07e5d39aa1f4 100644
--- a/drivers/net/altera/mcdma/mcdma_eth.h
+++ b/drivers/net/altera/mcdma/mcdma_eth.h
@@ -327,6 +327,8 @@ static inline void mcdma_pio_reg_write64(void *pio, uint64_t offset, uint64_t va
 }
 
 void mcdma_ethdev_ops_init(struct rte_eth_dev *dev);
+uint16_t mcdma_xmit_pkts(void *txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+uint16_t mcdma_recv_pkts(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
 int mcdma_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 			struct eth_queue_stats *qstats);
 
diff --git a/drivers/net/altera/mcdma/mcdma_eth_ops.c b/drivers/net/altera/mcdma/mcdma_eth_ops.c
index 8e7624312fe0..ac57eb26531e 100644
--- a/drivers/net/altera/mcdma/mcdma_eth_ops.c
+++ b/drivers/net/altera/mcdma/mcdma_eth_ops.c
@@ -928,4 +928,6 @@ static struct eth_dev_ops mcdma_ethdev_ops = {
 void mcdma_ethdev_ops_init(struct rte_eth_dev *dev)
 {
 	dev->dev_ops = &mcdma_ethdev_ops;
+	dev->rx_pkt_burst = &mcdma_recv_pkts;
+	dev->tx_pkt_burst = &mcdma_xmit_pkts;
 }
diff --git a/drivers/net/altera/mcdma/mcdma_eth_rxtx.c b/drivers/net/altera/mcdma/mcdma_eth_rxtx.c
new file mode 100644
index 000000000000..05c01d7f2150
--- /dev/null
+++ b/drivers/net/altera/mcdma/mcdma_eth_rxtx.c
@@ -0,0 +1,401 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2020-2026 Altera Corporation
+ */
+
+#include <string.h>
+
+#include <rte_malloc.h>
+
+#include "mcdma_eth.h"
+
+static uint16_t mcdma_descq_ring_avail(struct mcdma_queue *q)
+{
+	uint16_t used;
+
+	rte_rmb();
+	used = MCDMA_RING_USED_COUNT(q->prod_didx, q->freed_cons_didx, q->num_descs);
+	if (used >= q->num_descs - 1)
+		return 0;
+
+	/* Reserve one slot to distinguish full from empty. */
+	return q->num_descs - 1 - used;
+}
+
+/* Ring slots consumed by nb_segs data descriptors, including link slots. */
+static uint16_t
+mcdma_desc_slots_for_segs(struct mcdma_queue *q, uint16_t nb_segs)
+{
+	uint16_t prod = MCDMA_NEXT_IDX(mcdma_queue_prod_ring(q), q->num_descs);
+	uint16_t slots = 0;
+	uint16_t i;
+
+	for (i = 0; i < nb_segs; i++) {
+		struct mcdma_desc *d = MCDMA_DESC_PTR(q, prod);
+
+		if (d->link) {
+			slots++;
+			prod = MCDMA_NEXT_IDX(prod, q->num_descs);
+		}
+		slots++;
+		prod = MCDMA_NEXT_IDX(prod, q->num_descs);
+	}
+	return slots;
+}
+
+/*
+ * Link descriptors sit at every page boundary (idx 127, 255, ...).
+ * Jump to each link slot instead of walking every ring position.
+ */
+static uint16_t
+mcdma_desc_segs_for_slots(struct mcdma_queue *q, uint16_t slots)
+{
+	uint16_t prod = MCDMA_NEXT_IDX(mcdma_queue_prod_ring(q), q->num_descs);
+	uint16_t links = 0;
+	uint16_t remaining = slots;
+	uint16_t pos = prod;
+
+	while (remaining > 0) {
+		uint16_t off = pos & (MCDMA_NUM_DESC_PER_PAGE - 1);
+		uint16_t to_link;
+
+		if (off == MCDMA_NUM_DESC_PER_PAGE - 1) {
+			links++;
+			pos = MCDMA_NEXT_IDX(pos, q->num_descs);
+			remaining--;
+			continue;
+		}
+
+		to_link = (MCDMA_NUM_DESC_PER_PAGE - 1) - off;
+		if (remaining <= to_link)
+			break;
+
+		links++;
+		remaining -= to_link + 1;
+		pos = (pos + to_link + 1) % q->num_descs;
+	}
+
+	return slots - links;
+}
+
+static uint16_t mcdma_complete_requests(struct mcdma_queue *q,
+					struct rte_mbuf **pkts, uint16_t nb_pkts,
+					int dir)
+{
+	struct mcdma_desc *d;
+	struct rte_mbuf *mb;
+	uint16_t nb_to_free;
+	uint16_t idx;
+
+	rte_rmb();
+	nb_to_free = MCDMA_RING_USED_COUNT(q->cons_didx,
+				q->freed_cons_didx, q->num_descs);
+
+	if (dir == MCDMA_DIR_H2D) {
+		uint16_t i;
+
+		for (i = 0; i < nb_to_free; i++) {
+			idx = MCDMA_NEXT_IDX(mcdma_queue_freed_ring(q),
+					     q->num_descs);
+			d = MCDMA_DESC_PTR(q, idx);
+			if (!d->link && d->eof && q->sw_ring[idx] != NULL)
+				rte_pktmbuf_free(q->sw_ring[idx]);
+
+			q->sw_ring[idx] = NULL;
+			q->freed_cons_didx = d->didx;
+			if (!d->link)
+				q->complete++;
+		}
+
+	} else {
+		uint16_t nb_returned = 0;
+		uint16_t nb_avail = nb_to_free;
+
+		while (nb_avail > 0) {
+			idx = MCDMA_NEXT_IDX(mcdma_queue_freed_ring(q),
+					     q->num_descs);
+			d = MCDMA_DESC_PTR(q, idx);
+
+			if (d->link) {
+				q->freed_cons_didx = d->didx;
+				nb_avail--;
+				continue;
+			}
+
+			mb = q->sw_ring[idx];
+			/*
+			 * Non-scatter Rx: one buffer holds the full frame.
+			 * Deliver only on EOF with SOF on the same descriptor.
+			 */
+			if (mb != NULL && d->eof && d->sof && !d->desc_invalid &&
+			    nb_returned >= nb_pkts)
+				break;
+
+			q->freed_cons_didx = d->didx;
+			nb_avail--;
+			q->complete++;
+
+			q->sw_ring[idx] = NULL;
+			if (mb == NULL) {
+				q->drop_pkts++;
+				continue;
+			}
+
+			if (!d->eof || !d->sof || d->desc_invalid) {
+				rte_pktmbuf_free(mb);
+				q->drop_pkts++;
+				continue;
+			}
+
+			mb->pkt_len = d->rx_pyld_cnt;
+			rte_pktmbuf_data_len(mb) = d->rx_pyld_cnt;
+
+			pkts[nb_returned++] = mb;
+			q->rx_pkts++;
+			q->rx_bytes += mb->pkt_len;
+		}
+		nb_to_free = nb_returned;
+	}
+
+	rte_wmb();
+
+	/* return number of packets processed */
+	return nb_to_free;
+}
+
+static int mcdma_descq_queue_prepare(struct mcdma_queue *q,
+				     struct rte_mbuf *mb, int dir)
+{
+	struct mcdma_desc *d;
+	uint16_t prod_nxt = MCDMA_NEXT_IDX(mcdma_queue_prod_ring(q), q->num_descs);
+	uint16_t prod_didx = q->prod_didx;
+	uint16_t prod;
+	uint8_t first_desc = 1;
+	struct rte_mbuf *seg = mb;
+	int cnt = 0;
+
+	if (dir == MCDMA_DIR_D2H &&
+	    (mb->nb_segs != 1 || mb->next != NULL)) {
+		PMD_DRV_LOG(ERR,
+			    "Rx queue %u: multi-segment mbuf not supported (nb_segs=%u)",
+			    q->qid, mb->nb_segs);
+		return -EINVAL;
+	}
+
+	for (cnt = 0; cnt < mb->nb_segs; cnt++) {
+		prod = prod_nxt;
+		d = MCDMA_DESC_PTR(q, prod);
+		if (d->link) { /* skip the link desc */
+			q->didx = MCDMA_DIDX_NEXT(q->didx, q->num_descs);
+			d->didx = q->didx;
+			prod = MCDMA_NEXT_IDX(prod, q->num_descs);
+			d = MCDMA_DESC_PTR(q, prod);
+		}
+
+		memset(d, 0, sizeof(*d));
+		if (dir == MCDMA_DIR_D2H) {
+			/* Only ST supported for now */
+			d->dest = rte_pktmbuf_iova(seg);
+			d->len = RTE_MIN(q->rx_seg_len, rte_pktmbuf_tailroom(seg));
+		} else {
+			uint32_t seg_len = rte_pktmbuf_data_len(seg);
+
+			if (seg_len > MCDMA_IP_MAX_FRAME_LEN)
+				seg_len = MCDMA_IP_MAX_FRAME_LEN;
+
+			d->len = seg_len;
+			/* Only ST supported for now */
+			d->src = rte_pktmbuf_iova(seg);
+
+			/* Default sof on the first mbuf and eof on last */
+			if (first_desc) {
+				d->sof = 1;
+				first_desc = 0;
+			}
+			if (seg->next == NULL)
+				d->eof = 1;
+		}
+
+		if (dir == MCDMA_DIR_H2D) {
+			/*
+			 * One sw_ring owner per packet: head mbuf on the EOF
+			 * descriptor so completion frees the whole chain once.
+			 */
+			q->sw_ring[prod] = d->eof ? mb : NULL;
+		} else {
+			q->sw_ring[prod] = seg;
+		}
+		q->didx = MCDMA_DIDX_NEXT(q->didx, q->num_descs);
+		d->didx = q->didx;
+		prod_didx = q->didx;
+		seg = seg->next;
+		prod_nxt = MCDMA_NEXT_IDX(prod, q->num_descs);
+	}
+
+	q->prod_didx = prod_didx;
+
+	return 0;
+}
+
+static void mcdma_descq_queue_submit(struct mcdma_queue *q)
+{
+	uint16_t hw_tail = q->prod_didx;
+	uint16_t hw_submitted = q->submitted_didx;
+	uint16_t prod_ring = mcdma_queue_prod_ring(q);
+	struct mcdma_desc *d = MCDMA_DESC_PTR(q, prod_ring);
+
+	/* Only writeback supported as of now */
+	d->wb_en = MCDMA_COMPL_WB;
+
+	/*
+	 * resubmitting the same tail ptr update indicates no data to transfer,
+	 * So first submit 1 desc and then rest.
+	 */
+	if (hw_tail == hw_submitted) {
+		uint16_t nudge = MCDMA_NEXT_IDX(hw_submitted, q->num_descs);
+		uint32_t count = 0;
+
+		mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_TAIL_POINTER, nudge);
+		do {
+			uint32_t head = mcdma_qcsr_reg_readl(q->qcsr,
+							     MCDMA_QCSR_Q_HEAD_POINTER);
+			volatile uint16_t qhead = mcdma_qcsr_ptr_val(head);
+
+			if (qhead == nudge)
+				break;
+			count++;
+		} while (count < MCDMA_CNT_HEAD_MOVE);
+	}
+
+	rte_wmb();
+	mcdma_qcsr_reg_writel(q->qcsr, MCDMA_QCSR_Q_TAIL_POINTER, hw_tail);
+	q->submitted_didx = hw_tail;
+}
+
+uint16_t mcdma_xmit_pkts(void *txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
+{
+	struct mcdma_queue *q = txq;
+	uint16_t count;
+	uint16_t i;
+
+	mcdma_complete_requests(q, NULL, 0, MCDMA_DIR_H2D);
+
+	for (count = 0; count < nb_pkts; count++) {
+		uint16_t need;
+		uint16_t nb_avail;
+		struct rte_mbuf *mb;
+
+		mb = tx_pkts[count];
+		/* return check not required for H2D */
+
+		if (mb->nb_segs == 0)
+			break;
+
+		need = mcdma_desc_slots_for_segs(q, mb->nb_segs);
+		nb_avail = mcdma_descq_ring_avail(q);
+		if (nb_avail < need)
+			break;
+
+		if (mcdma_descq_queue_prepare(q, mb, MCDMA_DIR_H2D) != 0)
+			break;
+	}
+
+	rte_wmb();
+	if (count)
+		mcdma_descq_queue_submit(q);
+
+	for (i = 0; i < count; i++) {
+		q->tx_pkts++;
+		q->tx_bytes += rte_pktmbuf_pkt_len(tx_pkts[i]);
+	}
+
+	return count;
+}
+
+uint16_t mcdma_recv_pkts(void *rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
+{
+	struct mcdma_queue *q = rxq;
+	struct rte_mbuf *mb;
+	struct rte_mbuf **repl;
+	uint32_t mb_avail;
+	uint16_t cnt, nb_avail, to_submit, can_submit;
+	uint16_t i;
+
+	cnt = mcdma_complete_requests(q, rx_pkts, nb_pkts, MCDMA_DIR_D2H);
+	q->processed_cur = cnt;
+
+	/* 1 - How much ring avail */
+	nb_avail = mcdma_descq_ring_avail(q);
+	if (!nb_avail)
+		return cnt;
+
+	/* 2 - Limit slot scan to 4 descriptor pages per poll (HW/latency bound). */
+	can_submit = mcdma_desc_segs_for_slots(q,
+			RTE_MIN(nb_avail, MCDMA_NUM_DESC_PER_PAGE * 4));
+	if (can_submit < q->burst_size)
+		return cnt;
+
+	to_submit = (can_submit / q->burst_size) * q->burst_size;
+
+	/* 3 - Limit to max mbuf available */
+	mb_avail = rte_mempool_avail_count(q->mb_pool);
+	if (to_submit > mb_avail)
+		to_submit = (mb_avail / q->burst_size) * q->burst_size;
+
+	/* 4 - Support submission only in batches */
+	if (to_submit < q->burst_size)
+		return cnt;
+
+	repl = rte_malloc_socket(NULL, q->burst_size * sizeof(*repl), 0,
+				 q->socket_id);
+	if (repl == NULL) {
+		PMD_DRV_LOG(ERR, "Failed to allocate repl, queue id = %u, burst_size = %u",
+			    q->qid, q->burst_size);
+		return cnt;
+	}
+
+	q->ring_avail = nb_avail;
+	q->ring_to_submit = to_submit;
+
+	while (to_submit > 0) {
+		uint16_t batch = RTE_MIN(to_submit, q->burst_size);
+		int err;
+
+		err = rte_mempool_get_bulk(q->mb_pool, (void **)repl, batch);
+		if (err) {
+			q->rx_nombuf += batch;
+			PMD_DRV_LOG(ERR, "No MBUFS, queue id = %u, nb_avail = %u, batch: %u, "
+				    "mbuf_avail_count = %u, mbuf_in_use_count = %u",
+				    q->qid, nb_avail, batch,
+				    rte_mempool_avail_count(q->mb_pool),
+				    rte_mempool_in_use_count(q->mb_pool));
+			break;
+		}
+
+		for (i = 0; i < batch; i++) {
+			mb = repl[i];
+			rte_pktmbuf_reset(mb);
+			if (mcdma_descq_queue_prepare(q, mb, MCDMA_DIR_D2H) != 0) {
+				rte_mempool_put_bulk(q->mb_pool,
+						     (void **)&repl[i],
+						     batch - i);
+				break;
+			}
+		}
+
+		if (i < batch) {
+			if (i == 0)
+				break;
+			to_submit -= i;
+			break;
+		}
+
+		to_submit -= batch;
+	}
+
+	rte_wmb();
+	if (q->prod_didx != q->submitted_didx)
+		mcdma_descq_queue_submit(q);
+
+	rte_free(repl);
+	return cnt;
+}
diff --git a/drivers/net/altera/mcdma/meson.build b/drivers/net/altera/mcdma/meson.build
index 9195a5d34982..65f442310f07 100644
--- a/drivers/net/altera/mcdma/meson.build
+++ b/drivers/net/altera/mcdma/meson.build
@@ -9,4 +9,5 @@ endif
 sources += files(
         'mcdma_eth.c',
         'mcdma_eth_ops.c',
+        'mcdma_eth_rxtx.c',
 )
-- 
2.34.1

