Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDDBCA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 01:31:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 587254029E;
	Wed, 27 Aug 2025 03:31:11 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 884694028F
 for <dev@dpdk.org>; Wed, 27 Aug 2025 03:31:09 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cBRh80p6NzPqc6;
 Wed, 27 Aug 2025 09:26:32 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 4A425180495;
 Wed, 27 Aug 2025 09:31:08 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 09:31:07 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <anatoly.burakov@intel.com>,
 <david.hunt@intel.com>, <sivaprasad.tummala@amd.com>, <huisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 2/2] examples/l3fwd-power: support specify link speed
Date: Wed, 27 Aug 2025 09:31:06 +0800
Message-ID: <20250827013106.2453922-2-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250827013106.2453922-1-huangdengdui@huawei.com>
References: <20250827013106.2453922-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

Currently, l3fwd-power starts in auto-negotiation mode, but it may fail
to link up when auto-negotiation is not supported. Therefore, it is
necessary to support starting with a specified speed for port.

Additionally, this patch does not support changing the duplex mode.
 So speeds like 10M, 100M are not configurable using this method.

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 examples/l3fwd-power/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index e27b8531b5..ef2a086572 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -1501,6 +1501,7 @@ print_usage(const char *prgname)
 		"  -U: set min/max frequency for uncore to maximum value\n"
 		"  -i (frequency index): set min/max frequency for uncore to specified frequency index\n"
 		"  --config (port,queue,lcore): rx queues configuration\n"
+		"  --eth-link-speed: force link speed\n"
 		"  --cpu-resume-latency LATENCY: set CPU resume latency to control C-state selection,"
 		" 0 : just allow to enter C0-state\n"
 		"  --high-perf-cores CORELIST: list of high performance cores\n"
@@ -1742,12 +1743,14 @@ parse_pmd_mgmt_config(const char *name)
 #define CMD_LINE_OPT_SCALE_FREQ_MIN "scale-freq-min"
 #define CMD_LINE_OPT_SCALE_FREQ_MAX "scale-freq-max"
 #define CMD_LINE_OPT_CPU_RESUME_LATENCY "cpu-resume-latency"
+#define CMD_LINK_OPT_ETH_LINK_SPEED "eth-link-speed"
 
 /* Parse the argument given in the command line of the application */
 static int
 parse_args(int argc, char **argv)
 {
 	int opt, ret;
+	int speed_num;
 	char **argvopt;
 	int option_index;
 	char *prgname = argv[0];
@@ -1767,6 +1770,7 @@ parse_args(int argc, char **argv)
 		{CMD_LINE_OPT_PAUSE_DURATION, 1, 0, 0},
 		{CMD_LINE_OPT_SCALE_FREQ_MIN, 1, 0, 0},
 		{CMD_LINE_OPT_SCALE_FREQ_MAX, 1, 0, 0},
+		{CMD_LINK_OPT_ETH_LINK_SPEED, 1, 0, 0},
 		{NULL, 0, 0, 0}
 	};
 
@@ -1951,6 +1955,20 @@ parse_args(int argc, char **argv)
 				printf("PM QoS configured\n");
 			}
 
+			if (!strncmp(lgopts[option_index].name,
+					CMD_LINK_OPT_ETH_LINK_SPEED,
+					sizeof(CMD_LINK_OPT_ETH_LINK_SPEED))) {
+				speed_num = atoi(optarg);
+				if ((speed_num == RTE_ETH_SPEED_NUM_10M) ||
+				(speed_num == RTE_ETH_SPEED_NUM_100M)) {
+					fprintf(stderr, "Unsupported fixed speed\n");
+					print_usage(prgname);
+					return -1;
+				}
+				if (speed_num >= 0 && rte_eth_speed_bitflag(speed_num, 0) > 0)
+					port_conf.link_speeds = rte_eth_speed_bitflag(speed_num, 0);
+			}
+
 			break;
 
 		default:
-- 
2.33.0

