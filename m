Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEFCCCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 10:28:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAA6B4270A;
	Thu, 16 Oct 2025 12:28:12 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 78C4340269;
 Thu, 16 Oct 2025 12:28:09 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5BEE51A26D3;
 Thu, 16 Oct 2025 12:28:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 27A2D1A26F1;
 Thu, 16 Oct 2025 12:28:09 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 50EFE1800079;
 Thu, 16 Oct 2025 18:28:08 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org
Cc: stable@dpdk.org
Subject: [PATCH v2 02/15] net/dpaa2: fix to free buffers from error queue
Date: Thu, 16 Oct 2025 15:57:52 +0530
Message-ID: <20251016102805.2453687-3-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
References: <20251014064035.1312896-1-prashant.gupta_3@nxp.com>
 <20251016102805.2453687-1-prashant.gupta_3@nxp.com>
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

Free a packet mbuf back into its original mempool.
Fixes: 4690a6114ff6 ("net/dpaa2: enable error queues optionally")
Cc: stable@dpdk.org

Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 5bd377d4e6..656a3a423f 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -708,6 +708,7 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 		rte_hexdump(stderr, "Error packet", v_addr,
 			DPAA2_GET_FD_OFFSET(fd) + DPAA2_GET_FD_LEN(fd));
 
+		rte_pktmbuf_free(mbuf);
 		dq_storage++;
 		num_rx++;
 	} while (pending);
-- 
2.43.0

