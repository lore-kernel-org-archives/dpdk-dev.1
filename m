Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E6CCD3436
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 02:43:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84D9940674;
	Thu,  7 May 2026 04:42:41 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id ACC2A402BC
 for <dev@dpdk.org>; Thu,  7 May 2026 04:42:35 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=CWoGjgW+Vx5Ex4Blf/1/7VcSEwbzK5HgEWxoaRq1Y0k=;
 b=CsbnAXFRxBL/W4vn6b+/mEH+XOvZoS+6Y6cO8WecD3Lnun7EciYG4Qw8Wll6rB7P1tbPx4EVr
 7JTLRt5QgcrKFGKOkWmWrLO0uM6uDkLwI/Shb1h+hVhoquoUbrak32Fgf+jkpia3MHsn8cG2l2G
 sHY/qp4eQV9BRVhrdWYpKe8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4g9xFC6PYnzpSt7;
 Thu,  7 May 2026 10:35:43 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 585F9203B7;
 Thu,  7 May 2026 10:42:34 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 10:42:33 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 10:42:33 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH V2 07/15] power: add a common macro to verify lcore ID
Date: Thu, 7 May 2026 10:42:22 +0800
Message-ID: <20260507024230.1198111-8-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260507024230.1198111-1-lihuisong@huawei.com>
References: <20260416030612.2379407-1-lihuisong@huawei.com>
 <20260507024230.1198111-1-lihuisong@huawei.com>
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

There are many places to verify lcore ID in power. So add a common macro
to do this to simplify code.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/power/power_common.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/power/power_common.h b/lib/power/power_common.h
index 3f56b1103d..78cebef59b 100644
--- a/lib/power/power_common.h
+++ b/lib/power/power_common.h
@@ -23,6 +23,13 @@ extern int rte_power_logtype;
 #define POWER_DEBUG_LOG(...)
 #endif
 
+#define RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, retval) do { \
+	if (!rte_lcore_is_eal_managed(lcore_id)) { \
+		POWER_LOG(ERR, "lcore id %u is invalid", lcore_id); \
+		return retval; \
+	} \
+} while (0)
+
 /* check if scaling driver matches one we want */
 __rte_internal
 int cpufreq_check_scaling_driver(const char *driver);
-- 
2.33.0

