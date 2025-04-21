Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81157C369AB
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Apr 2025 07:22:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58213402DA;
	Mon, 21 Apr 2025 09:22:35 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 2DFF040156
 for <dev@dpdk.org>; Mon, 21 Apr 2025 09:22:32 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZgxYB4YcWzvWm2;
 Mon, 21 Apr 2025 15:18:22 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id D6F5F1402E9;
 Mon, 21 Apr 2025 15:22:30 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Apr 2025 15:22:30 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 1/4] app/testpmd: remove restrict of number of TCs in DCB
 command
Date: Mon, 21 Apr 2025 15:22:26 +0800
Message-ID: <20250421072229.33200-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250421072229.33200-1-fengchengwen@huawei.com>
References: <20250225091929.25072-1-fengchengwen@huawei.com>
 <20250421072229.33200-1-fengchengwen@huawei.com>
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

Currently, the "port config 0 dcb ..." command only supports 4 or 8
TCs. Other number of TCs may be used in actual applications.

This commit removes this restriction.

Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c                      | 4 ++--
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index b4089d281b..e34e47aaae 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -3472,9 +3472,9 @@ cmd_config_dcb_parsed(void *parsed_result,
 		return;
 	}
 
-	if ((res->num_tcs != RTE_ETH_4_TCS) && (res->num_tcs != RTE_ETH_8_TCS)) {
+	if ((res->num_tcs <= 1 || res->num_tcs > RTE_ETH_8_TCS)) {
 		fprintf(stderr,
-			"The invalid number of traffic class, only 4 or 8 allowed.\n");
+			"The invalid number of traffic class, only 2~8 allowed.\n");
 		return;
 	}
 
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index eeef49500f..38bc00705f 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -2167,7 +2167,7 @@ Set the DCB mode for an individual port::
 
    testpmd> port config (port_id) dcb vt (on|off) (traffic_class) pfc (on|off)
 
-The traffic class should be 4 or 8.
+The traffic class could be 2~8.
 
 port config - Burst
 ~~~~~~~~~~~~~~~~~~~
-- 
2.17.1

