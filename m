Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D737CCD37B2
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 08:45:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E77E54065A;
	Sat,  9 May 2026 10:45:10 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 65F1940269
 for <dev@dpdk.org>; Sat,  9 May 2026 10:45:08 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=tzmlfOSb4C0F2J+54p+2uewQp4Gy8hflpgBIPoWCqOM=;
 b=qoVw3v/9B+idZnEWMRbo8iEGb9J3/nnJIGApqygR4fZigx8mV8OXLc21aly5MKmuegSPHgoMO
 sVnq4on17EAHGZcrTxfTgupAnMytRTEbAyKtuA2uDVQU/CE6WPx8QjyFAY9MfIr+AsteKuUplgG
 0SYK62CQT8sV95TMKX7DZkM=
Received: from mail.maildlp.com (unknown [172.19.163.200])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gCK9h3H30zKm4S;
 Sat,  9 May 2026 16:37:28 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 7B31640563;
 Sat,  9 May 2026 16:45:05 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 May 2026 16:45:05 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 9 May 2026 16:45:04 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH 3/3] power: use common decimal macro definition
Date: Sat, 9 May 2026 16:45:03 +0800
Message-ID: <20260509084503.2917038-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260509084503.2917038-1-lihuisong@huawei.com>
References: <20260509084503.2917038-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Power QoS uses the common decimal macro definition
to replace magic number.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 lib/power/rte_power_qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/power/rte_power_qos.c b/lib/power/rte_power_qos.c
index be230d1c50..f991230532 100644
--- a/lib/power/rte_power_qos.c
+++ b/lib/power/rte_power_qos.c
@@ -115,7 +115,7 @@ rte_power_qos_get_cpu_resume_latency(uint16_t lcore_id)
 	if (strcmp(buf, "n/a") == 0)
 		latency = RTE_POWER_QOS_STRICT_LATENCY_VALUE;
 	else {
-		latency = strtoul(buf, NULL, 10);
+		latency = strtoul(buf, NULL, POWER_CONVERT_TO_DECIMAL);
 		latency = latency == 0 ? RTE_POWER_QOS_RESUME_LATENCY_NO_CONSTRAINT : latency;
 	}
 
-- 
2.33.0

