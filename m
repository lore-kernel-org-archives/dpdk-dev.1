Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F204CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 07:20:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C81D40678;
	Tue, 14 Oct 2025 09:20:14 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5DEE240288;
 Tue, 14 Oct 2025 08:00:48 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 477BB1A1BE2;
 Tue, 14 Oct 2025 08:00:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C5111A1BE3;
 Tue, 14 Oct 2025 08:00:48 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 36C2F1800093;
 Tue, 14 Oct 2025 14:00:47 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: stable@dpdk.org,
	Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 05/15] net/dpaa2: fix error frame dump issue
Date: Tue, 14 Oct 2025 11:30:35 +0530
Message-ID: <20251014060045.1304694-6-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014060045.1304694-1-prashant.gupta_3@nxp.com>
References: <20251014060045.1304694-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 14 Oct 2025 09:20:04 +0200
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

From: Jun Yang <jun.yang@nxp.com>

Dump error frame payload according to mbuf format.
Meanwhile, support dumping parser result of error frame.

Fixes: 4690a6114ff6 ("net/dpaa2: enable error queues optionally")
Cc: stable@dpdk.org

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_rxtx.c | 38 ++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 6cb91e67d4..7caccfa469 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -629,9 +629,11 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 	const struct qbman_fd *fd;
 	struct qbman_pull_desc pulldesc;
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
-	uint32_t lcore_id = rte_lcore_id();
+	uint32_t lcore_id = rte_lcore_id(), i = 0;
 	void *v_addr, *hw_annot_addr;
 	struct dpaa2_fas *fas;
+	struct rte_mbuf *mbuf;
+	char title[32];
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 		ret = dpaa2_affine_qbman_swp();
@@ -687,13 +689,37 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 		hw_annot_addr = (void *)((size_t)v_addr + DPAA2_FD_PTA_SIZE);
 		fas = hw_annot_addr;
 
-		DPAA2_PMD_ERR("[%d] error packet on port[%d]:"
-			" fd_off: %d, fd_err: %x, fas_status: %x",
-			rte_lcore_id(), eth_data->port_id,
+		if (DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg)
+			mbuf = eth_sg_fd_to_mbuf(fd, eth_data->port_id);
+		else
+			mbuf = eth_fd_to_mbuf(fd, eth_data->port_id);
+
+		if (!dpaa2_print_parser_result) {
+			/** Don't print parse result twice.*/
+			dpaa2_print_parse_result(hw_annot_addr);
+		}
+
+		DPAA2_PMD_ERR("Err pkt on port[%d]:", eth_data->port_id);
+		DPAA2_PMD_ERR("FD offset: %d, FD err: %x, FAS status: %x",
 			DPAA2_GET_FD_OFFSET(fd), DPAA2_GET_FD_ERR(fd),
 			fas->status);
-		rte_hexdump(stderr, "Error packet", v_addr,
-			DPAA2_GET_FD_OFFSET(fd) + DPAA2_GET_FD_LEN(fd));
+
+		if (mbuf)
+			__rte_mbuf_sanity_check(mbuf, 1);
+		if (mbuf->nb_segs > 1) {
+			while (mbuf) {
+				sprintf(title, "Payload seg[%d]", i);
+				rte_hexdump(stderr, title,
+					(char *)mbuf->buf_addr + mbuf->data_off,
+					mbuf->data_len);
+				mbuf = mbuf->next;
+				i++;
+			}
+		} else {
+			rte_hexdump(stderr, "Payload",
+				(char *)mbuf->buf_addr + mbuf->data_off,
+				mbuf->data_len);
+		}
 
 		rte_pktmbuf_free(mbuf);
 		dq_storage++;
-- 
2.43.0

