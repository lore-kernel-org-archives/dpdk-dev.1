Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18D5CD37BE
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 02:35:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DB9F4066A;
	Tue, 12 May 2026 04:35:22 +0200 (CEST)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com
 [113.46.200.225])
 by mails.dpdk.org (Postfix) with ESMTP id 4BA6540264
 for <dev@dpdk.org>; Tue, 12 May 2026 04:35:18 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=VRxkrcq6J6vHNm0wbZTl8DPv6vwMGL5o/4Mt8Im4szE=;
 b=hZ6CN9rmVUqRB26t2qXB2db2TMlq047RjpJ8AjYOTKt2XUK5syxZ1yC8gNwfpX4Fa0GV/oSb9
 hsMrl11WFybnCXLbAqPN9f0UL30mfXoMoYByaW+CYPo+pEVZPsv22qLHG/HlyQHpwD7PtKEjrHS
 odVbF3yZfGwHEqn+8t1kB24=
Received: from mail.maildlp.com (unknown [172.19.163.214])
 by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gF0qd5yFtz1KSnK;
 Tue, 12 May 2026 10:27:41 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
 by mail.maildlp.com (Postfix) with ESMTPS id C35B640561;
 Tue, 12 May 2026 10:35:16 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 May 2026 10:35:16 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 12 May 2026 10:35:15 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v1 3/7] examples/l3fwd-power: fix uncore help and log info
Date: Tue, 12 May 2026 10:35:09 +0800
Message-ID: <20260512023513.460169-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260512023513.460169-1-lihuisong@huawei.com>
References: <20260512023513.460169-1-lihuisong@huawei.com>
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

The '-i' parameter is to set any uncore frequency rather than
min/max value. And the error logs are not clear enough, fix it
by the way.

Fixes: 10db2a5b8724 ("examples/l3fwd-power: add options for uncore frequency")
Cc: stable@dpdk.org

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 doc/guides/sample_app_ug/l3_forward_power_man.rst | 2 +-
 examples/l3fwd-power/main.c                       | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/guides/sample_app_ug/l3_forward_power_man.rst b/doc/guides/sample_app_ug/l3_forward_power_man.rst
index 3271bc2154..dc882c5d77 100644
--- a/doc/guides/sample_app_ug/l3_forward_power_man.rst
+++ b/doc/guides/sample_app_ug/l3_forward_power_man.rst
@@ -106,7 +106,7 @@ where,
 
 *   -U: optional, sets uncore min/max frequency to maximum value.
 
-*   -i (frequency index): optional, sets uncore frequency to frequency index value, by setting min and max values to be the same.
+*   -i (frequency index): set target frequency for uncore by specified frequency index.
 
 *   --config (port,queue,lcore)[,(port,queue,lcore)]: determines which queues from which ports are mapped to which cores.
 
diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index ba2be5bf32..45b6697c85 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -1498,7 +1498,7 @@ print_usage(const char *prgname)
 		"  -P: enable promiscuous mode\n"
 		"  -u: set min/max frequency for uncore to minimum value\n"
 		"  -U: set min/max frequency for uncore to maximum value\n"
-		"  -i (frequency index): set min/max frequency for uncore to specified frequency index\n"
+		"  -i (frequency index): set target frequency for uncore by specified frequency index\n"
 		"  --config (port,queue,lcore): rx queues configuration\n"
 		"  --eth-link-speed: force link speed\n"
 		"  --cpu-resume-latency LATENCY: set CPU resume latency to control C-state selection,"
@@ -1582,7 +1582,7 @@ parse_uncore_options(enum uncore_choice choice, const char *argument)
 				ret = rte_power_uncore_freq_min(pkg, die);
 				if (ret == -1) {
 					RTE_LOG(INFO, L3FWD_POWER,
-					"Unable to set the uncore min/max to minimum uncore frequency value for pkg %02u die %02u\n"
+					"Unable to set the uncore frequency to minimum value for pkg %02u die %02u\n"
 					, pkg, die);
 					return ret;
 				}
@@ -1590,7 +1590,7 @@ parse_uncore_options(enum uncore_choice choice, const char *argument)
 				ret = rte_power_uncore_freq_max(pkg, die);
 				if (ret == -1) {
 					RTE_LOG(INFO, L3FWD_POWER,
-					"Unable to set uncore min/max to maximum uncore frequency value for pkg %02u die %02u\n"
+					"Unable to set uncore frequency to maximum value for pkg %02u die %02u\n"
 					, pkg, die);
 					return ret;
 				}
@@ -1611,7 +1611,7 @@ parse_uncore_options(enum uncore_choice choice, const char *argument)
 				ret = rte_power_set_uncore_freq(pkg, die, frequency_index);
 				if (ret == -1) {
 					RTE_LOG(INFO, L3FWD_POWER,
-					"Unable to set min/max uncore index value for pkg %02u die %02u\n",
+					"Unable to set specified frequency index for pkg %02u die %02u\n",
 					pkg, die);
 					return ret;
 				}
-- 
2.33.0

