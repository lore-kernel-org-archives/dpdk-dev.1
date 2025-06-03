Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC79CC5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 12:06:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D307B4069F;
	Tue,  3 Jun 2025 14:06:33 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 490A740697
 for <dev@dpdk.org>; Tue,  3 Jun 2025 14:06:32 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bBTtQ23s2z2TS3H;
 Tue,  3 Jun 2025 20:05:18 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 5C53B1A0190;
 Tue,  3 Jun 2025 20:06:24 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Jun 2025 20:06:23 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH v5] net: fix GTP packet parsing
Date: Tue, 3 Jun 2025 20:06:22 +0800
Message-ID: <20250603120622.82092-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250411084303.770040-1-huangdengdui@huawei.com>
References: <20250411084303.770040-1-huangdengdui@huawei.com>
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

After parsing the GTP packet header, the next protocol type should
be converted from RTE_GTP_TYPE_IPV4/IPV6 to RTE_ETHER_TYPE_IPV4/IPV6.
Otherwise, the next protocol cannot be parsed.

Bugzilla ID: 1672
Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
Acked-by: Jie Hai <haijie1@huawei.com>
---
 lib/net/rte_net.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 1264f33d61..098999e71e 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -231,7 +231,13 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 		 */
 		if (gh->msg_type == 0xff) {
 			ip_ver = *(const uint8_t *)((const char *)gh + gtp_len);
-			*proto = (ip_ver) & 0xf0;
+			ip_ver = (ip_ver) & 0xf0;
+			if (ip_ver == RTE_GTP_TYPE_IPV4)
+				*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+			else if (ip_ver == RTE_GTP_TYPE_IPV6)
+				*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6);
+			else
+				*proto = 0;
 		} else {
 			*proto = 0;
 		}
-- 
2.33.0

