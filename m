Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471C9F54AD7
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 952E740A67;
	Tue, 24 Mar 2026 17:14:40 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
 by mails.dpdk.org (Postfix) with ESMTP id D3111402BE;
 Tue, 24 Mar 2026 17:14:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhUnmhQdNdaHImUDJdlGEV36Q+UVwAra1L+zhJT2dVpcslM8SkzPOcFIhLEJUnBA0/go5CaFdOiti5+Ts5Y/rpGpzUTuFAPgFsfdRYiM7ci79EJmdRGZ7BqC6crf6j1MOHTWErFrTxvOGOY+pk24HYDZa4zcz/WLuy3n1ZRNJCmyccEgxwHWD0J9+UJKWzkBrMy01Z+tLajleSbQeHt9aTJGTrDcgRXo15a/AdCgsxGuZ73vKfdxX0LTFOU9g/vkWnNxhpCD8wunaqPxPxVYvokzZlX+DCt3Rt1uAZY568qW+R3pzgZ/WOPN0K6joQHyo85LjsR8EXmtSTvNvuKx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=742PeR08YGARpHQaY1achrfV/A7m83kpEm5Fx/SqJFU=;
 b=MPtjjeMZ9zuXrnUaK0OyO5p3xYRmyzjzgq/wiAPU8lrDnqp/So+pb3ncmByMVETuwWYTB5w7Z+ReH3SZFB1xx5vhIRyVYuDEvn4agh16SUaTaeU4qzHt/sMVi8H/6/Hm6sGp15BUT036LOELugXteWQ1ZUsABq0GznH8joi50mqMzvsWL7IMY7YryikT1MsutLsM6qf1RZMa1uOaHtdZRTKN2jj5onZX6JOg/dAt8UXrrpliVo6p55xdhPbRXlrIIE3VFVZRDkHxGR6T8XaXAcsJzfIfMOBSBMQu596rC3n2TNNlAxs+10G+8Li2R+nnacYLZ6ElxzY1xCSbYCg1Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=742PeR08YGARpHQaY1achrfV/A7m83kpEm5Fx/SqJFU=;
 b=tihM781VcO6z6n3BZ0pwJ8YO/jnkbrzKmlETxHDcy0oY00e9kKrKDv9DiBk6trKNO9WDbKEDHrHrhHuo1diNOcDovF9ksTdrFssswLOwM88uSH12x/xdjJ89s4HvwvOmQzmihp6JMY6ZMn24YwGCVz+9lnCIQf3/OA5OTVJ87wEP0CfvzSZ8D7AMPu3JF+I4vNsEr5uJamx1sd2xtWb7F0g6jjZoUUigeGJnbTnp1g4MFaNfuc3exbUI5ggafOYV8CBTwRsazWKBy799mIskeGRIxaFGHXcfTY42pgXq0TRMyvKlKrZmHwL7kENsM2L/5IhHdzYlakw+zt+RFiJn6Q==
Received: from AM0PR02CA0177.eurprd02.prod.outlook.com (2603:10a6:20b:28e::14)
 by VI1PR07MB6687.eurprd07.prod.outlook.com (2603:10a6:800:189::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 16:14:37 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::74) by AM0PR02CA0177.outlook.office365.com
 (2603:10a6:20b:28e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Tue,
 24 Mar 2026 16:14:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 16:14:37 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 24 Mar 2026 17:14:36 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id 2EA614020AB6;
 Tue, 24 Mar 2026 17:14:36 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 1678D618DCB2; Tue, 24 Mar 2026 17:14:36 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <jgrajcia@cisco.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <stephen@networkplumber.org>,
 <bly454@gmail.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v2] net/memif: fix multi-segment Rx corruption
Date: Tue, 24 Mar 2026 17:14:36 +0100
Message-ID: <20260324161436.2816927-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260316155918.3756017-1-sriram.yagnaraman@ericsson.com>
References: <20260316155918.3756017-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|VI1PR07MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd78c6e-0157-42c6-6fbe-08de89c071ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Eis6olpfrrXgw3Wq8T/Ok4oI4P01zCmlZ1xnKcOhTckH29QpNm6vfmgNbfcZdDV5ys6ooyaVypErQpEKCPveXL8S7cnn5djtPya4X5KIfaiTxJ+OsKZ41S0i2F5TReRuvAXpv+QPXbhwwFU1iEkhqv2AweFg3C3vNplIjZY90W1VmhCTiAN6CAj9OBhZxDAoCmY4hbPydmhtuQxw0SKVhn3KKIe0xi66PmN91ov/uPeuyN7yxqHPA13L8edOF7qeE3hGGA8b99qgonrWVum1i6X0yLYyCTkPgoXU7oPbXZ7YuHjTQMfcJOQfTvBuuMpHNyDPmAWm/PdLkXSFWvro32SHajFZKLC3oBVA39+ShhOwhTjOQlKdf11BUBhxMZ/MaIERMSZpiMSFGRcgOW1tbwBc6ko6SeKd8peLQcQ1iCWwnDsBKLRtQQzXB31WLJDb2cCeqWfi0Puny17TrWxmspIpeoE971O9nFH78JCdXItLh8+PtArVSu5ObINHhyq8FbopCHnPLXRcwLUMO+bC/RQhdoNsXpPQfcI8HTTuVBqb85x5AAOMBFrdvGj6NZEsAtgkPmc2cm3uYF4nOrbP7ioa7A5vXBRwdJX9jWZeHg3WOqVWFQl+x06hFfH2AJS/9PxCfUUXTcrJ7hklKj5y1tbpL34inlSXCwZOuSbilen+bqPA3ilik5IpsEMTG4j32mtPxezfqTCVHsglpE77oWDHHduvTI/Aon1S9XAutFTRobXfLsQcYWRUYmMtT1tuTVEIcVoKftssLhq7aoB8Xg==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PT6XFypDpZtMmRZh5fDKIrfNcMoqHyq9aPjB90wGLzOL21RwJnUov2pTLc2N8k5YxYCt2dzr4ssbrGMt84oJt1xHsBl/IZm3MZ7tXpwfF349/cInJWFUz/LST38n+I1vfDIr344Weyo0mjauK1/Bl1LhSbAuYqD+1mea9AwKrfPQSxQfDbwDrXHD9qKFmNtxK1xIBw5Cd66WmrFnApDdOv9G64S+JJYBFrYJQcIliyUH0sST/e4nsC0SDFwD6xEXpto/HCOuKXU1Se7pLKkB68gkC9afDx2CWXAo0TSx7uuT2KnflXi/1+KYI6vpegRYpOul+Rdqxp+fg9UiamJcRerhQ4VoCDF8/qHVmgg7aFqCsiH0hHs1YL0yLztKU8XPSgkVZmvw/Mq5dFOosxCi3cI/b2XXRZsYPDIr76aWP5asi2qF95h3XbJhMYEByvop
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:14:37.0726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd78c6e-0157-42c6-6fbe-08de89c071ee
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6687
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Fix dst_off being reset per-descriptor instead of per-packet in the Rx
slow path. When processing chained descriptors (MEMIF_DESC_FLAG_NEXT),
goto next_slot2 reset dst_off to 0, overwriting the beginning of the
current mbuf with data from subsequent descriptors. Move dst_off
initialization before the next_slot2 label so it is only reset once
per packet.

Add boundary check in both Rx paths before processing next segment.
If MEMIF_DESC_FLAG_NEXT is set but n_slots is 0, free the incomplete
mbuf chain and exit gracefully to prevent reading beyond available
descriptors.

Bugzilla ID: 1609
Fixes: aa17df860891 ("net/memif: add a Rx fast path")
Cc: stable@dpdk.org

Reported-by: Mike Bly <bly454@gmail.com>
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
v2:
- Fix double-free in fast-path truncation: mbuf_head is mbufs[rx_pkts],
  so rte_pktmbuf_free_bulk already frees it and its chain. Remove the
  separate rte_pktmbuf_free(mbuf_head) call. (Stephen Hemminger)
- Remove MIF_LOG from truncation paths, increment mq->n_err and report
  via stats->ierrors instead.

 drivers/net/memif/rte_eth_memif.c | 19 +++++++++++++++++--
 drivers/net/memif/rte_eth_memif.h |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index effcee3721..5d153c3a5a 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -378,6 +378,12 @@ eth_memif_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			n_slots--;
 
 			if (d0->flags & MEMIF_DESC_FLAG_NEXT) {
+				if (unlikely(n_slots == 0)) {
+					mq->n_err++;
+					rte_pktmbuf_free_bulk(mbufs + rx_pkts,
+							MAX_PKT_BURST - rx_pkts);
+					goto no_free_bufs;
+				}
 				mbuf_tail = mbuf;
 				mbuf = rte_pktmbuf_alloc(mq->mempool);
 				if (unlikely(mbuf == NULL)) {
@@ -416,13 +422,13 @@ eth_memif_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				goto no_free_bufs;
 			mbuf = mbuf_head;
 			mbuf->port = mq->in_port;
+			dst_off = 0;
 
 next_slot2:
 			s0 = cur_slot & mask;
 			d0 = &ring->desc[s0];
 
 			src_len = d0->length;
-			dst_off = 0;
 			src_off = 0;
 
 			do {
@@ -464,8 +470,14 @@ eth_memif_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			cur_slot++;
 			n_slots--;
 
-			if (d0->flags & MEMIF_DESC_FLAG_NEXT)
+			if (d0->flags & MEMIF_DESC_FLAG_NEXT) {
+				if (unlikely(n_slots == 0)) {
+					mq->n_err++;
+					rte_pktmbuf_free(mbuf_head);
+					goto no_free_bufs;
+				}
 				goto next_slot2;
+			}
 
 			mq->n_bytes += rte_pktmbuf_pkt_len(mbuf_head);
 			*bufs++ = mbuf_head;
@@ -1607,6 +1619,7 @@ memif_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 		}
 		stats->ipackets += mq->n_pkts;
 		stats->ibytes += mq->n_bytes;
+		stats->ierrors += mq->n_err;
 	}
 
 	tmp = (pmd->role == MEMIF_ROLE_CLIENT) ? pmd->run.num_c2s_rings :
@@ -1639,12 +1652,14 @@ memif_stats_reset(struct rte_eth_dev *dev)
 		    dev->data->rx_queues[i];
 		mq->n_pkts = 0;
 		mq->n_bytes = 0;
+		mq->n_err = 0;
 	}
 	for (i = 0; i < pmd->run.num_s2c_rings; i++) {
 		mq = (pmd->role == MEMIF_ROLE_CLIENT) ? dev->data->rx_queues[i] :
 		    dev->data->tx_queues[i];
 		mq->n_pkts = 0;
 		mq->n_bytes = 0;
+		mq->n_err = 0;
 	}
 
 	return 0;
diff --git a/drivers/net/memif/rte_eth_memif.h b/drivers/net/memif/rte_eth_memif.h
index d4e625ab51..9c7a3a93f0 100644
--- a/drivers/net/memif/rte_eth_memif.h
+++ b/drivers/net/memif/rte_eth_memif.h
@@ -69,6 +69,7 @@ struct memif_queue {
 	/* rx/tx info */
 	uint64_t n_pkts;			/**< number of rx/tx packets */
 	uint64_t n_bytes;			/**< number of rx/tx bytes */
+	uint64_t n_err;				/**< number of rx/tx errors */
 
 	struct rte_intr_handle *intr_handle;	/**< interrupt handle */
 
-- 
2.43.7

