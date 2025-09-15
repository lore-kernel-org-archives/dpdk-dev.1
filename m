Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4440CAC58E
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 07:54:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8935B40288;
	Mon, 15 Sep 2025 09:54:11 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 5EBC540262
 for <dev@dpdk.org>; Mon, 15 Sep 2025 09:54:10 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cQHHF6B6gzQlTV;
 Mon, 15 Sep 2025 15:49:29 +0800 (CST)
Received: from kwepemr200009.china.huawei.com (unknown [7.202.195.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 2F3CE140275;
 Mon, 15 Sep 2025 15:54:07 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemr200009.china.huawei.com (7.202.195.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Sep 2025 15:54:06 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <yangxingui@huawei.com>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH] maintainers: update for hns3 driver
Date: Mon, 15 Sep 2025 15:54:05 +0800
Message-ID: <20250915075405.1823997-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200009.china.huawei.com (7.202.195.137)
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

I am moving on to other things, Chengwen and Xingui will take on
the role of hns3 PMD maintainers. Update the MAINTAINERS accordingly.

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7aca98c537..deebc93a56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -767,7 +767,8 @@ F: doc/guides/nics/gve.rst
 F: doc/guides/nics/features/gve.ini
 
 Hisilicon hns3
-M: Dengdui Huang <huangdengdui@huawei.com>
+M: Xingui Yang <yangxingui@huawei.com>
+M: Chengwen Feng <fengchengwen@huawei.com>
 F: drivers/net/hns3/
 F: doc/guides/nics/hns3.rst
 F: doc/guides/nics/features/hns3.ini
-- 
2.33.0

