Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F369CD4851
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 12:42:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2EE1402B5;
	Thu, 14 May 2026 14:42:14 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 8FC6E40276
 for <dev@dpdk.org>; Thu, 14 May 2026 14:42:13 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=MrTX3aoBF+mDCXCYL2jHx1Gs+63vo4bV7dLIlv25b2o=;
 b=nHEgXlElkPg6g4DJdNNKE/Fken3xtkVKOnAM1C+b9fP8QPpRxV6M//SJPSuLUqkOk4SKtWwyb
 nr8CNbTJ2yNZTppmuDQ3B8Dfn14pDnh/o6gDzcDo/fJD5fhj5pG9SL632WW4XLT5sNz8NqHh5zc
 af4B2MAn8EQWEbzp2zmRWKc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gGVCc08FTzpStc;
 Thu, 14 May 2026 20:35:08 +0800 (CST)
Received: from kwepemr100008.china.huawei.com (unknown [7.202.195.119])
 by mail.maildlp.com (Postfix) with ESMTPS id 7AEBC40569;
 Thu, 14 May 2026 20:42:11 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemr100008.china.huawei.com (7.202.195.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 20:42:11 +0800
From: ZongYu Wu <wuzongyu1@huawei.com>
To: <dev@dpdk.org>
CC: <fanghao11@huawei.com>, <liulongfang@huawei.com>,
 <fengchengwen@huawei.com>, <thomas@monjalon.net>, Zongyu Wu
 <wuzongyu1@huawei.com>
Subject: [PATCH] maintainers: update for compress/uadk and crypto/uadk driver
Date: Thu, 14 May 2026 20:40:49 +0800
Message-ID: <20260514124049.3133884-1-wuzongyu1@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr100008.china.huawei.com (7.202.195.119)
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

From: Zongyu Wu <wuzongyu1@huawei.com>

Zongyu Wu replaces Zhangfei Gao as the maintainer of compress/uadk and crypto/uadk.

Signed-off-by: Zongyu Wu <wuzongyu1@huawei.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f5539f851..84133b00ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1201,7 +1201,7 @@ F: drivers/crypto/scheduler/
 F: doc/guides/cryptodevs/scheduler.rst
 
 HiSilicon UADK crypto
-M: Zhangfei Gao <zhangfei.gao@linaro.org>
+M: Zongyu Wu <wuzongyu1@huawei.com>
 F: drivers/crypto/uadk/
 F: doc/guides/cryptodevs/uadk.rst
 F: doc/guides/cryptodevs/features/uadk.ini
@@ -1318,7 +1318,7 @@ F: doc/guides/compressdevs/octeontx.rst
 F: doc/guides/compressdevs/features/octeontx.ini
 
 HiSilicon UADK compress
-M: Zhangfei Gao <zhangfei.gao@linaro.org>
+M: Zongyu Wu <wuzongyu1@huawei.com>
 F: drivers/compress/uadk/
 F: doc/guides/compressdevs/uadk.rst
 F: doc/guides/compressdevs/features/uadk.ini
-- 
2.33.0

