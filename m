Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E691CA0FED
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 01:31:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B63494064E;
	Wed, 27 Aug 2025 03:31:12 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 09E4D4028F
 for <dev@dpdk.org>; Wed, 27 Aug 2025 03:31:10 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cBRjB18qSz13NLq;
 Wed, 27 Aug 2025 09:27:26 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id E1C2A1800B1;
 Wed, 27 Aug 2025 09:31:07 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 27 Aug 2025 09:31:07 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <anatoly.burakov@intel.com>,
 <david.hunt@intel.com>, <sivaprasad.tummala@amd.com>, <huisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 1/2] examples/l3fwd: support specify link speed
Date: Wed, 27 Aug 2025 09:31:05 +0800
Message-ID: <20250827013106.2453922-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
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

Currently, l3fwd starts in auto-negotiation mode, but it may fail to
link up when auto-negotiation is not supported. Therefore, it is
necessary to support starting with a specified speed for port.

Additionally, this patch does not support changing the duplex mode.
So speeds like 10M, 100M are not configurable using this method.

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 examples/l3fwd/main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index ae3b4f6439..86235b39d7 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -423,6 +423,7 @@ print_usage(const char *prgname)
 		"            Accepted: em (Exact Match), lpm (Longest Prefix Match), fib (Forwarding Information Base),\n"
 		"                      acl (Access Control List)\n"
 		"  --config (port,queue,lcore): Rx queue configuration\n"
+		"  --eth-link-speed: force link speed\n"
 		"  --rx-queue-size NPKTS: Rx queue size in decimal\n"
 		"            Default: %d\n"
 		"  --tx-queue-size NPKTS: Tx queue size in decimal\n"
@@ -747,6 +748,7 @@ static const char short_options[] =
 	;
 
 #define CMD_LINE_OPT_CONFIG "config"
+#define CMD_LINK_OPT_ETH_LINK_SPEED "eth-link-speed"
 #define CMD_LINE_OPT_RX_QUEUE_SIZE "rx-queue-size"
 #define CMD_LINE_OPT_TX_QUEUE_SIZE "tx-queue-size"
 #define CMD_LINE_OPT_ETH_DEST "eth-dest"
@@ -778,6 +780,7 @@ enum {
 	 * conflict with short options */
 	CMD_LINE_OPT_MIN_NUM = 256,
 	CMD_LINE_OPT_CONFIG_NUM,
+	CMD_LINK_OPT_ETH_LINK_SPEED_NUM,
 	CMD_LINE_OPT_RX_QUEUE_SIZE_NUM,
 	CMD_LINE_OPT_TX_QUEUE_SIZE_NUM,
 	CMD_LINE_OPT_ETH_DEST_NUM,
@@ -805,6 +808,7 @@ enum {
 
 static const struct option lgopts[] = {
 	{CMD_LINE_OPT_CONFIG, 1, 0, CMD_LINE_OPT_CONFIG_NUM},
+	{CMD_LINK_OPT_ETH_LINK_SPEED, 1, 0, CMD_LINK_OPT_ETH_LINK_SPEED_NUM},
 	{CMD_LINE_OPT_RX_QUEUE_SIZE, 1, 0, CMD_LINE_OPT_RX_QUEUE_SIZE_NUM},
 	{CMD_LINE_OPT_TX_QUEUE_SIZE, 1, 0, CMD_LINE_OPT_TX_QUEUE_SIZE_NUM},
 	{CMD_LINE_OPT_ETH_DEST, 1, 0, CMD_LINE_OPT_ETH_DEST_NUM},
@@ -860,6 +864,7 @@ parse_args(int argc, char **argv)
 	uint8_t eth_rx_q = 0;
 	struct l3fwd_event_resources *evt_rsrc = l3fwd_get_eventdev_rsrc();
 #endif
+	int speed_num;
 
 	argvopt = argv;
 
@@ -908,7 +913,17 @@ parse_args(int argc, char **argv)
 			}
 			lcore_params = 1;
 			break;
-
+		case CMD_LINK_OPT_ETH_LINK_SPEED_NUM:
+			speed_num = atoi(optarg);
+			if ((speed_num == RTE_ETH_SPEED_NUM_10M) ||
+			    (speed_num == RTE_ETH_SPEED_NUM_100M)) {
+				fprintf(stderr, "Unsupported fixed speed\n");
+				print_usage(prgname);
+				return -1;
+			}
+			if (speed_num >= 0 && rte_eth_speed_bitflag(speed_num, 0) > 0)
+				port_conf.link_speeds = rte_eth_speed_bitflag(speed_num, 0);
+			break;
 		case CMD_LINE_OPT_RX_QUEUE_SIZE_NUM:
 			parse_queue_size(optarg, &nb_rxd, 1);
 			break;
-- 
2.33.0

