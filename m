Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4252AC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:57:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DF9542EDB;
	Thu, 10 Sep 2026 15:53:07 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0A5BA42E8B
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:54 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E4258200026;
 Thu, 10 Sep 2026 15:52:53 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ACF15200023;
 Thu, 10 Sep 2026 15:52:53 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 90C3D18000B1;
 Thu, 10 Sep 2026 21:52:52 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 45/47] net/dpaa2: do not overwrite mbuf hash with drop
 priority
Date: Thu, 10 Sep 2026 19:21:56 +0530
Message-ID: <20260910135158.2181141-46-prashant.gupta_3@nxp.com>
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

dpaa2_eth_fd_to_mbuf() wrote the frame descriptor's drop priority into
mbuf->hash.sched.color unconditionally. hash.sched shares the union with
hash.rss and hash.fdir, so this clobbered whatever the parse step had
placed there. The scheduler color is only meaningful when the frame came
out of a flow-steering table, and dpaa2_dev_rx_mbuf_sched_set() already
sets the whole sched field (queue, traffic class and colour) in that
case, so drop the unconditional write.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 6d17a4d160..7c2c484b8c 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -488,7 +488,6 @@ dpaa2_eth_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 	mbuf->pkt_len = mbuf->data_len;
 	mbuf->port = priv->eth_dev->data->port_id;
 	mbuf->next = NULL;
-	mbuf->hash.sched.color = DPAA2_GET_FD_DROPP(fd);
 	rte_mbuf_refcnt_set(mbuf, 1);
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
 	rte_mempool_check_cookies(rte_mempool_from_obj((void *)mbuf),
-- 
2.43.0

