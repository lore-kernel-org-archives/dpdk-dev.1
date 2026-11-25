Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5B606A323
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Nov 2026 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.a=rsa-sha256 header.s=dkim header.b=TwXvIo9l
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1130D4068A;
	Wed, 25 Nov 2026 15:06:36 +0100 (CET)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTPS id 054C740616
 for <dev@dpdk.org>; Wed, 25 Nov 2026 15:06:30 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=1N04s/+rasNZqbr2OibdjSetraYsQfXS2XS9fXUmkA4=;
 b=TwXvIo9l4RfeURGy4T2kv7b6+dxY+fZEfz/EvIO99lBdw6FZBZGBBqOWziIUl354pMKV9GfI3
 LFRtdYgW4F3EeEsQLrt+voAgY/ORuj4fbxmNwrrhtvbg3YdUiL0SpSKgMiV14a0710LB8hIoX0w
 5mSAe7cwnor4TltC0gJ58+o=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jZM001hHqz1T4H4;
 Wed, 25 Nov 2026 22:05:36 +0800 (CST)
Received: from dggpemr100003.china.huawei.com (unknown [7.185.36.150])
 by mail.maildlp.com (Postfix) with ESMTPS id 4318E40538;
 Wed, 25 Nov 2026 22:06:26 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemr100003.china.huawei.com (7.185.36.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 25 Nov 2026 22:06:25 +0800
From: Shuaisong Yang <yangshuaisong@h-partners.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>, Sivaprasad Tummala
 <sivaprasad.tummala@amd.com>
CC: <dev@dpdk.org>, <yangshuaisong@h-partners.com>, <liuyonglong@huawei.com>, 
 <fengchengwen@huawei.com>, <yangxingui@h-partners.com>,
 <yangxingui@huawei.com>, Huisong Li <lihuisong@huawei.com>
Subject: [PATCH 6/9] examples/l3fwd-power: set freq for specific uncore
Date: Wed, 25 Nov 2026 22:06:12 +0800
Message-ID: <20261125140616.3965843-7-yangshuaisong@h-partners.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
References: <20261125140616.3965843-1-yangshuaisong@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr100003.china.huawei.com (7.185.36.150)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Huisong Li <lihuisong@huawei.com>

l3fwd-power only supports the -u/-U/-i options which apply the
uncore frequency to all packages and dies. Add a new --uncore-freq
option so users can set the uncore frequency for specific
package/die pairs.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Signed-off-by: Shuaisong Yang <yangshuaisong@h-partners.com>
---
 .../sample_app_ug/l3_forward_power_man.rst    |  13 +
 examples/l3fwd-power/main.c                   | 309 ++++++++++++++----
 2 files changed, 253 insertions(+), 69 deletions(-)

diff --git a/doc/guides/sample_app_ug/l3_forward_power_man.rst b/doc/guides/sample_app_ug/l3_forward_power_man.rst
index ef3f1f1519..442d8f0c8f 100644
--- a/doc/guides/sample_app_ug/l3_forward_power_man.rst
+++ b/doc/guides/sample_app_ug/l3_forward_power_man.rst
@@ -108,6 +108,8 @@ where,
 
 *   -i (frequency index): set target frequency for uncore by specified frequency index.
 
+*   --uncore-freq=(\\(package,\\domain,\\frequency\\))(\\(package,\\domain,\\frequency\\)): optional, set target frequency for the specified uncore. <frequency> is min, max or a frequency index. If not given, -u/-U/-i apply to all uncore. May be specified multiple times.
+
 *   --config (port,queue,lcore)[,(port,queue,lcore)]: determines which queues from which ports are mapped to which cores.
 
 *   --cpu-resume-latency LATENCY: set CPU resume latency to control C-state selection, 0 : just allow entering C0-state.
@@ -333,6 +335,17 @@ Three options are available for setting uncore frequency:
   Frequency index values are in descending order,
   i.e., index 0 is maximum frequency index.
 
+``--uncore-freq``
+  This will allow you to set the uncore frequency for specific packages and dies.
+  Each ``(package,domain,frequency)`` group targets one uncore, where ``frequency``
+  is ``min``, ``max`` or a frequency index. Multiple groups can be given in a single
+  option. The ``-u``, ``-U`` and ``-i`` options apply to all packages and dies and
+  cannot be used together with ``--uncore-freq``.
+
 .. code-block:: console
 
    dpdk-l3fwd-power -l 1-3 -- -p 0x0f --config="(0,0,2),(0,1,3)" -i 1
+
+.. code-block:: console
+
+   dpdk-l3fwd-power -l 1-3 -- -p 0x0f --config="(0,0,2),(0,1,3)" --uncore-freq="(0,0,max)(0,1,1)"
diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index b6430f0c78..da44d74c0f 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -211,10 +211,15 @@ enum uncore_choice {
 
 /* flag to check if uncore option enabled */
 int enabled_uncore = -1;
+#define MAX_UNCORE_CFG 32
 static struct uncore_cfg {
+	uint16_t pkg;
+	uint16_t die;
 	enum uncore_choice uncore_choice;
 	uint32_t freq_idx;
-} uncore_cfg;
+} uncore_cfg[MAX_UNCORE_CFG];
+static uint32_t nb_uncore_cfg;
+static bool uncore_legacy;
 
 struct __rte_cache_aligned lcore_rx_queue {
 	uint16_t port_id;
@@ -1494,6 +1499,7 @@ print_usage(const char *prgname)
 {
 	printf ("%s [EAL options] -- -p PORTMASK -P"
 		"  [--config (port,queue,lcore)[,(port,queue,lcore]]"
+		"  [--uncore-freq (pkg,die,freq)[,(pkg,die,freq]]"
 		"  [--high-perf-cores CORELIST"
 		"  [--perf-config (port,queue,hi_perf,lcore_index)[,(port,queue,hi_perf,lcore_index]]"
 		"  [--max-pkt-len PKTLEN]\n"
@@ -1502,6 +1508,8 @@ print_usage(const char *prgname)
 		"  -u: set min/max frequency for uncore to minimum value\n"
 		"  -U: set min/max frequency for uncore to maximum value\n"
 		"  -i (frequency index): set target frequency for uncore by specified frequency index\n"
+		"  --uncore-freq (pkg,die,freq)[,(pkg,die,freq)]: set target frequency for the"
+		" specified uncore where freq is min, max or a frequency index\n"
 		"  --config (port,queue,lcore): rx queues configuration\n"
 		"  --eth-link-speed: force link speed\n"
 		"  --cpu-resume-latency LATENCY: set CPU resume latency to control C-state selection,"
@@ -1569,6 +1577,66 @@ parse_portmask(const char *portmask)
 	return pm;
 }
 
+static int
+parse_uncore_freq(const char *q_arg)
+{
+	unsigned long  pkg, die, freq_idx = 0;
+	const char *p, *p0 = q_arg;
+	enum uncore_choice choice;
+	char s[64];
+	char *end;
+	int i;
+
+	while ((p = strchr(p0, '(')) != NULL) {
+		++p;
+		p0 = strchr(p, ')');
+		if (p0 == NULL)
+			return -1;
+
+		if ((uint32_t)(p0 - p) >= sizeof(s))
+			return -1;
+		snprintf(s, sizeof(s), "%.*s", (int)(p0 - p), p);
+
+		end = s;
+		pkg = strtoul(end, &end, 0);
+		if (*end != ',' || pkg > UINT16_MAX)
+			return -1;
+		die = strtoul(++end, &end, 0);
+		if (*end != ',' || die > UINT16_MAX)
+			return -1;
+		end++;
+		if (strncmp(end, "min", 3) == 0) {
+			choice = UNCORE_MIN;
+			end += 3;
+		} else if (strncmp(end, "max", 3) == 0) {
+			choice = UNCORE_MAX;
+			end += 3;
+		} else {
+			freq_idx = strtoul(end, &end, 0);
+			if (end == s || freq_idx > UINT32_MAX)
+				return -1;
+			choice = UNCORE_IDX;
+		}
+		if (*end != '\0')
+			return -1;
+
+		if (nb_uncore_cfg >= MAX_UNCORE_CFG) {
+			RTE_LOG(INFO, L3FWD_POWER, "Too many uncore freq options,"
+				" max is %d\n", MAX_UNCORE_CFG);
+			return -1;
+		}
+
+		i = nb_uncore_cfg;
+		uncore_cfg[i].pkg = pkg;
+		uncore_cfg[i].die = die;
+		uncore_cfg[i].uncore_choice = choice;
+		uncore_cfg[i].freq_idx = freq_idx;
+		nb_uncore_cfg++;
+	}
+
+	return 0;
+}
+
 static int
 parse_config(const char *q_arg)
 {
@@ -1671,6 +1739,7 @@ parse_pmd_mgmt_config(const char *name)
 #define CMD_LINE_OPT_SCALE_FREQ_MIN "scale-freq-min"
 #define CMD_LINE_OPT_SCALE_FREQ_MAX "scale-freq-max"
 #define CMD_LINE_OPT_CPU_RESUME_LATENCY "cpu-resume-latency"
+#define CMD_LINE_OPT_UNCORE_FREQ "uncore-freq"
 #define CMD_LINK_OPT_ETH_LINK_SPEED "eth-link-speed"
 
 /* Parse the argument given in the command line of the application */
@@ -1699,6 +1768,7 @@ parse_args(int argc, char **argv)
 		{CMD_LINE_OPT_SCALE_FREQ_MIN, 1, 0, 0},
 		{CMD_LINE_OPT_SCALE_FREQ_MAX, 1, 0, 0},
 		{CMD_LINK_OPT_ETH_LINK_SPEED, 1, 0, 0},
+		{CMD_LINE_OPT_UNCORE_FREQ, 1, 0, 0},
 		{NULL, 0, 0, 0}
 	};
 
@@ -1722,21 +1792,42 @@ parse_args(int argc, char **argv)
 			promiscuous_on = 1;
 			break;
 		case 'u':
+			if (nb_uncore_cfg > 0) {
+				RTE_LOG(INFO, L3FWD_POWER,
+					"Option -u cannot be used together with --uncore-freq\n");
+				print_usage(prgname);
+				return -1;
+			}
 			enabled_uncore = 0;
-			uncore_cfg.uncore_choice = UNCORE_MIN;
+			uncore_legacy = true;
+			uncore_cfg[0].uncore_choice = UNCORE_MIN;
 			break;
 		case 'U':
+			if (nb_uncore_cfg > 0) {
+				RTE_LOG(INFO, L3FWD_POWER,
+					"Option -U cannot be used together with --uncore-freq\n");
+				print_usage(prgname);
+				return -1;
+			}
 			enabled_uncore = 0;
-			uncore_cfg.uncore_choice = UNCORE_MAX;
+			uncore_legacy = true;
+			uncore_cfg[0].uncore_choice = UNCORE_MAX;
 			break;
 		case 'i':
+			if (nb_uncore_cfg > 0) {
+				RTE_LOG(INFO, L3FWD_POWER,
+					"Option -i cannot be used together with --uncore-freq\n");
+				print_usage(prgname);
+				return -1;
+			}
 			enabled_uncore = 0;
-			if (parse_uint(optarg, UINT32_MAX, &uncore_cfg.freq_idx) != 0) {
-				RTE_LOG(INFO, L3FWD_POWER, "Index given is not a valid number.");
+			uncore_legacy = true;
+			if (parse_uint(optarg, UINT32_MAX, &uncore_cfg[0].freq_idx) != 0) {
+				RTE_LOG(INFO, L3FWD_POWER, "Invalid freq index");
 				print_usage(prgname);
 				return -1;
 			}
-			uncore_cfg.uncore_choice = UNCORE_IDX;
+			uncore_cfg[0].uncore_choice = UNCORE_IDX;
 			break;
 		/* long options */
 		case 0:
@@ -1893,6 +1984,26 @@ parse_args(int argc, char **argv)
 					port_conf.link_speeds = rte_eth_speed_bitflag(speed_num, 0);
 			}
 
+			if (!strncmp(lgopts[option_index].name,
+					CMD_LINE_OPT_UNCORE_FREQ,
+					sizeof(CMD_LINE_OPT_UNCORE_FREQ))) {
+				if (uncore_legacy) {
+					RTE_LOG(INFO, L3FWD_POWER,
+						"Option --uncore-freq cannot be used together"
+						" with -u/-U/-i\n");
+					print_usage(prgname);
+					return -1;
+				}
+				if (parse_uncore_freq(optarg) != 0) {
+					RTE_LOG(INFO, L3FWD_POWER,
+						"Invalid uncore freq, expected <package>,<domain>,<frequency>\n");
+					print_usage(prgname);
+					return -1;
+				}
+				enabled_uncore = 0;
+				uncore_legacy = false;
+			}
+
 			break;
 
 		default:
@@ -2189,12 +2300,60 @@ static int check_ptype(uint16_t portid)
 
 }
 
+static int
+set_uncore_freq(uint32_t pkg, uint32_t die, struct uncore_cfg *cfg)
+{
+	int freq_array_len;
+	int ret;
+
+	if (cfg->uncore_choice == UNCORE_MIN) {
+		ret = rte_power_uncore_freq_min(pkg, die);
+		if (ret == -1) {
+			RTE_LOG(INFO, L3FWD_POWER,
+			"Unable to set the uncore frequency to minimum value for pkg %u die %u\n"
+			, pkg, die);
+			return -1;
+		}
+	} else if (cfg->uncore_choice == UNCORE_MAX) {
+		ret = rte_power_uncore_freq_max(pkg, die);
+		if (ret == -1) {
+			RTE_LOG(INFO, L3FWD_POWER,
+			"Unable to set uncore frequency to maximum value for pkg %u die %u\n"
+			, pkg, die);
+			return -1;
+		}
+	} else if (cfg->uncore_choice == UNCORE_IDX) {
+		freq_array_len = rte_power_uncore_get_num_freqs(pkg, die);
+		if (freq_array_len <= 0) {
+			RTE_LOG(INFO, L3FWD_POWER, "Get uncore frequency number failed.\n");
+			return -1;
+		}
+		if (cfg->freq_idx > (uint32_t)(freq_array_len - 1)) {
+			RTE_LOG(INFO, L3FWD_POWER,
+			"Invalid freq index, please choose a value from 0 to %d.\n",
+			freq_array_len - 1);
+			return -1;
+		}
+		ret = rte_power_set_uncore_freq(pkg, die, cfg->freq_idx);
+		if (ret == -1) {
+			RTE_LOG(INFO, L3FWD_POWER,
+			"Unable to set specified frequency index for pkg %u die %u\n",
+			pkg, die);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 static int
 power_uncore_init(void)
 {
-	unsigned int die, pkg, max_pkg, max_die;
-	unsigned int init_pkg = 0, init_die = 0;
+	uint32_t max_pkg, max_die, die, pkg;
+	uint32_t init_pkg = 0, init_die = 0;
 	bool init_done = false;
+	uint32_t init_nb = 0;
+	uint32_t i;
 	int ret;
 
 	if (enabled_uncore == -1)
@@ -2206,84 +2365,96 @@ power_uncore_init(void)
 		return ret;
 	}
 
-	max_pkg = rte_power_uncore_get_num_pkgs();
-	if (max_pkg == 0)
-		return -1;
+	if (uncore_legacy) {
+		/* No specific uncore targeted, apply to all pkg/die. */
+		max_pkg = rte_power_uncore_get_num_pkgs();
+		if (max_pkg == 0)
+			return -1;
 
-	for (pkg = 0; pkg < max_pkg; pkg++) {
-		max_die = rte_power_uncore_get_num_dies(pkg);
-		if (max_die == 0) {
-			ret = -1;
-			goto uninit_uncore;
-		}
-		for (die = 0; die < max_die; die++) {
-			ret = rte_power_uncore_init(pkg, die);
-			if (ret == -1) {
-				RTE_LOG(INFO, L3FWD_POWER, "Unable to initialize uncore for pkg %02u die %02u\n"
-				, pkg, die);
+		for (pkg = 0; pkg < max_pkg; pkg++) {
+			max_die = rte_power_uncore_get_num_dies(pkg);
+			if (max_die == 0) {
+				ret = -1;
 				goto uninit_uncore;
 			}
-			init_pkg = pkg;
-			init_die = die;
-			init_done = true;
-
-			if (uncore_cfg.uncore_choice == UNCORE_MIN) {
-				ret = rte_power_uncore_freq_min(pkg, die);
-				if (ret == -1) {
-					RTE_LOG(INFO, L3FWD_POWER,
-					"Unable to set the uncore frequency to minimum value for pkg %02u die %02u\n"
-					, pkg, die);
-					goto uninit_uncore;
-				}
-			} else if (uncore_cfg.uncore_choice == UNCORE_MAX) {
-				ret = rte_power_uncore_freq_max(pkg, die);
+			for (die = 0; die < max_die; die++) {
+				ret = rte_power_uncore_init(pkg, die);
 				if (ret == -1) {
-					RTE_LOG(INFO, L3FWD_POWER,
-					"Unable to set uncore frequency to maximum value for pkg %02u die %02u\n"
+					RTE_LOG(INFO, L3FWD_POWER, "Unable to initialize uncore for pkg %u die %u\n"
 					, pkg, die);
 					goto uninit_uncore;
 				}
-			} else if (uncore_cfg.uncore_choice == UNCORE_IDX) {
-				int freq_array_len = rte_power_uncore_get_num_freqs(pkg, die);
-				if (freq_array_len <= 0) {
-					RTE_LOG(INFO, L3FWD_POWER, "Get uncore frequency number failed.\n");
-					ret = -1;
-					goto uninit_uncore;
-				}
-				if (uncore_cfg.freq_idx > (uint32_t)(freq_array_len - 1)) {
-					RTE_LOG(INFO, L3FWD_POWER,
-					"Frequency index given out of range, please choose a value from 0 to %d.\n",
-					freq_array_len - 1);
-					ret = -1;
-					goto uninit_uncore;
-				}
-				ret = rte_power_set_uncore_freq(pkg, die, uncore_cfg.freq_idx);
-				if (ret == -1) {
-					RTE_LOG(INFO, L3FWD_POWER,
-					"Unable to set specified frequency index for pkg %02u die %02u\n",
-					pkg, die);
+				init_pkg = pkg;
+				init_die = die;
+				init_done = true;
+
+				ret = set_uncore_freq(pkg, die, &uncore_cfg[0]);
+				if (ret == -1)
 					goto uninit_uncore;
-				}
 			}
 		}
+	} else {
+		max_pkg = rte_power_uncore_get_num_pkgs();
+		if (max_pkg == 0)
+			return -1;
+
+		for (i = 0; i < nb_uncore_cfg; i++) {
+			pkg = uncore_cfg[i].pkg;
+			die = uncore_cfg[i].die;
+
+			if (pkg >= max_pkg) {
+				RTE_LOG(INFO, L3FWD_POWER,
+					"Invalid package id %u, must be less than %u\n",
+					pkg, max_pkg);
+				ret = -1;
+				goto uninit_uncore;
+			}
+			max_die = rte_power_uncore_get_num_dies(pkg);
+			if (die >= max_die) {
+				RTE_LOG(INFO, L3FWD_POWER,
+					"Invalid die id %u for pkg %u, must be less than %u\n",
+					die, pkg, max_die);
+				ret = -1;
+				goto uninit_uncore;
+			}
+
+			ret = rte_power_uncore_init(pkg, die);
+			if (ret == -1) {
+				RTE_LOG(INFO, L3FWD_POWER, "Unable to initialize uncore for pkg %u die %u\n"
+				, pkg, die);
+				goto uninit_uncore;
+			}
+			init_nb = i + 1;
+
+			ret = set_uncore_freq(pkg, die, &uncore_cfg[i]);
+			if (ret == -1)
+				goto uninit_uncore;
+		}
 	}
 
 	return 0;
 
 uninit_uncore:
 	/* Roll back the pkg/die that were initialized before the failure. */
-	if (init_done) {
-		for (pkg = 0; pkg <= init_pkg; pkg++) {
-			if (pkg == init_pkg)
-				max_die = init_die + 1;
-			else {
-				max_die = rte_power_uncore_get_num_dies(pkg);
-				if (max_die == 0)
-					break;
+	if (uncore_legacy) {
+		if (init_done) {
+			for (pkg = 0; pkg <= init_pkg; pkg++) {
+				if (pkg == init_pkg)
+					max_die = init_die + 1;
+				else {
+					max_die = rte_power_uncore_get_num_dies(pkg);
+					if (max_die == 0)
+						break;
+				}
+				for (die = 0; die < max_die; die++)
+					rte_power_uncore_exit(pkg, die);
 			}
-			for (die = 0; die < max_die; die++)
-				rte_power_uncore_exit(pkg, die);
 		}
+	} else {
+		/* Only uninit the targeted uncore that were initialized. */
+		for (i = 0; i < init_nb; i++)
+			rte_power_uncore_exit(uncore_cfg[i].pkg,
+				uncore_cfg[i].die);
 	}
 
 	return ret;
@@ -2305,7 +2476,7 @@ power_uncore_uninit(void)
 			ret = rte_power_uncore_exit(pkg, die);
 			if (ret < 0)
 				RTE_LOG(ERR, L3FWD_POWER,
-					"Failed to exit uncore for pkg %02u die %02u, ret = %d.\n",
+					"Failed to exit uncore for pkg %u die %u, ret = %d.\n",
 					pkg, die, ret);
 		}
 	}
-- 
2.33.0

