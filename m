Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBA7C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Aug 2026 11:17:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2861640687;
	Tue, 18 Aug 2026 13:17:42 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 8836840269;
 Tue, 18 Aug 2026 13:17:38 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6AF611A010E;
 Tue, 18 Aug 2026 13:17:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3438E1A0118;
 Tue, 18 Aug 2026 13:17:38 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A64E918000BF;
 Tue, 18 Aug 2026 19:17:36 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v12 02/26] net/dpaa: fix Tx confirmation queue memory leak
Date: Tue, 18 Aug 2026 16:47:06 +0530
Message-Id: <20260818111730.801760-3-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260818111730.801760-1-hemant.agrawal@nxp.com>
References: <20260813144205.2505031-1-hemant.agrawal@nxp.com>
 <20260818111730.801760-1-hemant.agrawal@nxp.com>
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

dpaa_intf->tx_conf_queues is allocated unconditionally for every port
in dpaa_dev_init():

	dpaa_intf->tx_conf_queues = rte_zmalloc(NULL, sizeof(struct qman_fq) *
		MAX_DPAA_CORES, MAX_CACHELINE);

but it is never released. It is a driver private allocation, so
rte_eth_dev_release_port() does not free it either. The memory is
therefore leaked on every device close and on every probe failure that
happens after the allocation.

Free it in dpaa_eth_dev_close() next to tx_queues, and in the free_tx
error path of dpaa_dev_init(). The private data is allocated with
rte_zmalloc(), so the pointer is NULL on the error paths taken before
the allocation and rte_free() is a no-op there.

Fixes: 58e0420f72f8 ("net/dpaa: support Tx confirmation to enable PTP")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_ethdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 77730f16e3..86b1675c29 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -624,6 +624,9 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
+	rte_free(dpaa_intf->tx_conf_queues);
+	dpaa_intf->tx_conf_queues = NULL;
+
 	return ret;
 }
 
@@ -2497,6 +2500,8 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	return 0;
 
 free_tx:
+	rte_free(dpaa_intf->tx_conf_queues);
+	dpaa_intf->tx_conf_queues = NULL;
 	rte_free(dpaa_intf->tx_queues);
 	dpaa_intf->tx_queues = NULL;
 	dpaa_intf->nb_tx_queues = 0;
-- 
2.25.1

