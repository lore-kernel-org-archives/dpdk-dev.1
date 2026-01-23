Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FD3D6CFBB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 03:16:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10E6A4029A;
	Fri, 23 Jan 2026 04:16:52 +0100 (CET)
Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com
 [115.124.28.101])
 by mails.dpdk.org (Postfix) with ESMTP id 52F104021F;
 Fri, 23 Jan 2026 04:16:47 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gDV2mrZ_1769138205 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 23 Jan 2026 11:16:45 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, stable@dpdk.org,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 2/4] net/nbl: optimize mbuf headroom usage in packet
 transmission
Date: Thu, 22 Jan 2026 19:16:25 -0800
Message-Id: <20260123031627.151341-3-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
References: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Only use mbuf headroom when mbuf->refcnt == 1,
indicating exclusive ownership. For shared mbufs (refcnt > 1),
use next desc instead to avoid data corruption.

This prevents modifying shared buffers that may be used by other
processing contexts.

Implementation details:
- Check mbuf->refcnt before using headroom
- For refcnt == 1: use existing headroom (performance optimal)
- For refcnt > 1: use next desc

Fixes: e5fc1f78c78c ("net/nbl: support Tx and Rx burst")
Cc: stable@dpdk.org

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_hw/nbl_txrx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index 103f56c3a7..e906f0707e 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -514,7 +514,10 @@ nbl_res_txrx_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts, u
 			tx_extend_len = required_headroom + sizeof(struct rte_ether_hdr);
 		}
 
-		if (rte_pktmbuf_headroom(tx_pkt) >= required_headroom) {
+		if (rte_mbuf_refcnt_read(tx_pkt) == 1 &&
+		    RTE_MBUF_DIRECT(tx_pkt) &&
+		    tx_pkt->nb_segs == 1 &&
+		    rte_pktmbuf_headroom(tx_pkt) >= required_headroom) {
 			can_push = 1;
 			u = rte_pktmbuf_mtod_offset(tx_pkt, union nbl_tx_extend_head *,
 						    -required_headroom);
-- 
2.34.1

