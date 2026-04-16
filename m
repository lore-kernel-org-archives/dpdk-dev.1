Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80394F433D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 03:06:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5492402DD;
	Thu, 16 Apr 2026 05:06:21 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 3C6E1402A3
 for <dev@dpdk.org>; Thu, 16 Apr 2026 05:06:17 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=2BedrUqqiuVa8HE3a+McICEiZ9uZ2bBJyAOTuYRHsd8=;
 b=f2gqcF2B/yOtTQbqScejoaUeXBvWT041omyBzWc/7q0IxRi3uB74P5NqUtwYMfHKvL/QhqSAR
 jqxvh2nfm88zbfRexLhxMiQ/2zdAg6ijCcNdI5FNAnaseKNC9+UWr2JwwEi2nd3nKVdA+BWik1s
 VbCAC/jH4E8eB9aGfa4AdHQ=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fx2my2YtrzpSyr;
 Thu, 16 Apr 2026 11:00:02 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 27D6240561;
 Thu, 16 Apr 2026 11:06:16 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 11:06:15 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 16 Apr 2026 11:06:15 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 07/15] power: add a common macro to verify lcore ID
Date: Thu, 16 Apr 2026 11:06:04 +0800
Message-ID: <20260416030612.2379407-8-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260416030612.2379407-1-lihuisong@huawei.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)
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

There are many places to verify lcore ID in power lib or driver.
So add a common macro to do this to simplify code.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/power/power_common.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/power/power_common.h b/lib/power/power_common.h
index 3f56b1103d..5f13068ad6 100644
--- a/lib/power/power_common.h
+++ b/lib/power/power_common.h
@@ -23,6 +23,13 @@ extern int rte_power_logtype;
 #define POWER_DEBUG_LOG(...)
 #endif
 
+#define RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, retval) do { \
+	if (!rte_lcore_is_enabled(lcore_id)) { \
+		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id); \
+		return retval; \
+	} \
+} while (0)
+
 /* check if scaling driver matches one we want */
 __rte_internal
 int cpufreq_check_scaling_driver(const char *driver);
-- 
2.33.0

