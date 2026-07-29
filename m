Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE14C54F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 02:55:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62924402BB;
	Wed, 29 Jul 2026 04:54:58 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 77F5D40647
 for <dev@dpdk.org>; Wed, 29 Jul 2026 04:54:55 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JvfzdlOdEuPue5u0+S87osLpsky75w4qjdacC5T6BIg=;
 b=IBwTrptkOYq3XReHrY+v7UyN37D035d37FFseAq+ktHlzIRZkyc0AFqV1QV8HieJnDZNktXRm
 RhoaEkKy1TshRnpsLM+AaLCnjmB9Uh9Df4Z2tWD8Dk3EpPZ5zuyp26Sbi0YW/CXLly/+Kb/vx/t
 yxBQ6DHOxYgPHpS+Y9uqJtY=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h8xXJ2b3QzpSvB;
 Wed, 29 Jul 2026 10:45:36 +0800 (CST)
Received: from kwepemo100005.china.huawei.com (unknown [7.202.195.212])
 by mail.maildlp.com (Postfix) with ESMTPS id 3123040561;
 Wed, 29 Jul 2026 10:54:53 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100005.china.huawei.com (7.202.195.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 29 Jul 2026 10:54:52 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <anatoly.burakov@intel.com>, <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>, <yangxingui@huawei.com>, <zhanjie9@hisilicon.com>, 
 <lihuisong@huawei.com>
Subject: [PATCH v4 3/6] examples/l3fwd-power: fix uncore help and log info
Date: Wed, 29 Jul 2026 10:51:46 +0800
Message-ID: <20260729025149.2158868-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20260729025149.2158868-1-lihuisong@huawei.com>
References: <20260729025149.2158868-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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
index f33f3b2f94..ef3f1f1519 100644
--- a/doc/guides/sample_app_ug/l3_forward_power_man.rst
+++ b/doc/guides/sample_app_ug/l3_forward_power_man.rst
@@ -106,7 +106,7 @@ where,
 
 *   -U: optional, sets uncore min/max frequency to maximum value.
 
-*   -i (frequency index): optional, sets uncore frequency to frequency index value, by setting min and max values to be the same.
+*   -i (frequency index): set target frequency for uncore by specified frequency index.
 
 *   --config (port,queue,lcore)[,(port,queue,lcore)]: determines which queues from which ports are mapped to which cores.
 
diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 3af10c629a..72d4642ea4 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -1497,7 +1497,7 @@ print_usage(const char *prgname)
 		"  -P: enable promiscuous mode\n"
 		"  -u: set min/max frequency for uncore to minimum value\n"
 		"  -U: set min/max frequency for uncore to maximum value\n"
-		"  -i (frequency index): set min/max frequency for uncore to specified frequency index\n"
+		"  -i (frequency index): set target frequency for uncore by specified frequency index\n"
 		"  --config (port,queue,lcore): rx queues configuration\n"
 		"  --eth-link-speed: force link speed\n"
 		"  --cpu-resume-latency LATENCY: set CPU resume latency to control C-state selection,"
@@ -1581,7 +1581,7 @@ parse_uncore_options(enum uncore_choice choice, const char *argument)
 				ret = rte_power_uncore_freq_min(pkg, die);
 				if (ret == -1) {
 					RTE_LOG(INFO, L3FWD_POWER,
-					"Unable to set the uncore min/max to minimum uncore frequency value for pkg %02u die %02u\n"
+					"Unable to set the uncore frequency to minimum value for pkg %02u die %02u\n"
 					, pkg, die);
 					return ret;
 				}
@@ -1589,7 +1589,7 @@ parse_uncore_options(enum uncore_choice choice, const char *argument)
 				ret = rte_power_uncore_freq_max(pkg, die);
 				if (ret == -1) {
 					RTE_LOG(INFO, L3FWD_POWER,
-					"Unable to set uncore min/max to maximum uncore frequency value for pkg %02u die %02u\n"
+					"Unable to set uncore frequency to maximum value for pkg %02u die %02u\n"
 					, pkg, die);
 					return ret;
 				}
@@ -1610,7 +1610,7 @@ parse_uncore_options(enum uncore_choice choice, const char *argument)
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

