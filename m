Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D15CD98C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 07:33:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE9E1436CD;
	Mon, 15 Jun 2026 09:33:31 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id BBD1A436C2
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:33:28 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=4+t5zLl74fDZv4H8q38xlctLuUzMpZD6A5X1ZwmZsAs=;
 b=jNeRWhJbGZkKcqjWKxuRXtkwnlez3+bze+Je7YDg/Rtvfp7zs1fYOASIe6LTA+NRUZNoIueVC
 1lH7WZCYz0s2x5JRfbWA8uzhDem1ynQYBF6lS6lefJOE8IQnPzVeXKTHQcfVRbeQ6Y7ESPskH32
 WyRnaSinPMIsEhRG80/JR+Y=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gf1q04WGGzcb3s;
 Mon, 15 Jun 2026 15:25:00 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 8AF0240537;
 Mon, 15 Jun 2026 15:33:21 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 15 Jun 2026 15:33:21 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <thomas@monjalon.net>, <anatoly.burakov@intel.com>,
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v4 1/9] power: add a common macro to verify lcore ID
Date: Mon, 15 Jun 2026 15:30:42 +0800
Message-ID: <20260615073050.1996063-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260615073050.1996063-1-lihuisong@huawei.com>
References: <20260615073050.1996063-1-lihuisong@huawei.com>
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

There are many places to verify lcore ID in power. It is necessary
to add a common macro in power core.

According to the applicattion in l3fwd-power, the lcore must be at
least within the RTE_MAX_LCORE range and be a core of the ROLE_RTE
role. But the service on the ROLE_SERVICE core also can use and
require power management feature.

So this common macro restricts that the lcore ID must be ROLE_RTE
and ROLE_SERVICE.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 doc/guides/rel_notes/release_26_07.rst | 4 ++++
 lib/power/power_common.h               | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 5d7aa8d1bf..aeabb908ec 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -155,6 +155,10 @@ New Features
   Added AGENTS.md file for AI review
   and supporting scripts to review patches and documentation.
 
+* **Added a common macro to verify lcore ID in power core.**
+
+  Added the ``RTE_POWER_VALID_LCOREID_OR_ERR_RET`` macro to verify lcore ID
+  in power core.
 
 Removed Items
 -------------
diff --git a/lib/power/power_common.h b/lib/power/power_common.h
index e2d5b68a17..370c5246c6 100644
--- a/lib/power/power_common.h
+++ b/lib/power/power_common.h
@@ -25,6 +25,14 @@ extern int rte_power_logtype;
 
 #define POWER_CONVERT_TO_DECIMAL 10
 
+#define RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, retval) do {   \
+	if (rte_eal_lcore_role(lcore_id) != ROLE_RTE &&             \
+	    rte_eal_lcore_role(lcore_id) != ROLE_SERVICE) {         \
+		POWER_LOG(ERR, "lcore id %u is invalid", lcore_id); \
+		return retval;                                      \
+	}                                                           \
+} while (0)
+
 /* check if scaling driver matches one we want */
 __rte_internal
 int cpufreq_check_scaling_driver(const char *driver);
-- 
2.33.0

