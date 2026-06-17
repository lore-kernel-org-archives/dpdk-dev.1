Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0C5CD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 10:31:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9EE340B95;
	Wed, 17 Jun 2026 12:31:19 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 67FB240A7A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 12:31:18 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=DRgk7ziEzDw/Dt1y/XE1L5V8eFNab0c52bJ0EQxoVX4=;
 b=SHxxH8uaQy06ODa8vI1Nm2C2i+/GYO67ncFOK2W4Sjg1hMs1KKJHbSpSVGYhEGCoXSLa/P68C
 pnsGDBdfxRqaLfSajwebwzAbIw6J5fZ8juRpGvlS6c+fswiSPuDFYsegLRYgkJzG1u36o3XAWGe
 hxofpfSfp0Ep9x5bvlDOqLc=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ggKfs16T7znTVR;
 Wed, 17 Jun 2026 18:22:29 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id F2201405D1;
 Wed, 17 Jun 2026 18:31:16 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 18:31:16 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <thomas@monjalon.net>
CC: <mb@smartsharesystems.com>, <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 5/5] test: use new lcore role enum names
Date: Wed, 17 Jun 2026 18:28:34 +0800
Message-ID: <20260617102834.2343356-6-lihuisong@huawei.com>
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
in test applications.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 app/test/test_lcores.c  | 2 +-
 app/test/test_mempool.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test/test_lcores.c b/app/test/test_lcores.c
index 13842615d5..60354b3f7f 100644
--- a/app/test/test_lcores.c
+++ b/app/test/test_lcores.c
@@ -396,7 +396,7 @@ test_lcores(void)
 	unsigned int i;
 
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
-		if (!rte_lcore_has_role(i, ROLE_OFF))
+		if (!rte_lcore_has_role(i, RTE_LCORE_ROLE_OFF))
 			eal_threads_count++;
 	}
 	if (eal_threads_count == 0) {
diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index e54249ce61..38f0b6e712 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -353,7 +353,7 @@ test_mempool_sp_sc(void)
 		ret = -1;
 		goto err;
 	}
-	if (rte_eal_lcore_role(lcore_next) != ROLE_RTE) {
+	if (rte_eal_lcore_role(lcore_next) != RTE_LCORE_ROLE_RTE) {
 		ret = -1;
 		goto err;
 	}
-- 
2.33.0

