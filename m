Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59931F433D9
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 03:07:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E32E0406A2;
	Thu, 16 Apr 2026 05:06:33 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id 6CCAA402B0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 05:06:20 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Gp/8iAi0z5S98Z++U8CpFRfuffQGHLkv9E9+yNww1e8=;
 b=i9W0UK9QV41HoqozeCkxgKiRZ6untZeGac7KmL1DKuIPFygnjJ1lPvejk9fR/JX4YXSrJXaM0
 C+rAsjZ5v8rYrmoCJUIlyNmjeTIjwyQLquW0P/XaefTuzk0vjiVBLwsbMfY03jarOU6HVOs6hdf
 m+KbZmNdXJzRJlWUmEl4zkA=
Received: from mail.maildlp.com (unknown [172.19.163.15])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fx2mx0TzfzLlVQ;
 Thu, 16 Apr 2026 11:00:01 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 1FE9A40574;
 Thu, 16 Apr 2026 11:06:19 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 11:06:16 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 16 Apr 2026 11:06:16 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 09/15] power/qos: replace the lcore ID verification with
 new macro
Date: Thu, 16 Apr 2026 11:06:06 +0800
Message-ID: <20260416030612.2379407-10-lihuisong@huawei.com>
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

Replace the duplicate code for validating the ID with
RTE_POWER_VALID_LCOREID_OR_ERR_RET.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/power/rte_power_qos.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

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

