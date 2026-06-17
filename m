Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275B1CD98E2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 10:31:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 615D240679;
	Wed, 17 Jun 2026 12:31:14 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 25BAA40679
 for <dev@dpdk.org>; Wed, 17 Jun 2026 12:31:13 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=djIdrm/0cfpvQfHSKqoGa0iAqDsRHa++2NQjXm9Eq6I=;
 b=LxvZTRdGGzc9xkTWDBLWXIdRCmTUl0Qm6gl0D9m+OTTDSE0MBGdYGulHlanL99smo8pobIBZy
 CFYZ80eIDhdLE+OlMAHCmTkRdCng7nplXs1UMR9AtH5Nep2q0ZspeyU8jzQYD6tW4jfUPQXwQCR
 OteQM5KbkWrG3RSCm/aiHXA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4ggKgj2g8jzRhXp;
 Wed, 17 Jun 2026 18:23:13 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id B216D4056D;
 Wed, 17 Jun 2026 18:31:11 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 18:31:11 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <thomas@monjalon.net>
CC: <mb@smartsharesystems.com>, <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 3/5] graph: use new lcore role enum names
Date: Wed, 17 Jun 2026 18:28:32 +0800
Message-ID: <20260617102834.2343356-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260617102834.2343356-1-lihuisong@huawei.com>
References: <20260617102834.2343356-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo100005.china.huawei.com (7.202.195.212)
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

Replace old lcore role enum names with new RTE_LCORE_ prefixed names
in graph library.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/graph/graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/graph/graph.c b/lib/graph/graph.c
index 5f8ada2185..8165a0a932 100644
--- a/lib/graph/graph.c
+++ b/lib/graph/graph.c
@@ -359,7 +359,7 @@ rte_graph_model_mcore_dispatch_core_bind(rte_graph_t id, int lcore)
 		goto fail;
 	}
 
-	if (rte_lcore_has_role(lcore, ROLE_OFF))
+	if (rte_lcore_has_role(lcore, RTE_LCORE_ROLE_OFF))
 		SET_ERR_JMP(ENOLINK, fail, "lcore %d is invalid", lcore);
 
 	STAILQ_FOREACH(graph, &graph_list, next)
-- 
2.33.0

