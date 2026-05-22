Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109BCCD4F5B
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 04:12:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C11A4067B;
	Fri, 22 May 2026 06:11:26 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 79295402D9
 for <dev@dpdk.org>; Fri, 22 May 2026 06:11:17 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=r4MpNxLY4GMSEMMpHFljntxLyzoBIVK0O3tjWogL+Xc=;
 b=NLcZmcYn3hNHLZCdrhfjZ7u6Ni3JGfkatq0IPBSwkkN/fcYlE75nI6x4Sx89vdcpsD5DOoGRL
 nfkXA9uDqpttZyZsOPWGUD910Pso9LP5mpkiUQigWlYhzEZX5XbsQNvDiqHNCbtuFMovxmqDGsd
 yBtJxnj2wzHo06xRr+Uo/jo=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gMBTb0Rmvz1prKy;
 Fri, 22 May 2026 12:03:31 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 0D61840537;
 Fri, 22 May 2026 12:11:16 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 May 2026 12:11:15 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 22 May 2026 12:11:15 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v3 09/10] power: allow the service core to config power QoS
Date: Fri, 22 May 2026 12:11:09 +0800
Message-ID: <20260522041110.2023062-10-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260522041110.2023062-1-lihuisong@huawei.com>
References: <20260522041110.2023062-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

The lcore ID verification in power QoS API used to use
rte_lcore_is_enabled(), which only accepts the lcore with
ROLE_RTE role. But service core thread (ROLE_SERVICE) can
also use power QoS API.

So this patch replaces rte_lcore_is_enabled() with the new
helper rte_lcore_is_eal_managed() by using the common macro
RTE_POWER_VALID_LCOREID_OR_ERR_RET. This change makes the
power QoS API accept both ROLE_RTE and ROLE_SERVICE lcores.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 doc/guides/rel_notes/release_26_07.rst |  6 ++++++
 lib/power/rte_power_qos.c              | 10 ++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 98a7cf0203..0eca0261b3 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -76,6 +76,12 @@ New Features
   that the lcore ID is EAL-managed (``ROLE_RTE`` or ``ROLE_SERVICE``)
   before proceeding, replacing per-driver range checks.
 
+  The power QoS library also updated its lcore validation to use the
+  new helper, so service cores (``ROLE_SERVICE``) are now permitted
+  to configure power QoS parameters via ``rte_power_qos_set_cpu_resume_latency()``
+  and ``rte_power_qos_get_cpu_resume_latency()``, in addition to
+  regular DPDK lcores (``ROLE_RTE``).
+
 
 Removed Items
 -------------
diff --git a/lib/power/rte_power_qos.c b/lib/power/rte_power_qos.c
index be230d1c50..f6630b08f7 100644
--- a/lib/power/rte_power_qos.c
+++ b/lib/power/rte_power_qos.c
@@ -27,10 +27,7 @@ rte_power_qos_set_cpu_resume_latency(uint16_t lcore_id, int latency)
 	FILE *f;
 	int ret;
 
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -EINVAL;
-	}
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -EINVAL);
 	ret = power_get_lcore_mapped_cpu_id(lcore_id, &cpu_id);
 	if (ret != 0)
 		return ret;
@@ -82,10 +79,7 @@ rte_power_qos_get_cpu_resume_latency(uint16_t lcore_id)
 	FILE *f;
 	int ret;
 
-	if (!rte_lcore_is_enabled(lcore_id)) {
-		POWER_LOG(ERR, "lcore id %u is not enabled", lcore_id);
-		return -EINVAL;
-	}
+	RTE_POWER_VALID_LCOREID_OR_ERR_RET(lcore_id, -EINVAL);
 	ret = power_get_lcore_mapped_cpu_id(lcore_id, &cpu_id);
 	if (ret != 0)
 		return ret;
-- 
2.33.0

