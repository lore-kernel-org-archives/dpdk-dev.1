Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B16CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 12:25:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F8294026D;
	Mon, 10 Nov 2025 13:25:55 +0100 (CET)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id A5FB4400D6
 for <dev@dpdk.org>; Mon, 10 Nov 2025 13:25:53 +0100 (CET)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AA4UImm536716; Mon, 10 Nov 2025 04:25:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=+XiwI23PZYBplzmf/6sJ1cN
 CiuOIBgGzBJzuC5ZgQ80=; b=ZN3sWs1YH+iTeEMMrycx4VZqjTyTLfSgc33+dko
 5VAlNQpqpZuamOEeWi2Yi+bn7nrO1MPPQUCnpiFOscm8Sq1WxcrjPlwmj1KBjxg8
 JSCO3M/sXXq791j5M180UD0lHn6RdaNgJ/zq7CGodu1HTPWlL19rnJjEP9xzrLDg
 OukIcCQeijV6nYTpaBVCI3LSqRnPPE5708CbtUZSFGm3f1hyLraq1B6rFIJFrBxf
 +huvn3xFjB6QvjCGRYo9KKzMKw5hYIn0WreRpe3xS/e7N+rlEOMeuTEIfEWNVQ0L
 7t7xTIP+TznWHwDugTY0X9Cw4+8fTNFb5t2ZICcDw8hfBYQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4aau0ct267-10
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Nov 2025 04:25:52 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 10 Nov 2025 04:25:12 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 10 Nov 2025 04:25:12 -0800
Received: from cavium-3070-BM23.. (unknown [10.28.34.25])
 by maili.marvell.com (Postfix) with ESMTP id 558763F7083;
 Mon, 10 Nov 2025 04:25:00 -0800 (PST)
From: <skori@marvell.com>
To: Bruce Richardson <bruce.richardson@intel.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Sunil Kumar Kori <skori@marvell.com>
Subject: [PATCH] net/ice: set pkt prepare to dummy instead of NULL
Date: Mon, 10 Nov 2025 17:54:54 +0530
Message-ID: <20251110122457.2575615-1-skori@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MMdtWcZl c=1 sm=1 tr=0 ts=6911d9d0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=yGRXe5J_5nzL8qcSgywA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEwOCBTYWx0ZWRfX2Fnw/rYvW8mp
 IzfIMkH5lXEwzCGiNFZhnRhrX4Xb4jPAd4tRcpgVp+3v4pCp0DYkgOQeXEJuVFkLm+U4FZcip9y
 BCUQY0Mx2su5T7YF+0NwX5f2q/U2g71xwAliHq+z7ID/j8brSllNnQ0lvV93UeUQbjz85vE3wWq
 5vBEIEqV7qs2m3R1LQOotKRbNY9yOWV0PHcHRPPzqMhjalwEvqGpclpslTuJpn4RqoXvF2wtgXS
 0iMbfBEITZ8qh/z6B+O+XqpQAM5hD2o9VFzWYAubA++IEXN0CJFhfyplM7NzyQxNSqW6fqoyH/M
 bnRHQKr6CGM9H8U5CbyDyPB+TfpnrW5NUsm73L8sg==
X-Proofpoint-ORIG-GUID: 6cAy3bhrRpuBGIHHeHQFap0vPqc2FoWb
X-Proofpoint-GUID: 6cAy3bhrRpuBGIHHeHQFap0vPqc2FoWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
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

From: Sunil Kumar Kori <skori@marvell.com>

As per recent change by the following commit:

commit 066f3d9cc21c ("ethdev: remove callback checks from fast path")

framework unconditionally invokes dev->tx_pkt_prepare.
Due to this, ICE driver gets crashed as tx_pkt_prepare
was set to NULL during initialization.

Ensure dev->tx_pkt_prepare is not NULL when vector or simple
TX paths are selected, by assigning rte_eth_tx_pkt_prepare_dummy.

This aligns with expectations with above mentioned commit.

Bugzilla ID: 1795

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index fd0b3a7532..18077aca78 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -4131,7 +4131,7 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 	}
 
 	if (ad->tx_vec_allowed) {
-		dev->tx_pkt_prepare = NULL;
+		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 		if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
 #ifdef CC_AVX512_SUPPORT
 			if (tx_check_ret == ICE_VECTOR_OFFLOAD_PATH) {
@@ -4177,7 +4177,7 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 	if (ad->tx_simple_allowed) {
 		PMD_INIT_LOG(DEBUG, "Simple tx finally be used.");
 		dev->tx_pkt_burst = ice_xmit_pkts_simple;
-		dev->tx_pkt_prepare = NULL;
+		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 	} else {
 		PMD_INIT_LOG(DEBUG, "Normal tx finally be used.");
 		dev->tx_pkt_burst = ice_xmit_pkts;
-- 
2.43.0

