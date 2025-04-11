Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E29C369A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 08:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02AB7406BB;
	Fri, 11 Apr 2025 10:43:52 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by mails.dpdk.org (Postfix) with ESMTP id C0A87406B4
 for <dev@dpdk.org>; Fri, 11 Apr 2025 10:43:49 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZYqvT6gmqz1d177;
 Fri, 11 Apr 2025 16:43:01 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 2C2E21401E0;
 Fri, 11 Apr 2025 16:43:45 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Apr 2025 16:43:44 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <jasvinder.singh@intel.com>, <stephen@networkplumber.org>,
 <thomas@monjalon.net>, <mb@smartsharesystems.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <haijie1@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH] net: fix GTP packet parsing
Date: Fri, 11 Apr 2025 16:43:03 +0800
Message-ID: <20250411084303.770040-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 lib/net/rte_net.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index be24690fdf..1771588a09 100644
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

