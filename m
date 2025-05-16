Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93744C3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 09:29:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D21684060F;
	Fri, 16 May 2025 11:28:49 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by mails.dpdk.org (Postfix) with ESMTP id 9D68D402D8
 for <dev@dpdk.org>; Fri, 16 May 2025 11:28:44 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZzMDL32LFz1d107;
 Fri, 16 May 2025 17:27:14 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 12E59140202;
 Fri, 16 May 2025 17:28:43 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 May 2025 17:28:42 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>
Subject: [PATCH v3 4/4] app/testpmd: fix obtain inner info of tunnel packet
Date: Fri, 16 May 2025 17:28:40 +0800
Message-ID: <20250516092840.2061252-5-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250516092840.2061252-1-huangdengdui@huawei.com>
References: <20250417123739.2291519-1-huangdengdui@huawei.com>
 <20250516092840.2061252-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

l2_len for tunneling packets should contain Outer_L4_len.
Additionally, the current offset used for the inner Ethernet
header is incorrect. This patch fixes these issues.

Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 app/test-pmd/csumonly.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index fa0002d321..6d93b7a04d 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -711,11 +711,11 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 		if (txp->parse_tunnel && RTE_ETH_IS_TUNNEL_PKT(ptype) != 0) {
 			info.is_tunnel = 1;
 			update_tunnel_outer(&info);
-			info.l2_len = hdr_lens.inner_l2_len + hdr_lens.tunnel_len;
+			info.l2_len = hdr_lens.inner_l2_len + hdr_lens.tunnel_len + hdr_lens.l4_len;
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

