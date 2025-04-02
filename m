Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755A1C28B20
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 08:54:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65F54402B5;
	Wed,  2 Apr 2025 10:54:02 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id 7F61D40275
 for <dev@dpdk.org>; Wed,  2 Apr 2025 10:54:00 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZSJSj2qH7z1f1gX;
 Wed,  2 Apr 2025 16:49:09 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
 by mail.maildlp.com (Postfix) with ESMTPS id 3ACD518001B;
 Wed,  2 Apr 2025 16:53:58 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 16:53:57 +0800
From: Jie Hai <haijie1@huawei.com>
To: <dev@dpdk.org>, <thomas@monjalon.net>, <ferruh.yigit@amd.com>
CC: <lihuisong@huawei.com>, <fengcengwen@huawei.com>, <haijie1@huawei.com>,
 <huangdengdui@huawei.com>
Subject: [PATCH] maintainers: update for hns3
Date: Wed, 2 Apr 2025 16:47:44 +0800
Message-ID: <20250402084744.334095-1-haijie1@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.30.45]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500004.china.huawei.com (7.202.181.242)
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

I am moving on to other things and dengdui is going to
take over the role of hns3 maintainer. Update the
MAINTAINERS accordingly.

Signed-off-by: Jie Hai <haijie1@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b01103f8e83..bcc9fdaf0c92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -765,7 +765,7 @@ F: doc/guides/nics/gve.rst
 F: doc/guides/nics/features/gve.ini
 
 Hisilicon hns3
-M: Jie Hai <haijie1@huawei.com>
+M: Dengdui Huang <huangdengdui@huawei.com>
 F: drivers/net/hns3/
 F: doc/guides/nics/hns3.rst
 F: doc/guides/nics/features/hns3.ini
-- 
2.22.0

