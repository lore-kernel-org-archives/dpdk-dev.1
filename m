Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC9ECFD376
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 03:42:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88EE24067B;
	Tue, 25 Nov 2025 04:42:07 +0100 (CET)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id E7EE940678
 for <dev@dpdk.org>; Tue, 25 Nov 2025 04:42:05 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=XpWWbPuSfvgAp6i5nR6CcJXZLDp513xb5XCbzmv31t4=;
 b=5Hc/Dd2TKgMMJp4MuCnqBBTf48bSVBSDlL2IPkUJwewJTDaYABJs3WehgQSPojDHHYl/n/iYL
 ioAbIt4Y++YRL1bj/fEglbS2nAZJOpuDGvLe8b3FC2II72ZJAviRtJqZ7eFE5hQjYWyfVn6gcco
 GTQ2fPu2iERfMfGYm/9nCpY=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dFpNZ4YnPzpTRZ;
 Tue, 25 Nov 2025 11:39:58 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B768414022D;
 Tue, 25 Nov 2025 11:42:03 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Nov 2025 11:42:03 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <aman.deep.singh@intel.com>
Subject: [PATCH 1/2] app/testpmd: support multi-cores process one TC help
Date: Tue, 25 Nov 2025 11:41:57 +0800
Message-ID: <20251125034158.55192-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251125034158.55192-1-fengchengwen@huawei.com>
References: <20251125034158.55192-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

This commit adds support multi-cores process one TC help info.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-pmd/cmdline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index c33c66f327..e701cd7ec4 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -514,6 +514,9 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"set dcb fwd_tc (tc_mask)\n"
 			"    Set DCB forwarding on specify TCs, if bit-n in tc-mask is 1, then TC-n's forwarding is enabled\n\n"
 
+			"set dcb fwd_tc_cores (tc_cores)\n"
+			"    Set DCB forwarding cores per-TC, 1-means one core process all queues of a TC.\n\n"
+
 			"mac_addr add (port_id) (XX:XX:XX:XX:XX:XX)\n"
 			"    Add a MAC address on port_id.\n\n"
 
-- 
2.17.1

