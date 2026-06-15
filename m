Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB668CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 07:34:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90A3B436E2;
	Mon, 15 Jun 2026 09:33:44 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 0A2F4436E1
 for <dev@dpdk.org>; Mon, 15 Jun 2026 09:33:42 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=mbvIRgmPFpJA/8iopRGqwNASfLKIokNX49Wd4KQ7Wuo=;
 b=DotB8xAhqnzZTQcgsZYKRR6yxE2/UsAhOLct/9mbSCtLfc77up3OOyuLxYyJXZIGgXLPq7TRM
 TExmEYxAZj6I7mipbPUTLkKPbfSfPtxyMuUVLOV4rD15ichIVOCnq4BNFp2xiHSiaxcmOMrtnAl
 fjUu3KB2WlvmKDwEh3SLFcQ=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gf1qM6YskzcZyh;
 Mon, 15 Jun 2026 15:25:19 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id D3B6940363;
 Mon, 15 Jun 2026 15:33:40 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 15 Jun 2026 15:33:40 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <thomas@monjalon.net>, <anatoly.burakov@intel.com>,
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <stephen@networkplumber.org>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v4 8/9] power: allow the service core to config power QoS
Date: Mon, 15 Jun 2026 15:30:49 +0800
Message-ID: <20260615073050.1996063-9-lihuisong@huawei.com>
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

The lcore ID verification in power QoS API used to use
rte_lcore_is_enabled(), which only accepts the lcore with
ROLE_RTE role. But service core thread (ROLE_SERVICE) can
also use power QoS API.

So use RTE_POWER_VALID_LCOREID_OR_ERR_RET to verify the
lcore ID. This change makes the power QoS API accept both
ROLE_RTE and ROLE_SERVICE lcores.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 doc/guides/rel_notes/release_26_07.rst |  5 ++++-
 lib/power/rte_power_qos.c              | 10 ++--------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index aeabb908ec..5eb3974ddb 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -158,7 +158,10 @@ New Features
 * **Added a common macro to verify lcore ID in power core.**
 
   Added the ``RTE_POWER_VALID_LCOREID_OR_ERR_RET`` macro to verify lcore ID
-  in power core.
+  in power core. The power QoS library also updated its lcore validation to
+  use this macro, so service cores (``ROLE_SERVICE``) are now permitted.
+
+
 
 Removed Items
 -------------
diff --git a/lib/power/rte_power_qos.c b/lib/power/rte_power_qos.c
index f991230532..d8d8d36a76 100644
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

