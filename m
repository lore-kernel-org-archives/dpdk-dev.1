Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B664C021AD
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 07:07:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5713D4014F;
	Thu, 20 Feb 2025 08:07:07 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 9B1E74014F
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:07:05 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Yz4613jCdzd171;
 Thu, 20 Feb 2025 15:05:29 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id BBE5118009E;
 Thu, 20 Feb 2025 15:07:02 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 15:07:02 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>
Subject: [PATCH 1/2] app/testpmd: support display DCB all priority's TC map
Date: Thu, 20 Feb 2025 15:06:50 +0800
Message-ID: <20250220070651.42123-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220070651.42123-1-fengchengwen@huawei.com>
References: <20250220070651.42123-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Currently, the "show port dcb_tc" command displays only the mapping
in the number of TCs. This patch fixes it by show all priority's TC
mapping.

Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 08a8ab02ea..e89af21cec 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -7273,8 +7273,8 @@ port_dcb_info_display(portid_t port_id)
 	printf("\n  TC :        ");
 	for (i = 0; i < dcb_info.nb_tcs; i++)
 		printf("\t%4d", i);
-	printf("\n  Priority :  ");
-	for (i = 0; i < dcb_info.nb_tcs; i++)
+	printf("\n  Prio2TC :  ");
+	for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++)
 		printf("\t%4d", dcb_info.prio_tc[i]);
 	printf("\n  BW percent :");
 	for (i = 0; i < dcb_info.nb_tcs; i++)
-- 
2.17.1

