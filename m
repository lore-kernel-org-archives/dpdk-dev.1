Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0EECD4846
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 02:35:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78EE440673;
	Tue, 12 May 2026 04:35:23 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 0A7054060C
 for <dev@dpdk.org>; Tue, 12 May 2026 04:35:19 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=u4L5e8DrZXovSvSVCgUCid80mZ7HZX3fC5NURUl0rDY=;
 b=AkMxmEVD31RoILfb7BHcgyS5pkp4Hb8OwQC2NOG6NsoJz8ut9ZAHNReo/nHL2MDWBmJR+9agb
 OjUBIB7jhGSyzLXIPnZsz5MMdL4ALLMgkXokgobOEJqVY6KbXLedwhRP4kLF4ud5XUyHr5bOuIa
 LPRaDvRNJAY6y5F3gMJiAC8=
Received: from mail.maildlp.com (unknown [172.19.163.163])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gF0qY6LJtzL33n;
 Tue, 12 May 2026 10:27:37 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 991D14056E;
 Tue, 12 May 2026 10:35:16 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
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
Subject: [PATCH v1 4/7] examples/l3fwd-power: relocate uncore initialization
Date: Tue, 12 May 2026 10:35:10 +0800
Message-ID: <20260512023513.460169-5-lihuisong@huawei.com>
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

Currently, the deinitialization of uncore is in deinit_power_library().
But its initialization is located in the parameter parsing function,
which is not good to maintain.
So move this logic to init_power_library().

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 examples/l3fwd-power/main.c | 192 ++++++++++++++++++------------------
 1 file changed, 97 insertions(+), 95 deletions(-)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index 45b6697c85..a22634a04e 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -149,9 +149,6 @@ static struct rte_timer telemetry_timer;
 /* stats index returned by metrics lib */
 int telstats_index;
 
-/* flag to check if uncore option enabled */
-int enabled_uncore = -1;
-
 struct telstats_name {
 	char name[RTE_ETH_XSTATS_NAME_SIZE];
 };
@@ -170,12 +167,6 @@ enum busy_rate {
 	FULL = 100
 };
 
-enum uncore_choice {
-	UNCORE_MIN = 0,
-	UNCORE_MAX = 1,
-	UNCORE_IDX = 2
-};
-
 /* reference poll count to measure core busyness */
 #define DEFAULT_COUNT 10000
 /*
@@ -212,6 +203,19 @@ enum freq_scale_hint_t
 	FREQ_HIGHEST  =       2
 };
 
+enum uncore_choice {
+	UNCORE_MIN = 0,
+	UNCORE_MAX = 1,
+	UNCORE_IDX = 2
+};
+
+/* flag to check if uncore option enabled */
+int enabled_uncore = -1;
+struct uncore_cfg {
+	enum uncore_choice uncore_choice;
+	uint32_t freq_idx;
+} g_uncore_cfg;
+
 struct __rte_cache_aligned lcore_rx_queue {
 	uint16_t port_id;
 	uint16_t queue_id;
@@ -1552,80 +1556,6 @@ parse_uint(const char *opt, uint32_t max, uint32_t *res)
 	return 0;
 }
 
-static int
-parse_uncore_options(enum uncore_choice choice, const char *argument)
-{
-	unsigned int die, pkg, max_pkg, max_die;
-	int ret = 0;
-	ret = rte_power_set_uncore_env(RTE_UNCORE_PM_ENV_AUTO_DETECT);
-	if (ret < 0) {
-		RTE_LOG(INFO, L3FWD_POWER, "Failed to set uncore env\n");
-		return ret;
-	}
-
-	max_pkg = rte_power_uncore_get_num_pkgs();
-	if (max_pkg == 0)
-		return -1;
-
-	for (pkg = 0; pkg < max_pkg; pkg++) {
-		max_die = rte_power_uncore_get_num_dies(pkg);
-		if (max_die == 0)
-			return -1;
-		for (die = 0; die < max_die; die++) {
-			ret = rte_power_uncore_init(pkg, die);
-			if (ret == -1) {
-				RTE_LOG(INFO, L3FWD_POWER, "Unable to initialize uncore for pkg %02u die %02u\n"
-				, pkg, die);
-				return ret;
-			}
-			if (choice == UNCORE_MIN) {
-				ret = rte_power_uncore_freq_min(pkg, die);
-				if (ret == -1) {
-					RTE_LOG(INFO, L3FWD_POWER,
-					"Unable to set the uncore frequency to minimum value for pkg %02u die %02u\n"
-					, pkg, die);
-					return ret;
-				}
-			} else if (choice == UNCORE_MAX) {
-				ret = rte_power_uncore_freq_max(pkg, die);
-				if (ret == -1) {
-					RTE_LOG(INFO, L3FWD_POWER,
-					"Unable to set uncore frequency to maximum value for pkg %02u die %02u\n"
-					, pkg, die);
-					return ret;
-				}
-			} else if (choice == UNCORE_IDX) {
-				char *ptr = NULL;
-				int frequency_index = strtol(argument, &ptr, 10);
-				if (argument == ptr) {
-					RTE_LOG(INFO, L3FWD_POWER, "Index given is not a valid number.");
-					return -1;
-				}
-				int freq_array_len = rte_power_uncore_get_num_freqs(pkg, die);
-				if (frequency_index > freq_array_len - 1) {
-					RTE_LOG(INFO, L3FWD_POWER,
-					"Frequency index given out of range, please choose a value from 0 to %d.\n",
-					freq_array_len);
-					return -1;
-				}
-				ret = rte_power_set_uncore_freq(pkg, die, frequency_index);
-				if (ret == -1) {
-					RTE_LOG(INFO, L3FWD_POWER,
-					"Unable to set specified frequency index for pkg %02u die %02u\n",
-					pkg, die);
-					return ret;
-				}
-			} else {
-				RTE_LOG(INFO, L3FWD_POWER, "Uncore choice provided invalid\n");
-				return -1;
-			}
-		}
-	}
-
-	RTE_LOG(INFO, L3FWD_POWER, "Successfully set max/min/index uncore frequency.\n");
-	return ret;
-}
-
 static int
 parse_portmask(const char *portmask)
 {
@@ -1793,25 +1723,21 @@ parse_args(int argc, char **argv)
 			promiscuous_on = 1;
 			break;
 		case 'u':
-			enabled_uncore = parse_uncore_options(UNCORE_MIN, NULL);
-			if (enabled_uncore < 0) {
-				print_usage(prgname);
-				return -1;
-			}
+			enabled_uncore = 0;
+			g_uncore_cfg.uncore_choice = UNCORE_MIN;
 			break;
 		case 'U':
-			enabled_uncore = parse_uncore_options(UNCORE_MAX, NULL);
-			if (enabled_uncore < 0) {
-				print_usage(prgname);
-				return -1;
-			}
+			enabled_uncore = 0;
+			g_uncore_cfg.uncore_choice = UNCORE_MAX;
 			break;
 		case 'i':
-			enabled_uncore = parse_uncore_options(UNCORE_IDX, optarg);
-			if (enabled_uncore < 0) {
+			enabled_uncore = 0;
+			if (parse_uint(optarg, UINT32_MAX, &g_uncore_cfg.freq_idx) != 0) {
+				RTE_LOG(INFO, L3FWD_POWER, "Index given is not a valid number.");
 				print_usage(prgname);
 				return -1;
 			}
+			g_uncore_cfg.uncore_choice = UNCORE_IDX;
 			break;
 		/* long options */
 		case 0:
@@ -2264,6 +2190,78 @@ static int check_ptype(uint16_t portid)
 
 }
 
+static int
+power_uncore_init(void)
+{
+	unsigned int die, pkg, max_pkg, max_die;
+	int ret;
+
+	if (enabled_uncore == -1)
+		return 0;
+
+	ret = rte_power_set_uncore_env(RTE_UNCORE_PM_ENV_AUTO_DETECT);
+	if (ret < 0) {
+		RTE_LOG(INFO, L3FWD_POWER, "Failed to set uncore env\n");
+		return ret;
+	}
+
+	max_pkg = rte_power_uncore_get_num_pkgs();
+	if (max_pkg == 0)
+		return -1;
+
+	for (pkg = 0; pkg < max_pkg; pkg++) {
+		max_die = rte_power_uncore_get_num_dies(pkg);
+		if (max_die == 0)
+			return -1;
+		for (die = 0; die < max_die; die++) {
+			ret = rte_power_uncore_init(pkg, die);
+			if (ret == -1) {
+				RTE_LOG(INFO, L3FWD_POWER, "Unable to initialize uncore for pkg %02u die %02u\n"
+				, pkg, die);
+				return ret;
+			}
+			if (g_uncore_cfg.uncore_choice == UNCORE_MIN) {
+				ret = rte_power_uncore_freq_min(pkg, die);
+				if (ret == -1) {
+					RTE_LOG(INFO, L3FWD_POWER,
+					"Unable to set the uncore frequency to minimum value for pkg %02u die %02u\n"
+					, pkg, die);
+					return ret;
+				}
+			} else if (g_uncore_cfg.uncore_choice == UNCORE_MAX) {
+				ret = rte_power_uncore_freq_max(pkg, die);
+				if (ret == -1) {
+					RTE_LOG(INFO, L3FWD_POWER,
+					"Unable to set uncore frequency to maximum value for pkg %02u die %02u\n"
+					, pkg, die);
+					return ret;
+				}
+			} else if (g_uncore_cfg.uncore_choice == UNCORE_IDX) {
+				int freq_array_len = rte_power_uncore_get_num_freqs(pkg, die);
+				if (freq_array_len <= 0) {
+					RTE_LOG(INFO, L3FWD_POWER, "Get uncore frequency number failed.\n");
+					return -1;
+				}
+				if (g_uncore_cfg.freq_idx > (uint32_t)(freq_array_len - 1)) {
+					RTE_LOG(INFO, L3FWD_POWER,
+					"Frequency index given out of range, please choose a value from 0 to %d.\n",
+					freq_array_len);
+					return -1;
+				}
+				ret = rte_power_set_uncore_freq(pkg, die, g_uncore_cfg.freq_idx);
+				if (ret == -1) {
+					RTE_LOG(INFO, L3FWD_POWER,
+					"Unable to set specified frequency index for pkg %02u die %02u\n",
+					pkg, die);
+					return ret;
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int
 init_power_library(void)
 {
@@ -2295,6 +2293,10 @@ init_power_library(void)
 		}
 	}
 
+	ret = power_uncore_init();
+	if (ret != 0)
+		return ret;
+
 	if (cpu_resume_latency != -1) {
 		RTE_LCORE_FOREACH(lcore_id) {
 			/* Back old CPU resume latency. */
-- 
2.33.0

