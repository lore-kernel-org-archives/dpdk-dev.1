Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1349CC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 09:28:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBB31402DF;
	Fri, 16 May 2025 11:28:46 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 7EF8E400EF
 for <dev@dpdk.org>; Fri, 16 May 2025 11:28:44 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZzM9p5kzCz1Z1jS;
 Fri, 16 May 2025 17:25:02 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id AA148180080;
 Fri, 16 May 2025 17:28:42 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 May 2025 17:28:42 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>
Subject: [PATCH v3 3/4] net: fix GENEVE packet parsing
Date: Fri, 16 May 2025 17:28:39 +0800
Message-ID: <20250516092840.2061252-4-huangdengdui@huawei.com>
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

When the GENEVE packet is processed, the offset is
not changed correctly. As a result, the inner packet
is incorrectly parsed. This patch fixes it.

Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 lib/net/rte_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 67d57d5f04..cd8cc0d0c8 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -260,7 +260,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 		if (unlikely(gnh == NULL))
 			return 0;
 		geneve_len = sizeof(*gnh) + gnh->opt_len * 4;
-		*off = geneve_len;
+		*off += geneve_len;
 		hdr_lens->tunnel_len = geneve_len;
 		*proto = gnh->proto;
 		if (gnh->proto == 0)
-- 
2.33.0

