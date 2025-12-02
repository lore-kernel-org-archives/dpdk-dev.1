Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AE7CFD2F6
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 06:04:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8C31C40268;
	Tue,  2 Dec 2025 07:04:28 +0100 (CET)
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net
 (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
 by mails.dpdk.org (Postfix) with ESMTP id 8B456400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 07:04:26 +0100 (CET)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn7JhjgS5pc+zmAg--.625S2;
 Tue, 02 Dec 2025 14:04:19 +0800 (CST)
Received: from debian11. (unknown [219.142.137.151])
 by mail (Coremail) with SMTP id AQAAfwBXr+xegS5pOPIIAA--.17885S3;
 Tue, 02 Dec 2025 14:04:14 +0800 (CST)
From: xiejianhua@phytium.com.cn
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, dev@dpdk.org
Cc: Yuhailong <yuhailong1088@phytium.com.cn>, Joyce Kong <joyce.kong@arm.com>,
 Ruifeng Wang <ruifeng.wang@arm.com>,
 Jianhua Xie <xiejianhua@phytium.com.cn>
Subject: [PATCH] net/ice: fix descriptor scan on Arm
Date: Tue,  2 Dec 2025 14:04:14 +0800
Message-Id: <20251202060414.113275-1-xiejianhua@phytium.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXr+xegS5pOPIIAA--.17885S3
X-CM-SenderInfo: x0lhyx5dqk3to6sk53xlxphulrpou0/1tbiAQAMCmkt9q4BbQAHsw
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=xiejianhua
 @phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF1DXrWDKr1xAF43ArWfuFg_yoW8AryDpF
 W3Jr1fC3y8Gr43Kw4fXayIvw15Gw1vyryxur98tw1Y9Fn5Aw45u34aya4qvrykWryYgF4f
 Za1UGwsxWa13W37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
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

From: Yuhailong <yuhailong1088@phytium.com.cn>

This patch borrows i40 patch:
commit 65b2ec7b4f6b ("net/i40e: fix descriptor scan on Arm")

For Arm platforms, reading descs can get re-ordered, then the status
of DD bits will be discontinuous, so add the logic to only process
continuous descs by checking DD bits.

Cc: Joyce Kong <joyce.kong@arm.com>
Cc: Ruifeng Wang <ruifeng.wang@arm.com>

Signed-off-by: Yuhailong <yuhailong1088@phytium.com.cn>
Signed-off-by: Jianhua Xie <xiejianhua@phytium.com.cn>
---
 drivers/net/intel/ice/ice_rxtx.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 74db0fbec9..b9358e49ba 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1888,7 +1888,7 @@ ice_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 	struct rte_mbuf *mb;
 	uint16_t stat_err0;
 	uint16_t pkt_len, hdr_len;
-	int32_t s[ICE_LOOK_AHEAD], nb_dd;
+	int32_t s[ICE_LOOK_AHEAD], nb_dd, var = 0;
 	int32_t i, j, nb_rx = 0;
 	uint64_t pkt_flags = 0;
 	uint32_t *ptype_tbl = rxq->ice_vsi->adapter->ptype_tbl;
@@ -1930,8 +1930,18 @@ ice_rx_scan_hw_ring(struct ci_rx_queue *rxq)
 		rte_smp_rmb();
 
 		/* Compute how many status bits were set */
-		for (j = 0, nb_dd = 0; j < ICE_LOOK_AHEAD; j++)
-			nb_dd += s[j] & (1 << ICE_RX_FLEX_DESC_STATUS0_DD_S);
+		for (j = 0, nb_dd = 0; j < ICE_LOOK_AHEAD; j++) {
+			var = s[j] & (1 << ICE_RX_FLEX_DESC_STATUS0_DD_S);
+#ifdef RTE_ARCH_ARM
+			/* For Arm platforms, only compute continuous status bits */
+			if (var)
+				nb_dd += 1;
+			else
+				break;
+#else
+			nb_dd += var;
+#endif
+		}
 
 		nb_rx += nb_dd;
 
-- 
2.30.2

