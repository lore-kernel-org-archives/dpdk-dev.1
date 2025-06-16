Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8731EC71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 08:27:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EB7B40615;
	Mon, 16 Jun 2025 10:27:07 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id 9CE8440292
 for <dev@dpdk.org>; Mon, 16 Jun 2025 10:27:05 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bLNNx66vQz1g2mc;
 Mon, 16 Jun 2025 16:25:37 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 33DD71400D2;
 Mon, 16 Jun 2025 16:27:04 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Jun 2025 16:27:03 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, <jasvinder.singh@intel.com>,
 <stephen@networkplumber.org>, <aman.deep.singh@intel.com>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 2/2] app/testpmd: fix obtain inner info of tunnel packet
Date: Mon, 16 Jun 2025 16:27:02 +0800
Message-ID: <20250616082702.3422034-3-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250616082702.3422034-1-huangdengdui@huawei.com>
References: <20250616082702.3422034-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

The l2_len field of tunnel packets already includes the tunnel_len field.
Additionally, the current offset used for the internal Ethernet header is
incorrect. This patch fixes these issues.

Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 app/test-pmd/csumonly.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index 203af35cf0..d355dbd8c0 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -712,11 +712,11 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 		if (txp->parse_tunnel && RTE_ETH_IS_TUNNEL_PKT(ptype) != 0) {
 			info.is_tunnel = 1;
 			update_tunnel_outer(&info);
-			info.l2_len = hdr_lens.inner_l2_len + hdr_lens.tunnel_len;
+			info.l2_len = hdr_lens.inner_l2_len;
 			info.l3_len = hdr_lens.inner_l3_len;
 			info.l4_len = hdr_lens.inner_l4_len;
-			eth_hdr = (struct rte_ether_hdr *)(char *)l3_hdr +
-					info.outer_l3_len + hdr_lens.tunnel_len;
+			eth_hdr = (struct rte_ether_hdr *)((char *)l3_hdr +
+				hdr_lens.l3_len + hdr_lens.l4_len + hdr_lens.tunnel_len);
 			info.ethertype = get_ethertype_by_ptype(eth_hdr,
 						ptype & RTE_PTYPE_INNER_L3_MASK);
 			tx_ol_flags |= get_tunnel_ol_flags_by_ptype(ptype);
-- 
2.33.0

