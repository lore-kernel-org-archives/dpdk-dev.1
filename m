Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B50DC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 10:47:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35A0E402CC;
	Wed, 23 Jul 2025 12:47:16 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 235B040264
 for <dev@dpdk.org>; Wed, 23 Jul 2025 12:47:13 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bn9hP3k3Tz2CfyM;
 Wed, 23 Jul 2025 18:43:01 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id A98431A016C;
 Wed, 23 Jul 2025 18:47:11 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Jul 2025 18:47:11 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <aman.deep.singh@intel.com>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH] net: fix incorrect L2 length for GRE tunneling packet
Date: Wed, 23 Jul 2025 18:47:10 +0800
Message-ID: <20250723104710.558623-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
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

The meaning of L2_len in the parsing result of the rte_net_get_ptype()
is the same as the L2_len field in the mbuf. For tunnel packets,
the L2_len should include protocol header of tunnel packets.

Bugzilla ID: 1754
Fixes: d21d855464ff ("net: support GRE in software packet type parser")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 lib/net/rte_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 44fb6c0f51..c70b57fdc0 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -481,6 +481,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 
 		pkt_type |= ptype_tunnel_without_udp(&proto, m, &off);
 		hdr_lens->tunnel_len = off - prev_off;
+		hdr_lens->inner_l2_len = off - prev_off;
 	}
 
 	/* same job for inner header: we need to duplicate the code
-- 
2.33.0

