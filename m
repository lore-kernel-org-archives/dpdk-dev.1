Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37606CD342C
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 02:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A91040B9B;
	Thu,  7 May 2026 04:42:51 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 7B4C440658
 for <dev@dpdk.org>; Thu,  7 May 2026 04:42:38 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=SUBh+NbV+kh+n7B52a80hwrIQ3JvcvIMl7N1ygXpHIU=;
 b=bKFGiqUgjNcWsHKjQPx0h9G38mOBLpT4K+KfyDNTktSx9Ay//BGVtPSEjEWNkFYSdjXyWS3P5
 lp/TKrPdp6tys+aDg3SmWFQct980ulVWDM8Z3UooTDUo58eb7fy7QQnp6WF1lVpBrpX/LnXEPEz
 SAayTXWRTDeZK59n/zN7/b8=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4g9xDS166yz1T4Hh;
 Thu,  7 May 2026 10:35:04 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id 9DE604056A;
 Thu,  7 May 2026 10:42:36 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 May 2026 10:42:36 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 7 May 2026 10:42:35 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <fengchengwen@huawei.com>,
 <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH V2 14/15] power: allow the service core to config power QoS
Date: Thu, 7 May 2026 10:42:29 +0800
Message-ID: <20260507024230.1198111-15-lihuisong@huawei.com>
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

The service core thread can use power QoS API.
So allow these cores to config it.

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

