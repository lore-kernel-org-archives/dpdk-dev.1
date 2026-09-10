Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF54C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:55:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B71C442E7F;
	Thu, 10 Sep 2026 15:52:53 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id B08ED42E5E
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:40 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 97FDF200035;
 Thu, 10 Sep 2026 15:52:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 621402003F6;
 Thu, 10 Sep 2026 15:52:40 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5B64B18000B6;
 Thu, 10 Sep 2026 21:52:39 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 33/47] net/dpaa2: remove unused soft parser Tx code
Date: Thu, 10 Sep 2026 19:21:44 +0530
Message-ID: <20260910135158.2181141-34-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

Remove the soft parser related code from the Tx path. The soft parser
can only be loaded before Linux boots, so this code was never reachable
at runtime.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 5c46c0f6d2..6d17a4d160 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -162,16 +162,6 @@ dpaa2_dev_rx_parse_new(struct dpaa2_dev_priv *priv,
 			ext_packet_type |= RTE_PTYPE_INNER_L3_IPV4;
 		}
 	}
-	if (priv->sp_protocol) {
-		if (frc_parse->fafe2) {
-			frc_parse->fafe2 = 0;
-			ext_packet_type |= RTE_PTYPE_TUNNEL_GENEVE;
-		}
-		if (frc_parse->sum_l.l4.fafe3) {
-			frc_parse->sum_l.l4.fafe3 = 0;
-			ext_packet_type |= RTE_PTYPE_INNER_L3_IPV4;
-		}
-	}
 	switch (frc) {
 	case DPAA2_PKT_TYPE_IPV4_UDP:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
@@ -740,7 +730,7 @@ dpaa2_dev_tx_mbuf_to_sg_fd(struct rte_mempool *hw_mp,
 
 	if (mbuf->pool->ops_index == hw_mp->ops_index &&
 		RTE_MBUF_DIRECT(mbuf) &&
-		(mbuf->data_off > RTE_ALIGN(sg_size + offset, 8))) {
+		mbuf->data_off > RTE_ALIGN(sg_size + offset, 8)) {
 		sg_mbuf = mbuf;
 		mp = mbuf->pool;
 		if (need_conf) {
@@ -1563,7 +1553,7 @@ uint16_t dpaa2_dev_tx_conf(void *txq, int drain)
 			mp = mbufs[idx]->pool;
 		if (unlikely(rte_mbuf_refcnt_read(mbufs[idx]) > 1))
 			bulk_free = false;
-		if (bulk_free == true &&
+		if (bulk_free &&
 			!dpaa2_dev_is_mbuf_from_spec_pool(mp, mbufs[idx]))
 			bulk_free = false;
 		if (unlikely(mbufs[idx]->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)) {
-- 
2.43.0

