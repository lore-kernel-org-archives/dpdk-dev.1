Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495FAEFB810
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 07:27:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC53A4027F;
	Tue, 24 Feb 2026 08:26:59 +0100 (CET)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id A4B4D400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 08:26:58 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=f3PfmtzTSmy7sFzAm65n8BQXIysrP0iMyVVOWYY4zVw=;
 b=TSDUJ5M3vUnILUwyj9SKbOK5/jvG6Tozl6NMy4IQys/s5QRJZVwJ2Ss/1KwsixccaDP+zFoO7
 56M0/cI6x178KSiF7WVSZBaex4fVwSYTs3yqjGVSscAu5xZJ3xptAXs4jzpNmKX/IOEn6Au1Rp9
 C+D7HfKzCKLLsLVMQDt7skQ=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fKq0y0j5SzLlSX;
 Tue, 24 Feb 2026 15:22:10 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 277E340568;
 Tue, 24 Feb 2026 15:26:56 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Feb 2026 15:26:55 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: [PATCH 1/2] app/testpmd: check whether start for DCB fwd-tc command
Date: Tue, 24 Feb 2026 15:26:46 +0800
Message-ID: <20260224072647.607-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260224072647.607-1-fengchengwen@huawei.com>
References: <20260224072647.607-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

The 'set dcb fwd_tc xxx' and 'set dcb fwd_tc_cores xxx' commands should
check whether started forwarding, this patch add it.

Fixes: c58bdc7a589c ("app/testpmd: set DCB forwarding TCs")
Fixes: 945e9be0a803 ("app/testpmd: support multi-cores process one TC")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index c33c66f327..012a3ad32f 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -6241,6 +6241,10 @@ static void cmd_set_dcb_fwd_tc_parsed(void *parsed_result,
 {
 	struct cmd_set_dcb_fwd_tc_result *res = parsed_result;
 	int i;
+	if (test_done == 0) {
+		fprintf(stderr, "Please stop forwarding first\n");
+		return;
+	}
 	if (res->tc_mask == 0) {
 		fprintf(stderr, "TC mask should not be zero!\n");
 		return;
@@ -6293,6 +6297,10 @@ static void cmd_set_dcb_fwd_tc_cores_parsed(void *parsed_result,
 					    __rte_unused void *data)
 {
 	struct cmd_set_dcb_fwd_tc_cores_result *res = parsed_result;
+	if (test_done == 0) {
+		fprintf(stderr, "Please stop forwarding first\n");
+		return;
+	}
 	if (res->tc_cores == 0) {
 		fprintf(stderr, "Cores per-TC should not be zero!\n");
 		return;
-- 
2.17.1

