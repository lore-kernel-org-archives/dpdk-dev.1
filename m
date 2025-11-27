Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4F0D111A8
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 09:38:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D82C54021F;
	Mon,  1 Dec 2025 10:38:28 +0100 (CET)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id 0793C4013F
 for <dev@dpdk.org>; Thu, 27 Nov 2025 04:51:19 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=Ck45pYzRyy9t5I5RHRqNCF0aOod7lvN3yntD6NhNsBs=;
 b=S34pBSsoRGmz/In5ia4W1cJ5u3o+hlbI7JjUybw+UNSTiw8oGQuA3vxQlSICREGdlixv+3CiC
 low/exSgvT33sLNsFzuJVjmZfK+05oKY4SHykyEe70dgpWsC6D8Fy6IPGlpysRZlTsX9BTkMXRP
 RSA+9fY+7Ha2PgfFsr0rjsY=
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dH2Vd0Ll8z1cyQN
 for <dev@dpdk.org>; Thu, 27 Nov 2025 11:49:29 +0800 (CST)
Received: from dggpemr100002.china.huawei.com (unknown [7.185.36.245])
 by mail.maildlp.com (Postfix) with ESMTPS id C6E021A016C
 for <dev@dpdk.org>; Thu, 27 Nov 2025 11:51:17 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemr100002.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 11:51:17 +0800
From: Donghua Huang <huangdonghua3@h-partners.com>
To: <dev@dpdk.org>, <liuyonglong@huawei.com>, <yangxingui@h-partners.com>,
 <lihuisong@h-partners.com>, <fengchengwen@huawei.com>
Subject: [PATCH] Upload some patches of vf multiple tc and some of others
Date: Thu, 27 Nov 2025 11:51:16 +0800
Message-ID: <20251127035116.3877371-1-huangdonghua3@h-partners.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemr100002.china.huawei.com (7.185.36.245)
X-Mailman-Approved-At: Mon, 01 Dec 2025 10:38:26 +0100
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

Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
---
 ...testpmd-handle-IEEE1588-init-failure.patch |  59 ++
 ...3fwd-add-option-to-set-Rx-burst-size.patch | 248 +++++++
 ...v-fix-queue-crash-with-generic-pipel.patch | 108 +++
 ...dd-Tx-burst-size-configuration-optio.patch | 338 +++++++++
 ...t-hns3-remove-duplicate-struct-field.patch | 260 +++++++
 0119-net-hns3-refactor-DCB-module.patch       | 296 ++++++++
 ...-net-hns3-parse-max-TC-number-for-VF.patch |  73 ++
 ...-support-multi-TCs-capability-for-VF.patch | 172 +++++
 ...ns3-fix-queue-TC-configuration-on-VF.patch | 109 +++
 ...pport-multi-TCs-configuration-for-VF.patch | 681 ++++++++++++++++++
 ...pp-testpmd-avoid-crash-in-DCB-config.patch |  46 ++
 ...testpmd-show-all-DCB-priority-TC-map.patch |  38 +
 ...d-relax-number-of-TCs-in-DCB-command.patch |  54 ++
 ...euse-RSS-config-when-configuring-DCB.patch |  93 +++
 ...stpmd-add-prio-tc-map-in-DCB-command.patch | 296 ++++++++
 ...add-queue-restriction-in-DCB-command.patch | 264 +++++++
 ...p-testpmd-add-command-to-disable-DCB.patch | 158 ++++
 0131-examples-l3fwd-force-link-speed.patch    |  87 +++
 ...xamples-l3fwd-power-force-link-speed.patch |  80 ++
 0133-config-arm-add-HiSilicon-HIP12.patch     |  96 +++
 0134-app-testpmd-fix-DCB-Tx-port.patch        |  51 ++
 0135-app-testpmd-fix-DCB-Rx-queues.patch      |  35 +
 ...support-specify-TCs-when-DCB-forward.patch | 254 +++++++
 ...d-support-multi-cores-process-one-TC.patch | 292 ++++++++
 dpdk.spec                                     |  54 +-
 25 files changed, 4241 insertions(+), 1 deletion(-)
 create mode 100644 0114-app-testpmd-handle-IEEE1588-init-failure.patch
 create mode 100644 0115-examples-l3fwd-add-option-to-set-Rx-burst-size.patch
 create mode 100644 0116-examples-eventdev-fix-queue-crash-with-generic-pipel.patch
 create mode 100644 0117-examples-l3fwd-add-Tx-burst-size-configuration-optio.patch
 create mode 100644 0118-net-hns3-remove-duplicate-struct-field.patch
 create mode 100644 0119-net-hns3-refactor-DCB-module.patch
 create mode 100644 0120-net-hns3-parse-max-TC-number-for-VF.patch
 create mode 100644 0121-net-hns3-support-multi-TCs-capability-for-VF.patch
 create mode 100644 0122-net-hns3-fix-queue-TC-configuration-on-VF.patch
 create mode 100644 0123-net-hns3-support-multi-TCs-configuration-for-VF.patch
 create mode 100644 0124-app-testpmd-avoid-crash-in-DCB-config.patch
 create mode 100644 0125-app-testpmd-show-all-DCB-priority-TC-map.patch
 create mode 100644 0126-app-testpmd-relax-number-of-TCs-in-DCB-command.patch
 create mode 100644 0127-app-testpmd-reuse-RSS-config-when-configuring-DCB.patch
 create mode 100644 0128-app-testpmd-add-prio-tc-map-in-DCB-command.patch
 create mode 100644 0129-app-testpmd-add-queue-restriction-in-DCB-command.patch
 create mode 100644 0130-app-testpmd-add-command-to-disable-DCB.patch
 create mode 100644 0131-examples-l3fwd-force-link-speed.patch
 create mode 100644 0132-examples-l3fwd-power-force-link-speed.patch
 create mode 100644 0133-config-arm-add-HiSilicon-HIP12.patch
 create mode 100644 0134-app-testpmd-fix-DCB-Tx-port.patch
 create mode 100644 0135-app-testpmd-fix-DCB-Rx-queues.patch
 create mode 100644 0136-app-testpmd-support-specify-TCs-when-DCB-forward.patch
 create mode 100644 0137-app-testpmd-support-multi-cores-process-one-TC.patch

diff --git a/0114-app-testpmd-handle-IEEE1588-init-failure.patch b/0114-app-testpmd-handle-IEEE1588-init-failure.patch
new file mode 100644
index 0000000..479ae2a
--- /dev/null
+++ b/0114-app-testpmd-handle-IEEE1588-init-failure.patch
@@ -0,0 +1,59 @@
+From 79d85f1f563526c39150082f6eb6d3515e0fcc93 Mon Sep 17 00:00:00 2001
+From: Dengdui Huang <huangdengdui@huawei.com>
+Date: Sat, 30 Mar 2024 15:44:09 +0800
+Subject: [PATCH 01/24] app/testpmd: handle IEEE1588 init failure
+
+[ upstream commit 80071a1c8ed669298434c56efe4ca0839f2a970e ]
+
+When the port's timestamping function failed to initialize
+(for example, the device does not support PTP), the packets
+received by the hardware do not contain the timestamp.
+In this case, IEEE1588 packet forwarding should not start.
+This patch fix it.
+
+Plus, adding a failure message when failed to disable PTP.
+
+Fixes: a78040c990cb ("app/testpmd: update forward engine beginning")
+Cc: stable@dpdk.org
+
+Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
+Acked-by: Aman Singh <aman.deep.singh@intel.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ app/test-pmd/ieee1588fwd.c | 15 ++++++++++++---
+ 1 file changed, 12 insertions(+), 3 deletions(-)
+
+diff --git a/app/test-pmd/ieee1588fwd.c b/app/test-pmd/ieee1588fwd.c
+index 386d9f1..52ae551 100644
+--- a/app/test-pmd/ieee1588fwd.c
++++ b/app/test-pmd/ieee1588fwd.c
+@@ -197,14 +197,23 @@ ieee1588_packet_fwd(struct fwd_stream *fs)
+ static int
+ port_ieee1588_fwd_begin(portid_t pi)
+ {
+-	rte_eth_timesync_enable(pi);
+-	return 0;
++	int ret;
++
++	ret = rte_eth_timesync_enable(pi);
++	if (ret)
++		printf("Port %u enable PTP failed, ret = %d\n", pi, ret);
++
++	return ret;
+ }
+ 
+ static void
+ port_ieee1588_fwd_end(portid_t pi)
+ {
+-	rte_eth_timesync_disable(pi);
++	int ret;
++
++	ret = rte_eth_timesync_disable(pi);
++	if (ret)
++		printf("Port %u disable PTP failed, ret = %d\n", pi, ret);
+ }
+ 
+ static void
+-- 
+2.33.0
+
diff --git a/0115-examples-l3fwd-add-option-to-set-Rx-burst-size.patch b/0115-examples-l3fwd-add-option-to-set-Rx-burst-size.patch
new file mode 100644
index 0000000..dfbca3b
--- /dev/null
+++ b/0115-examples-l3fwd-add-option-to-set-Rx-burst-size.patch
@@ -0,0 +1,248 @@
+From e686a6cad028ebfaadefbdf942cf27f7612fbef5 Mon Sep 17 00:00:00 2001
+From: Jie Hai <haijie1@huawei.com>
+Date: Fri, 18 Oct 2024 09:08:51 +0800
+Subject: [PATCH 02/24] examples/l3fwd: add option to set Rx burst size
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
+[ upstream commit d5c4897ecfb2540dc4990d9b367ddbe5013d0e66 ]
+
+Now the Rx burst size is fixed to MAX_PKT_BURST (32). This
+parameter needs to be modified in some performance optimization
+scenarios. So an option '--burst' is added to set the burst size
+explicitly. The default value is DEFAULT_PKT_BURST (32) and maximum
+value is MAX_PKT_BURST (512).
+
+Signed-off-by: Jie Hai <haijie1@huawei.com>
+Acked-by: Chengwen Feng <fengchengwen@huawei.com>
+Acked-by: Huisong Li <lihuisong@huawei.com>
+Acked-by: Morten Brørup <mb@smartsharesystems.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ examples/l3fwd/l3fwd.h     |  7 +++--
+ examples/l3fwd/l3fwd_acl.c |  2 +-
+ examples/l3fwd/l3fwd_em.c  |  2 +-
+ examples/l3fwd/l3fwd_fib.c |  2 +-
+ examples/l3fwd/l3fwd_lpm.c |  2 +-
+ examples/l3fwd/main.c      | 60 ++++++++++++++++++++++++++++++++++++--
+ 6 files changed, 67 insertions(+), 8 deletions(-)
+
+diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
+index e7ae0e5..bb73edd 100644
+--- a/examples/l3fwd/l3fwd.h
++++ b/examples/l3fwd/l3fwd.h
+@@ -23,10 +23,11 @@
+ #define RX_DESC_DEFAULT 1024
+ #define TX_DESC_DEFAULT 1024
+ 
+-#define MAX_PKT_BURST     32
++#define DEFAULT_PKT_BURST 32
++#define MAX_PKT_BURST 512
+ #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
+ 
+-#define MEMPOOL_CACHE_SIZE 256
++#define MEMPOOL_CACHE_SIZE RTE_MEMPOOL_CACHE_MAX_SIZE
+ #define MAX_RX_QUEUE_PER_LCORE 16
+ 
+ #define VECTOR_SIZE_DEFAULT   MAX_PKT_BURST
+@@ -115,6 +116,8 @@ extern struct acl_algorithms acl_alg[];
+ 
+ extern uint32_t max_pkt_len;
+ 
++extern uint32_t nb_pkt_per_burst;
++
+ /* Send burst of packets on an output interface */
+ static inline int
+ send_burst(struct lcore_conf *qconf, uint16_t n, uint16_t port)
+diff --git a/examples/l3fwd/l3fwd_acl.c b/examples/l3fwd/l3fwd_acl.c
+index 401692b..89be104 100644
+--- a/examples/l3fwd/l3fwd_acl.c
++++ b/examples/l3fwd/l3fwd_acl.c
+@@ -1055,7 +1055,7 @@ acl_main_loop(__rte_unused void *dummy)
+ 			portid = qconf->rx_queue_list[i].port_id;
+ 			queueid = qconf->rx_queue_list[i].queue_id;
+ 			nb_rx = rte_eth_rx_burst(portid, queueid,
+-				pkts_burst, MAX_PKT_BURST);
++				pkts_burst, nb_pkt_per_burst);
+ 
+ 			if (nb_rx > 0) {
+ 				struct acl_search_t acl_search;
+diff --git a/examples/l3fwd/l3fwd_em.c b/examples/l3fwd/l3fwd_em.c
+index 00796f1..9a37019 100644
+--- a/examples/l3fwd/l3fwd_em.c
++++ b/examples/l3fwd/l3fwd_em.c
+@@ -652,7 +652,7 @@ em_main_loop(__rte_unused void *dummy)
+ 			portid = qconf->rx_queue_list[i].port_id;
+ 			queueid = qconf->rx_queue_list[i].queue_id;
+ 			nb_rx = rte_eth_rx_burst(portid, queueid, pkts_burst,
+-				MAX_PKT_BURST);
++				nb_pkt_per_burst);
+ 			if (nb_rx == 0)
+ 				continue;
+ 
+diff --git a/examples/l3fwd/l3fwd_fib.c b/examples/l3fwd/l3fwd_fib.c
+index 6a21984..5a55b35 100644
+--- a/examples/l3fwd/l3fwd_fib.c
++++ b/examples/l3fwd/l3fwd_fib.c
+@@ -239,7 +239,7 @@ fib_main_loop(__rte_unused void *dummy)
+ 			portid = qconf->rx_queue_list[i].port_id;
+ 			queueid = qconf->rx_queue_list[i].queue_id;
+ 			nb_rx = rte_eth_rx_burst(portid, queueid, pkts_burst,
+-					MAX_PKT_BURST);
++					nb_pkt_per_burst);
+ 			if (nb_rx == 0)
+ 				continue;
+ 
+diff --git a/examples/l3fwd/l3fwd_lpm.c b/examples/l3fwd/l3fwd_lpm.c
+index a484a33..c3df879 100644
+--- a/examples/l3fwd/l3fwd_lpm.c
++++ b/examples/l3fwd/l3fwd_lpm.c
+@@ -206,7 +206,7 @@ lpm_main_loop(__rte_unused void *dummy)
+ 			portid = qconf->rx_queue_list[i].port_id;
+ 			queueid = qconf->rx_queue_list[i].queue_id;
+ 			nb_rx = rte_eth_rx_burst(portid, queueid, pkts_burst,
+-				MAX_PKT_BURST);
++				nb_pkt_per_burst);
+ 			if (nb_rx == 0)
+ 				continue;
+ 
+diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
+index 3bf28ae..258a235 100644
+--- a/examples/l3fwd/main.c
++++ b/examples/l3fwd/main.c
+@@ -14,6 +14,7 @@
+ #include <getopt.h>
+ #include <signal.h>
+ #include <stdbool.h>
++#include <assert.h>
+ 
+ #include <rte_common.h>
+ #include <rte_vect.h>
+@@ -53,8 +54,10 @@
+ 
+ #define MAX_LCORE_PARAMS 1024
+ 
++static_assert(MEMPOOL_CACHE_SIZE >= MAX_PKT_BURST, "MAX_PKT_BURST should be at most MEMPOOL_CACHE_SIZE");
+ uint16_t nb_rxd = RX_DESC_DEFAULT;
+ uint16_t nb_txd = TX_DESC_DEFAULT;
++uint32_t nb_pkt_per_burst = DEFAULT_PKT_BURST;
+ 
+ /**< Ports set in promiscuous mode off by default. */
+ static int promiscuous_on;
+@@ -395,6 +398,7 @@ print_usage(const char *prgname)
+ 		" --config (port,queue,lcore)[,(port,queue,lcore)]"
+ 		" [--rx-queue-size NPKTS]"
+ 		" [--tx-queue-size NPKTS]"
++		" [--burst NPKTS]"
+ 		" [--eth-dest=X,MM:MM:MM:MM:MM:MM]"
+ 		" [--max-pkt-len PKTLEN]"
+ 		" [--no-numa]"
+@@ -420,6 +424,8 @@ print_usage(const char *prgname)
+ 		"            Default: %d\n"
+ 		"  --tx-queue-size NPKTS: Tx queue size in decimal\n"
+ 		"            Default: %d\n"
++		"  --burst NPKTS: Burst size in decimal\n"
++		"            Default: %d\n"
+ 		"  --eth-dest=X,MM:MM:MM:MM:MM:MM: Ethernet destination for port X\n"
+ 		"  --max-pkt-len PKTLEN: maximum packet length in decimal (64-9600)\n"
+ 		"  --no-numa: Disable numa awareness\n"
+@@ -449,7 +455,7 @@ print_usage(const char *prgname)
+ 		"                    another is route entry at while line leads with character '%c'.\n"
+ 		"  --rule_ipv6=FILE: Specify the ipv6 rules entries file.\n"
+ 		"  --alg: ACL classify method to use, one of: %s.\n\n",
+-		prgname, RX_DESC_DEFAULT, TX_DESC_DEFAULT,
++		prgname, RX_DESC_DEFAULT, TX_DESC_DEFAULT, DEFAULT_PKT_BURST,
+ 		ACL_LEAD_CHAR, ROUTE_LEAD_CHAR, alg);
+ }
+ 
+@@ -662,6 +668,49 @@ parse_lookup(const char *optarg)
+ 	return 0;
+ }
+ 
++static void
++parse_pkt_burst(const char *optarg)
++{
++	struct rte_eth_dev_info dev_info;
++	unsigned long pkt_burst;
++	uint16_t burst_size;
++	char *end = NULL;
++	int ret;
++
++	/* parse decimal string */
++	pkt_burst = strtoul(optarg, &end, 10);
++	if ((optarg[0] == '\0') || (end == NULL) || (*end != '\0'))
++		return;
++
++	if (pkt_burst > MAX_PKT_BURST) {
++		RTE_LOG(INFO, L3FWD, "User provided burst must be <= %d. Using default value %d\n",
++			MAX_PKT_BURST, nb_pkt_per_burst);
++		return;
++	} else if (pkt_burst > 0) {
++		nb_pkt_per_burst = (uint32_t)pkt_burst;
++		return;
++	}
++
++	/* If user gives a value of zero, query the PMD for its recommended Rx burst size. */
++	ret = rte_eth_dev_info_get(0, &dev_info);
++	if (ret != 0)
++		return;
++	burst_size = dev_info.default_rxportconf.burst_size;
++	if (burst_size == 0) {
++		RTE_LOG(INFO, L3FWD, "PMD does not recommend a burst size. Using default value %d. "
++			"User provided value must be in [1, %d]\n",
++			nb_pkt_per_burst, MAX_PKT_BURST);
++		return;
++	} else if (burst_size > MAX_PKT_BURST) {
++		RTE_LOG(INFO, L3FWD, "PMD recommended burst size %d exceeds maximum value %d. "
++			"Using default value %d\n",
++			burst_size, MAX_PKT_BURST, nb_pkt_per_burst);
++		return;
++	}
++	nb_pkt_per_burst = burst_size;
++	RTE_LOG(INFO, L3FWD, "Using PMD-provided burst value %d\n", burst_size);
++}
++
+ #define MAX_JUMBO_PKT_LEN  9600
+ 
+ static const char short_options[] =
+@@ -693,6 +742,7 @@ static const char short_options[] =
+ #define CMD_LINE_OPT_RULE_IPV4 "rule_ipv4"
+ #define CMD_LINE_OPT_RULE_IPV6 "rule_ipv6"
+ #define CMD_LINE_OPT_ALG "alg"
++#define CMD_LINE_OPT_PKT_BURST "burst"
+ 
+ enum {
+ 	/* long options mapped to a short option */
+@@ -721,7 +771,8 @@ enum {
+ 	CMD_LINE_OPT_LOOKUP_NUM,
+ 	CMD_LINE_OPT_ENABLE_VECTOR_NUM,
+ 	CMD_LINE_OPT_VECTOR_SIZE_NUM,
+-	CMD_LINE_OPT_VECTOR_TMO_NS_NUM
++	CMD_LINE_OPT_VECTOR_TMO_NS_NUM,
++	CMD_LINE_OPT_PKT_BURST_NUM,
+ };
+ 
+ static const struct option lgopts[] = {
+@@ -748,6 +799,7 @@ static const struct option lgopts[] = {
+ 	{CMD_LINE_OPT_RULE_IPV4,   1, 0, CMD_LINE_OPT_RULE_IPV4_NUM},
+ 	{CMD_LINE_OPT_RULE_IPV6,   1, 0, CMD_LINE_OPT_RULE_IPV6_NUM},
+ 	{CMD_LINE_OPT_ALG,   1, 0, CMD_LINE_OPT_ALG_NUM},
++	{CMD_LINE_OPT_PKT_BURST,   1, 0, CMD_LINE_OPT_PKT_BURST_NUM},
+ 	{NULL, 0, 0, 0}
+ };
+ 
+@@ -836,6 +888,10 @@ parse_args(int argc, char **argv)
+ 			parse_queue_size(optarg, &nb_txd, 0);
+ 			break;
+ 
++		case CMD_LINE_OPT_PKT_BURST_NUM:
++			parse_pkt_burst(optarg);
++			break;
++
+ 		case CMD_LINE_OPT_ETH_DEST_NUM:
+ 			parse_eth_dest(optarg);
+ 			break;
+-- 
+2.33.0
+
diff --git a/0116-examples-eventdev-fix-queue-crash-with-generic-pipel.patch b/0116-examples-eventdev-fix-queue-crash-with-generic-pipel.patch
new file mode 100644
index 0000000..f530b79
--- /dev/null
+++ b/0116-examples-eventdev-fix-queue-crash-with-generic-pipel.patch
@@ -0,0 +1,108 @@
+From 0d4fffdc3eae64a9d3a59bdcb6e327e7c85ef637 Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Wed, 18 Sep 2024 06:41:42 +0000
+Subject: [PATCH 03/24] examples/eventdev: fix queue crash with generic
+ pipeline
+
+[ upstream commit f6f2307931c90d924405ea44b0b4be9d3d01bd17 ]
+
+There was a segmentation fault when executing eventdev_pipeline with
+command [1] with ConnectX-5 NIC card:
+
+0x000000000079208c in rte_eth_tx_buffer (tx_pkt=0x16f8ed300, buffer=0x100,
+                   queue_id=11, port_id=0) at
+                   ../lib/ethdev/rte_ethdev.h:6636
+txa_service_tx (txa=0x17b19d080, ev=0xffffffffe500, n=4) at
+                   ../lib/eventdev/rte_event_eth_tx_adapter.c:631
+0x0000000000792234 in txa_service_func (args=0x17b19d080) at
+                   ../lib/eventdev/rte_event_eth_tx_adapter.c:666
+0x00000000008b0784 in service_runner_do_callback (s=0x17fffe100,
+                   cs=0x17ffb5f80, service_idx=2) at
+                   ../lib/eal/common/rte_service.c:405
+0x00000000008b0ad8 in service_run (i=2, cs=0x17ffb5f80,
+                   service_mask=18446744073709551615, s=0x17fffe100,
+                   serialize_mt_unsafe=0) at
+                   ../lib/eal/common/rte_service.c:441
+0x00000000008b0c68 in rte_service_run_iter_on_app_lcore (id=2,
+                   serialize_mt_unsafe=0) at
+                   ../lib/eal/common/rte_service.c:477
+0x000000000057bcc4 in schedule_devices (lcore_id=0) at
+                   ../examples/eventdev_pipeline/pipeline_common.h:138
+0x000000000057ca94 in worker_generic_burst (arg=0x17b131e80) at
+                   ../examples/eventdev_pipeline/
+                   pipeline_worker_generic.c:83
+0x00000000005794a8 in main (argc=11, argv=0xfffffffff470) at
+                   ../examples/eventdev_pipeline/main.c:449
+
+The root cause is that the queue_id (11) is invalid, the queue_id comes
+from mbuf.hash.txadapter.txq which may pre-write by NIC driver when
+receiving packets (e.g. pre-write mbuf.hash.fdir.hi field).
+
+Because this example only enabled one ethdev queue, so fixes it by reset
+txq to zero in the first worker stage.
+
+[1] dpdk-eventdev_pipeline -l 0-48 --vdev event_sw0 -- -r1 -t1 -e1 -w ff0
+    -s5 -n0 -c32 -W1000 -D
+When launch eventdev_pipeline with command [1],  event_sw
+
+Fixes: 81fb40f95c82 ("examples/eventdev: add generic worker pipeline")
+Cc: stable@dpdk.org
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Chenxingyu Wang <wangchenxingyu@huawei.com>
+Acked-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ .mailmap                                             |  1 +
+ examples/eventdev_pipeline/pipeline_worker_generic.c | 12 ++++++++----
+ 2 files changed, 9 insertions(+), 4 deletions(-)
+
+diff --git a/.mailmap b/.mailmap
+index ab0742a..7725e1c 100644
+--- a/.mailmap
++++ b/.mailmap
+@@ -224,6 +224,7 @@ Cheng Liu <liucheng11@huawei.com>
+ Cheng Peng <cheng.peng5@zte.com.cn>
+ Chengwen Feng <fengchengwen@huawei.com>
+ Chenmin Sun <chenmin.sun@intel.com>
++Chenxingyu Wang <wangchenxingyu@huawei.com>
+ Chenxu Di <chenxux.di@intel.com>
+ Chenyu Huang <chenyux.huang@intel.com>
+ Cheryl Houser <chouser@vmware.com>
+diff --git a/examples/eventdev_pipeline/pipeline_worker_generic.c b/examples/eventdev_pipeline/pipeline_worker_generic.c
+index 783f68c..831d7fd 100644
+--- a/examples/eventdev_pipeline/pipeline_worker_generic.c
++++ b/examples/eventdev_pipeline/pipeline_worker_generic.c
+@@ -38,10 +38,12 @@ worker_generic(void *arg)
+ 		}
+ 		received++;
+ 
+-		/* The first worker stage does classification */
+-		if (ev.queue_id == cdata.qid[0])
++		/* The first worker stage does classification and sets txq. */
++		if (ev.queue_id == cdata.qid[0]) {
+ 			ev.flow_id = ev.mbuf->hash.rss
+ 						% cdata.num_fids;
++			rte_event_eth_tx_adapter_txq_set(ev.mbuf, 0);
++		}
+ 
+ 		ev.queue_id = cdata.next_qid[ev.queue_id];
+ 		ev.op = RTE_EVENT_OP_FORWARD;
+@@ -96,10 +98,12 @@ worker_generic_burst(void *arg)
+ 
+ 		for (i = 0; i < nb_rx; i++) {
+ 
+-			/* The first worker stage does classification */
+-			if (events[i].queue_id == cdata.qid[0])
++			/* The first worker stage does classification and sets txq. */
++			if (events[i].queue_id == cdata.qid[0]) {
+ 				events[i].flow_id = events[i].mbuf->hash.rss
+ 							% cdata.num_fids;
++				rte_event_eth_tx_adapter_txq_set(events[i].mbuf, 0);
++			}
+ 
+ 			events[i].queue_id = cdata.next_qid[events[i].queue_id];
+ 			events[i].op = RTE_EVENT_OP_FORWARD;
+-- 
+2.33.0
+
diff --git a/0117-examples-l3fwd-add-Tx-burst-size-configuration-optio.patch b/0117-examples-l3fwd-add-Tx-burst-size-configuration-optio.patch
new file mode 100644
index 0000000..35b50bf
--- /dev/null
+++ b/0117-examples-l3fwd-add-Tx-burst-size-configuration-optio.patch
@@ -0,0 +1,338 @@
+From a384e977287431b4e845924405cef27eb93dc442 Mon Sep 17 00:00:00 2001
+From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
+Date: Thu, 6 Nov 2025 14:16:31 +0000
+Subject: [PATCH 04/24] examples/l3fwd: add Tx burst size configuration option
+
+[ upstream commit 79375d1015b308234e8b6955671a296394249f9b ]
+
+Previously, the Tx burst size in l3fwd was fixed at 256, which could
+lead to suboptimal performance in certain scenarios.
+
+This patch introduces separate --rx-burst and --tx-burst options to
+explicitly configure Rx and Tx burst sizes. By default, the Tx burst
+size now matches the Rx burst size for better efficiency and pipeline
+balance.
+
+Fixes: d5c4897ecfb2 ("examples/l3fwd: add option to set Rx burst size")
+
+Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
+Tested-by: Venkat Kumar Ande <venkatkumar.ande@amd.com>
+Tested-by: Dengdui Huang <huangdengdui@huawei.com>
+Tested-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
+Acked-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ doc/guides/sample_app_ug/l3_forward.rst |  6 ++
+ examples/l3fwd/l3fwd.h                  | 10 +---
+ examples/l3fwd/l3fwd_acl.c              |  2 +-
+ examples/l3fwd/l3fwd_common.h           |  5 +-
+ examples/l3fwd/l3fwd_em.c               |  2 +-
+ examples/l3fwd/l3fwd_fib.c              |  2 +-
+ examples/l3fwd/l3fwd_lpm.c              |  2 +-
+ examples/l3fwd/main.c                   | 80 +++++++++++++++----------
+ 8 files changed, 67 insertions(+), 42 deletions(-)
+
+diff --git a/doc/guides/sample_app_ug/l3_forward.rst b/doc/guides/sample_app_ug/l3_forward.rst
+index 1cc2c1d..22014cc 100644
+--- a/doc/guides/sample_app_ug/l3_forward.rst
++++ b/doc/guides/sample_app_ug/l3_forward.rst
+@@ -78,6 +78,8 @@ The application has a number of command line options::
+                              [-P]
+                              [--lookup LOOKUP_METHOD]
+                              --config(port,queue,lcore)[,(port,queue,lcore)]
++                             [--rx-burst NPKTS]
++                             [--tx-burst NPKTS]
+                              [--eth-dest=X,MM:MM:MM:MM:MM:MM]
+                              [--max-pkt-len PKTLEN]
+                              [--no-numa]
+@@ -114,6 +116,10 @@ Where,
+ 
+ * ``--config (port,queue,lcore)[,(port,queue,lcore)]:`` Determines which queues from which ports are mapped to which cores.
+ 
++* ``--rx-burst NPKTS:`` Optional, Rx burst size in decimal (default 32).
++
++* ``--tx-burst NPKTS:`` Optional, Tx burst size in decimal (default 32).
++
+ * ``--eth-dest=X,MM:MM:MM:MM:MM:MM:`` Optional, ethernet destination for port X.
+ 
+ * ``--max-pkt-len:`` Optional, maximum packet length in decimal (64-9600).
+diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
+index bb73edd..7c36ab2 100644
+--- a/examples/l3fwd/l3fwd.h
++++ b/examples/l3fwd/l3fwd.h
+@@ -32,10 +32,6 @@
+ 
+ #define VECTOR_SIZE_DEFAULT   MAX_PKT_BURST
+ #define VECTOR_TMO_NS_DEFAULT 1E6 /* 1ms */
+-/*
+- * Try to avoid TX buffering if we have at least MAX_TX_BURST packets to send.
+- */
+-#define	MAX_TX_BURST	  (MAX_PKT_BURST / 2)
+ 
+ #define NB_SOCKETS        8
+ 
+@@ -116,7 +112,7 @@ extern struct acl_algorithms acl_alg[];
+ 
+ extern uint32_t max_pkt_len;
+ 
+-extern uint32_t nb_pkt_per_burst;
++extern uint32_t rx_burst_size;
+ 
+ /* Send burst of packets on an output interface */
+ static inline int
+@@ -151,8 +147,8 @@ send_single_packet(struct lcore_conf *qconf,
+ 	len++;
+ 
+ 	/* enough pkts to be sent */
+-	if (unlikely(len == MAX_PKT_BURST)) {
+-		send_burst(qconf, MAX_PKT_BURST, port);
++	if (unlikely(len == rx_burst_size)) {
++		send_burst(qconf, rx_burst_size, port);
+ 		len = 0;
+ 	}
+ 
+diff --git a/examples/l3fwd/l3fwd_acl.c b/examples/l3fwd/l3fwd_acl.c
+index 89be104..58218da 100644
+--- a/examples/l3fwd/l3fwd_acl.c
++++ b/examples/l3fwd/l3fwd_acl.c
+@@ -1055,7 +1055,7 @@ acl_main_loop(__rte_unused void *dummy)
+ 			portid = qconf->rx_queue_list[i].port_id;
+ 			queueid = qconf->rx_queue_list[i].queue_id;
+ 			nb_rx = rte_eth_rx_burst(portid, queueid,
+-				pkts_burst, nb_pkt_per_burst);
++				pkts_burst, rx_burst_size);
+ 
+ 			if (nb_rx > 0) {
+ 				struct acl_search_t acl_search;
+diff --git a/examples/l3fwd/l3fwd_common.h b/examples/l3fwd/l3fwd_common.h
+index 224b1c0..9b9bdf6 100644
+--- a/examples/l3fwd/l3fwd_common.h
++++ b/examples/l3fwd/l3fwd_common.h
+@@ -18,6 +18,9 @@
+ /* Minimum value of IPV4 total length (20B) in network byte order. */
+ #define	IPV4_MIN_LEN_BE	(sizeof(struct rte_ipv4_hdr) << 8)
+ 
++extern uint32_t rx_burst_size;
++extern uint32_t tx_burst_size;
++
+ /*
+  * From http://www.rfc-editor.org/rfc/rfc1812.txt section 5.2.2:
+  * - The IP version number must be 4.
+@@ -64,7 +67,7 @@ send_packetsx4(struct lcore_conf *qconf, uint16_t port, struct rte_mbuf *m[],
+ 	 * If TX buffer for that queue is empty, and we have enough packets,
+ 	 * then send them straightway.
+ 	 */
+-	if (num >= MAX_TX_BURST && len == 0) {
++	if (num >= tx_burst_size && len == 0) {
+ 		n = rte_eth_tx_burst(port, qconf->tx_queue_id[port], m, num);
+ 		if (unlikely(n < num)) {
+ 			do {
+diff --git a/examples/l3fwd/l3fwd_em.c b/examples/l3fwd/l3fwd_em.c
+index 9a37019..75e89e6 100644
+--- a/examples/l3fwd/l3fwd_em.c
++++ b/examples/l3fwd/l3fwd_em.c
+@@ -652,7 +652,7 @@ em_main_loop(__rte_unused void *dummy)
+ 			portid = qconf->rx_queue_list[i].port_id;
+ 			queueid = qconf->rx_queue_list[i].queue_id;
+ 			nb_rx = rte_eth_rx_burst(portid, queueid, pkts_burst,
+-				nb_pkt_per_burst);
++				rx_burst_size);
+ 			if (nb_rx == 0)
+ 				continue;
+ 
+diff --git a/examples/l3fwd/l3fwd_fib.c b/examples/l3fwd/l3fwd_fib.c
+index 5a55b35..3f905f9 100644
+--- a/examples/l3fwd/l3fwd_fib.c
++++ b/examples/l3fwd/l3fwd_fib.c
+@@ -239,7 +239,7 @@ fib_main_loop(__rte_unused void *dummy)
+ 			portid = qconf->rx_queue_list[i].port_id;
+ 			queueid = qconf->rx_queue_list[i].queue_id;
+ 			nb_rx = rte_eth_rx_burst(portid, queueid, pkts_burst,
+-					nb_pkt_per_burst);
++					rx_burst_size);
+ 			if (nb_rx == 0)
+ 				continue;
+ 
+diff --git a/examples/l3fwd/l3fwd_lpm.c b/examples/l3fwd/l3fwd_lpm.c
+index c3df879..40c365e 100644
+--- a/examples/l3fwd/l3fwd_lpm.c
++++ b/examples/l3fwd/l3fwd_lpm.c
+@@ -206,7 +206,7 @@ lpm_main_loop(__rte_unused void *dummy)
+ 			portid = qconf->rx_queue_list[i].port_id;
+ 			queueid = qconf->rx_queue_list[i].queue_id;
+ 			nb_rx = rte_eth_rx_burst(portid, queueid, pkts_burst,
+-				nb_pkt_per_burst);
++				rx_burst_size);
+ 			if (nb_rx == 0)
+ 				continue;
+ 
+diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
+index 258a235..be5b5d8 100644
+--- a/examples/l3fwd/main.c
++++ b/examples/l3fwd/main.c
+@@ -57,7 +57,8 @@
+ static_assert(MEMPOOL_CACHE_SIZE >= MAX_PKT_BURST, "MAX_PKT_BURST should be at most MEMPOOL_CACHE_SIZE");
+ uint16_t nb_rxd = RX_DESC_DEFAULT;
+ uint16_t nb_txd = TX_DESC_DEFAULT;
+-uint32_t nb_pkt_per_burst = DEFAULT_PKT_BURST;
++uint32_t rx_burst_size = DEFAULT_PKT_BURST;
++uint32_t tx_burst_size = DEFAULT_PKT_BURST;
+ 
+ /**< Ports set in promiscuous mode off by default. */
+ static int promiscuous_on;
+@@ -398,7 +399,8 @@ print_usage(const char *prgname)
+ 		" --config (port,queue,lcore)[,(port,queue,lcore)]"
+ 		" [--rx-queue-size NPKTS]"
+ 		" [--tx-queue-size NPKTS]"
+-		" [--burst NPKTS]"
++		" [--rx-burst NPKTS]"
++		" [--tx-burst NPKTS]"
+ 		" [--eth-dest=X,MM:MM:MM:MM:MM:MM]"
+ 		" [--max-pkt-len PKTLEN]"
+ 		" [--no-numa]"
+@@ -424,7 +426,9 @@ print_usage(const char *prgname)
+ 		"            Default: %d\n"
+ 		"  --tx-queue-size NPKTS: Tx queue size in decimal\n"
+ 		"            Default: %d\n"
+-		"  --burst NPKTS: Burst size in decimal\n"
++		"  --rx-burst NPKTS: RX Burst size in decimal\n"
++		"            Default: %d\n"
++		"  --tx-burst NPKTS: TX Burst size in decimal\n"
+ 		"            Default: %d\n"
+ 		"  --eth-dest=X,MM:MM:MM:MM:MM:MM: Ethernet destination for port X\n"
+ 		"  --max-pkt-len PKTLEN: maximum packet length in decimal (64-9600)\n"
+@@ -455,8 +459,8 @@ print_usage(const char *prgname)
+ 		"                    another is route entry at while line leads with character '%c'.\n"
+ 		"  --rule_ipv6=FILE: Specify the ipv6 rules entries file.\n"
+ 		"  --alg: ACL classify method to use, one of: %s.\n\n",
+-		prgname, RX_DESC_DEFAULT, TX_DESC_DEFAULT, DEFAULT_PKT_BURST,
+-		ACL_LEAD_CHAR, ROUTE_LEAD_CHAR, alg);
++		prgname, RX_DESC_DEFAULT, TX_DESC_DEFAULT, DEFAULT_PKT_BURST, DEFAULT_PKT_BURST,
++		MEMPOOL_CACHE_SIZE, ACL_LEAD_CHAR, ROUTE_LEAD_CHAR, alg);
+ }
+ 
+ static int
+@@ -669,7 +673,7 @@ parse_lookup(const char *optarg)
+ }
+ 
+ static void
+-parse_pkt_burst(const char *optarg)
++parse_pkt_burst(const char *optarg, bool is_rx_burst, uint32_t *burst_sz)
+ {
+ 	struct rte_eth_dev_info dev_info;
+ 	unsigned long pkt_burst;
+@@ -684,31 +688,38 @@ parse_pkt_burst(const char *optarg)
+ 
+ 	if (pkt_burst > MAX_PKT_BURST) {
+ 		RTE_LOG(INFO, L3FWD, "User provided burst must be <= %d. Using default value %d\n",
+-			MAX_PKT_BURST, nb_pkt_per_burst);
++			MAX_PKT_BURST, *burst_sz);
+ 		return;
+ 	} else if (pkt_burst > 0) {
+-		nb_pkt_per_burst = (uint32_t)pkt_burst;
++		*burst_sz = (uint32_t)pkt_burst;
+ 		return;
+ 	}
+ 
+-	/* If user gives a value of zero, query the PMD for its recommended Rx burst size. */
+-	ret = rte_eth_dev_info_get(0, &dev_info);
+-	if (ret != 0)
+-		return;
+-	burst_size = dev_info.default_rxportconf.burst_size;
+-	if (burst_size == 0) {
+-		RTE_LOG(INFO, L3FWD, "PMD does not recommend a burst size. Using default value %d. "
+-			"User provided value must be in [1, %d]\n",
+-			nb_pkt_per_burst, MAX_PKT_BURST);
+-		return;
+-	} else if (burst_size > MAX_PKT_BURST) {
+-		RTE_LOG(INFO, L3FWD, "PMD recommended burst size %d exceeds maximum value %d. "
+-			"Using default value %d\n",
+-			burst_size, MAX_PKT_BURST, nb_pkt_per_burst);
+-		return;
++	if (is_rx_burst) {
++		/* If user gives a value of zero, query the PMD for its recommended
++		 * Rx burst size.
++		 */
++		ret = rte_eth_dev_info_get(0, &dev_info);
++		if (ret != 0)
++			return;
++		burst_size = dev_info.default_rxportconf.burst_size;
++		if (burst_size == 0) {
++			RTE_LOG(INFO, L3FWD, "PMD does not recommend a burst size. Using default value %d. "
++				"User provided value must be in [1, %d]\n",
++				rx_burst_size, MAX_PKT_BURST);
++			return;
++		} else if (burst_size > MAX_PKT_BURST) {
++			RTE_LOG(INFO, L3FWD, "PMD recommended burst size %d exceeds maximum value %d. "
++				"Using default value %d\n",
++				burst_size, MAX_PKT_BURST, rx_burst_size);
++			return;
++		}
++		*burst_sz = burst_size;
++		RTE_LOG(INFO, L3FWD, "Using PMD-provided RX burst value %d\n", burst_size);
++	} else {
++		RTE_LOG(INFO, L3FWD, "User provided TX burst is 0. Using default value %d\n",
++			*burst_sz);
+ 	}
+-	nb_pkt_per_burst = burst_size;
+-	RTE_LOG(INFO, L3FWD, "Using PMD-provided burst value %d\n", burst_size);
+ }
+ 
+ #define MAX_JUMBO_PKT_LEN  9600
+@@ -742,7 +753,8 @@ static const char short_options[] =
+ #define CMD_LINE_OPT_RULE_IPV4 "rule_ipv4"
+ #define CMD_LINE_OPT_RULE_IPV6 "rule_ipv6"
+ #define CMD_LINE_OPT_ALG "alg"
+-#define CMD_LINE_OPT_PKT_BURST "burst"
++#define CMD_LINE_OPT_PKT_RX_BURST "rx-burst"
++#define CMD_LINE_OPT_PKT_TX_BURST "tx-burst"
+ 
+ enum {
+ 	/* long options mapped to a short option */
+@@ -772,7 +784,8 @@ enum {
+ 	CMD_LINE_OPT_ENABLE_VECTOR_NUM,
+ 	CMD_LINE_OPT_VECTOR_SIZE_NUM,
+ 	CMD_LINE_OPT_VECTOR_TMO_NS_NUM,
+-	CMD_LINE_OPT_PKT_BURST_NUM,
++	CMD_LINE_OPT_PKT_RX_BURST_NUM,
++	CMD_LINE_OPT_PKT_TX_BURST_NUM,
+ };
+ 
+ static const struct option lgopts[] = {
+@@ -799,7 +812,8 @@ static const struct option lgopts[] = {
+ 	{CMD_LINE_OPT_RULE_IPV4,   1, 0, CMD_LINE_OPT_RULE_IPV4_NUM},
+ 	{CMD_LINE_OPT_RULE_IPV6,   1, 0, CMD_LINE_OPT_RULE_IPV6_NUM},
+ 	{CMD_LINE_OPT_ALG,   1, 0, CMD_LINE_OPT_ALG_NUM},
+-	{CMD_LINE_OPT_PKT_BURST,   1, 0, CMD_LINE_OPT_PKT_BURST_NUM},
++	{CMD_LINE_OPT_PKT_RX_BURST,   1, 0, CMD_LINE_OPT_PKT_RX_BURST_NUM},
++	{CMD_LINE_OPT_PKT_TX_BURST,   1, 0, CMD_LINE_OPT_PKT_TX_BURST_NUM},
+ 	{NULL, 0, 0, 0}
+ };
+ 
+@@ -888,8 +902,12 @@ parse_args(int argc, char **argv)
+ 			parse_queue_size(optarg, &nb_txd, 0);
+ 			break;
+ 
+-		case CMD_LINE_OPT_PKT_BURST_NUM:
+-			parse_pkt_burst(optarg);
++		case CMD_LINE_OPT_PKT_RX_BURST_NUM:
++			parse_pkt_burst(optarg, true, &rx_burst_size);
++			break;
++
++		case CMD_LINE_OPT_PKT_TX_BURST_NUM:
++			parse_pkt_burst(optarg, false, &tx_burst_size);
+ 			break;
+ 
+ 		case CMD_LINE_OPT_ETH_DEST_NUM:
+@@ -1613,6 +1631,8 @@ main(int argc, char **argv)
+ 	if (ret < 0)
+ 		rte_exit(EXIT_FAILURE, "Invalid L3FWD parameters\n");
+ 
++	RTE_LOG(INFO, L3FWD, "Using Rx burst %u Tx burst %u\n", rx_burst_size, tx_burst_size);
++
+ 	/* Setup function pointers for lookup method. */
+ 	setup_l3fwd_lookup_tables();
+ 
+-- 
+2.33.0
+
diff --git a/0118-net-hns3-remove-duplicate-struct-field.patch b/0118-net-hns3-remove-duplicate-struct-field.patch
new file mode 100644
index 0000000..48f16b3
--- /dev/null
+++ b/0118-net-hns3-remove-duplicate-struct-field.patch
@@ -0,0 +1,260 @@
+From 90219bcbe62357d12707e244239b1e00912c2e9a Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Tue, 1 Jul 2025 17:10:00 +0800
+Subject: [PATCH 05/24] net/hns3: remove duplicate struct field
+
+[ upstream commit 3f09e50b5c23ff3a06e89f944e9e1e4cb37faacb ]
+
+The struct hns3_hw and hns3_hw.dcb_info both has num_tc field, their
+meanings are the same, to ensure code readability, remove the num_tc
+field of struct hns3_hw.
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ drivers/net/hns3/hns3_dcb.c       | 44 ++++++++++++-------------------
+ drivers/net/hns3/hns3_dump.c      |  2 +-
+ drivers/net/hns3/hns3_ethdev.c    |  4 +--
+ drivers/net/hns3/hns3_ethdev.h    |  3 +--
+ drivers/net/hns3/hns3_ethdev_vf.c |  2 +-
+ drivers/net/hns3/hns3_tm.c        |  6 ++---
+ 6 files changed, 25 insertions(+), 36 deletions(-)
+
+diff --git a/drivers/net/hns3/hns3_dcb.c b/drivers/net/hns3/hns3_dcb.c
+index 915e4eb..ee7502d 100644
+--- a/drivers/net/hns3/hns3_dcb.c
++++ b/drivers/net/hns3/hns3_dcb.c
+@@ -623,7 +623,7 @@ hns3_set_rss_size(struct hns3_hw *hw, uint16_t nb_rx_q)
+ 	uint16_t used_rx_queues;
+ 	uint16_t i;
+ 
+-	rx_qnum_per_tc = nb_rx_q / hw->num_tc;
++	rx_qnum_per_tc = nb_rx_q / hw->dcb_info.num_tc;
+ 	if (rx_qnum_per_tc > hw->rss_size_max) {
+ 		hns3_err(hw, "rx queue number of per tc (%u) is greater than "
+ 			 "value (%u) hardware supported.",
+@@ -631,11 +631,11 @@ hns3_set_rss_size(struct hns3_hw *hw, uint16_t nb_rx_q)
+ 		return -EINVAL;
+ 	}
+ 
+-	used_rx_queues = hw->num_tc * rx_qnum_per_tc;
++	used_rx_queues = hw->dcb_info.num_tc * rx_qnum_per_tc;
+ 	if (used_rx_queues != nb_rx_q) {
+ 		hns3_err(hw, "rx queue number (%u) configured must be an "
+ 			 "integral multiple of valid tc number (%u).",
+-			 nb_rx_q, hw->num_tc);
++			 nb_rx_q, hw->dcb_info.num_tc);
+ 		return -EINVAL;
+ 	}
+ 	hw->alloc_rss_size = rx_qnum_per_tc;
+@@ -665,12 +665,12 @@ hns3_tc_queue_mapping_cfg(struct hns3_hw *hw, uint16_t nb_tx_q)
+ 	uint16_t tx_qnum_per_tc;
+ 	uint8_t i;
+ 
+-	tx_qnum_per_tc = nb_tx_q / hw->num_tc;
+-	used_tx_queues = hw->num_tc * tx_qnum_per_tc;
++	tx_qnum_per_tc = nb_tx_q / hw->dcb_info.num_tc;
++	used_tx_queues = hw->dcb_info.num_tc * tx_qnum_per_tc;
+ 	if (used_tx_queues != nb_tx_q) {
+ 		hns3_err(hw, "tx queue number (%u) configured must be an "
+ 			 "integral multiple of valid tc number (%u).",
+-			 nb_tx_q, hw->num_tc);
++			 nb_tx_q, hw->dcb_info.num_tc);
+ 		return -EINVAL;
+ 	}
+ 
+@@ -678,7 +678,7 @@ hns3_tc_queue_mapping_cfg(struct hns3_hw *hw, uint16_t nb_tx_q)
+ 	hw->tx_qnum_per_tc = tx_qnum_per_tc;
+ 	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
+ 		tc_queue = &hw->tc_queue[i];
+-		if (hw->hw_tc_map & BIT(i) && i < hw->num_tc) {
++		if (hw->hw_tc_map & BIT(i) && i < hw->dcb_info.num_tc) {
+ 			tc_queue->enable = true;
+ 			tc_queue->tqp_offset = i * hw->tx_qnum_per_tc;
+ 			tc_queue->tqp_count = hw->tx_qnum_per_tc;
+@@ -720,15 +720,15 @@ hns3_queue_to_tc_mapping(struct hns3_hw *hw, uint16_t nb_rx_q, uint16_t nb_tx_q)
+ {
+ 	int ret;
+ 
+-	if (nb_rx_q < hw->num_tc) {
++	if (nb_rx_q < hw->dcb_info.num_tc) {
+ 		hns3_err(hw, "number of Rx queues(%u) is less than number of TC(%u).",
+-			 nb_rx_q, hw->num_tc);
++			 nb_rx_q, hw->dcb_info.num_tc);
+ 		return -EINVAL;
+ 	}
+ 
+-	if (nb_tx_q < hw->num_tc) {
++	if (nb_tx_q < hw->dcb_info.num_tc) {
+ 		hns3_err(hw, "number of Tx queues(%u) is less than number of TC(%u).",
+-			 nb_tx_q, hw->num_tc);
++			 nb_tx_q, hw->dcb_info.num_tc);
+ 		return -EINVAL;
+ 	}
+ 
+@@ -739,15 +739,6 @@ hns3_queue_to_tc_mapping(struct hns3_hw *hw, uint16_t nb_rx_q, uint16_t nb_tx_q)
+ 	return hns3_tc_queue_mapping_cfg(hw, nb_tx_q);
+ }
+ 
+-static int
+-hns3_dcb_update_tc_queue_mapping(struct hns3_hw *hw, uint16_t nb_rx_q,
+-				 uint16_t nb_tx_q)
+-{
+-	hw->num_tc = hw->dcb_info.num_tc;
+-
+-	return hns3_queue_to_tc_mapping(hw, nb_rx_q, nb_tx_q);
+-}
+-
+ int
+ hns3_dcb_info_init(struct hns3_hw *hw)
+ {
+@@ -1028,7 +1019,7 @@ hns3_q_to_qs_map(struct hns3_hw *hw)
+ 	uint32_t i, j;
+ 	int ret;
+ 
+-	for (i = 0; i < hw->num_tc; i++) {
++	for (i = 0; i < hw->dcb_info.num_tc; i++) {
+ 		tc_queue = &hw->tc_queue[i];
+ 		for (j = 0; j < tc_queue->tqp_count; j++) {
+ 			q_id = tc_queue->tqp_offset + j;
+@@ -1053,7 +1044,7 @@ hns3_pri_q_qs_cfg(struct hns3_hw *hw)
+ 		return -EINVAL;
+ 
+ 	/* Cfg qs -> pri mapping */
+-	for (i = 0; i < hw->num_tc; i++) {
++	for (i = 0; i < hw->dcb_info.num_tc; i++) {
+ 		ret = hns3_qs_to_pri_map_cfg(hw, i, i);
+ 		if (ret) {
+ 			hns3_err(hw, "qs_to_pri mapping fail: %d", ret);
+@@ -1448,8 +1439,8 @@ hns3_dcb_info_cfg(struct hns3_adapter *hns)
+ 	for (i = 0; i < HNS3_MAX_USER_PRIO; i++)
+ 		hw->dcb_info.prio_tc[i] = dcb_rx_conf->dcb_tc[i];
+ 
+-	ret = hns3_dcb_update_tc_queue_mapping(hw, hw->data->nb_rx_queues,
+-					       hw->data->nb_tx_queues);
++	ret = hns3_queue_to_tc_mapping(hw, hw->data->nb_rx_queues,
++				       hw->data->nb_tx_queues);
+ 	if (ret)
+ 		hns3_err(hw, "update tc queue mapping failed, ret = %d.", ret);
+ 
+@@ -1635,8 +1626,7 @@ hns3_dcb_init(struct hns3_hw *hw)
+ 		 */
+ 		default_tqp_num = RTE_MIN(hw->rss_size_max,
+ 					  hw->tqps_num / hw->dcb_info.num_tc);
+-		ret = hns3_dcb_update_tc_queue_mapping(hw, default_tqp_num,
+-						       default_tqp_num);
++		ret = hns3_queue_to_tc_mapping(hw, default_tqp_num, default_tqp_num);
+ 		if (ret) {
+ 			hns3_err(hw,
+ 				 "update tc queue mapping failed, ret = %d.",
+@@ -1673,7 +1663,7 @@ hns3_update_queue_map_configure(struct hns3_adapter *hns)
+ 	if ((uint32_t)mq_mode & RTE_ETH_MQ_RX_DCB_FLAG)
+ 		return 0;
+ 
+-	ret = hns3_dcb_update_tc_queue_mapping(hw, nb_rx_q, nb_tx_q);
++	ret = hns3_queue_to_tc_mapping(hw, nb_rx_q, nb_tx_q);
+ 	if (ret) {
+ 		hns3_err(hw, "failed to update tc queue mapping, ret = %d.",
+ 			 ret);
+diff --git a/drivers/net/hns3/hns3_dump.c b/drivers/net/hns3/hns3_dump.c
+index 8411835..947526e 100644
+--- a/drivers/net/hns3/hns3_dump.c
++++ b/drivers/net/hns3/hns3_dump.c
+@@ -914,7 +914,7 @@ hns3_is_link_fc_mode(struct hns3_adapter *hns)
+ 	if (hw->current_fc_status == HNS3_FC_STATUS_PFC)
+ 		return false;
+ 
+-	if (hw->num_tc > 1 && !pf->support_multi_tc_pause)
++	if (hw->dcb_info.num_tc > 1 && !pf->support_multi_tc_pause)
+ 		return false;
+ 
+ 	return true;
+diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
+index f74fad4..035ebb1 100644
+--- a/drivers/net/hns3/hns3_ethdev.c
++++ b/drivers/net/hns3/hns3_ethdev.c
+@@ -5440,7 +5440,7 @@ hns3_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
+ 		return -EOPNOTSUPP;
+ 	}
+ 
+-	if (hw->num_tc > 1 && !pf->support_multi_tc_pause) {
++	if (hw->dcb_info.num_tc > 1 && !pf->support_multi_tc_pause) {
+ 		hns3_err(hw, "in multi-TC scenarios, MAC pause is not supported.");
+ 		return -EOPNOTSUPP;
+ 	}
+@@ -5517,7 +5517,7 @@ hns3_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
+ 	for (i = 0; i < dcb_info->nb_tcs; i++)
+ 		dcb_info->tc_bws[i] = hw->dcb_info.pg_info[0].tc_dwrr[i];
+ 
+-	for (i = 0; i < hw->num_tc; i++) {
++	for (i = 0; i < hw->dcb_info.num_tc; i++) {
+ 		dcb_info->tc_queue.tc_rxq[0][i].base = hw->alloc_rss_size * i;
+ 		dcb_info->tc_queue.tc_txq[0][i].base =
+ 						hw->tc_queue[i].tqp_offset;
+diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
+index d856285..532d44b 100644
+--- a/drivers/net/hns3/hns3_ethdev.h
++++ b/drivers/net/hns3/hns3_ethdev.h
+@@ -133,7 +133,7 @@ struct hns3_tc_info {
+ };
+ 
+ struct hns3_dcb_info {
+-	uint8_t num_tc;
++	uint8_t num_tc;     /* Total number of enabled TCs */
+ 	uint8_t num_pg;     /* It must be 1 if vNET-Base schd */
+ 	uint8_t pg_dwrr[HNS3_PG_NUM];
+ 	uint8_t prio_tc[HNS3_MAX_USER_PRIO];
+@@ -537,7 +537,6 @@ struct hns3_hw {
+ 	uint16_t rss_ind_tbl_size;
+ 	uint16_t rss_key_size;
+ 
+-	uint8_t num_tc;             /* Total number of enabled TCs */
+ 	uint8_t hw_tc_map;
+ 	enum hns3_fc_mode requested_fc_mode; /* FC mode requested by user */
+ 	struct hns3_dcb_info dcb_info;
+diff --git a/drivers/net/hns3/hns3_ethdev_vf.c b/drivers/net/hns3/hns3_ethdev_vf.c
+index 465280d..3e0bb9d 100644
+--- a/drivers/net/hns3/hns3_ethdev_vf.c
++++ b/drivers/net/hns3/hns3_ethdev_vf.c
+@@ -854,7 +854,7 @@ hns3vf_get_basic_info(struct hns3_hw *hw)
+ 
+ 	basic_info = (struct hns3_basic_info *)resp_msg;
+ 	hw->hw_tc_map = basic_info->hw_tc_map;
+-	hw->num_tc = hns3vf_get_num_tc(hw);
++	hw->dcb_info.num_tc = hns3vf_get_num_tc(hw);
+ 	hw->pf_vf_if_version = basic_info->pf_vf_if_version;
+ 	hns3vf_update_caps(hw, basic_info->caps);
+ 
+diff --git a/drivers/net/hns3/hns3_tm.c b/drivers/net/hns3/hns3_tm.c
+index d969164..387b37c 100644
+--- a/drivers/net/hns3/hns3_tm.c
++++ b/drivers/net/hns3/hns3_tm.c
+@@ -519,13 +519,13 @@ hns3_tm_tc_node_add(struct rte_eth_dev *dev, uint32_t node_id,
+ 
+ 	if (node_id >= pf->tm_conf.nb_nodes_max - 1 ||
+ 	    node_id < pf->tm_conf.nb_leaf_nodes_max ||
+-	    hns3_tm_calc_node_tc_no(&pf->tm_conf, node_id) >= hw->num_tc) {
++	    hns3_tm_calc_node_tc_no(&pf->tm_conf, node_id) >= hw->dcb_info.num_tc) {
+ 		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+ 		error->message = "invalid tc node ID";
+ 		return -EINVAL;
+ 	}
+ 
+-	if (pf->tm_conf.nb_tc_node >= hw->num_tc) {
++	if (pf->tm_conf.nb_tc_node >= hw->dcb_info.num_tc) {
+ 		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+ 		error->message = "too many TCs";
+ 		return -EINVAL;
+@@ -974,7 +974,7 @@ hns3_tm_configure_check(struct hns3_hw *hw, struct rte_tm_error *error)
+ 		}
+ 
+ 		if (hns3_tm_calc_node_tc_no(tm_conf, tm_node->id) >=
+-			hw->num_tc) {
++			hw->dcb_info.num_tc) {
+ 			error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+ 			error->message = "node's TC not exist";
+ 			return false;
+-- 
+2.33.0
+
diff --git a/0119-net-hns3-refactor-DCB-module.patch b/0119-net-hns3-refactor-DCB-module.patch
new file mode 100644
index 0000000..06fd5aa
--- /dev/null
+++ b/0119-net-hns3-refactor-DCB-module.patch
@@ -0,0 +1,296 @@
+From 9e24d82acdc382dfd6113a6e8a798f04f5a6f3b6 Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Tue, 1 Jul 2025 17:10:01 +0800
+Subject: [PATCH 06/24] net/hns3: refactor DCB module
+
+[ upstream commit c90c52d7a9028cca0686b799a7614c988d8b9b42 ]
+
+The DCB-related fields span in multiple structures, this patch moves
+them into struct hns3_dcb_info.
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ drivers/net/hns3/hns3_dcb.c       | 13 +++++------
+ drivers/net/hns3/hns3_ethdev.c    | 38 +++++++++++++++----------------
+ drivers/net/hns3/hns3_ethdev.h    |  8 +++----
+ drivers/net/hns3/hns3_ethdev_vf.c |  4 ++--
+ drivers/net/hns3/hns3_rss.c       |  8 +++----
+ 5 files changed, 34 insertions(+), 37 deletions(-)
+
+diff --git a/drivers/net/hns3/hns3_dcb.c b/drivers/net/hns3/hns3_dcb.c
+index ee7502d..76f597e 100644
+--- a/drivers/net/hns3/hns3_dcb.c
++++ b/drivers/net/hns3/hns3_dcb.c
+@@ -678,7 +678,7 @@ hns3_tc_queue_mapping_cfg(struct hns3_hw *hw, uint16_t nb_tx_q)
+ 	hw->tx_qnum_per_tc = tx_qnum_per_tc;
+ 	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
+ 		tc_queue = &hw->tc_queue[i];
+-		if (hw->hw_tc_map & BIT(i) && i < hw->dcb_info.num_tc) {
++		if (hw->dcb_info.hw_tc_map & BIT(i) && i < hw->dcb_info.num_tc) {
+ 			tc_queue->enable = true;
+ 			tc_queue->tqp_offset = i * hw->tx_qnum_per_tc;
+ 			tc_queue->tqp_count = hw->tx_qnum_per_tc;
+@@ -762,7 +762,7 @@ hns3_dcb_info_init(struct hns3_hw *hw)
+ 		if (i != 0)
+ 			continue;
+ 
+-		hw->dcb_info.pg_info[i].tc_bit_map = hw->hw_tc_map;
++		hw->dcb_info.pg_info[i].tc_bit_map = hw->dcb_info.hw_tc_map;
+ 		for (k = 0; k < hw->dcb_info.num_tc; k++)
+ 			hw->dcb_info.pg_info[i].tc_dwrr[k] = BW_MAX_PERCENT;
+ 	}
+@@ -1395,15 +1395,14 @@ static int
+ hns3_dcb_info_cfg(struct hns3_adapter *hns)
+ {
+ 	struct rte_eth_dcb_rx_conf *dcb_rx_conf;
+-	struct hns3_pf *pf = &hns->pf;
+ 	struct hns3_hw *hw = &hns->hw;
+ 	uint8_t tc_bw, bw_rest;
+ 	uint8_t i, j;
+ 	int ret;
+ 
+ 	dcb_rx_conf = &hw->data->dev_conf.rx_adv_conf.dcb_rx_conf;
+-	pf->local_max_tc = (uint8_t)dcb_rx_conf->nb_tcs;
+-	pf->pfc_max = (uint8_t)dcb_rx_conf->nb_tcs;
++	hw->dcb_info.local_max_tc = (uint8_t)dcb_rx_conf->nb_tcs;
++	hw->dcb_info.pfc_max = (uint8_t)dcb_rx_conf->nb_tcs;
+ 
+ 	/* Config pg0 */
+ 	memset(hw->dcb_info.pg_info, 0,
+@@ -1412,7 +1411,7 @@ hns3_dcb_info_cfg(struct hns3_adapter *hns)
+ 	hw->dcb_info.pg_info[0].pg_id = 0;
+ 	hw->dcb_info.pg_info[0].pg_sch_mode = HNS3_SCH_MODE_DWRR;
+ 	hw->dcb_info.pg_info[0].bw_limit = hw->max_tm_rate;
+-	hw->dcb_info.pg_info[0].tc_bit_map = hw->hw_tc_map;
++	hw->dcb_info.pg_info[0].tc_bit_map = hw->dcb_info.hw_tc_map;
+ 
+ 	/* Each tc has same bw for valid tc by default */
+ 	tc_bw = BW_MAX_PERCENT / hw->dcb_info.num_tc;
+@@ -1482,7 +1481,7 @@ hns3_dcb_info_update(struct hns3_adapter *hns, uint8_t num_tc)
+ 		bit_map = 1;
+ 		hw->dcb_info.num_tc = 1;
+ 	}
+-	hw->hw_tc_map = bit_map;
++	hw->dcb_info.hw_tc_map = bit_map;
+ 
+ 	return hns3_dcb_info_cfg(hns);
+ }
+diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
+index 035ebb1..8c4f38c 100644
+--- a/drivers/net/hns3/hns3_ethdev.c
++++ b/drivers/net/hns3/hns3_ethdev.c
+@@ -1876,7 +1876,6 @@ hns3_check_mq_mode(struct rte_eth_dev *dev)
+ 	enum rte_eth_rx_mq_mode rx_mq_mode = dev->data->dev_conf.rxmode.mq_mode;
+ 	enum rte_eth_tx_mq_mode tx_mq_mode = dev->data->dev_conf.txmode.mq_mode;
+ 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+-	struct hns3_pf *pf = HNS3_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+ 	struct rte_eth_dcb_rx_conf *dcb_rx_conf;
+ 	struct rte_eth_dcb_tx_conf *dcb_tx_conf;
+ 	uint8_t num_tc;
+@@ -1894,9 +1893,9 @@ hns3_check_mq_mode(struct rte_eth_dev *dev)
+ 	dcb_rx_conf = &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
+ 	dcb_tx_conf = &dev->data->dev_conf.tx_adv_conf.dcb_tx_conf;
+ 	if ((uint32_t)rx_mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
+-		if (dcb_rx_conf->nb_tcs > pf->tc_max) {
++		if (dcb_rx_conf->nb_tcs > hw->dcb_info.tc_max) {
+ 			hns3_err(hw, "nb_tcs(%u) > max_tc(%u) driver supported.",
+-				 dcb_rx_conf->nb_tcs, pf->tc_max);
++				 dcb_rx_conf->nb_tcs, hw->dcb_info.tc_max);
+ 			return -EINVAL;
+ 		}
+ 
+@@ -2837,25 +2836,25 @@ hns3_get_board_configuration(struct hns3_hw *hw)
+ 		return ret;
+ 	}
+ 
+-	pf->tc_max = cfg.tc_num;
+-	if (pf->tc_max > HNS3_MAX_TC_NUM || pf->tc_max < 1) {
++	hw->dcb_info.tc_max = cfg.tc_num;
++	if (hw->dcb_info.tc_max > HNS3_MAX_TC_NUM || hw->dcb_info.tc_max < 1) {
+ 		PMD_INIT_LOG(WARNING,
+ 			     "Get TC num(%u) from flash, set TC num to 1",
+-			     pf->tc_max);
+-		pf->tc_max = 1;
++			     hw->dcb_info.tc_max);
++		hw->dcb_info.tc_max = 1;
+ 	}
+ 
+ 	/* Dev does not support DCB */
+ 	if (!hns3_dev_get_support(hw, DCB)) {
+-		pf->tc_max = 1;
+-		pf->pfc_max = 0;
++		hw->dcb_info.tc_max = 1;
++		hw->dcb_info.pfc_max = 0;
+ 	} else
+-		pf->pfc_max = pf->tc_max;
++		hw->dcb_info.pfc_max = hw->dcb_info.tc_max;
+ 
+ 	hw->dcb_info.num_tc = 1;
+ 	hw->alloc_rss_size = RTE_MIN(hw->rss_size_max,
+ 				     hw->tqps_num / hw->dcb_info.num_tc);
+-	hns3_set_bit(hw->hw_tc_map, 0, 1);
++	hns3_set_bit(hw->dcb_info.hw_tc_map, 0, 1);
+ 	pf->tx_sch_mode = HNS3_FLAG_TC_BASE_SCH_MODE;
+ 
+ 	pf->wanted_umv_size = cfg.umv_space;
+@@ -3025,7 +3024,7 @@ hns3_tx_buffer_calc(struct hns3_hw *hw, struct hns3_pkt_buf_alloc *buf_alloc)
+ 	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
+ 		priv = &buf_alloc->priv_buf[i];
+ 
+-		if (hw->hw_tc_map & BIT(i)) {
++		if (hw->dcb_info.hw_tc_map & BIT(i)) {
+ 			if (total_size < pf->tx_buf_size)
+ 				return -ENOMEM;
+ 
+@@ -3076,7 +3075,7 @@ hns3_get_tc_num(struct hns3_hw *hw)
+ 	uint8_t i;
+ 
+ 	for (i = 0; i < HNS3_MAX_TC_NUM; i++)
+-		if (hw->hw_tc_map & BIT(i))
++		if (hw->dcb_info.hw_tc_map & BIT(i))
+ 			cnt++;
+ 	return cnt;
+ }
+@@ -3136,7 +3135,7 @@ hns3_get_no_pfc_priv_num(struct hns3_hw *hw,
+ 
+ 	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
+ 		priv = &buf_alloc->priv_buf[i];
+-		if (hw->hw_tc_map & BIT(i) &&
++		if (hw->dcb_info.hw_tc_map & BIT(i) &&
+ 		    !(hw->dcb_info.hw_pfc_map & BIT(i)) && priv->enable)
+ 			cnt++;
+ 	}
+@@ -3235,7 +3234,7 @@ hns3_rx_buf_calc_all(struct hns3_hw *hw, bool max,
+ 		priv->wl.high = 0;
+ 		priv->buf_size = 0;
+ 
+-		if (!(hw->hw_tc_map & BIT(i)))
++		if (!(hw->dcb_info.hw_tc_map & BIT(i)))
+ 			continue;
+ 
+ 		priv->enable = 1;
+@@ -3274,7 +3273,7 @@ hns3_drop_nopfc_buf_till_fit(struct hns3_hw *hw,
+ 	for (i = HNS3_MAX_TC_NUM - 1; i >= 0; i--) {
+ 		priv = &buf_alloc->priv_buf[i];
+ 		mask = BIT((uint8_t)i);
+-		if (hw->hw_tc_map & mask &&
++		if (hw->dcb_info.hw_tc_map & mask &&
+ 		    !(hw->dcb_info.hw_pfc_map & mask)) {
+ 			/* Clear the no pfc TC private buffer */
+ 			priv->wl.low = 0;
+@@ -3311,7 +3310,7 @@ hns3_drop_pfc_buf_till_fit(struct hns3_hw *hw,
+ 	for (i = HNS3_MAX_TC_NUM - 1; i >= 0; i--) {
+ 		priv = &buf_alloc->priv_buf[i];
+ 		mask = BIT((uint8_t)i);
+-		if (hw->hw_tc_map & mask && hw->dcb_info.hw_pfc_map & mask) {
++		if (hw->dcb_info.hw_tc_map & mask && hw->dcb_info.hw_pfc_map & mask) {
+ 			/* Reduce the number of pfc TC with private buffer */
+ 			priv->wl.low = 0;
+ 			priv->enable = 0;
+@@ -3369,7 +3368,7 @@ hns3_only_alloc_priv_buff(struct hns3_hw *hw,
+ 		priv->wl.high = 0;
+ 		priv->buf_size = 0;
+ 
+-		if (!(hw->hw_tc_map & BIT(i)))
++		if (!(hw->dcb_info.hw_tc_map & BIT(i)))
+ 			continue;
+ 
+ 		priv->enable = 1;
+@@ -5502,13 +5501,12 @@ static int
+ hns3_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
+ {
+ 	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+-	struct hns3_pf *pf = HNS3_DEV_PRIVATE_TO_PF(dev->data->dev_private);
+ 	enum rte_eth_rx_mq_mode mq_mode = dev->data->dev_conf.rxmode.mq_mode;
+ 	int i;
+ 
+ 	rte_spinlock_lock(&hw->lock);
+ 	if ((uint32_t)mq_mode & RTE_ETH_MQ_RX_DCB_FLAG)
+-		dcb_info->nb_tcs = pf->local_max_tc;
++		dcb_info->nb_tcs = hw->dcb_info.local_max_tc;
+ 	else
+ 		dcb_info->nb_tcs = 1;
+ 
+diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
+index 532d44b..ef39d81 100644
+--- a/drivers/net/hns3/hns3_ethdev.h
++++ b/drivers/net/hns3/hns3_ethdev.h
+@@ -133,7 +133,11 @@ struct hns3_tc_info {
+ };
+ 
+ struct hns3_dcb_info {
++	uint8_t tc_max;     /* max number of tc driver supported */
+ 	uint8_t num_tc;     /* Total number of enabled TCs */
++	uint8_t hw_tc_map;
++	uint8_t local_max_tc; /* max number of local tc */
++	uint8_t pfc_max;
+ 	uint8_t num_pg;     /* It must be 1 if vNET-Base schd */
+ 	uint8_t pg_dwrr[HNS3_PG_NUM];
+ 	uint8_t prio_tc[HNS3_MAX_USER_PRIO];
+@@ -537,7 +541,6 @@ struct hns3_hw {
+ 	uint16_t rss_ind_tbl_size;
+ 	uint16_t rss_key_size;
+ 
+-	uint8_t hw_tc_map;
+ 	enum hns3_fc_mode requested_fc_mode; /* FC mode requested by user */
+ 	struct hns3_dcb_info dcb_info;
+ 	enum hns3_fc_status current_fc_status; /* current flow control status */
+@@ -833,9 +836,6 @@ struct hns3_pf {
+ 	uint16_t mps; /* Max packet size */
+ 
+ 	uint8_t tx_sch_mode;
+-	uint8_t tc_max; /* max number of tc driver supported */
+-	uint8_t local_max_tc; /* max number of local tc */
+-	uint8_t pfc_max;
+ 	uint16_t pause_time;
+ 	bool support_fc_autoneg;       /* support FC autonegotiate */
+ 	bool support_multi_tc_pause;
+diff --git a/drivers/net/hns3/hns3_ethdev_vf.c b/drivers/net/hns3/hns3_ethdev_vf.c
+index 3e0bb9d..b713327 100644
+--- a/drivers/net/hns3/hns3_ethdev_vf.c
++++ b/drivers/net/hns3/hns3_ethdev_vf.c
+@@ -830,7 +830,7 @@ hns3vf_get_num_tc(struct hns3_hw *hw)
+ 	uint32_t i;
+ 
+ 	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
+-		if (hw->hw_tc_map & BIT(i))
++		if (hw->dcb_info.hw_tc_map & BIT(i))
+ 			num_tc++;
+ 	}
+ 	return num_tc;
+@@ -853,7 +853,7 @@ hns3vf_get_basic_info(struct hns3_hw *hw)
+ 	}
+ 
+ 	basic_info = (struct hns3_basic_info *)resp_msg;
+-	hw->hw_tc_map = basic_info->hw_tc_map;
++	hw->dcb_info.hw_tc_map = basic_info->hw_tc_map;
+ 	hw->dcb_info.num_tc = hns3vf_get_num_tc(hw);
+ 	hw->pf_vf_if_version = basic_info->pf_vf_if_version;
+ 	hns3vf_update_caps(hw, basic_info->caps);
+diff --git a/drivers/net/hns3/hns3_rss.c b/drivers/net/hns3/hns3_rss.c
+index 3eae4ca..508b3e2 100644
+--- a/drivers/net/hns3/hns3_rss.c
++++ b/drivers/net/hns3/hns3_rss.c
+@@ -940,13 +940,13 @@ hns3_set_rss_tc_mode_entry(struct hns3_hw *hw, uint8_t *tc_valid,
+ 			 * has to enable the unused TC by using TC0 queue
+ 			 * mapping configuration.
+ 			 */
+-			tc_valid[i] = (hw->hw_tc_map & BIT(i)) ?
+-					!!(hw->hw_tc_map & BIT(i)) : 1;
++			tc_valid[i] = (hw->dcb_info.hw_tc_map & BIT(i)) ?
++					!!(hw->dcb_info.hw_tc_map & BIT(i)) : 1;
+ 			tc_size[i] = roundup_size;
+-			tc_offset[i] = (hw->hw_tc_map & BIT(i)) ?
++			tc_offset[i] = (hw->dcb_info.hw_tc_map & BIT(i)) ?
+ 					rss_size * i : 0;
+ 		} else {
+-			tc_valid[i] = !!(hw->hw_tc_map & BIT(i));
++			tc_valid[i] = !!(hw->dcb_info.hw_tc_map & BIT(i));
+ 			tc_size[i] = tc_valid[i] ? roundup_size : 0;
+ 			tc_offset[i] = tc_valid[i] ? rss_size * i : 0;
+ 		}
+-- 
+2.33.0
+
diff --git a/0120-net-hns3-parse-max-TC-number-for-VF.patch b/0120-net-hns3-parse-max-TC-number-for-VF.patch
new file mode 100644
index 0000000..9d590f4
--- /dev/null
+++ b/0120-net-hns3-parse-max-TC-number-for-VF.patch
@@ -0,0 +1,73 @@
+From ae67f91f9ca6deb981d595000e06936b966e710d Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Tue, 1 Jul 2025 17:10:02 +0800
+Subject: [PATCH 07/24] net/hns3: parse max TC number for VF
+
+[ upstream commit 4bbf4f689cd029dac9fdf0e5e6dc63dc15be4629 ]
+
+The mailbox message HNS3_MBX_GET_BASIC_INFO can obtain the maximum
+number of TCs of the device. The VF does not support multiple TCs,
+therefore, this field is not saved.
+
+Now the VF needs to support multiple TCs, therefore, this field needs
+to be saved.
+
+This commit also support dump the TC info.
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ drivers/net/hns3/hns3_dump.c      | 2 ++
+ drivers/net/hns3/hns3_ethdev_vf.c | 1 +
+ drivers/net/hns3/hns3_mbx.h       | 2 +-
+ 3 files changed, 4 insertions(+), 1 deletion(-)
+
+diff --git a/drivers/net/hns3/hns3_dump.c b/drivers/net/hns3/hns3_dump.c
+index 947526e..16e7db7 100644
+--- a/drivers/net/hns3/hns3_dump.c
++++ b/drivers/net/hns3/hns3_dump.c
+@@ -209,6 +209,7 @@ hns3_get_device_basic_info(FILE *file, struct rte_eth_dev *dev)
+ 		"  - Device Base Info:\n"
+ 		"\t  -- name: %s\n"
+ 		"\t  -- adapter_state=%s\n"
++		"\t  -- tc_max=%u tc_num=%u\n"
+ 		"\t  -- nb_rx_queues=%u nb_tx_queues=%u\n"
+ 		"\t  -- total_tqps_num=%u tqps_num=%u intr_tqps_num=%u\n"
+ 		"\t  -- rss_size_max=%u alloc_rss_size=%u tx_qnum_per_tc=%u\n"
+@@ -221,6 +222,7 @@ hns3_get_device_basic_info(FILE *file, struct rte_eth_dev *dev)
+ 		"\t  -- intr_conf: lsc=%u rxq=%u\n",
+ 		dev->data->name,
+ 		hns3_get_adapter_state_name(hw->adapter_state),
++		hw->dcb_info.tc_max, hw->dcb_info.num_tc,
+ 		dev->data->nb_rx_queues, dev->data->nb_tx_queues,
+ 		hw->total_tqps_num, hw->tqps_num, hw->intr_tqps_num,
+ 		hw->rss_size_max, hw->alloc_rss_size, hw->tx_qnum_per_tc,
+diff --git a/drivers/net/hns3/hns3_ethdev_vf.c b/drivers/net/hns3/hns3_ethdev_vf.c
+index b713327..f06e06f 100644
+--- a/drivers/net/hns3/hns3_ethdev_vf.c
++++ b/drivers/net/hns3/hns3_ethdev_vf.c
+@@ -853,6 +853,7 @@ hns3vf_get_basic_info(struct hns3_hw *hw)
+ 	}
+ 
+ 	basic_info = (struct hns3_basic_info *)resp_msg;
++	hw->dcb_info.tc_max = basic_info->tc_max;
+ 	hw->dcb_info.hw_tc_map = basic_info->hw_tc_map;
+ 	hw->dcb_info.num_tc = hns3vf_get_num_tc(hw);
+ 	hw->pf_vf_if_version = basic_info->pf_vf_if_version;
+diff --git a/drivers/net/hns3/hns3_mbx.h b/drivers/net/hns3/hns3_mbx.h
+index 2b6cb8f..705e776 100644
+--- a/drivers/net/hns3/hns3_mbx.h
++++ b/drivers/net/hns3/hns3_mbx.h
+@@ -53,7 +53,7 @@ enum HNS3_MBX_OPCODE {
+ 
+ struct hns3_basic_info {
+ 	uint8_t hw_tc_map;
+-	uint8_t rsv;
++	uint8_t tc_max;
+ 	uint16_t pf_vf_if_version;
+ 	/* capabilities of VF dependent on PF */
+ 	uint32_t caps;
+-- 
+2.33.0
+
diff --git a/0121-net-hns3-support-multi-TCs-capability-for-VF.patch b/0121-net-hns3-support-multi-TCs-capability-for-VF.patch
new file mode 100644
index 0000000..1c3b400
--- /dev/null
+++ b/0121-net-hns3-support-multi-TCs-capability-for-VF.patch
@@ -0,0 +1,172 @@
+From 6c1d20c2842ccecc2174c0d668772b5ec4e2128c Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Tue, 1 Jul 2025 17:10:03 +0800
+Subject: [PATCH 08/24] net/hns3: support multi-TCs capability for VF
+
+[ upstream commit 95dc6d361143508077e3f3635c170d69126f8faa ]
+
+The VF multi-TCs feature depends on firmware and PF driver, the
+capability was set when:
+1) Firmware report VF multi-TCs flag.
+2) PF driver report VF multi-TCs flag.
+3) PF driver support query multi-TCs info mailbox message.
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ drivers/net/hns3/hns3_cmd.c       |  5 ++++-
+ drivers/net/hns3/hns3_cmd.h       |  2 ++
+ drivers/net/hns3/hns3_dump.c      |  3 ++-
+ drivers/net/hns3/hns3_ethdev.h    |  1 +
+ drivers/net/hns3/hns3_ethdev_vf.c | 33 +++++++++++++++++++++++++++++++
+ drivers/net/hns3/hns3_mbx.h       |  7 +++++++
+ 6 files changed, 49 insertions(+), 2 deletions(-)
+
+diff --git a/drivers/net/hns3/hns3_cmd.c b/drivers/net/hns3/hns3_cmd.c
+index 62da6dd..6955afb 100644
+--- a/drivers/net/hns3/hns3_cmd.c
++++ b/drivers/net/hns3/hns3_cmd.c
+@@ -482,7 +482,8 @@ static void
+ hns3_parse_capability(struct hns3_hw *hw,
+ 		      struct hns3_query_version_cmd *cmd)
+ {
+-	uint32_t caps = rte_le_to_cpu_32(cmd->caps[0]);
++	uint64_t caps = ((uint64_t)rte_le_to_cpu_32(cmd->caps[1]) << 32) |
++			rte_le_to_cpu_32(cmd->caps[0]);
+ 
+ 	if (hns3_get_bit(caps, HNS3_CAPS_FD_QUEUE_REGION_B))
+ 		hns3_set_bit(hw->capability, HNS3_DEV_SUPPORT_FD_QUEUE_REGION_B,
+@@ -524,6 +525,8 @@ hns3_parse_capability(struct hns3_hw *hw,
+ 		hns3_set_bit(hw->capability, HNS3_DEV_SUPPORT_FC_AUTO_B, 1);
+ 	if (hns3_get_bit(caps, HNS3_CAPS_GRO_B))
+ 		hns3_set_bit(hw->capability, HNS3_DEV_SUPPORT_GRO_B, 1);
++	if (hns3_get_bit(caps, HNS3_CAPS_VF_MULTI_TCS_B))
++		hns3_set_bit(hw->capability, HNS3_DEV_SUPPORT_VF_MULTI_TCS_B, 1);
+ }
+ 
+ static uint32_t
+diff --git a/drivers/net/hns3/hns3_cmd.h b/drivers/net/hns3/hns3_cmd.h
+index 4d707c1..86169f5 100644
+--- a/drivers/net/hns3/hns3_cmd.h
++++ b/drivers/net/hns3/hns3_cmd.h
+@@ -325,6 +325,7 @@ enum HNS3_CAPS_BITS {
+ 	HNS3_CAPS_TM_B = 19,
+ 	HNS3_CAPS_GRO_B = 20,
+ 	HNS3_CAPS_FC_AUTO_B = 30,
++	HNS3_CAPS_VF_MULTI_TCS_B = 34,
+ };
+ 
+ /* Capabilities of VF dependent on the PF */
+@@ -334,6 +335,7 @@ enum HNS3VF_CAPS_BITS {
+ 	 * in kernel side PF.
+ 	 */
+ 	HNS3VF_CAPS_VLAN_FLT_MOD_B = 0,
++	HNS3VF_CAPS_MULTI_TCS_B = 1,
+ };
+ 
+ enum HNS3_API_CAP_BITS {
+diff --git a/drivers/net/hns3/hns3_dump.c b/drivers/net/hns3/hns3_dump.c
+index 16e7db7..c8da7e1 100644
+--- a/drivers/net/hns3/hns3_dump.c
++++ b/drivers/net/hns3/hns3_dump.c
+@@ -105,7 +105,8 @@ hns3_get_dev_feature_capability(FILE *file, struct hns3_hw *hw)
+ 		{HNS3_DEV_SUPPORT_TM_B, "TM"},
+ 		{HNS3_DEV_SUPPORT_VF_VLAN_FLT_MOD_B, "VF VLAN FILTER MOD"},
+ 		{HNS3_DEV_SUPPORT_FC_AUTO_B, "FC AUTO"},
+-		{HNS3_DEV_SUPPORT_GRO_B, "GRO"}
++		{HNS3_DEV_SUPPORT_GRO_B, "GRO"},
++		{HNS3_DEV_SUPPORT_VF_MULTI_TCS_B, "VF MULTI TCS"},
+ 	};
+ 	uint32_t i;
+ 
+diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
+index ef39d81..c8acd28 100644
+--- a/drivers/net/hns3/hns3_ethdev.h
++++ b/drivers/net/hns3/hns3_ethdev.h
+@@ -918,6 +918,7 @@ enum hns3_dev_cap {
+ 	HNS3_DEV_SUPPORT_VF_VLAN_FLT_MOD_B,
+ 	HNS3_DEV_SUPPORT_FC_AUTO_B,
+ 	HNS3_DEV_SUPPORT_GRO_B,
++	HNS3_DEV_SUPPORT_VF_MULTI_TCS_B,
+ };
+ 
+ #define hns3_dev_get_support(hw, _name) \
+diff --git a/drivers/net/hns3/hns3_ethdev_vf.c b/drivers/net/hns3/hns3_ethdev_vf.c
+index f06e06f..52859a8 100644
+--- a/drivers/net/hns3/hns3_ethdev_vf.c
++++ b/drivers/net/hns3/hns3_ethdev_vf.c
+@@ -815,12 +815,45 @@ hns3vf_get_queue_info(struct hns3_hw *hw)
+ 	return hns3vf_check_tqp_info(hw);
+ }
+ 
++static void
++hns3vf_update_multi_tcs_cap(struct hns3_hw *hw, uint32_t pf_multi_tcs_bit)
++{
++	uint8_t resp_msg[HNS3_MBX_MAX_RESP_DATA_SIZE];
++	struct hns3_vf_to_pf_msg req;
++	int ret;
++
++	if (!hns3_dev_get_support(hw, VF_MULTI_TCS))
++		return;
++
++	if (pf_multi_tcs_bit == 0) {
++		/*
++		 * Early PF driver versions may don't report
++		 * HNS3VF_CAPS_MULTI_TCS_B when VF query basic info, so clear
++		 * the corresponding capability bit.
++		 */
++		hns3_set_bit(hw->capability, HNS3_DEV_SUPPORT_VF_MULTI_TCS_B, 0);
++		return;
++	}
++
++	/*
++	 * Early PF driver versions may also report HNS3VF_CAPS_MULTI_TCS_B
++	 * when VF query basic info, but they don't support query TC info
++	 * mailbox message, so clear the corresponding capability bit.
++	 */
++	hns3vf_mbx_setup(&req, HNS3_MBX_GET_TC, HNS3_MBX_GET_PRIO_MAP);
++	ret = hns3vf_mbx_send(hw, &req, true, resp_msg, sizeof(resp_msg));
++	if (ret)
++		hns3_set_bit(hw->capability, HNS3_DEV_SUPPORT_VF_MULTI_TCS_B, 0);
++}
++
+ static void
+ hns3vf_update_caps(struct hns3_hw *hw, uint32_t caps)
+ {
+ 	if (hns3_get_bit(caps, HNS3VF_CAPS_VLAN_FLT_MOD_B))
+ 		hns3_set_bit(hw->capability,
+ 				HNS3_DEV_SUPPORT_VF_VLAN_FLT_MOD_B, 1);
++
++	hns3vf_update_multi_tcs_cap(hw, hns3_get_bit(caps, HNS3VF_CAPS_MULTI_TCS_B));
+ }
+ 
+ static int
+diff --git a/drivers/net/hns3/hns3_mbx.h b/drivers/net/hns3/hns3_mbx.h
+index 705e776..97fbc4c 100644
+--- a/drivers/net/hns3/hns3_mbx.h
++++ b/drivers/net/hns3/hns3_mbx.h
+@@ -48,6 +48,9 @@ enum HNS3_MBX_OPCODE {
+ 
+ 	HNS3_MBX_HANDLE_VF_TBL = 38,    /* (VF -> PF) store/clear hw cfg tbl */
+ 	HNS3_MBX_GET_RING_VECTOR_MAP,   /* (VF -> PF) get ring-to-vector map */
++
++	HNS3_MBX_GET_TC = 47,           /* (VF -> PF) get tc info of PF configured */
++
+ 	HNS3_MBX_PUSH_LINK_STATUS = 201, /* (IMP -> PF) get port link status */
+ };
+ 
+@@ -59,6 +62,10 @@ struct hns3_basic_info {
+ 	uint32_t caps;
+ };
+ 
++enum hns3_mbx_get_tc_subcode {
++	HNS3_MBX_GET_PRIO_MAP = 0, /* query priority to tc map */
++};
++
+ /* below are per-VF mac-vlan subcodes */
+ enum hns3_mbx_mac_vlan_subcode {
+ 	HNS3_MBX_MAC_VLAN_UC_MODIFY = 0,        /* modify UC mac addr */
+-- 
+2.33.0
+
diff --git a/0122-net-hns3-fix-queue-TC-configuration-on-VF.patch b/0122-net-hns3-fix-queue-TC-configuration-on-VF.patch
new file mode 100644
index 0000000..c25930f
--- /dev/null
+++ b/0122-net-hns3-fix-queue-TC-configuration-on-VF.patch
@@ -0,0 +1,109 @@
+From 290aef514a1d17ad7e99b73f98539995caf0c1b3 Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Tue, 1 Jul 2025 17:09:59 +0800
+Subject: [PATCH 09/24] net/hns3: fix queue TC configuration on VF
+
+[ upstream commit a542f48bc0ec83c296ae01ad691479c17caf99b5 ]
+
+The VF cannot configure the mapping of queue to TC by directly writing
+the register. Instead, the mapping must be modified by using firmware
+command.
+
+Fixes: bba636698316 ("net/hns3: support Rx/Tx and related operations")
+Cc: stable@dpdk.org
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ drivers/net/hns3/hns3_cmd.h  |  8 ++++++++
+ drivers/net/hns3/hns3_rxtx.c | 26 +++++++++++++++++++++-----
+ 2 files changed, 29 insertions(+), 5 deletions(-)
+
+diff --git a/drivers/net/hns3/hns3_cmd.h b/drivers/net/hns3/hns3_cmd.h
+index 86169f5..2a2ec15 100644
+--- a/drivers/net/hns3/hns3_cmd.h
++++ b/drivers/net/hns3/hns3_cmd.h
+@@ -178,6 +178,7 @@ enum hns3_opcode_type {
+ 
+ 	/* TQP commands */
+ 	HNS3_OPC_QUERY_TX_STATUS        = 0x0B03,
++	HNS3_OPC_TQP_TX_QUEUE_TC        = 0x0B04,
+ 	HNS3_OPC_QUERY_RX_STATUS        = 0x0B13,
+ 	HNS3_OPC_CFG_COM_TQP_QUEUE      = 0x0B20,
+ 	HNS3_OPC_RESET_TQP_QUEUE        = 0x0B22,
+@@ -972,6 +973,13 @@ struct hns3_reset_tqp_queue_cmd {
+ 	uint8_t rsv[19];
+ };
+ 
++struct hns3vf_tx_ring_tc_cmd {
++	uint16_t tqp_id;
++	uint16_t rsv1;
++	uint8_t  tc_id;
++	uint8_t  rsv2[19];
++};
++
+ #define HNS3_CFG_RESET_MAC_B		3
+ #define HNS3_CFG_RESET_FUNC_B		7
+ #define HNS3_CFG_RESET_RCB_B		1
+diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
+index 393512b..6beb91c 100644
+--- a/drivers/net/hns3/hns3_rxtx.c
++++ b/drivers/net/hns3/hns3_rxtx.c
+@@ -1176,12 +1176,14 @@ hns3_init_txq(struct hns3_tx_queue *txq)
+ 	hns3_init_tx_queue_hw(txq);
+ }
+ 
+-static void
++static int
+ hns3_init_tx_ring_tc(struct hns3_adapter *hns)
+ {
++	struct hns3_cmd_desc desc;
++	struct hns3vf_tx_ring_tc_cmd *req = (struct hns3vf_tx_ring_tc_cmd *)desc.data;
+ 	struct hns3_hw *hw = &hns->hw;
+ 	struct hns3_tx_queue *txq;
+-	int i, num;
++	int i, num, ret;
+ 
+ 	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
+ 		struct hns3_tc_queue_info *tc_queue = &hw->tc_queue[i];
+@@ -1196,9 +1198,24 @@ hns3_init_tx_ring_tc(struct hns3_adapter *hns)
+ 			if (txq == NULL)
+ 				continue;
+ 
+-			hns3_write_dev(txq, HNS3_RING_TX_TC_REG, tc_queue->tc);
++			if (!hns->is_vf) {
++				hns3_write_dev(txq, HNS3_RING_TX_TC_REG, tc_queue->tc);
++				continue;
++			}
++
++			hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_TQP_TX_QUEUE_TC, false);
++			req->tqp_id = rte_cpu_to_le_16(num);
++			req->tc_id  = tc_queue->tc;
++			ret = hns3_cmd_send(hw, &desc, 1);
++			if (ret != 0) {
++				hns3_err(hw, "config Tx queue (%u)'s TC failed! ret = %d.",
++					 num, ret);
++				return ret;
++			}
+ 		}
+ 	}
++
++	return 0;
+ }
+ 
+ static int
+@@ -1274,9 +1291,8 @@ hns3_init_tx_queues(struct hns3_adapter *hns)
+ 		txq = (struct hns3_tx_queue *)hw->fkq_data.tx_queues[i];
+ 		hns3_init_txq(txq);
+ 	}
+-	hns3_init_tx_ring_tc(hns);
+ 
+-	return 0;
++	return hns3_init_tx_ring_tc(hns);
+ }
+ 
+ /*
+-- 
+2.33.0
+
diff --git a/0123-net-hns3-support-multi-TCs-configuration-for-VF.patch b/0123-net-hns3-support-multi-TCs-configuration-for-VF.patch
new file mode 100644
index 0000000..67a83f7
--- /dev/null
+++ b/0123-net-hns3-support-multi-TCs-configuration-for-VF.patch
@@ -0,0 +1,681 @@
+From 04c5d5addc5f94134ea729d9d3e07a1b0185fdf7 Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Tue, 1 Jul 2025 17:10:04 +0800
+Subject: [PATCH 10/24] net/hns3: support multi-TCs configuration for VF
+
+[ upstream commit fd89a25eb8112e0a6ff821a8f19e92b9d95082bc ]
+
+If VF has the multi-TCs capability, then application could configure the
+multi-TCs feature through the DCB interface. Because VF does not have
+its own ETS and PFC components, the constraints are as follows:
+
+1. The DCB configuration (struct rte_eth_dcb_rx_conf and
+   rte_eth_dcb_tx_conf) must be the same as that of the PF.
+2. VF does not support RTE_ETH_DCB_PFC_SUPPORT configuration.
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ drivers/net/hns3/hns3_dcb.c       | 106 ++++++++++++
+ drivers/net/hns3/hns3_dcb.h       |   4 +
+ drivers/net/hns3/hns3_dump.c      |   6 +-
+ drivers/net/hns3/hns3_ethdev.c    |  98 +-----------
+ drivers/net/hns3/hns3_ethdev_vf.c | 257 ++++++++++++++++++++++++++++--
+ drivers/net/hns3/hns3_mbx.h       |  39 +++++
+ 6 files changed, 402 insertions(+), 108 deletions(-)
+
+diff --git a/drivers/net/hns3/hns3_dcb.c b/drivers/net/hns3/hns3_dcb.c
+index 76f597e..c1a8542 100644
+--- a/drivers/net/hns3/hns3_dcb.c
++++ b/drivers/net/hns3/hns3_dcb.c
+@@ -1800,3 +1800,109 @@ hns3_fc_enable(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
+ 
+ 	return ret;
+ }
++
++int
++hns3_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
++{
++	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
++	enum rte_eth_rx_mq_mode mq_mode = dev->data->dev_conf.rxmode.mq_mode;
++	struct hns3_adapter *hns = HNS3_DEV_HW_TO_ADAPTER(hw);
++	int i;
++
++	if (hns->is_vf && !hns3_dev_get_support(hw, VF_MULTI_TCS))
++		return -ENOTSUP;
++
++	rte_spinlock_lock(&hw->lock);
++	if ((uint32_t)mq_mode & RTE_ETH_MQ_RX_DCB_FLAG)
++		dcb_info->nb_tcs = hw->dcb_info.local_max_tc;
++	else
++		dcb_info->nb_tcs = 1;
++
++	for (i = 0; i < HNS3_MAX_USER_PRIO; i++)
++		dcb_info->prio_tc[i] = hw->dcb_info.prio_tc[i];
++	for (i = 0; i < dcb_info->nb_tcs; i++)
++		dcb_info->tc_bws[i] = hw->dcb_info.pg_info[0].tc_dwrr[i];
++
++	for (i = 0; i < hw->dcb_info.num_tc; i++) {
++		dcb_info->tc_queue.tc_rxq[0][i].base = hw->alloc_rss_size * i;
++		dcb_info->tc_queue.tc_txq[0][i].base =
++						hw->tc_queue[i].tqp_offset;
++		dcb_info->tc_queue.tc_rxq[0][i].nb_queue = hw->alloc_rss_size;
++		dcb_info->tc_queue.tc_txq[0][i].nb_queue =
++						hw->tc_queue[i].tqp_count;
++	}
++	rte_spinlock_unlock(&hw->lock);
++
++	return 0;
++}
++
++int
++hns3_check_dev_mq_mode(struct rte_eth_dev *dev)
++{
++	enum rte_eth_rx_mq_mode rx_mq_mode = dev->data->dev_conf.rxmode.mq_mode;
++	enum rte_eth_tx_mq_mode tx_mq_mode = dev->data->dev_conf.txmode.mq_mode;
++	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
++	struct hns3_adapter *hns = HNS3_DEV_HW_TO_ADAPTER(hw);
++	struct rte_eth_dcb_rx_conf *dcb_rx_conf;
++	struct rte_eth_dcb_tx_conf *dcb_tx_conf;
++	uint8_t num_tc;
++	int max_tc = 0;
++	int i;
++
++	if (((uint32_t)rx_mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) ||
++	    (tx_mq_mode == RTE_ETH_MQ_TX_VMDQ_DCB ||
++	     tx_mq_mode == RTE_ETH_MQ_TX_VMDQ_ONLY)) {
++		hns3_err(hw, "VMDQ is not supported, rx_mq_mode = %d, tx_mq_mode = %d.",
++			 rx_mq_mode, tx_mq_mode);
++		return -EOPNOTSUPP;
++	}
++
++	dcb_rx_conf = &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
++	dcb_tx_conf = &dev->data->dev_conf.tx_adv_conf.dcb_tx_conf;
++	if ((uint32_t)rx_mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
++		if (dcb_rx_conf->nb_tcs > hw->dcb_info.tc_max) {
++			hns3_err(hw, "nb_tcs(%u) > max_tc(%u) driver supported.",
++				 dcb_rx_conf->nb_tcs, hw->dcb_info.tc_max);
++			return -EINVAL;
++		}
++
++		/*
++		 * The PF driver supports only four or eight TCs. But the
++		 * number of TCs supported by the VF driver is flexible,
++		 * therefore, only the number of TCs in the PF is verified.
++		 */
++		if (!hns->is_vf && !(dcb_rx_conf->nb_tcs == HNS3_4_TCS ||
++				     dcb_rx_conf->nb_tcs == HNS3_8_TCS)) {
++			hns3_err(hw, "on RTE_ETH_MQ_RX_DCB_RSS mode, "
++				 "nb_tcs(%d) != %d or %d in rx direction.",
++				 dcb_rx_conf->nb_tcs, HNS3_4_TCS, HNS3_8_TCS);
++			return -EINVAL;
++		}
++
++		if (dcb_rx_conf->nb_tcs != dcb_tx_conf->nb_tcs) {
++			hns3_err(hw, "num_tcs(%d) of tx is not equal to rx(%d)",
++				 dcb_tx_conf->nb_tcs, dcb_rx_conf->nb_tcs);
++			return -EINVAL;
++		}
++
++		for (i = 0; i < HNS3_MAX_USER_PRIO; i++) {
++			if (dcb_rx_conf->dcb_tc[i] != dcb_tx_conf->dcb_tc[i]) {
++				hns3_err(hw, "dcb_tc[%d] = %u in rx direction, "
++					 "is not equal to one in tx direction.",
++					 i, dcb_rx_conf->dcb_tc[i]);
++				return -EINVAL;
++			}
++			if (dcb_rx_conf->dcb_tc[i] > max_tc)
++				max_tc = dcb_rx_conf->dcb_tc[i];
++		}
++
++		num_tc = max_tc + 1;
++		if (num_tc > dcb_rx_conf->nb_tcs) {
++			hns3_err(hw, "max num_tc(%u) mapped > nb_tcs(%u)",
++				 num_tc, dcb_rx_conf->nb_tcs);
++			return -EINVAL;
++		}
++	}
++
++	return 0;
++}
+diff --git a/drivers/net/hns3/hns3_dcb.h b/drivers/net/hns3/hns3_dcb.h
+index d5bb5ed..552e9c3 100644
+--- a/drivers/net/hns3/hns3_dcb.h
++++ b/drivers/net/hns3/hns3_dcb.h
+@@ -215,4 +215,8 @@ int hns3_update_queue_map_configure(struct hns3_adapter *hns);
+ int hns3_port_shaper_update(struct hns3_hw *hw, uint32_t speed);
+ uint8_t hns3_txq_mapped_tc_get(struct hns3_hw *hw, uint16_t txq_no);
+ 
++int hns3_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info);
++
++int hns3_check_dev_mq_mode(struct rte_eth_dev *dev);
++
+ #endif /* HNS3_DCB_H */
+diff --git a/drivers/net/hns3/hns3_dump.c b/drivers/net/hns3/hns3_dump.c
+index c8da7e1..5bd1a45 100644
+--- a/drivers/net/hns3/hns3_dump.c
++++ b/drivers/net/hns3/hns3_dump.c
+@@ -210,7 +210,7 @@ hns3_get_device_basic_info(FILE *file, struct rte_eth_dev *dev)
+ 		"  - Device Base Info:\n"
+ 		"\t  -- name: %s\n"
+ 		"\t  -- adapter_state=%s\n"
+-		"\t  -- tc_max=%u tc_num=%u\n"
++		"\t  -- tc_max=%u tc_num=%u dwrr[%u %u %u %u]\n"
+ 		"\t  -- nb_rx_queues=%u nb_tx_queues=%u\n"
+ 		"\t  -- total_tqps_num=%u tqps_num=%u intr_tqps_num=%u\n"
+ 		"\t  -- rss_size_max=%u alloc_rss_size=%u tx_qnum_per_tc=%u\n"
+@@ -224,6 +224,10 @@ hns3_get_device_basic_info(FILE *file, struct rte_eth_dev *dev)
+ 		dev->data->name,
+ 		hns3_get_adapter_state_name(hw->adapter_state),
+ 		hw->dcb_info.tc_max, hw->dcb_info.num_tc,
++		hw->dcb_info.pg_info[0].tc_dwrr[0],
++		hw->dcb_info.pg_info[0].tc_dwrr[1],
++		hw->dcb_info.pg_info[0].tc_dwrr[2],
++		hw->dcb_info.pg_info[0].tc_dwrr[3],
+ 		dev->data->nb_rx_queues, dev->data->nb_tx_queues,
+ 		hw->total_tqps_num, hw->tqps_num, hw->intr_tqps_num,
+ 		hw->rss_size_max, hw->alloc_rss_size, hw->tx_qnum_per_tc,
+diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
+index 8c4f38c..d8cb5ce 100644
+--- a/drivers/net/hns3/hns3_ethdev.c
++++ b/drivers/net/hns3/hns3_ethdev.c
+@@ -1870,71 +1870,6 @@ hns3_remove_mc_mac_addr(struct hns3_hw *hw, struct rte_ether_addr *mac_addr)
+ 	return ret;
+ }
+ 
+-static int
+-hns3_check_mq_mode(struct rte_eth_dev *dev)
+-{
+-	enum rte_eth_rx_mq_mode rx_mq_mode = dev->data->dev_conf.rxmode.mq_mode;
+-	enum rte_eth_tx_mq_mode tx_mq_mode = dev->data->dev_conf.txmode.mq_mode;
+-	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+-	struct rte_eth_dcb_rx_conf *dcb_rx_conf;
+-	struct rte_eth_dcb_tx_conf *dcb_tx_conf;
+-	uint8_t num_tc;
+-	int max_tc = 0;
+-	int i;
+-
+-	if (((uint32_t)rx_mq_mode & RTE_ETH_MQ_RX_VMDQ_FLAG) ||
+-	    (tx_mq_mode == RTE_ETH_MQ_TX_VMDQ_DCB ||
+-	     tx_mq_mode == RTE_ETH_MQ_TX_VMDQ_ONLY)) {
+-		hns3_err(hw, "VMDQ is not supported, rx_mq_mode = %d, tx_mq_mode = %d.",
+-			 rx_mq_mode, tx_mq_mode);
+-		return -EOPNOTSUPP;
+-	}
+-
+-	dcb_rx_conf = &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
+-	dcb_tx_conf = &dev->data->dev_conf.tx_adv_conf.dcb_tx_conf;
+-	if ((uint32_t)rx_mq_mode & RTE_ETH_MQ_RX_DCB_FLAG) {
+-		if (dcb_rx_conf->nb_tcs > hw->dcb_info.tc_max) {
+-			hns3_err(hw, "nb_tcs(%u) > max_tc(%u) driver supported.",
+-				 dcb_rx_conf->nb_tcs, hw->dcb_info.tc_max);
+-			return -EINVAL;
+-		}
+-
+-		if (!(dcb_rx_conf->nb_tcs == HNS3_4_TCS ||
+-		      dcb_rx_conf->nb_tcs == HNS3_8_TCS)) {
+-			hns3_err(hw, "on RTE_ETH_MQ_RX_DCB_RSS mode, "
+-				 "nb_tcs(%d) != %d or %d in rx direction.",
+-				 dcb_rx_conf->nb_tcs, HNS3_4_TCS, HNS3_8_TCS);
+-			return -EINVAL;
+-		}
+-
+-		if (dcb_rx_conf->nb_tcs != dcb_tx_conf->nb_tcs) {
+-			hns3_err(hw, "num_tcs(%d) of tx is not equal to rx(%d)",
+-				 dcb_tx_conf->nb_tcs, dcb_rx_conf->nb_tcs);
+-			return -EINVAL;
+-		}
+-
+-		for (i = 0; i < HNS3_MAX_USER_PRIO; i++) {
+-			if (dcb_rx_conf->dcb_tc[i] != dcb_tx_conf->dcb_tc[i]) {
+-				hns3_err(hw, "dcb_tc[%d] = %u in rx direction, "
+-					 "is not equal to one in tx direction.",
+-					 i, dcb_rx_conf->dcb_tc[i]);
+-				return -EINVAL;
+-			}
+-			if (dcb_rx_conf->dcb_tc[i] > max_tc)
+-				max_tc = dcb_rx_conf->dcb_tc[i];
+-		}
+-
+-		num_tc = max_tc + 1;
+-		if (num_tc > dcb_rx_conf->nb_tcs) {
+-			hns3_err(hw, "max num_tc(%u) mapped > nb_tcs(%u)",
+-				 num_tc, dcb_rx_conf->nb_tcs);
+-			return -EINVAL;
+-		}
+-	}
+-
+-	return 0;
+-}
+-
+ static int
+ hns3_bind_ring_with_vector(struct hns3_hw *hw, uint16_t vector_id, bool en,
+ 			   enum hns3_ring_type queue_type, uint16_t queue_id)
+@@ -2033,7 +1968,7 @@ hns3_check_dev_conf(struct rte_eth_dev *dev)
+ 	struct rte_eth_conf *conf = &dev->data->dev_conf;
+ 	int ret;
+ 
+-	ret = hns3_check_mq_mode(dev);
++	ret = hns3_check_dev_mq_mode(dev);
+ 	if (ret)
+ 		return ret;
+ 
+@@ -5497,37 +5432,6 @@ hns3_priority_flow_ctrl_set(struct rte_eth_dev *dev,
+ 	return ret;
+ }
+ 
+-static int
+-hns3_get_dcb_info(struct rte_eth_dev *dev, struct rte_eth_dcb_info *dcb_info)
+-{
+-	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+-	enum rte_eth_rx_mq_mode mq_mode = dev->data->dev_conf.rxmode.mq_mode;
+-	int i;
+-
+-	rte_spinlock_lock(&hw->lock);
+-	if ((uint32_t)mq_mode & RTE_ETH_MQ_RX_DCB_FLAG)
+-		dcb_info->nb_tcs = hw->dcb_info.local_max_tc;
+-	else
+-		dcb_info->nb_tcs = 1;
+-
+-	for (i = 0; i < HNS3_MAX_USER_PRIO; i++)
+-		dcb_info->prio_tc[i] = hw->dcb_info.prio_tc[i];
+-	for (i = 0; i < dcb_info->nb_tcs; i++)
+-		dcb_info->tc_bws[i] = hw->dcb_info.pg_info[0].tc_dwrr[i];
+-
+-	for (i = 0; i < hw->dcb_info.num_tc; i++) {
+-		dcb_info->tc_queue.tc_rxq[0][i].base = hw->alloc_rss_size * i;
+-		dcb_info->tc_queue.tc_txq[0][i].base =
+-						hw->tc_queue[i].tqp_offset;
+-		dcb_info->tc_queue.tc_rxq[0][i].nb_queue = hw->alloc_rss_size;
+-		dcb_info->tc_queue.tc_txq[0][i].nb_queue =
+-						hw->tc_queue[i].tqp_count;
+-	}
+-	rte_spinlock_unlock(&hw->lock);
+-
+-	return 0;
+-}
+-
+ static int
+ hns3_reinit_dev(struct hns3_adapter *hns)
+ {
+diff --git a/drivers/net/hns3/hns3_ethdev_vf.c b/drivers/net/hns3/hns3_ethdev_vf.c
+index 52859a8..a207bbf 100644
+--- a/drivers/net/hns3/hns3_ethdev_vf.c
++++ b/drivers/net/hns3/hns3_ethdev_vf.c
+@@ -379,6 +379,236 @@ hns3vf_bind_ring_with_vector(struct hns3_hw *hw, uint16_t vector_id,
+ 	return ret;
+ }
+ 
++static int
++hns3vf_set_multi_tc(struct hns3_hw *hw, const struct hns3_mbx_tc_config *config)
++{
++	struct hns3_mbx_tc_config *payload;
++	struct hns3_vf_to_pf_msg req;
++	int ret;
++
++	hns3vf_mbx_setup(&req, HNS3_MBX_SET_TC, 0);
++	payload = (struct hns3_mbx_tc_config *)req.data;
++	memcpy(payload, config, sizeof(*payload));
++	payload->prio_tc_map = rte_cpu_to_le_32(config->prio_tc_map);
++	ret = hns3vf_mbx_send(hw, &req, true, NULL, 0);
++	if (ret)
++		hns3_err(hw, "failed to set multi-tc, ret = %d.", ret);
++
++	return ret;
++}
++
++static int
++hns3vf_unset_multi_tc(struct hns3_hw *hw)
++{
++	struct hns3_mbx_tc_config *paylod;
++	struct hns3_vf_to_pf_msg req;
++	int ret;
++
++	hns3vf_mbx_setup(&req, HNS3_MBX_SET_TC, 0);
++	paylod = (struct hns3_mbx_tc_config *)req.data;
++	paylod->tc_dwrr[0] = HNS3_ETS_DWRR_MAX;
++	paylod->num_tc = 1;
++	ret = hns3vf_mbx_send(hw, &req, true, NULL, 0);
++	if (ret)
++		hns3_err(hw, "failed to unset multi-tc, ret = %d.", ret);
++
++	return ret;
++}
++
++static int
++hns3vf_check_multi_tc_config(struct rte_eth_dev *dev, const struct hns3_mbx_tc_config *info)
++{
++	struct rte_eth_dcb_rx_conf *rx_conf = &dev->data->dev_conf.rx_adv_conf.dcb_rx_conf;
++	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
++	uint32_t prio_tc_map = info->prio_tc_map;
++	uint8_t map;
++	int i;
++
++	if (rx_conf->nb_tcs != info->num_tc) {
++		hns3_err(hw, "num_tcs(%d) is not equal to PF config(%u)!",
++			 rx_conf->nb_tcs, info->num_tc);
++		return -EINVAL;
++	}
++
++	for (i = 0; i < HNS3_MAX_USER_PRIO; i++) {
++		map = prio_tc_map & HNS3_MBX_PRIO_MASK;
++		prio_tc_map >>= HNS3_MBX_PRIO_SHIFT;
++		if (rx_conf->dcb_tc[i] != map) {
++			hns3_err(hw, "dcb_tc[%d] = %u is not equal to PF config(%u)!",
++				 i, rx_conf->dcb_tc[i], map);
++			return -EINVAL;
++		}
++	}
++
++	return 0;
++}
++
++static int
++hns3vf_get_multi_tc_info(struct hns3_hw *hw, struct hns3_mbx_tc_config *info)
++{
++	uint8_t resp_msg[HNS3_MBX_MAX_RESP_DATA_SIZE];
++	struct hns3_mbx_tc_prio_map *map = (struct hns3_mbx_tc_prio_map *)resp_msg;
++	struct hns3_mbx_tc_ets_info *ets = (struct hns3_mbx_tc_ets_info *)resp_msg;
++	struct hns3_vf_to_pf_msg req;
++	int i, ret;
++
++	memset(info, 0, sizeof(*info));
++
++	hns3vf_mbx_setup(&req, HNS3_MBX_GET_TC, HNS3_MBX_GET_PRIO_MAP);
++	ret = hns3vf_mbx_send(hw, &req, true, resp_msg, sizeof(resp_msg));
++	if (ret) {
++		hns3_err(hw, "failed to get multi-tc prio map, ret = %d.", ret);
++		return ret;
++	}
++	info->prio_tc_map = rte_le_to_cpu_32(map->prio_tc_map);
++
++	hns3vf_mbx_setup(&req, HNS3_MBX_GET_TC, HNS3_MBX_GET_ETS_INFO);
++	ret = hns3vf_mbx_send(hw, &req, true, resp_msg, sizeof(resp_msg));
++	if (ret) {
++		hns3_err(hw, "failed to get multi-tc ETS info, ret = %d.", ret);
++		return ret;
++	}
++	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
++		if (ets->sch_mode[i] == HNS3_ETS_SCHED_MODE_INVALID)
++			continue;
++		info->tc_dwrr[i] = ets->sch_mode[i];
++		info->num_tc++;
++		if (ets->sch_mode[i] > 0)
++			info->tc_sch_mode |= 1u << i;
++	}
++
++	return 0;
++}
++
++static void
++hns3vf_update_dcb_info(struct hns3_hw *hw, const struct hns3_mbx_tc_config *info)
++{
++	uint32_t prio_tc_map;
++	uint8_t map;
++	int i;
++
++	hw->dcb_info.local_max_tc = hw->dcb_info.num_tc;
++	hw->dcb_info.hw_tc_map = (1u << hw->dcb_info.num_tc) - 1u;
++	memset(hw->dcb_info.pg_info[0].tc_dwrr, 0, sizeof(hw->dcb_info.pg_info[0].tc_dwrr));
++
++	if (hw->dcb_info.num_tc == 1) {
++		memset(hw->dcb_info.prio_tc, 0, sizeof(hw->dcb_info.prio_tc));
++		hw->dcb_info.pg_info[0].tc_dwrr[0] = HNS3_ETS_DWRR_MAX;
++		return;
++	}
++
++	if (info == NULL)
++		return;
++
++	prio_tc_map = info->prio_tc_map;
++	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
++		map = prio_tc_map & HNS3_MBX_PRIO_MASK;
++		prio_tc_map >>= HNS3_MBX_PRIO_SHIFT;
++		hw->dcb_info.prio_tc[i] = map;
++	}
++	for (i = 0; i < hw->dcb_info.num_tc; i++)
++		hw->dcb_info.pg_info[0].tc_dwrr[i] = info->tc_dwrr[i];
++}
++
++static int
++hns3vf_setup_dcb(struct rte_eth_dev *dev)
++{
++	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
++	struct hns3_mbx_tc_config info;
++	int ret;
++
++	if (!hns3_dev_get_support(hw, VF_MULTI_TCS)) {
++		hns3_err(hw, "this port does not support dcb configurations.");
++		return -ENOTSUP;
++	}
++
++	if (dev->data->dev_conf.dcb_capability_en & RTE_ETH_DCB_PFC_SUPPORT) {
++		hns3_err(hw, "VF don't support PFC!");
++		return -ENOTSUP;
++	}
++
++	ret = hns3vf_get_multi_tc_info(hw, &info);
++	if (ret)
++		return ret;
++
++	ret = hns3vf_check_multi_tc_config(dev, &info);
++	if (ret)
++		return ret;
++
++	/*
++	 * If multiple-TCs have been configured, cancel the configuration
++	 * first. Otherwise, the configuration will fail.
++	 */
++	if (hw->dcb_info.num_tc > 1) {
++		ret = hns3vf_unset_multi_tc(hw);
++		if (ret)
++			return ret;
++		hw->dcb_info.num_tc = 1;
++		hns3vf_update_dcb_info(hw, NULL);
++	}
++
++	ret = hns3vf_set_multi_tc(hw, &info);
++	if (ret)
++		return ret;
++
++	hw->dcb_info.num_tc = info.num_tc;
++	hns3vf_update_dcb_info(hw, &info);
++
++	return hns3_queue_to_tc_mapping(hw, hw->data->nb_rx_queues, hw->data->nb_rx_queues);
++}
++
++static int
++hns3vf_unset_dcb(struct rte_eth_dev *dev)
++{
++	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
++	int ret;
++
++	if (hw->dcb_info.num_tc > 1) {
++		ret = hns3vf_unset_multi_tc(hw);
++		if (ret)
++			return ret;
++	}
++
++	hw->dcb_info.num_tc = 1;
++	hns3vf_update_dcb_info(hw, NULL);
++
++	return hns3_queue_to_tc_mapping(hw, hw->data->nb_rx_queues, hw->data->nb_rx_queues);
++}
++
++static int
++hns3vf_config_dcb(struct rte_eth_dev *dev)
++{
++	struct rte_eth_conf *conf = &dev->data->dev_conf;
++	uint32_t rx_mq_mode = conf->rxmode.mq_mode;
++	int ret;
++
++	if (rx_mq_mode & RTE_ETH_MQ_RX_DCB_FLAG)
++		ret = hns3vf_setup_dcb(dev);
++	else
++		ret = hns3vf_unset_dcb(dev);
++
++	return ret;
++}
++
++static int
++hns3vf_check_dev_conf(struct rte_eth_dev *dev)
++{
++	struct hns3_hw *hw = HNS3_DEV_PRIVATE_TO_HW(dev->data->dev_private);
++	struct rte_eth_conf *conf = &dev->data->dev_conf;
++	int ret;
++
++	ret = hns3_check_dev_mq_mode(dev);
++	if (ret)
++		return ret;
++
++	if (conf->link_speeds & RTE_ETH_LINK_SPEED_FIXED) {
++		hns3_err(hw, "setting link speed/duplex not supported");
++		ret = -EINVAL;
++	}
++
++	return ret;
++}
++
+ static int
+ hns3vf_dev_configure(struct rte_eth_dev *dev)
+ {
+@@ -412,11 +642,13 @@ hns3vf_dev_configure(struct rte_eth_dev *dev)
+ 	}
+ 
+ 	hw->adapter_state = HNS3_NIC_CONFIGURING;
+-	if (conf->link_speeds & RTE_ETH_LINK_SPEED_FIXED) {
+-		hns3_err(hw, "setting link speed/duplex not supported");
+-		ret = -EINVAL;
++	ret = hns3vf_check_dev_conf(dev);
++	if (ret)
++		goto cfg_err;
++
++	ret = hns3vf_config_dcb(dev);
++	if (ret)
+ 		goto cfg_err;
+-	}
+ 
+ 	/* When RSS is not configured, redirect the packet queue 0 */
+ 	if ((uint32_t)mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) {
+@@ -1496,6 +1728,15 @@ hns3vf_init_vf(struct rte_eth_dev *eth_dev)
+ 	return ret;
+ }
+ 
++static void
++hns3vf_notify_uninit(struct hns3_hw *hw)
++{
++	struct hns3_vf_to_pf_msg req;
++
++	hns3vf_mbx_setup(&req, HNS3_MBX_VF_UNINIT, 0);
++	(void)hns3vf_mbx_send(hw, &req, false, NULL, 0);
++}
++
+ static void
+ hns3vf_uninit_vf(struct rte_eth_dev *eth_dev)
+ {
+@@ -1515,6 +1756,7 @@ hns3vf_uninit_vf(struct rte_eth_dev *eth_dev)
+ 	rte_intr_disable(pci_dev->intr_handle);
+ 	hns3_intr_unregister(pci_dev->intr_handle, hns3vf_interrupt_handler,
+ 			     eth_dev);
++	(void)hns3vf_notify_uninit(hw);
+ 	hns3_cmd_uninit(hw);
+ 	hns3_cmd_destroy_queue(hw);
+ 	hw->io_base = NULL;
+@@ -1652,14 +1894,8 @@ static int
+ hns3vf_do_start(struct hns3_adapter *hns, bool reset_queue)
+ {
+ 	struct hns3_hw *hw = &hns->hw;
+-	uint16_t nb_rx_q = hw->data->nb_rx_queues;
+-	uint16_t nb_tx_q = hw->data->nb_tx_queues;
+ 	int ret;
+ 
+-	ret = hns3_queue_to_tc_mapping(hw, nb_rx_q, nb_tx_q);
+-	if (ret)
+-		return ret;
+-
+ 	hns3_enable_rxd_adv_layout(hw);
+ 
+ 	ret = hns3_init_queues(hns, reset_queue);
+@@ -2240,6 +2476,7 @@ static const struct eth_dev_ops hns3vf_eth_dev_ops = {
+ 	.vlan_filter_set    = hns3vf_vlan_filter_set,
+ 	.vlan_offload_set   = hns3vf_vlan_offload_set,
+ 	.get_reg            = hns3_get_regs,
++	.get_dcb_info       = hns3_get_dcb_info,
+ 	.dev_supported_ptypes_get = hns3_dev_supported_ptypes_get,
+ 	.tx_done_cleanup    = hns3_tx_done_cleanup,
+ 	.eth_dev_priv_dump  = hns3_eth_dev_priv_dump,
+diff --git a/drivers/net/hns3/hns3_mbx.h b/drivers/net/hns3/hns3_mbx.h
+index 97fbc4c..1a8c2df 100644
+--- a/drivers/net/hns3/hns3_mbx.h
++++ b/drivers/net/hns3/hns3_mbx.h
+@@ -9,6 +9,8 @@
+ 
+ #include <rte_spinlock.h>
+ 
++#include "hns3_cmd.h"
++
+ enum HNS3_MBX_OPCODE {
+ 	HNS3_MBX_RESET = 0x01,          /* (VF -> PF) assert reset */
+ 	HNS3_MBX_ASSERTING_RESET,       /* (PF -> VF) PF is asserting reset */
+@@ -45,11 +47,13 @@ enum HNS3_MBX_OPCODE {
+ 	HNS3_MBX_PUSH_VLAN_INFO = 34,   /* (PF -> VF) push port base vlan */
+ 
+ 	HNS3_MBX_PUSH_PROMISC_INFO = 36, /* (PF -> VF) push vf promisc info */
++	HNS3_MBX_VF_UNINIT,              /* (VF -> PF) vf is unintializing */
+ 
+ 	HNS3_MBX_HANDLE_VF_TBL = 38,    /* (VF -> PF) store/clear hw cfg tbl */
+ 	HNS3_MBX_GET_RING_VECTOR_MAP,   /* (VF -> PF) get ring-to-vector map */
+ 
+ 	HNS3_MBX_GET_TC = 47,           /* (VF -> PF) get tc info of PF configured */
++	HNS3_MBX_SET_TC,                /* (VF -> PF) set tc */
+ 
+ 	HNS3_MBX_PUSH_LINK_STATUS = 201, /* (IMP -> PF) get port link status */
+ };
+@@ -64,8 +68,43 @@ struct hns3_basic_info {
+ 
+ enum hns3_mbx_get_tc_subcode {
+ 	HNS3_MBX_GET_PRIO_MAP = 0, /* query priority to tc map */
++	HNS3_MBX_GET_ETS_INFO,     /* query ets info */
++};
++
++struct hns3_mbx_tc_prio_map {
++	/*
++	 * Each four bits correspond to one priority's TC.
++	 * Bit0-3 correspond to priority-0's TC, bit4-7 correspond to
++	 * priority-1's TC, and so on.
++	 */
++	uint32_t prio_tc_map;
+ };
+ 
++#define HNS3_ETS_SCHED_MODE_INVALID	255
++#define HNS3_ETS_DWRR_MAX		100
++struct hns3_mbx_tc_ets_info {
++	uint8_t sch_mode[HNS3_MAX_TC_NUM]; /* 1~100: DWRR, 0: SP; 255-invalid */
++};
++
++#define HNS3_MBX_PRIO_SHIFT	4
++#define HNS3_MBX_PRIO_MASK	0xFu
++struct __rte_packed_begin hns3_mbx_tc_config {
++	/*
++	 * Each four bits correspond to one priority's TC.
++	 * Bit0-3 correspond to priority-0's TC, bit4-7 correspond to
++	 * priority-1's TC, and so on.
++	 */
++	uint32_t prio_tc_map;
++	uint8_t tc_dwrr[HNS3_MAX_TC_NUM];
++	uint8_t num_tc;
++	/*
++	 * Each bit correspond to one TC's scheduling mode, 0 means SP
++	 * scheduling mode, 1 means DWRR scheduling mode.
++	 * Bit0 corresponds to TC0, bit1 corresponds to TC1, and so on.
++	 */
++	uint8_t tc_sch_mode;
++} __rte_packed_end;
++
+ /* below are per-VF mac-vlan subcodes */
+ enum hns3_mbx_mac_vlan_subcode {
+ 	HNS3_MBX_MAC_VLAN_UC_MODIFY = 0,        /* modify UC mac addr */
+-- 
+2.33.0
+
diff --git a/0124-app-testpmd-avoid-crash-in-DCB-config.patch b/0124-app-testpmd-avoid-crash-in-DCB-config.patch
new file mode 100644
index 0000000..1ae38e6
--- /dev/null
+++ b/0124-app-testpmd-avoid-crash-in-DCB-config.patch
@@ -0,0 +1,46 @@
+From f0e5cd4941e2b6e95c86e27de5c93d3ba5c3c096 Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Thu, 20 Feb 2025 15:06:51 +0800
+Subject: [PATCH 11/24] app/testpmd: avoid crash in DCB config
+
+[ upstream commit d646e219b34ffc4d531f3703fc317e7cff9a25ae ]
+
+The "port config dcb ..." command will segment fault when input with
+invalid port id, this patch fixes it.
+
+Fixes: 9b53e542e9e1 ("app/testpmd: add priority flow control")
+Cc: stable@dpdk.org
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ app/test-pmd/cmdline.c | 6 ++++++
+ 1 file changed, 6 insertions(+)
+
+diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
+index 8ef116c..7eba675 100644
+--- a/app/test-pmd/cmdline.c
++++ b/app/test-pmd/cmdline.c
+@@ -3201,6 +3201,9 @@ cmd_config_dcb_parsed(void *parsed_result,
+ 	uint8_t pfc_en;
+ 	int ret;
+ 
++	if (port_id_is_invalid(port_id, ENABLED_WARN))
++		return;
++
+ 	port = &ports[port_id];
+ 	/** Check if the port is not started **/
+ 	if (port->port_status != RTE_PORT_STOPPED) {
+@@ -6401,6 +6404,9 @@ cmd_priority_flow_ctrl_set_parsed(void *parsed_result,
+ 	int rx_fc_enable, tx_fc_enable;
+ 	int ret;
+ 
++	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
++		return;
++
+ 	/*
+ 	 * Rx on/off, flow control is enabled/disabled on RX side. This can indicate
+ 	 * the RTE_ETH_FC_TX_PAUSE, Transmit pause frame at the Rx side.
+-- 
+2.33.0
+
diff --git a/0125-app-testpmd-show-all-DCB-priority-TC-map.patch b/0125-app-testpmd-show-all-DCB-priority-TC-map.patch
new file mode 100644
index 0000000..a32819f
--- /dev/null
+++ b/0125-app-testpmd-show-all-DCB-priority-TC-map.patch
@@ -0,0 +1,38 @@
+From 4bff87cadadf0912b34e4bcb3436ddd6f2f8a59b Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Thu, 20 Feb 2025 15:06:50 +0800
+Subject: [PATCH 12/24] app/testpmd: show all DCB priority TC map
+
+[ upstream commit 164d7ac277bba10b27dd96821536e6b4a71cfebf ]
+
+Currently, the "show port dcb_tc" command displays only the mapping
+in the number of TCs. This patch fixes it by show all priority's TC
+mapping.
+
+Fixes: cd80f411a7e7 ("app/testpmd: add command to display DCB info")
+Cc: stable@dpdk.org
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ app/test-pmd/config.c | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
+index 2c4dedd..0722cc2 100644
+--- a/app/test-pmd/config.c
++++ b/app/test-pmd/config.c
+@@ -6911,8 +6911,8 @@ port_dcb_info_display(portid_t port_id)
+ 	printf("\n  TC :        ");
+ 	for (i = 0; i < dcb_info.nb_tcs; i++)
+ 		printf("\t%4d", i);
+-	printf("\n  Priority :  ");
+-	for (i = 0; i < dcb_info.nb_tcs; i++)
++	printf("\n  Prio2TC :  ");
++	for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++)
+ 		printf("\t%4d", dcb_info.prio_tc[i]);
+ 	printf("\n  BW percent :");
+ 	for (i = 0; i < dcb_info.nb_tcs; i++)
+-- 
+2.33.0
+
diff --git a/0126-app-testpmd-relax-number-of-TCs-in-DCB-command.patch b/0126-app-testpmd-relax-number-of-TCs-in-DCB-command.patch
new file mode 100644
index 0000000..b8f012d
--- /dev/null
+++ b/0126-app-testpmd-relax-number-of-TCs-in-DCB-command.patch
@@ -0,0 +1,54 @@
+From 2c6b9d89f89d05ccb26f20c55bfd90b6b08b7132 Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Thu, 24 Apr 2025 14:17:46 +0800
+Subject: [PATCH 13/24] app/testpmd: relax number of TCs in DCB command
+
+[ upstream commit 5f2695ee948ddaf36050f2d6b58a3437248c1663 ]
+
+Currently, the "port config 0 dcb ..." command only supports 4 or 8
+TCs. Other number of TCs may be used in actual applications.
+
+This commit removes this restriction.
+
+Fixes: 900550de04a7 ("app/testpmd: add dcb support")
+Cc: stable@dpdk.org
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ app/test-pmd/cmdline.c                      | 4 ++--
+ doc/guides/testpmd_app_ug/testpmd_funcs.rst | 2 +-
+ 2 files changed, 3 insertions(+), 3 deletions(-)
+
+diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
+index 7eba675..8cea88c 100644
+--- a/app/test-pmd/cmdline.c
++++ b/app/test-pmd/cmdline.c
+@@ -3211,9 +3211,9 @@ cmd_config_dcb_parsed(void *parsed_result,
+ 		return;
+ 	}
+ 
+-	if ((res->num_tcs != RTE_ETH_4_TCS) && (res->num_tcs != RTE_ETH_8_TCS)) {
++	if (res->num_tcs <= 1 || res->num_tcs > RTE_ETH_8_TCS) {
+ 		fprintf(stderr,
+-			"The invalid number of traffic class, only 4 or 8 allowed.\n");
++			"The invalid number of traffic class, only 2~8 allowed.\n");
+ 		return;
+ 	}
+ 
+diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+index 227188f..c07b62d 100644
+--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
++++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+@@ -2142,7 +2142,7 @@ Set the DCB mode for an individual port::
+ 
+    testpmd> port config (port_id) dcb vt (on|off) (traffic_class) pfc (on|off)
+ 
+-The traffic class should be 4 or 8.
++The traffic class could be 2~8.
+ 
+ port config - Burst
+ ~~~~~~~~~~~~~~~~~~~
+-- 
+2.33.0
+
diff --git a/0127-app-testpmd-reuse-RSS-config-when-configuring-DCB.patch b/0127-app-testpmd-reuse-RSS-config-when-configuring-DCB.patch
new file mode 100644
index 0000000..353a93b
--- /dev/null
+++ b/0127-app-testpmd-reuse-RSS-config-when-configuring-DCB.patch
@@ -0,0 +1,93 @@
+From 5cc8fdb356b74e3c8b7a8ec83ac33b6c2ff5fc45 Mon Sep 17 00:00:00 2001
+From: Min Zhou <zhoumin@loongson.cn>
+Date: Wed, 20 Nov 2024 17:37:46 +0800
+Subject: [PATCH 14/24] app/testpmd: reuse RSS config when configuring DCB
+
+In the testpmd command, we have to stop the port firstly before configuring
+the DCB. However, some PMDs may execute a hardware reset during the port
+stop, such as ixgbe. Some kind of reset operations of PMD could clear the
+configurations of RSS in the hardware register. This would cause the loss
+of RSS configurations that were set during the testpmd initialization. As
+a result, I find that I cannot enable RSS and DCB at the same time in the
+testpmd command when using Intel 82599 NIC.
+
+The patch uses rss conf from software instead of reading from the hardware
+register when configuring DCB.
+
+Signed-off-by: Min Zhou <zhoumin@loongson.cn>
+Acked-by: Stephen Hemminger <stephen@networkplumber.org>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ app/test-pmd/testpmd.c | 26 ++++++--------------------
+ 1 file changed, 6 insertions(+), 20 deletions(-)
+
+diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
+index 9e4e99e..e93214d 100644
+--- a/app/test-pmd/testpmd.c
++++ b/app/test-pmd/testpmd.c
+@@ -4298,15 +4298,11 @@ const uint16_t vlan_tags[] = {
+ 		24, 25, 26, 27, 28, 29, 30, 31
+ };
+ 
+-static  int
+-get_eth_dcb_conf(portid_t pid, struct rte_eth_conf *eth_conf,
+-		 enum dcb_mode_enable dcb_mode,
+-		 enum rte_eth_nb_tcs num_tcs,
+-		 uint8_t pfc_en)
++static void
++get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
++		 enum rte_eth_nb_tcs num_tcs, uint8_t pfc_en)
+ {
+ 	uint8_t i;
+-	int32_t rc;
+-	struct rte_eth_rss_conf rss_conf;
+ 
+ 	/*
+ 	 * Builds up the correct configuration for dcb+vt based on the vlan tags array
+@@ -4348,12 +4344,6 @@ get_eth_dcb_conf(portid_t pid, struct rte_eth_conf *eth_conf,
+ 		struct rte_eth_dcb_tx_conf *tx_conf =
+ 				&eth_conf->tx_adv_conf.dcb_tx_conf;
+ 
+-		memset(&rss_conf, 0, sizeof(struct rte_eth_rss_conf));
+-
+-		rc = rte_eth_dev_rss_hash_conf_get(pid, &rss_conf);
+-		if (rc != 0)
+-			return rc;
+-
+ 		rx_conf->nb_tcs = num_tcs;
+ 		tx_conf->nb_tcs = num_tcs;
+ 
+@@ -4365,7 +4355,6 @@ get_eth_dcb_conf(portid_t pid, struct rte_eth_conf *eth_conf,
+ 		eth_conf->rxmode.mq_mode =
+ 				(enum rte_eth_rx_mq_mode)
+ 					(rx_mq_mode & RTE_ETH_MQ_RX_DCB_RSS);
+-		eth_conf->rx_adv_conf.rss_conf = rss_conf;
+ 		eth_conf->txmode.mq_mode = RTE_ETH_MQ_TX_DCB;
+ 	}
+ 
+@@ -4374,8 +4363,6 @@ get_eth_dcb_conf(portid_t pid, struct rte_eth_conf *eth_conf,
+ 				RTE_ETH_DCB_PG_SUPPORT | RTE_ETH_DCB_PFC_SUPPORT;
+ 	else
+ 		eth_conf->dcb_capability_en = RTE_ETH_DCB_PG_SUPPORT;
+-
+-	return 0;
+ }
+ 
+ int
+@@ -4398,10 +4385,9 @@ init_port_dcb_config(portid_t pid,
+ 	/* retain the original device configuration. */
+ 	memcpy(&port_conf, &rte_port->dev_conf, sizeof(struct rte_eth_conf));
+ 
+-	/*set configuration of DCB in vt mode and DCB in non-vt mode*/
+-	retval = get_eth_dcb_conf(pid, &port_conf, dcb_mode, num_tcs, pfc_en);
+-	if (retval < 0)
+-		return retval;
++	/* set configuration of DCB in vt mode and DCB in non-vt mode */
++	get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, pfc_en);
++
+ 	port_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
+ 	/* remove RSS HASH offload for DCB in vt mode */
+ 	if (port_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_VMDQ_DCB) {
+-- 
+2.33.0
+
diff --git a/0128-app-testpmd-add-prio-tc-map-in-DCB-command.patch b/0128-app-testpmd-add-prio-tc-map-in-DCB-command.patch
new file mode 100644
index 0000000..ad4ea47
--- /dev/null
+++ b/0128-app-testpmd-add-prio-tc-map-in-DCB-command.patch
@@ -0,0 +1,296 @@
+From ebb9eb84c710366d9a42a95e2e4168eb3b2b027a Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Thu, 24 Apr 2025 14:17:47 +0800
+Subject: [PATCH 15/24] app/testpmd: add prio-tc map in DCB command
+
+[ upstream commit 601576ae6699b31460f35816be54a63c34f54377 ]
+
+Currently, the "port config 0 dcb ..." command config the prio-tc map
+by remainder operation, which means the prio-tc = prio % nb_tcs.
+
+This commit introduces an optional parameter "prio-tc" which is the same
+as kernel dcb ets tool. The new command:
+
+  port config 0 dcb vt off 4 pfc off prio-tc 0:1 1:2 2:3 ...
+
+If this parameter is not specified, the prio-tc map is configured by
+default.
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ app/test-pmd/cmdline.c                      | 119 ++++++++++++++++++--
+ app/test-pmd/testpmd.c                      |  21 ++--
+ app/test-pmd/testpmd.h                      |   4 +-
+ doc/guides/testpmd_app_ug/testpmd_funcs.rst |   3 +-
+ 4 files changed, 125 insertions(+), 22 deletions(-)
+
+diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
+index 8cea88c..3178040 100644
+--- a/app/test-pmd/cmdline.c
++++ b/app/test-pmd/cmdline.c
+@@ -3186,19 +3186,111 @@ struct cmd_config_dcb {
+ 	cmdline_fixed_string_t vt_en;
+ 	uint8_t num_tcs;
+ 	cmdline_fixed_string_t pfc;
+-	cmdline_fixed_string_t pfc_en;
++	cmdline_multi_string_t token_str;
+ };
+ 
++static int
++parse_dcb_token_prio_tc(char *param_str[], int param_num,
++			uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
++			uint8_t *prio_tc_en)
++{
++	unsigned long prio, tc;
++	int prio_tc_maps = 0;
++	char *param, *end;
++	int i;
++
++	for (i = 0; i < param_num; i++) {
++		param = param_str[i];
++		prio = strtoul(param, &end, 10);
++		if (prio >= RTE_ETH_DCB_NUM_USER_PRIORITIES) {
++			fprintf(stderr, "Bad Argument: invalid PRIO %lu\n", prio);
++			return -1;
++		}
++		if ((*end != ':') || (strlen(end + 1) == 0)) {
++			fprintf(stderr, "Bad Argument: invalid PRIO:TC format %s\n", param);
++			return -1;
++		}
++		tc = strtoul(end + 1, &end, 10);
++		if (tc >= RTE_ETH_8_TCS) {
++			fprintf(stderr, "Bad Argument: invalid TC %lu\n", tc);
++			return -1;
++		}
++		if (*end != '\0') {
++			fprintf(stderr, "Bad Argument: invalid PRIO:TC format %s\n", param);
++			return -1;
++		}
++		prio_tc[prio] = tc;
++		prio_tc_maps++;
++	} while (0);
++
++	if (prio_tc_maps == 0) {
++		fprintf(stderr, "Bad Argument: no PRIO:TC provided\n");
++		return -1;
++	}
++	*prio_tc_en = 1;
++
++	return 0;
++}
++
++static int
++parse_dcb_token_value(char *token_str,
++		      uint8_t *pfc_en,
++		      uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
++		      uint8_t *prio_tc_en)
++{
++#define MAX_TOKEN_NUM	128
++	char *split_str[MAX_TOKEN_NUM];
++	int split_num = 0;
++	char *token;
++
++	/* split multiple token to split str. */
++	do {
++		token = strtok_r(token_str, " \f\n\r\t\v", &token_str);
++		if (token == NULL)
++			break;
++		if (split_num >= MAX_TOKEN_NUM) {
++			fprintf(stderr, "Bad Argument: too much argument\n");
++			return -1;
++		}
++		split_str[split_num++] = token;
++	} while (1);
++
++	/* parse fixed parameter "pfc-en" first. */
++	token = split_str[0];
++	if (strcmp(token, "on") == 0)
++		*pfc_en = 1;
++	else if (strcmp(token, "off") == 0)
++		*pfc_en = 0;
++	else {
++		fprintf(stderr, "Bad Argument: pfc-en must be on or off\n");
++		return -EINVAL;
++	}
++
++	if (split_num == 1)
++		return 0;
++
++	/* start parse optional parameter. */
++	token = split_str[1];
++	if (strcmp(token, "prio-tc") != 0) {
++		fprintf(stderr, "Bad Argument: unknown token %s\n", token);
++		return -1;
++	}
++
++	return parse_dcb_token_prio_tc(&split_str[2], split_num - 2, prio_tc, prio_tc_en);
++}
++
+ static void
+ cmd_config_dcb_parsed(void *parsed_result,
+                         __rte_unused struct cmdline *cl,
+                         __rte_unused void *data)
+ {
++	uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES] = {0};
+ 	struct cmd_config_dcb *res = parsed_result;
+ 	struct rte_eth_dcb_info dcb_info;
+ 	portid_t port_id = res->port_id;
++	uint8_t prio_tc_en = 0;
+ 	struct rte_port *port;
+-	uint8_t pfc_en;
++	uint8_t pfc_en = 0;
+ 	int ret;
+ 
+ 	if (port_id_is_invalid(port_id, ENABLED_WARN))
+@@ -3230,20 +3322,19 @@ cmd_config_dcb_parsed(void *parsed_result,
+ 		return;
+ 	}
+ 
+-	if (!strncmp(res->pfc_en, "on", 2))
+-		pfc_en = 1;
+-	else
+-		pfc_en = 0;
++	ret = parse_dcb_token_value(res->token_str, &pfc_en, prio_tc, &prio_tc_en);
++	if (ret != 0)
++		return;
+ 
+ 	/* DCB in VT mode */
+ 	if (!strncmp(res->vt_en, "on", 2))
+ 		ret = init_port_dcb_config(port_id, DCB_VT_ENABLED,
+ 				(enum rte_eth_nb_tcs)res->num_tcs,
+-				pfc_en);
++				pfc_en, prio_tc, prio_tc_en);
+ 	else
+ 		ret = init_port_dcb_config(port_id, DCB_ENABLED,
+ 				(enum rte_eth_nb_tcs)res->num_tcs,
+-				pfc_en);
++				pfc_en, prio_tc, prio_tc_en);
+ 	if (ret != 0) {
+ 		fprintf(stderr, "Cannot initialize network ports.\n");
+ 		return;
+@@ -3270,13 +3361,17 @@ static cmdline_parse_token_num_t cmd_config_dcb_num_tcs =
+ 	TOKEN_NUM_INITIALIZER(struct cmd_config_dcb, num_tcs, RTE_UINT8);
+ static cmdline_parse_token_string_t cmd_config_dcb_pfc =
+         TOKEN_STRING_INITIALIZER(struct cmd_config_dcb, pfc, "pfc");
+-static cmdline_parse_token_string_t cmd_config_dcb_pfc_en =
+-        TOKEN_STRING_INITIALIZER(struct cmd_config_dcb, pfc_en, "on#off");
++static cmdline_parse_token_string_t cmd_config_dcb_token_str =
++	TOKEN_STRING_INITIALIZER(struct cmd_config_dcb, token_str, TOKEN_STRING_MULTI);
+ 
+ static cmdline_parse_inst_t cmd_config_dcb = {
+ 	.f = cmd_config_dcb_parsed,
+ 	.data = NULL,
+-	.help_str = "port config <port-id> dcb vt on|off <num_tcs> pfc on|off",
++	.help_str = "port config <port-id> dcb vt on|off <num_tcs> pfc on|off prio-tc PRIO-MAP\n"
++		    "where PRIO-MAP: [ PRIO-MAP ] PRIO-MAPPING\n"
++		    "	   PRIO-MAPPING := PRIO:TC\n"
++		    "	   PRIO: { 0 .. 7 }\n"
++		    "	   TC: { 0 .. 7 }",
+ 	.tokens = {
+ 		(void *)&cmd_config_dcb_port,
+ 		(void *)&cmd_config_dcb_config,
+@@ -3286,7 +3381,7 @@ static cmdline_parse_inst_t cmd_config_dcb = {
+ 		(void *)&cmd_config_dcb_vt_en,
+ 		(void *)&cmd_config_dcb_num_tcs,
+ 		(void *)&cmd_config_dcb_pfc,
+-		(void *)&cmd_config_dcb_pfc_en,
++		(void *)&cmd_config_dcb_token_str,
+                 NULL,
+         },
+ };
+diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
+index e93214d..fa3cd37 100644
+--- a/app/test-pmd/testpmd.c
++++ b/app/test-pmd/testpmd.c
+@@ -4300,9 +4300,10 @@ const uint16_t vlan_tags[] = {
+ 
+ static void
+ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
+-		 enum rte_eth_nb_tcs num_tcs, uint8_t pfc_en)
++		 enum rte_eth_nb_tcs num_tcs, uint8_t pfc_en,
++		 uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES], uint8_t prio_tc_en)
+ {
+-	uint8_t i;
++	uint8_t dcb_tc_val, i;
+ 
+ 	/*
+ 	 * Builds up the correct configuration for dcb+vt based on the vlan tags array
+@@ -4329,8 +4330,9 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
+ 				1 << (i % vmdq_rx_conf->nb_queue_pools);
+ 		}
+ 		for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {
+-			vmdq_rx_conf->dcb_tc[i] = i % num_tcs;
+-			vmdq_tx_conf->dcb_tc[i] = i % num_tcs;
++			dcb_tc_val = prio_tc_en ? prio_tc[i] : i % num_tcs;
++			vmdq_rx_conf->dcb_tc[i] = dcb_tc_val;
++			vmdq_tx_conf->dcb_tc[i] = dcb_tc_val;
+ 		}
+ 
+ 		/* set DCB mode of RX and TX of multiple queues */
+@@ -4348,8 +4350,9 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
+ 		tx_conf->nb_tcs = num_tcs;
+ 
+ 		for (i = 0; i < RTE_ETH_DCB_NUM_USER_PRIORITIES; i++) {
+-			rx_conf->dcb_tc[i] = i % num_tcs;
+-			tx_conf->dcb_tc[i] = i % num_tcs;
++			dcb_tc_val = prio_tc_en ? prio_tc[i] : i % num_tcs;
++			rx_conf->dcb_tc[i] = dcb_tc_val;
++			tx_conf->dcb_tc[i] = dcb_tc_val;
+ 		}
+ 
+ 		eth_conf->rxmode.mq_mode =
+@@ -4369,7 +4372,9 @@ int
+ init_port_dcb_config(portid_t pid,
+ 		     enum dcb_mode_enable dcb_mode,
+ 		     enum rte_eth_nb_tcs num_tcs,
+-		     uint8_t pfc_en)
++		     uint8_t pfc_en,
++		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
++		     uint8_t prio_tc_en)
+ {
+ 	struct rte_eth_conf port_conf;
+ 	struct rte_port *rte_port;
+@@ -4386,7 +4391,7 @@ init_port_dcb_config(portid_t pid,
+ 	memcpy(&port_conf, &rte_port->dev_conf, sizeof(struct rte_eth_conf));
+ 
+ 	/* set configuration of DCB in vt mode and DCB in non-vt mode */
+-	get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, pfc_en);
++	get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, pfc_en, prio_tc, prio_tc_en);
+ 
+ 	port_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
+ 	/* remove RSS HASH offload for DCB in vt mode */
+diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
+index 9b10a9e..6b8ff28 100644
+--- a/app/test-pmd/testpmd.h
++++ b/app/test-pmd/testpmd.h
+@@ -1120,7 +1120,9 @@ uint8_t port_is_bonding_member(portid_t member_pid);
+ 
+ int init_port_dcb_config(portid_t pid, enum dcb_mode_enable dcb_mode,
+ 		     enum rte_eth_nb_tcs num_tcs,
+-		     uint8_t pfc_en);
++		     uint8_t pfc_en,
++		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
++		     uint8_t prio_tc_en);
+ int start_port(portid_t pid);
+ void stop_port(portid_t pid);
+ void close_port(portid_t pid);
+diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+index c07b62d..c60fd15 100644
+--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
++++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+@@ -2140,9 +2140,10 @@ port config - DCB
+ 
+ Set the DCB mode for an individual port::
+ 
+-   testpmd> port config (port_id) dcb vt (on|off) (traffic_class) pfc (on|off)
++   testpmd> port config (port_id) dcb vt (on|off) (traffic_class) pfc (on|off) prio-tc (prio-tc)
+ 
+ The traffic class could be 2~8.
++The prio-tc field here is optional, if not specified then the prio-tc use default configuration.
+ 
+ port config - Burst
+ ~~~~~~~~~~~~~~~~~~~
+-- 
+2.33.0
+
diff --git a/0129-app-testpmd-add-queue-restriction-in-DCB-command.patch b/0129-app-testpmd-add-queue-restriction-in-DCB-command.patch
new file mode 100644
index 0000000..1aab2e7
--- /dev/null
+++ b/0129-app-testpmd-add-queue-restriction-in-DCB-command.patch
@@ -0,0 +1,264 @@
+From fb99db310dca2b93a1f50fcaa8c46226e84ae411 Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Thu, 24 Apr 2025 14:17:48 +0800
+Subject: [PATCH 16/24] app/testpmd: add queue restriction in DCB command
+
+[ upstream commit 2169699b15fc4cf317108f86d5039a7e8055d024 ]
+
+In some test scenarios, users want to test DCB by specifying the number
+of Rx/Tx queues. But the "port config 0 dcb ..." command will auto
+adjust Rx/Tx queue number.
+
+This patch introduces an optional parameter "keep-qnum" which make sure
+the "port config 0 dcb ..." command don't adjust Rx/Tx queue number.
+The new command:
+
+  port config 0 dcb vt off 4 pfc off keep-qnum
+
+If this parameter is not specified, the Rx/Tx queue number was adjusted
+by default.
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ app/test-pmd/cmdline.c                      | 83 ++++++++++++++++++---
+ app/test-pmd/testpmd.c                      | 42 ++++++-----
+ app/test-pmd/testpmd.h                      |  3 +-
+ doc/guides/testpmd_app_ug/testpmd_funcs.rst |  3 +-
+ 4 files changed, 98 insertions(+), 33 deletions(-)
+
+diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
+index 3178040..f42b806 100644
+--- a/app/test-pmd/cmdline.c
++++ b/app/test-pmd/cmdline.c
+@@ -3232,14 +3232,47 @@ parse_dcb_token_prio_tc(char *param_str[], int param_num,
+ 	return 0;
+ }
+ 
++#define DCB_TOKEN_PRIO_TC	"prio-tc"
++#define DCB_TOKEN_KEEP_QNUM	"keep-qnum"
++
++static int
++parse_dcb_token_find(char *split_str[], int split_num, int *param_num)
++{
++	int i;
++
++	if (strcmp(split_str[0], DCB_TOKEN_KEEP_QNUM) == 0) {
++		*param_num = 0;
++		return 0;
++	}
++
++	if (strcmp(split_str[0], DCB_TOKEN_PRIO_TC) != 0) {
++		fprintf(stderr, "Bad Argument: unknown token %s\n", split_str[0]);
++		return -EINVAL;
++	}
++
++	for (i = 1; i < split_num; i++) {
++		if ((strcmp(split_str[i], DCB_TOKEN_PRIO_TC) != 0) &&
++		    (strcmp(split_str[i], DCB_TOKEN_KEEP_QNUM) != 0))
++			continue;
++		/* find another optional parameter, then exit. */
++		break;
++	}
++
++	*param_num = i - 1;
++
++	return 0;
++}
++
+ static int
+ parse_dcb_token_value(char *token_str,
+ 		      uint8_t *pfc_en,
+ 		      uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
+-		      uint8_t *prio_tc_en)
++		      uint8_t *prio_tc_en,
++		      uint8_t *keep_qnum)
+ {
+ #define MAX_TOKEN_NUM	128
+ 	char *split_str[MAX_TOKEN_NUM];
++	int param_num, start, ret;
+ 	int split_num = 0;
+ 	char *token;
+ 
+@@ -3270,13 +3303,40 @@ parse_dcb_token_value(char *token_str,
+ 		return 0;
+ 
+ 	/* start parse optional parameter. */
+-	token = split_str[1];
+-	if (strcmp(token, "prio-tc") != 0) {
+-		fprintf(stderr, "Bad Argument: unknown token %s\n", token);
+-		return -1;
+-	}
++	start = 1;
++	do {
++		param_num = 0;
++		ret = parse_dcb_token_find(&split_str[start], split_num - start, &param_num);
++		if (ret != 0)
++			return ret;
+ 
+-	return parse_dcb_token_prio_tc(&split_str[2], split_num - 2, prio_tc, prio_tc_en);
++		token = split_str[start];
++		if (strcmp(token, DCB_TOKEN_PRIO_TC) == 0) {
++			if (*prio_tc_en == 1) {
++				fprintf(stderr, "Bad Argument: detect multiple %s token\n",
++					DCB_TOKEN_PRIO_TC);
++				return -1;
++			}
++			ret = parse_dcb_token_prio_tc(&split_str[start + 1], param_num, prio_tc,
++						      prio_tc_en);
++			if (ret != 0)
++				return ret;
++		} else {
++			/* this must be keep-qnum. */
++			if (*keep_qnum == 1) {
++				fprintf(stderr, "Bad Argument: detect multiple %s token\n",
++					DCB_TOKEN_KEEP_QNUM);
++				return -1;
++			}
++			*keep_qnum = 1;
++		}
++
++		start += param_num + 1;
++		if (start >= split_num)
++			break;
++	} while (1);
++
++	return 0;
+ }
+ 
+ static void
+@@ -3289,6 +3349,7 @@ cmd_config_dcb_parsed(void *parsed_result,
+ 	struct rte_eth_dcb_info dcb_info;
+ 	portid_t port_id = res->port_id;
+ 	uint8_t prio_tc_en = 0;
++	uint8_t keep_qnum = 0;
+ 	struct rte_port *port;
+ 	uint8_t pfc_en = 0;
+ 	int ret;
+@@ -3322,7 +3383,7 @@ cmd_config_dcb_parsed(void *parsed_result,
+ 		return;
+ 	}
+ 
+-	ret = parse_dcb_token_value(res->token_str, &pfc_en, prio_tc, &prio_tc_en);
++	ret = parse_dcb_token_value(res->token_str, &pfc_en, prio_tc, &prio_tc_en, &keep_qnum);
+ 	if (ret != 0)
+ 		return;
+ 
+@@ -3330,11 +3391,11 @@ cmd_config_dcb_parsed(void *parsed_result,
+ 	if (!strncmp(res->vt_en, "on", 2))
+ 		ret = init_port_dcb_config(port_id, DCB_VT_ENABLED,
+ 				(enum rte_eth_nb_tcs)res->num_tcs,
+-				pfc_en, prio_tc, prio_tc_en);
++				pfc_en, prio_tc, prio_tc_en, keep_qnum);
+ 	else
+ 		ret = init_port_dcb_config(port_id, DCB_ENABLED,
+ 				(enum rte_eth_nb_tcs)res->num_tcs,
+-				pfc_en, prio_tc, prio_tc_en);
++				pfc_en, prio_tc, prio_tc_en, keep_qnum);
+ 	if (ret != 0) {
+ 		fprintf(stderr, "Cannot initialize network ports.\n");
+ 		return;
+@@ -3367,7 +3428,7 @@ static cmdline_parse_token_string_t cmd_config_dcb_token_str =
+ static cmdline_parse_inst_t cmd_config_dcb = {
+ 	.f = cmd_config_dcb_parsed,
+ 	.data = NULL,
+-	.help_str = "port config <port-id> dcb vt on|off <num_tcs> pfc on|off prio-tc PRIO-MAP\n"
++	.help_str = "port config <port-id> dcb vt on|off <num_tcs> pfc on|off prio-tc PRIO-MAP keep-qnum\n"
+ 		    "where PRIO-MAP: [ PRIO-MAP ] PRIO-MAPPING\n"
+ 		    "	   PRIO-MAPPING := PRIO:TC\n"
+ 		    "	   PRIO: { 0 .. 7 }\n"
+diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
+index fa3cd37..0f8d8a1 100644
+--- a/app/test-pmd/testpmd.c
++++ b/app/test-pmd/testpmd.c
+@@ -4374,7 +4374,8 @@ init_port_dcb_config(portid_t pid,
+ 		     enum rte_eth_nb_tcs num_tcs,
+ 		     uint8_t pfc_en,
+ 		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
+-		     uint8_t prio_tc_en)
++		     uint8_t prio_tc_en,
++		     uint8_t keep_qnum)
+ {
+ 	struct rte_eth_conf port_conf;
+ 	struct rte_port *rte_port;
+@@ -4422,26 +4423,27 @@ init_port_dcb_config(portid_t pid,
+ 		return -1;
+ 	}
+ 
+-	/* Assume the ports in testpmd have the same dcb capability
+-	 * and has the same number of rxq and txq in dcb mode
+-	 */
+-	if (dcb_mode == DCB_VT_ENABLED) {
+-		if (rte_port->dev_info.max_vfs > 0) {
+-			nb_rxq = rte_port->dev_info.nb_rx_queues;
+-			nb_txq = rte_port->dev_info.nb_tx_queues;
+-		} else {
+-			nb_rxq = rte_port->dev_info.max_rx_queues;
+-			nb_txq = rte_port->dev_info.max_tx_queues;
+-		}
+-	} else {
+-		/*if vt is disabled, use all pf queues */
+-		if (rte_port->dev_info.vmdq_pool_base == 0) {
+-			nb_rxq = rte_port->dev_info.max_rx_queues;
+-			nb_txq = rte_port->dev_info.max_tx_queues;
++	if (keep_qnum == 0) {
++		/* Assume the ports in testpmd have the same dcb capability
++		 * and has the same number of rxq and txq in dcb mode
++		 */
++		if (dcb_mode == DCB_VT_ENABLED) {
++			if (rte_port->dev_info.max_vfs > 0) {
++				nb_rxq = rte_port->dev_info.nb_rx_queues;
++				nb_txq = rte_port->dev_info.nb_tx_queues;
++			} else {
++				nb_rxq = rte_port->dev_info.max_rx_queues;
++				nb_txq = rte_port->dev_info.max_tx_queues;
++			}
+ 		} else {
+-			nb_rxq = (queueid_t)num_tcs;
+-			nb_txq = (queueid_t)num_tcs;
+-
++			/*if vt is disabled, use all pf queues */
++			if (rte_port->dev_info.vmdq_pool_base == 0) {
++				nb_rxq = rte_port->dev_info.max_rx_queues;
++				nb_txq = rte_port->dev_info.max_tx_queues;
++			} else {
++				nb_rxq = (queueid_t)num_tcs;
++				nb_txq = (queueid_t)num_tcs;
++			}
+ 		}
+ 	}
+ 	rx_free_thresh = 64;
+diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
+index 6b8ff28..4e12073 100644
+--- a/app/test-pmd/testpmd.h
++++ b/app/test-pmd/testpmd.h
+@@ -1122,7 +1122,8 @@ int init_port_dcb_config(portid_t pid, enum dcb_mode_enable dcb_mode,
+ 		     enum rte_eth_nb_tcs num_tcs,
+ 		     uint8_t pfc_en,
+ 		     uint8_t prio_tc[RTE_ETH_DCB_NUM_USER_PRIORITIES],
+-		     uint8_t prio_tc_en);
++		     uint8_t prio_tc_en,
++		     uint8_t keep_qnum);
+ int start_port(portid_t pid);
+ void stop_port(portid_t pid);
+ void close_port(portid_t pid);
+diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+index c60fd15..f265e45 100644
+--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
++++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+@@ -2140,10 +2140,11 @@ port config - DCB
+ 
+ Set the DCB mode for an individual port::
+ 
+-   testpmd> port config (port_id) dcb vt (on|off) (traffic_class) pfc (on|off) prio-tc (prio-tc)
++   testpmd> port config (port_id) dcb vt (on|off) (traffic_class) pfc (on|off) prio-tc (prio-tc) keep-qnum
+ 
+ The traffic class could be 2~8.
+ The prio-tc field here is optional, if not specified then the prio-tc use default configuration.
++The keep-qnum field here is also optional, if specified then don't adjust Rx/Tx queue number.
+ 
+ port config - Burst
+ ~~~~~~~~~~~~~~~~~~~
+-- 
+2.33.0
+
diff --git a/0130-app-testpmd-add-command-to-disable-DCB.patch b/0130-app-testpmd-add-command-to-disable-DCB.patch
new file mode 100644
index 0000000..b428a9d
--- /dev/null
+++ b/0130-app-testpmd-add-command-to-disable-DCB.patch
@@ -0,0 +1,158 @@
+From e8dc9121f8f870512219dada8b6859aa528a371b Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Thu, 24 Apr 2025 14:17:49 +0800
+Subject: [PATCH 17/24] app/testpmd: add command to disable DCB
+
+[ upstream commit 0ecbf93f50018e552ea3aa401129ef6075c1b36b ]
+
+After the "port config 0 dcb ..." command is invoked, no command is
+available to disable DCB.
+
+This commit introduces disable DCB when num_tcs is 1, so user could
+disable the DCB by command:
+  port config 0 dcb vt off 1 pfc off
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ app/test-pmd/cmdline.c                      |  4 +-
+ app/test-pmd/testpmd.c                      | 58 ++++++++++++++-------
+ doc/guides/testpmd_app_ug/testpmd_funcs.rst |  2 +-
+ 3 files changed, 43 insertions(+), 21 deletions(-)
+
+diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
+index f42b806..332d7b3 100644
+--- a/app/test-pmd/cmdline.c
++++ b/app/test-pmd/cmdline.c
+@@ -3364,9 +3364,9 @@ cmd_config_dcb_parsed(void *parsed_result,
+ 		return;
+ 	}
+ 
+-	if (res->num_tcs <= 1 || res->num_tcs > RTE_ETH_8_TCS) {
++	if (res->num_tcs < 1 || res->num_tcs > RTE_ETH_8_TCS) {
+ 		fprintf(stderr,
+-			"The invalid number of traffic class, only 2~8 allowed.\n");
++			"The invalid number of traffic class, only 1~8 allowed.\n");
+ 		return;
+ 	}
+ 
+diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
+index 0f8d8a1..5557314 100644
+--- a/app/test-pmd/testpmd.c
++++ b/app/test-pmd/testpmd.c
+@@ -4368,6 +4368,22 @@ get_eth_dcb_conf(struct rte_eth_conf *eth_conf, enum dcb_mode_enable dcb_mode,
+ 		eth_conf->dcb_capability_en = RTE_ETH_DCB_PG_SUPPORT;
+ }
+ 
++static void
++clear_eth_dcb_conf(portid_t pid, struct rte_eth_conf *eth_conf)
++{
++	uint32_t i;
++
++	eth_conf->rxmode.mq_mode &= ~(RTE_ETH_MQ_RX_DCB | RTE_ETH_MQ_RX_VMDQ_DCB);
++	eth_conf->txmode.mq_mode = RTE_ETH_MQ_TX_NONE;
++	eth_conf->dcb_capability_en = 0;
++	if (dcb_config) {
++		/* Unset VLAN filter configuration if already config DCB. */
++		eth_conf->rxmode.offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
++		for (i = 0; i < RTE_DIM(vlan_tags); i++)
++			rx_vft_set(pid, vlan_tags[i], 0);
++	}
++}
++
+ int
+ init_port_dcb_config(portid_t pid,
+ 		     enum dcb_mode_enable dcb_mode,
+@@ -4391,16 +4407,19 @@ init_port_dcb_config(portid_t pid,
+ 	/* retain the original device configuration. */
+ 	memcpy(&port_conf, &rte_port->dev_conf, sizeof(struct rte_eth_conf));
+ 
+-	/* set configuration of DCB in vt mode and DCB in non-vt mode */
+-	get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, pfc_en, prio_tc, prio_tc_en);
+-
+-	port_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
+-	/* remove RSS HASH offload for DCB in vt mode */
+-	if (port_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_VMDQ_DCB) {
+-		port_conf.rxmode.offloads &= ~RTE_ETH_RX_OFFLOAD_RSS_HASH;
+-		for (i = 0; i < nb_rxq; i++)
+-			rte_port->rxq[i].conf.offloads &=
+-				~RTE_ETH_RX_OFFLOAD_RSS_HASH;
++	if (num_tcs > 1) {
++		/* set configuration of DCB in vt mode and DCB in non-vt mode */
++		get_eth_dcb_conf(&port_conf, dcb_mode, num_tcs, pfc_en, prio_tc, prio_tc_en);
++		port_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
++		/* remove RSS HASH offload for DCB in vt mode */
++		if (port_conf.rxmode.mq_mode == RTE_ETH_MQ_RX_VMDQ_DCB) {
++			port_conf.rxmode.offloads &= ~RTE_ETH_RX_OFFLOAD_RSS_HASH;
++			for (i = 0; i < nb_rxq; i++)
++				rte_port->rxq[i].conf.offloads &=
++					~RTE_ETH_RX_OFFLOAD_RSS_HASH;
++		}
++	} else {
++		clear_eth_dcb_conf(pid, &port_conf);
+ 	}
+ 
+ 	/* re-configure the device . */
+@@ -4415,7 +4434,8 @@ init_port_dcb_config(portid_t pid,
+ 	/* If dev_info.vmdq_pool_base is greater than 0,
+ 	 * the queue id of vmdq pools is started after pf queues.
+ 	 */
+-	if (dcb_mode == DCB_VT_ENABLED &&
++	if (num_tcs > 1 &&
++	    dcb_mode == DCB_VT_ENABLED &&
+ 	    rte_port->dev_info.vmdq_pool_base > 0) {
+ 		fprintf(stderr,
+ 			"VMDQ_DCB multi-queue mode is nonsensical for port %d.\n",
+@@ -4423,7 +4443,7 @@ init_port_dcb_config(portid_t pid,
+ 		return -1;
+ 	}
+ 
+-	if (keep_qnum == 0) {
++	if (num_tcs > 1 && keep_qnum == 0) {
+ 		/* Assume the ports in testpmd have the same dcb capability
+ 		 * and has the same number of rxq and txq in dcb mode
+ 		 */
+@@ -4451,19 +4471,21 @@ init_port_dcb_config(portid_t pid,
+ 	memcpy(&rte_port->dev_conf, &port_conf, sizeof(struct rte_eth_conf));
+ 
+ 	rxtx_port_config(pid);
+-	/* VLAN filter */
+-	rte_port->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
+-	for (i = 0; i < RTE_DIM(vlan_tags); i++)
+-		rx_vft_set(pid, vlan_tags[i], 1);
++	if (num_tcs > 1) {
++		/* VLAN filter */
++		rte_port->dev_conf.rxmode.offloads |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
++		for (i = 0; i < RTE_DIM(vlan_tags); i++)
++			rx_vft_set(pid, vlan_tags[i], 1);
++	}
+ 
+ 	retval = eth_macaddr_get_print_err(pid, &rte_port->eth_addr);
+ 	if (retval != 0)
+ 		return retval;
+ 
+-	rte_port->dcb_flag = 1;
++	rte_port->dcb_flag = num_tcs > 1 ? 1 : 0;
+ 
+ 	/* Enter DCB configuration status */
+-	dcb_config = 1;
++	dcb_config = num_tcs > 1 ? 1 : 0;
+ 
+ 	return 0;
+ }
+diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+index f265e45..e816c81 100644
+--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
++++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+@@ -2142,7 +2142,7 @@ Set the DCB mode for an individual port::
+ 
+    testpmd> port config (port_id) dcb vt (on|off) (traffic_class) pfc (on|off) prio-tc (prio-tc) keep-qnum
+ 
+-The traffic class could be 2~8.
++The traffic class could be 1~8, if the value is 1, DCB is disabled.
+ The prio-tc field here is optional, if not specified then the prio-tc use default configuration.
+ The keep-qnum field here is also optional, if specified then don't adjust Rx/Tx queue number.
+ 
+-- 
+2.33.0
+
diff --git a/0131-examples-l3fwd-force-link-speed.patch b/0131-examples-l3fwd-force-link-speed.patch
new file mode 100644
index 0000000..c4a660b
--- /dev/null
+++ b/0131-examples-l3fwd-force-link-speed.patch
@@ -0,0 +1,87 @@
+From f45d2fe457138ef75dc43aa8171d9473313b7ca7 Mon Sep 17 00:00:00 2001
+From: Dengdui Huang <huangdengdui@huawei.com>
+Date: Wed, 27 Aug 2025 09:31:05 +0800
+Subject: [PATCH 18/24] examples/l3fwd: force link speed
+
+[ upstream commit 2001c8eaf4efb94173410644cf29cbaa62a0ac83 ]
+
+Currently, l3fwd starts in auto-negotiation mode, but it may fail to
+link up when auto-negotiation is not supported. Therefore, it is
+necessary to support starting with a specified speed for port.
+
+Additionally, this patch does not support changing the duplex mode.
+So speeds like 10M, 100M are not configurable using this method.
+
+Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
+Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ examples/l3fwd/main.c | 17 ++++++++++++++++-
+ 1 file changed, 16 insertions(+), 1 deletion(-)
+
+diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
+index be5b5d8..066e7c8 100644
+--- a/examples/l3fwd/main.c
++++ b/examples/l3fwd/main.c
+@@ -422,6 +422,7 @@ print_usage(const char *prgname)
+ 		"            Accepted: em (Exact Match), lpm (Longest Prefix Match), fib (Forwarding Information Base),\n"
+ 		"                      acl (Access Control List)\n"
+ 		"  --config (port,queue,lcore): Rx queue configuration\n"
++		"  --eth-link-speed: force link speed\n"
+ 		"  --rx-queue-size NPKTS: Rx queue size in decimal\n"
+ 		"            Default: %d\n"
+ 		"  --tx-queue-size NPKTS: Tx queue size in decimal\n"
+@@ -732,6 +733,7 @@ static const char short_options[] =
+ 	;
+ 
+ #define CMD_LINE_OPT_CONFIG "config"
++#define CMD_LINK_OPT_ETH_LINK_SPEED "eth-link-speed"
+ #define CMD_LINE_OPT_RX_QUEUE_SIZE "rx-queue-size"
+ #define CMD_LINE_OPT_TX_QUEUE_SIZE "tx-queue-size"
+ #define CMD_LINE_OPT_ETH_DEST "eth-dest"
+@@ -763,6 +765,7 @@ enum {
+ 	 * conflict with short options */
+ 	CMD_LINE_OPT_MIN_NUM = 256,
+ 	CMD_LINE_OPT_CONFIG_NUM,
++	CMD_LINK_OPT_ETH_LINK_SPEED_NUM,
+ 	CMD_LINE_OPT_RX_QUEUE_SIZE_NUM,
+ 	CMD_LINE_OPT_TX_QUEUE_SIZE_NUM,
+ 	CMD_LINE_OPT_ETH_DEST_NUM,
+@@ -790,6 +793,7 @@ enum {
+ 
+ static const struct option lgopts[] = {
+ 	{CMD_LINE_OPT_CONFIG, 1, 0, CMD_LINE_OPT_CONFIG_NUM},
++	{CMD_LINK_OPT_ETH_LINK_SPEED, 1, 0, CMD_LINK_OPT_ETH_LINK_SPEED_NUM},
+ 	{CMD_LINE_OPT_RX_QUEUE_SIZE, 1, 0, CMD_LINE_OPT_RX_QUEUE_SIZE_NUM},
+ 	{CMD_LINE_OPT_TX_QUEUE_SIZE, 1, 0, CMD_LINE_OPT_TX_QUEUE_SIZE_NUM},
+ 	{CMD_LINE_OPT_ETH_DEST, 1, 0, CMD_LINE_OPT_ETH_DEST_NUM},
+@@ -845,6 +849,7 @@ parse_args(int argc, char **argv)
+ 	uint8_t eth_rx_q = 0;
+ 	struct l3fwd_event_resources *evt_rsrc = l3fwd_get_eventdev_rsrc();
+ #endif
++	int speed_num;
+ 
+ 	argvopt = argv;
+ 
+@@ -893,7 +898,17 @@ parse_args(int argc, char **argv)
+ 			}
+ 			lcore_params = 1;
+ 			break;
+-
++		case CMD_LINK_OPT_ETH_LINK_SPEED_NUM:
++			speed_num = atoi(optarg);
++			if ((speed_num == RTE_ETH_SPEED_NUM_10M) ||
++			    (speed_num == RTE_ETH_SPEED_NUM_100M)) {
++				fprintf(stderr, "Unsupported fixed speed\n");
++				print_usage(prgname);
++				return -1;
++			}
++			if (speed_num >= 0 && rte_eth_speed_bitflag(speed_num, 0) > 0)
++				port_conf.link_speeds = rte_eth_speed_bitflag(speed_num, 0);
++			break;
+ 		case CMD_LINE_OPT_RX_QUEUE_SIZE_NUM:
+ 			parse_queue_size(optarg, &nb_rxd, 1);
+ 			break;
+-- 
+2.33.0
+
diff --git a/0132-examples-l3fwd-power-force-link-speed.patch b/0132-examples-l3fwd-power-force-link-speed.patch
new file mode 100644
index 0000000..57f1f09
--- /dev/null
+++ b/0132-examples-l3fwd-power-force-link-speed.patch
@@ -0,0 +1,80 @@
+From 2239ed372f161db4f729c983511b2f7ab4ca0a6c Mon Sep 17 00:00:00 2001
+From: Dengdui Huang <huangdengdui@huawei.com>
+Date: Wed, 27 Aug 2025 09:31:06 +0800
+Subject: [PATCH 19/24] examples/l3fwd-power: force link speed
+
+[ upstream commit 2001c8eaf4efb94173410644cf29cbaa62a0ac83 ]
+
+Currently, l3fwd-power starts in auto-negotiation mode, but it may fail
+to link up when auto-negotiation is not supported. Therefore, it is
+necessary to support starting with a specified speed for port.
+
+Additionally, this patch does not support changing the duplex mode.
+ So speeds like 10M, 100M are not configurable using this method.
+
+Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
+Reviewed-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ examples/l3fwd-power/main.c | 18 ++++++++++++++++++
+ 1 file changed, 18 insertions(+)
+
+diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
+index 9c0dcd3..cb5e90c 100644
+--- a/examples/l3fwd-power/main.c
++++ b/examples/l3fwd-power/main.c
+@@ -1503,6 +1503,7 @@ print_usage(const char *prgname)
+ 		"  -U: set min/max frequency for uncore to maximum value\n"
+ 		"  -i (frequency index): set min/max frequency for uncore to specified frequency index\n"
+ 		"  --config (port,queue,lcore): rx queues configuration\n"
++		"  --eth-link-speed: force link speed\n"
+ 		"  --high-perf-cores CORELIST: list of high performance cores\n"
+ 		"  --perf-config: similar as config, cores specified as indices"
+ 		" for bins containing high or regular performance cores\n"
+@@ -1741,12 +1742,14 @@ parse_pmd_mgmt_config(const char *name)
+ #define CMD_LINE_OPT_PAUSE_DURATION "pause-duration"
+ #define CMD_LINE_OPT_SCALE_FREQ_MIN "scale-freq-min"
+ #define CMD_LINE_OPT_SCALE_FREQ_MAX "scale-freq-max"
++#define CMD_LINK_OPT_ETH_LINK_SPEED "eth-link-speed"
+ 
+ /* Parse the argument given in the command line of the application */
+ static int
+ parse_args(int argc, char **argv)
+ {
+ 	int opt, ret;
++	int speed_num;
+ 	char **argvopt;
+ 	int option_index;
+ 	char *prgname = argv[0];
+@@ -1765,6 +1768,7 @@ parse_args(int argc, char **argv)
+ 		{CMD_LINE_OPT_PAUSE_DURATION, 1, 0, 0},
+ 		{CMD_LINE_OPT_SCALE_FREQ_MIN, 1, 0, 0},
+ 		{CMD_LINE_OPT_SCALE_FREQ_MAX, 1, 0, 0},
++		{CMD_LINK_OPT_ETH_LINK_SPEED, 1, 0, 0},
+ 		{NULL, 0, 0, 0}
+ 	};
+ 
+@@ -1935,6 +1939,20 @@ parse_args(int argc, char **argv)
+ 				scale_freq_max = parse_int(optarg);
+ 			}
+ 
++			if (!strncmp(lgopts[option_index].name,
++					CMD_LINK_OPT_ETH_LINK_SPEED,
++					sizeof(CMD_LINK_OPT_ETH_LINK_SPEED))) {
++				speed_num = atoi(optarg);
++				if ((speed_num == RTE_ETH_SPEED_NUM_10M) ||
++				(speed_num == RTE_ETH_SPEED_NUM_100M)) {
++					fprintf(stderr, "Unsupported fixed speed\n");
++					print_usage(prgname);
++					return -1;
++				}
++				if (speed_num >= 0 && rte_eth_speed_bitflag(speed_num, 0) > 0)
++					port_conf.link_speeds = rte_eth_speed_bitflag(speed_num, 0);
++			}
++
+ 			break;
+ 
+ 		default:
+-- 
+2.33.0
+
diff --git a/0133-config-arm-add-HiSilicon-HIP12.patch b/0133-config-arm-add-HiSilicon-HIP12.patch
new file mode 100644
index 0000000..f43d124
--- /dev/null
+++ b/0133-config-arm-add-HiSilicon-HIP12.patch
@@ -0,0 +1,96 @@
+From 512d1f89e458fe638b489164965940aef7eb67cb Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Wed, 29 Oct 2025 09:16:26 +0800
+Subject: [PATCH 20/24] config/arm: add HiSilicon HIP12
+
+[ upstream commit a054de204b0b937dd976d0390fbb03353745e7cb ]
+
+Adding support for HiSilicon HIP12 platform.
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Acked-by: Huisong Li <lihuisong@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ config/arm/arm64_hip12_linux_gcc | 17 +++++++++++++++++
+ config/arm/meson.build           | 20 ++++++++++++++++++++
+ 2 files changed, 37 insertions(+)
+ create mode 100644 config/arm/arm64_hip12_linux_gcc
+
+diff --git a/config/arm/arm64_hip12_linux_gcc b/config/arm/arm64_hip12_linux_gcc
+new file mode 100644
+index 0000000..949093d
+--- /dev/null
++++ b/config/arm/arm64_hip12_linux_gcc
+@@ -0,0 +1,17 @@
++[binaries]
++c = ['ccache', 'aarch64-linux-gnu-gcc']
++cpp = ['ccache', 'aarch64-linux-gnu-g++']
++ar = 'aarch64-linux-gnu-gcc-ar'
++strip = 'aarch64-linux-gnu-strip'
++pkgconfig = 'aarch64-linux-gnu-pkg-config'
++pkg-config = 'aarch64-linux-gnu-pkg-config'
++pcap-config = ''
++
++[host_machine]
++system = 'linux'
++cpu_family = 'aarch64'
++cpu = 'armv8.5-a'
++endian = 'little'
++
++[properties]
++platform = 'hip12'
+diff --git a/config/arm/meson.build b/config/arm/meson.build
+index 7c8fcb8..195f1bb 100644
+--- a/config/arm/meson.build
++++ b/config/arm/meson.build
+@@ -233,6 +233,17 @@ implementer_hisilicon = {
+                 ['RTE_MAX_LCORE', 1280],
+                 ['RTE_MAX_NUMA_NODES', 16]
+             ]
++        },
++        '0xd06': {
++            'mcpu': 'mcpu_hip12',
++            'march': 'armv8.5-a',
++            'march_extensions': ['crypto', 'sve']
++            'flags': [
++                ['RTE_MACHINE', '"hip12"'],
++                ['RTE_ARM_FEATURE_ATOMICS', true],
++                ['RTE_MAX_LCORE', 1280],
++                ['RTE_MAX_NUMA_NODES', 16]
++            ]
+         }
+     }
+ }
+@@ -436,6 +447,13 @@ soc_hip10 = {
+     'numa': true
+ }
+ 
++soc_hip12 = {
++    'description': 'HiSilicon HIP12',
++    'implementer': '0x48',
++    'part_number': '0xd06',
++    'numa': true
++}
++
+ soc_kunpeng920 = {
+     'description': 'HiSilicon Kunpeng 920',
+     'implementer': '0x48',
+@@ -537,6 +555,7 @@ tys2500:         Phytium TengYun S2500
+ graviton2:       AWS Graviton2
+ graviton3:       AWS Graviton3
+ hip10:           HiSilicon HIP10
++hip12:           HiSilicon HIP12
+ kunpeng920:      HiSilicon Kunpeng 920
+ kunpeng930:      HiSilicon Kunpeng 930
+ n1sdp:           Arm Neoverse N1SDP
+@@ -568,6 +587,7 @@ socs = {
+     'graviton2': soc_graviton2,
+     'graviton3': soc_graviton3,
+     'hip10': soc_hip10,
++    'hip12': soc_hip12,
+     'kunpeng920': soc_kunpeng920,
+     'kunpeng930': soc_kunpeng930,
+     'n1sdp': soc_n1sdp,
+-- 
+2.33.0
+
diff --git a/0134-app-testpmd-fix-DCB-Tx-port.patch b/0134-app-testpmd-fix-DCB-Tx-port.patch
new file mode 100644
index 0000000..f17b135
--- /dev/null
+++ b/0134-app-testpmd-fix-DCB-Tx-port.patch
@@ -0,0 +1,51 @@
+From 64f53c7016c0480acd0103a533328f070acc47ef Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Thu, 6 Nov 2025 08:29:19 +0800
+Subject: [PATCH 21/24] app/testpmd: fix DCB Tx port
+
+[ upstream commit 47012b7cbf78531e99b6ab3faa3a69e941ddbaa0 ]
+
+The txp maybe invalid (e.g. start with only one port but set with 1),
+this commit fix it by get txp from fwd_topology_tx_port_get() function.
+
+An added benefit is that the DCB test also supports '--port-topology'
+parameter.
+
+Fixes: 1a572499beb6 ("app/testpmd: setup DCB forwarding based on traffic class")
+Cc: stable@dpdk.org
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ app/test-pmd/config.c | 7 ++-----
+ 1 file changed, 2 insertions(+), 5 deletions(-)
+
+diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
+index 0722cc2..d71b398 100644
+--- a/app/test-pmd/config.c
++++ b/app/test-pmd/config.c
+@@ -4919,7 +4919,7 @@ dcb_fwd_config_setup(void)
+ 	/* reinitialize forwarding streams */
+ 	init_fwd_streams();
+ 	sm_id = 0;
+-	txp = 1;
++	txp = fwd_topology_tx_port_get(rxp);
+ 	/* get the dcb info on the first RX and TX ports */
+ 	(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[rxp], &rxp_dcb_info);
+ 	(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
+@@ -4967,11 +4967,8 @@ dcb_fwd_config_setup(void)
+ 			rxp++;
+ 		if (rxp >= nb_fwd_ports)
+ 			return;
++		txp = fwd_topology_tx_port_get(rxp);
+ 		/* get the dcb information on next RX and TX ports */
+-		if ((rxp & 0x1) == 0)
+-			txp = (portid_t) (rxp + 1);
+-		else
+-			txp = (portid_t) (rxp - 1);
+ 		rte_eth_dev_get_dcb_info(fwd_ports_ids[rxp], &rxp_dcb_info);
+ 		rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
+ 	}
+-- 
+2.33.0
+
diff --git a/0135-app-testpmd-fix-DCB-Rx-queues.patch b/0135-app-testpmd-fix-DCB-Rx-queues.patch
new file mode 100644
index 0000000..a052b89
--- /dev/null
+++ b/0135-app-testpmd-fix-DCB-Rx-queues.patch
@@ -0,0 +1,35 @@
+From 27c05f7ee5c1e0567e602862961db082542b9b44 Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Thu, 6 Nov 2025 08:29:20 +0800
+Subject: [PATCH 22/24] app/testpmd: fix DCB Rx queues
+
+[ upstream commit 32387caaa00660ebe35be25f2371edb0069cc80a ]
+
+The nb_rx_queue should get from rxp_dcb_info not txp_dcb_info, this
+commit fix it.
+
+Fixes: 1a572499beb6 ("app/testpmd: setup DCB forwarding based on traffic class")
+Cc: stable@dpdk.org
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ app/test-pmd/config.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
+index d71b398..c65586b 100644
+--- a/app/test-pmd/config.c
++++ b/app/test-pmd/config.c
+@@ -4937,7 +4937,7 @@ dcb_fwd_config_setup(void)
+ 				fwd_lcores[lc_id]->stream_idx;
+ 			rxq = rxp_dcb_info.tc_queue.tc_rxq[i][tc].base;
+ 			txq = txp_dcb_info.tc_queue.tc_txq[i][tc].base;
+-			nb_rx_queue = txp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue;
++			nb_rx_queue = rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue;
+ 			nb_tx_queue = txp_dcb_info.tc_queue.tc_txq[i][tc].nb_queue;
+ 			for (j = 0; j < nb_rx_queue; j++) {
+ 				struct fwd_stream *fs;
+-- 
+2.33.0
+
diff --git a/0136-app-testpmd-support-specify-TCs-when-DCB-forward.patch b/0136-app-testpmd-support-specify-TCs-when-DCB-forward.patch
new file mode 100644
index 0000000..bd57ad5
--- /dev/null
+++ b/0136-app-testpmd-support-specify-TCs-when-DCB-forward.patch
@@ -0,0 +1,254 @@
+From d1caf16b597ccd08ee72765d7027bb3a9ea172c6 Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Tue, 11 Nov 2025 17:13:02 +0800
+Subject: [PATCH 23/24] app/testpmd: support specify TCs when DCB forward
+
+[ upstream commit 48077248013eb2b52e020cf2eb103a314d794e81 ]
+
+This commit supports specify TCs when DCB forwarding, the command:
+
+  set dcb fwd_tc (tc_mask)
+
+The background of this command: only some TCs are expected to generate
+traffic when the DCB function is tested based on txonly forwarding, we
+could use this command to specify TCs to be used.
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Acked-by: Huisong Li <lihuisong@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ app/test-pmd/cmdline.c                      | 57 +++++++++++++++++++++
+ app/test-pmd/config.c                       | 50 +++++++++++++++++-
+ app/test-pmd/testpmd.c                      |  6 +++
+ app/test-pmd/testpmd.h                      |  3 ++
+ doc/guides/testpmd_app_ug/testpmd_funcs.rst |  8 +++
+ 5 files changed, 122 insertions(+), 2 deletions(-)
+
+diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
+index 332d7b3..c8a8ecd 100644
+--- a/app/test-pmd/cmdline.c
++++ b/app/test-pmd/cmdline.c
+@@ -488,6 +488,9 @@ static void cmd_help_long_parsed(void *parsed_result,
+ 			"set fwd (%s)\n"
+ 			"    Set packet forwarding mode.\n\n"
+ 
++			"set dcb fwd_tc (tc_mask)\n"
++			"    Set dcb forwarding on specify TCs, if bit-n in tc-mask is 1, then TC-n's forwarding is enabled\n\n"
++
+ 			"mac_addr add (port_id) (XX:XX:XX:XX:XX:XX)\n"
+ 			"    Add a MAC address on port_id.\n\n"
+ 
+@@ -5944,6 +5947,59 @@ static void cmd_set_fwd_retry_mode_init(void)
+ 	token_struct->string_data.str = token;
+ }
+ 
++/* *** set dcb forward TCs *** */
++struct cmd_set_dcb_fwd_tc_result {
++	cmdline_fixed_string_t set;
++	cmdline_fixed_string_t dcb;
++	cmdline_fixed_string_t fwd_tc;
++	uint8_t                tc_mask;
++};
++
++static void cmd_set_dcb_fwd_tc_parsed(void *parsed_result,
++				      __rte_unused struct cmdline *cl,
++				      __rte_unused void *data)
++{
++	struct cmd_set_dcb_fwd_tc_result *res = parsed_result;
++	int i;
++	if (res->tc_mask == 0) {
++		fprintf(stderr, "TC mask should not be zero!\n");
++		return;
++	}
++	printf("Enabled DCB forwarding TC list:");
++	dcb_fwd_tc_mask = res->tc_mask;
++	for (i = 0; i < RTE_ETH_8_TCS; i++) {
++		if (dcb_fwd_tc_mask & (1u << i))
++			printf(" %d", i);
++	}
++	printf("\n");
++}
++
++static cmdline_parse_token_string_t cmd_set_dcb_fwd_tc_set =
++	TOKEN_STRING_INITIALIZER(struct cmd_set_dcb_fwd_tc_result,
++			set, "set");
++static cmdline_parse_token_string_t cmd_set_dcb_fwd_tc_dcb =
++	TOKEN_STRING_INITIALIZER(struct cmd_set_dcb_fwd_tc_result,
++			dcb, "dcb");
++static cmdline_parse_token_string_t cmd_set_dcb_fwd_tc_fwdtc =
++	TOKEN_STRING_INITIALIZER(struct cmd_set_dcb_fwd_tc_result,
++			fwd_tc, "fwd_tc");
++static cmdline_parse_token_num_t cmd_set_dcb_fwd_tc_tcmask =
++	TOKEN_NUM_INITIALIZER(struct cmd_set_dcb_fwd_tc_result,
++			tc_mask, RTE_UINT8);
++
++static cmdline_parse_inst_t cmd_set_dcb_fwd_tc = {
++	.f = cmd_set_dcb_fwd_tc_parsed,
++	.data = NULL,
++	.help_str = "config DCB forwarding on specify TCs, if bit-n in tc-mask is 1, then TC-n's forwarding is enabled, and vice versa.",
++	.tokens = {
++		(void *)&cmd_set_dcb_fwd_tc_set,
++		(void *)&cmd_set_dcb_fwd_tc_dcb,
++		(void *)&cmd_set_dcb_fwd_tc_fwdtc,
++		(void *)&cmd_set_dcb_fwd_tc_tcmask,
++		NULL,
++	},
++};
++
+ /* *** SET BURST TX DELAY TIME RETRY NUMBER *** */
+ struct cmd_set_burst_tx_retry_result {
+ 	cmdline_fixed_string_t set;
+@@ -13318,6 +13374,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
+ 	(cmdline_parse_inst_t *)&cmd_set_fwd_mask,
+ 	(cmdline_parse_inst_t *)&cmd_set_fwd_mode,
+ 	(cmdline_parse_inst_t *)&cmd_set_fwd_retry_mode,
++	(cmdline_parse_inst_t *)&cmd_set_dcb_fwd_tc,
+ 	(cmdline_parse_inst_t *)&cmd_set_burst_tx_retry,
+ 	(cmdline_parse_inst_t *)&cmd_set_promisc_mode_one,
+ 	(cmdline_parse_inst_t *)&cmd_set_promisc_mode_all,
+diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
+index c65586b..4735dfa 100644
+--- a/app/test-pmd/config.c
++++ b/app/test-pmd/config.c
+@@ -4853,12 +4853,48 @@ get_fwd_port_total_tc_num(void)
+ 
+ 	for (i = 0; i < nb_fwd_ports; i++) {
+ 		(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[i], &dcb_info);
+-		total_tc_num += dcb_info.nb_tcs;
++		total_tc_num += rte_popcount32(dcb_fwd_tc_mask & ((1u << dcb_info.nb_tcs) - 1));
+ 	}
+ 
+ 	return total_tc_num;
+ }
+ 
++static void
++dcb_fwd_tc_update_dcb_info(struct rte_eth_dcb_info *org_dcb_info)
++{
++	struct rte_eth_dcb_info dcb_info = {0};
++	uint32_t i, vmdq_idx;
++	uint32_t tc = 0;
++
++	if (dcb_fwd_tc_mask == DEFAULT_DCB_FWD_TC_MASK)
++		return;
++
++	/*
++	 * Use compress scheme to update dcb-info.
++	 * E.g. If org_dcb_info->nb_tcs is 4 and dcb_fwd_tc_mask is 0x8, it
++	 *      means only enable TC3, then the new dcb-info's nb_tcs is set to
++	 *      1, and also move corresponding tc_rxq and tc_txq info to new
++	 *      index.
++	 */
++	for (i = 0; i < org_dcb_info->nb_tcs; i++) {
++		if (!(dcb_fwd_tc_mask & (1u << i)))
++			continue;
++		for (vmdq_idx = 0; vmdq_idx < RTE_ETH_MAX_VMDQ_POOL; vmdq_idx++) {
++			dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].base =
++				org_dcb_info->tc_queue.tc_rxq[vmdq_idx][i].base;
++			dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].nb_queue =
++				org_dcb_info->tc_queue.tc_rxq[vmdq_idx][i].nb_queue;
++			dcb_info.tc_queue.tc_txq[vmdq_idx][tc].base =
++				org_dcb_info->tc_queue.tc_txq[vmdq_idx][i].base;
++			dcb_info.tc_queue.tc_txq[vmdq_idx][tc].nb_queue =
++				org_dcb_info->tc_queue.tc_txq[vmdq_idx][i].nb_queue;
++		}
++		tc++;
++	}
++	dcb_info.nb_tcs = tc;
++	*org_dcb_info = dcb_info;
++}
++
+ /**
+  * For the DCB forwarding test, each core is assigned on each traffic class.
+  *
+@@ -4908,11 +4944,17 @@ dcb_fwd_config_setup(void)
+ 		}
+ 	}
+ 
++	total_tc_num = get_fwd_port_total_tc_num();
++	if (total_tc_num == 0) {
++		fprintf(stderr, "Error: total forwarding TC num is zero!\n");
++		cur_fwd_config.nb_fwd_lcores = 0;
++		return;
++	}
++
+ 	cur_fwd_config.nb_fwd_lcores = (lcoreid_t) nb_fwd_lcores;
+ 	cur_fwd_config.nb_fwd_ports = nb_fwd_ports;
+ 	cur_fwd_config.nb_fwd_streams =
+ 		(streamid_t) (nb_rxq * cur_fwd_config.nb_fwd_ports);
+-	total_tc_num = get_fwd_port_total_tc_num();
+ 	if (cur_fwd_config.nb_fwd_lcores > total_tc_num)
+ 		cur_fwd_config.nb_fwd_lcores = total_tc_num;
+ 
+@@ -4922,7 +4964,9 @@ dcb_fwd_config_setup(void)
+ 	txp = fwd_topology_tx_port_get(rxp);
+ 	/* get the dcb info on the first RX and TX ports */
+ 	(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[rxp], &rxp_dcb_info);
++	dcb_fwd_tc_update_dcb_info(&rxp_dcb_info);
+ 	(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
++	dcb_fwd_tc_update_dcb_info(&txp_dcb_info);
+ 
+ 	for (lc_id = 0; lc_id < cur_fwd_config.nb_fwd_lcores; lc_id++) {
+ 		fwd_lcores[lc_id]->stream_nb = 0;
+@@ -4970,7 +5014,9 @@ dcb_fwd_config_setup(void)
+ 		txp = fwd_topology_tx_port_get(rxp);
+ 		/* get the dcb information on next RX and TX ports */
+ 		rte_eth_dev_get_dcb_info(fwd_ports_ids[rxp], &rxp_dcb_info);
++		dcb_fwd_tc_update_dcb_info(&rxp_dcb_info);
+ 		rte_eth_dev_get_dcb_info(fwd_ports_ids[txp], &txp_dcb_info);
++		dcb_fwd_tc_update_dcb_info(&txp_dcb_info);
+ 	}
+ }
+ 
+diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
+index 5557314..770cb40 100644
+--- a/app/test-pmd/testpmd.c
++++ b/app/test-pmd/testpmd.c
+@@ -206,6 +206,12 @@ struct fwd_engine * fwd_engines[] = {
+ 	NULL,
+ };
+ 
++/*
++ * Bitmask for control DCB forwarding for TCs.
++ * If bit-n in tc-mask is 1, then TC-n's forwarding is enabled, and vice versa.
++ */
++uint8_t dcb_fwd_tc_mask = DEFAULT_DCB_FWD_TC_MASK;
++
+ struct rte_mempool *mempools[RTE_MAX_NUMA_NODES * MAX_SEGS_BUFFER_SPLIT];
+ uint16_t mempool_flags;
+ 
+diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
+index 4e12073..c22d673 100644
+--- a/app/test-pmd/testpmd.h
++++ b/app/test-pmd/testpmd.h
+@@ -464,6 +464,9 @@ extern cmdline_parse_inst_t cmd_show_set_raw_all;
+ extern cmdline_parse_inst_t cmd_set_flex_is_pattern;
+ extern cmdline_parse_inst_t cmd_set_flex_spec_pattern;
+ 
++#define DEFAULT_DCB_FWD_TC_MASK	0xFF
++extern uint8_t dcb_fwd_tc_mask;
++
+ extern uint16_t mempool_flags;
+ 
+ /**
+diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+index e816c81..83006aa 100644
+--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
++++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+@@ -1838,6 +1838,14 @@ during the flow rule creation::
+ 
+ Otherwise the default index ``0`` is used.
+ 
++set dcb fwd_tc
++~~~~~~~~~~~~~~
++
++Config DCB forwarding on specify TCs, if bit-n in tc-mask is 1, then TC-n's
++forwarding is enabled, and vice versa::
++
++   testpmd> set dcb fwd_tc (tc_mask)
++
+ Port Functions
+ --------------
+ 
+-- 
+2.33.0
+
diff --git a/0137-app-testpmd-support-multi-cores-process-one-TC.patch b/0137-app-testpmd-support-multi-cores-process-one-TC.patch
new file mode 100644
index 0000000..db46b6c
--- /dev/null
+++ b/0137-app-testpmd-support-multi-cores-process-one-TC.patch
@@ -0,0 +1,292 @@
+From 56209344f3eb31a960c38afa986bbb8a6072f838 Mon Sep 17 00:00:00 2001
+From: Chengwen Feng <fengchengwen@huawei.com>
+Date: Tue, 11 Nov 2025 17:13:03 +0800
+Subject: [PATCH 24/24] app/testpmd: support multi-cores process one TC
+
+[ upstream commit fca6f2910345c25a5050a0b586e0d324ca616cbb ]
+
+Currently, one TC can be processed by only one core, when there are a
+large number of small packets, this core becomes a bottleneck.
+
+This commit supports multi-cores process one TC, the command:
+
+  set dcb fwd_tc_cores (tc_cores)
+
+Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
+Acked-by: Huisong Li <lihuisong@huawei.com>
+Signed-off-by: Donghua Huang <huangdonghua3@h-partners.com>
+---
+ app/test-pmd/cmdline.c                      | 48 ++++++++++++
+ app/test-pmd/config.c                       | 85 ++++++++++++++++-----
+ app/test-pmd/testpmd.c                      |  9 +++
+ app/test-pmd/testpmd.h                      |  1 +
+ doc/guides/testpmd_app_ug/testpmd_funcs.rst |  8 ++
+ 5 files changed, 134 insertions(+), 17 deletions(-)
+
+diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
+index c8a8ecd..275df67 100644
+--- a/app/test-pmd/cmdline.c
++++ b/app/test-pmd/cmdline.c
+@@ -6000,6 +6000,53 @@ static cmdline_parse_inst_t cmd_set_dcb_fwd_tc = {
+ 	},
+ };
+ 
++/* *** set dcb forward cores per TC *** */
++struct cmd_set_dcb_fwd_tc_cores_result {
++	cmdline_fixed_string_t set;
++	cmdline_fixed_string_t dcb;
++	cmdline_fixed_string_t fwd_tc_cores;
++	uint8_t                tc_cores;
++};
++
++static void cmd_set_dcb_fwd_tc_cores_parsed(void *parsed_result,
++					    __rte_unused struct cmdline *cl,
++					    __rte_unused void *data)
++{
++	struct cmd_set_dcb_fwd_tc_cores_result *res = parsed_result;
++	if (res->tc_cores == 0) {
++		fprintf(stderr, "Cores per-TC should not be zero!\n");
++		return;
++	}
++	dcb_fwd_tc_cores = res->tc_cores;
++	printf("Set cores-per-TC: %u\n", dcb_fwd_tc_cores);
++}
++
++static cmdline_parse_token_string_t cmd_set_dcb_fwd_tc_cores_set =
++	TOKEN_STRING_INITIALIZER(struct cmd_set_dcb_fwd_tc_cores_result,
++			set, "set");
++static cmdline_parse_token_string_t cmd_set_dcb_fwd_tc_cores_dcb =
++	TOKEN_STRING_INITIALIZER(struct cmd_set_dcb_fwd_tc_cores_result,
++			dcb, "dcb");
++static cmdline_parse_token_string_t cmd_set_dcb_fwd_tc_cores_fwdtccores =
++	TOKEN_STRING_INITIALIZER(struct cmd_set_dcb_fwd_tc_cores_result,
++			fwd_tc_cores, "fwd_tc_cores");
++static cmdline_parse_token_num_t cmd_set_dcb_fwd_tc_cores_tccores =
++	TOKEN_NUM_INITIALIZER(struct cmd_set_dcb_fwd_tc_cores_result,
++			tc_cores, RTE_UINT8);
++
++static cmdline_parse_inst_t cmd_set_dcb_fwd_tc_cores = {
++	.f = cmd_set_dcb_fwd_tc_cores_parsed,
++	.data = NULL,
++	.help_str = "config DCB forwarding cores per-TC, 1-means one core process all queues of a TC.",
++	.tokens = {
++		(void *)&cmd_set_dcb_fwd_tc_cores_set,
++		(void *)&cmd_set_dcb_fwd_tc_cores_dcb,
++		(void *)&cmd_set_dcb_fwd_tc_cores_fwdtccores,
++		(void *)&cmd_set_dcb_fwd_tc_cores_tccores,
++		NULL,
++	},
++};
++
+ /* *** SET BURST TX DELAY TIME RETRY NUMBER *** */
+ struct cmd_set_burst_tx_retry_result {
+ 	cmdline_fixed_string_t set;
+@@ -13375,6 +13422,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
+ 	(cmdline_parse_inst_t *)&cmd_set_fwd_mode,
+ 	(cmdline_parse_inst_t *)&cmd_set_fwd_retry_mode,
+ 	(cmdline_parse_inst_t *)&cmd_set_dcb_fwd_tc,
++	(cmdline_parse_inst_t *)&cmd_set_dcb_fwd_tc_cores,
+ 	(cmdline_parse_inst_t *)&cmd_set_burst_tx_retry,
+ 	(cmdline_parse_inst_t *)&cmd_set_promisc_mode_one,
+ 	(cmdline_parse_inst_t *)&cmd_set_promisc_mode_all,
+diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
+index 4735dfa..53809d9 100644
+--- a/app/test-pmd/config.c
++++ b/app/test-pmd/config.c
+@@ -4844,6 +4844,36 @@ rss_fwd_config_setup(void)
+ 	}
+ }
+ 
++static int
++dcb_fwd_check_cores_per_tc(void)
++{
++	struct rte_eth_dcb_info dcb_info = {0};
++	uint32_t port, tc, vmdq_idx;
++
++	if (dcb_fwd_tc_cores == 1)
++		return 0;
++
++	for (port = 0; port < nb_fwd_ports; port++) {
++		(void)rte_eth_dev_get_dcb_info(fwd_ports_ids[port], &dcb_info);
++		for (tc = 0; tc < dcb_info.nb_tcs; tc++) {
++			for (vmdq_idx = 0; vmdq_idx < RTE_ETH_MAX_VMDQ_POOL; vmdq_idx++) {
++				if (dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].nb_queue == 0)
++					break;
++				/* make sure nb_rx_queue can be divisible. */
++				if (dcb_info.tc_queue.tc_rxq[vmdq_idx][tc].nb_queue %
++					dcb_fwd_tc_cores)
++					return -1;
++				/* make sure nb_tx_queue can be divisible. */
++				if (dcb_info.tc_queue.tc_txq[vmdq_idx][tc].nb_queue %
++					dcb_fwd_tc_cores)
++					return -1;
++			}
++		}
++	}
++
++	return 0;
++}
++
+ static uint16_t
+ get_fwd_port_total_tc_num(void)
+ {
+@@ -4896,14 +4926,17 @@ dcb_fwd_tc_update_dcb_info(struct rte_eth_dcb_info *org_dcb_info)
+ }
+ 
+ /**
+- * For the DCB forwarding test, each core is assigned on each traffic class.
++ * For the DCB forwarding test, each core is assigned on each traffic class
++ * defaultly:
++ *   Each core is assigned a multi-stream, each stream being composed of
++ *   a RX queue to poll on a RX port for input messages, associated with
++ *   a TX queue of a TX port where to send forwarded packets. All RX and
++ *   TX queues are mapping to the same traffic class.
++ *   If VMDQ and DCB co-exist, each traffic class on different POOLs share
++ *   the same core.
+  *
+- * Each core is assigned a multi-stream, each stream being composed of
+- * a RX queue to poll on a RX port for input messages, associated with
+- * a TX queue of a TX port where to send forwarded packets. All RX and
+- * TX queues are mapping to the same traffic class.
+- * If VMDQ and DCB co-exist, each traffic class on different POOLs share
+- * the same core
++ * If user set cores-per-TC to other value (e.g. 2), then there will multiple
++ * cores to process one TC.
+  */
+ static void
+ dcb_fwd_config_setup(void)
+@@ -4911,9 +4944,10 @@ dcb_fwd_config_setup(void)
+ 	struct rte_eth_dcb_info rxp_dcb_info, txp_dcb_info;
+ 	portid_t txp, rxp = 0;
+ 	queueid_t txq, rxq = 0;
+-	lcoreid_t  lc_id;
++	lcoreid_t  lc_id, target_lcores;
+ 	uint16_t nb_rx_queue, nb_tx_queue;
+ 	uint16_t i, j, k, sm_id = 0;
++	uint16_t sub_core_idx = 0;
+ 	uint16_t total_tc_num;
+ 	struct rte_port *port;
+ 	uint8_t tc = 0;
+@@ -4944,6 +4978,13 @@ dcb_fwd_config_setup(void)
+ 		}
+ 	}
+ 
++	ret = dcb_fwd_check_cores_per_tc();
++	if (ret != 0) {
++		fprintf(stderr, "Error: check forwarding cores-per-TC failed!\n");
++		cur_fwd_config.nb_fwd_lcores = 0;
++		return;
++	}
++
+ 	total_tc_num = get_fwd_port_total_tc_num();
+ 	if (total_tc_num == 0) {
+ 		fprintf(stderr, "Error: total forwarding TC num is zero!\n");
+@@ -4951,12 +4992,17 @@ dcb_fwd_config_setup(void)
+ 		return;
+ 	}
+ 
+-	cur_fwd_config.nb_fwd_lcores = (lcoreid_t) nb_fwd_lcores;
++	target_lcores = (lcoreid_t)total_tc_num * (lcoreid_t)dcb_fwd_tc_cores;
++	if (nb_fwd_lcores < target_lcores) {
++		fprintf(stderr, "Error: the number of forwarding cores is insufficient!\n");
++		cur_fwd_config.nb_fwd_lcores = 0;
++		return;
++	}
++
++	cur_fwd_config.nb_fwd_lcores = target_lcores;
+ 	cur_fwd_config.nb_fwd_ports = nb_fwd_ports;
+ 	cur_fwd_config.nb_fwd_streams =
+ 		(streamid_t) (nb_rxq * cur_fwd_config.nb_fwd_ports);
+-	if (cur_fwd_config.nb_fwd_lcores > total_tc_num)
+-		cur_fwd_config.nb_fwd_lcores = total_tc_num;
+ 
+ 	/* reinitialize forwarding streams */
+ 	init_fwd_streams();
+@@ -4979,10 +5025,12 @@ dcb_fwd_config_setup(void)
+ 				break;
+ 			k = fwd_lcores[lc_id]->stream_nb +
+ 				fwd_lcores[lc_id]->stream_idx;
+-			rxq = rxp_dcb_info.tc_queue.tc_rxq[i][tc].base;
+-			txq = txp_dcb_info.tc_queue.tc_txq[i][tc].base;
+-			nb_rx_queue = rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue;
+-			nb_tx_queue = txp_dcb_info.tc_queue.tc_txq[i][tc].nb_queue;
++			nb_rx_queue = rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue /
++						dcb_fwd_tc_cores;
++			nb_tx_queue = txp_dcb_info.tc_queue.tc_txq[i][tc].nb_queue /
++						dcb_fwd_tc_cores;
++			rxq = rxp_dcb_info.tc_queue.tc_rxq[i][tc].base + nb_rx_queue * sub_core_idx;
++			txq = txp_dcb_info.tc_queue.tc_txq[i][tc].base + nb_tx_queue * sub_core_idx;
+ 			for (j = 0; j < nb_rx_queue; j++) {
+ 				struct fwd_stream *fs;
+ 
+@@ -4994,11 +5042,14 @@ dcb_fwd_config_setup(void)
+ 				fs->peer_addr = fs->tx_port;
+ 				fs->retry_enabled = retry_enabled;
+ 			}
+-			fwd_lcores[lc_id]->stream_nb +=
+-				rxp_dcb_info.tc_queue.tc_rxq[i][tc].nb_queue;
++			sub_core_idx++;
++			fwd_lcores[lc_id]->stream_nb += nb_rx_queue;
+ 		}
+ 		sm_id = (streamid_t) (sm_id + fwd_lcores[lc_id]->stream_nb);
++		if (sub_core_idx < dcb_fwd_tc_cores)
++			continue;
+ 
++		sub_core_idx = 0;
+ 		tc++;
+ 		if (tc < rxp_dcb_info.nb_tcs)
+ 			continue;
+diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
+index 770cb40..f665f00 100644
+--- a/app/test-pmd/testpmd.c
++++ b/app/test-pmd/testpmd.c
+@@ -211,6 +211,15 @@ struct fwd_engine * fwd_engines[] = {
+  * If bit-n in tc-mask is 1, then TC-n's forwarding is enabled, and vice versa.
+  */
+ uint8_t dcb_fwd_tc_mask = DEFAULT_DCB_FWD_TC_MASK;
++/*
++ * Poll cores per TC when DCB forwarding.
++ * E.g. 1 indicates that one core process all queues of a TC.
++ *      2 indicates that two cores process all queues of a TC. If there
++ *        is a TC with 8 queues, then [0, 3] belong to first core, and
++ *        [4, 7] belong to second core.
++ *      ...
++ */
++uint8_t dcb_fwd_tc_cores = 1;
+ 
+ struct rte_mempool *mempools[RTE_MAX_NUMA_NODES * MAX_SEGS_BUFFER_SPLIT];
+ uint16_t mempool_flags;
+diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
+index c22d673..06f432a 100644
+--- a/app/test-pmd/testpmd.h
++++ b/app/test-pmd/testpmd.h
+@@ -466,6 +466,7 @@ extern cmdline_parse_inst_t cmd_set_flex_spec_pattern;
+ 
+ #define DEFAULT_DCB_FWD_TC_MASK	0xFF
+ extern uint8_t dcb_fwd_tc_mask;
++extern uint8_t dcb_fwd_tc_cores;
+ 
+ extern uint16_t mempool_flags;
+ 
+diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+index 83006aa..fc63587 100644
+--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
++++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+@@ -1846,6 +1846,14 @@ forwarding is enabled, and vice versa::
+ 
+    testpmd> set dcb fwd_tc (tc_mask)
+ 
++set dcb fwd_tc_cores
++~~~~~~~~~~~~~~~~~~~~
++
++Config DCB forwarding cores per-TC, 1-means one core process all queues of a TC,
++2-means two cores process all queues of a TC, and so on::
++
++   testpmd> set dcb fwd_tc_cores (tc_cores)
++
+ Port Functions
+ --------------
+ 
+-- 
+2.33.0
+
diff --git a/dpdk.spec b/dpdk.spec
index f150946..6d3750c 100644
--- a/dpdk.spec
+++ b/dpdk.spec
@@ -11,7 +11,7 @@
 
 Name: dpdk
 Version: 23.11
-Release: 37
+Release: 38
 URL: http://dpdk.org
 Source: https://fast.dpdk.org/rel/dpdk-%{version}.tar.xz
 
@@ -146,6 +146,31 @@ Patch6110: 0110-net-hns3-fix-overwrite-mbuf-in-vector-path.patch
 Patch6111: 0111-net-hns3-fix-unrelease-VLAN-resource-when-init-fail.patch
 Patch6112: 0112-net-hns3-fix-VLAN-tag-loss-for-short-tunnel-frame.patch
 Patch6113: 0113-app-testpmd-fix-L4-protocol-retrieval-from-L3-header.patch
+Patch6114: 0114-app-testpmd-handle-IEEE1588-init-failure.patch
+Patch6115: 0115-examples-l3fwd-add-option-to-set-Rx-burst-size.patch
+Patch6116: 0116-examples-eventdev-fix-queue-crash-with-generic-pipel.patch
+Patch6117: 0117-examples-l3fwd-add-Tx-burst-size-configuration-optio.patch
+Patch6118: 0118-net-hns3-remove-duplicate-struct-field.patch
+Patch6119: 0119-net-hns3-refactor-DCB-module.patch
+Patch6120: 0120-net-hns3-parse-max-TC-number-for-VF.patch
+Patch6121: 0121-net-hns3-support-multi-TCs-capability-for-VF.patch
+Patch6122: 0122-net-hns3-fix-queue-TC-configuration-on-VF.patch
+Patch6123: 0123-net-hns3-support-multi-TCs-configuration-for-VF.patch
+Patch6124: 0124-app-testpmd-avoid-crash-in-DCB-config.patch
+Patch6125: 0125-app-testpmd-show-all-DCB-priority-TC-map.patch
+Patch6126: 0126-app-testpmd-relax-number-of-TCs-in-DCB-command.patch
+Patch6127: 0127-app-testpmd-reuse-RSS-config-when-configuring-DCB.patch
+Patch6128: 0128-app-testpmd-add-prio-tc-map-in-DCB-command.patch
+Patch6129: 0129-app-testpmd-add-queue-restriction-in-DCB-command.patch
+Patch6130: 0130-app-testpmd-add-command-to-disable-DCB.patch
+Patch6131: 0131-examples-l3fwd-force-link-speed.patch
+Patch6132: 0132-examples-l3fwd-power-force-link-speed.patch
+Patch6133: 0133-config-arm-add-HiSilicon-HIP12.patch
+Patch6134: 0134-app-testpmd-fix-DCB-Tx-port.patch
+Patch6135: 0135-app-testpmd-fix-DCB-Rx-queues.patch
+Patch6136: 0136-app-testpmd-support-specify-TCs-when-DCB-forward.patch
+Patch6137: 0137-app-testpmd-support-multi-cores-process-one-TC.patch
+
 
 BuildRequires: meson
 BuildRequires: python3-pyelftools
@@ -350,6 +375,33 @@ fi
 /usr/sbin/depmod
 
 %changelog
+* Thu Nov 27 2025 huangdonghua <huangdonghua3@h-partners.com> - 23.11-38
+ Upload some patches of vf multiple tc and some of others:
+ - app/testpmd: handle IEEE1588 init failure
+ - examples/l3fwd: add option to set Rx burst size
+ - examples/eventdev: fix queue crash with generic pipeline
+ - examples/l3fwd: add Tx burst size configuration option
+ - net/hns3: remove duplicate struct field
+ - net/hns3: refactor DCB module
+ - net/hns3: parse max TC number for VF
+ - net/hns3: support multi-TCs capability for VF
+ - net/hns3: fix queue TC configuration on VF
+ - net/hns3: support multi-TCs configuration for VF
+ - app/testpmd: avoid crash in DCB config
+ - app/testpmd: show all DCB priority TC map
+ - app/testpmd: relax number of TCs in DCB command
+ - app/testpmd: reuse RSS config when configuring DCB
+ - app/testpmd: add prio-tc map in DCB command
+ - app/testpmd: add queue restriction in DCB command
+ - app/testpmd: add command to disable DCB
+ - examples/l3fwd: force link speed
+ - examples/l3fwd-power: force link speed
+ - config/arm: add HiSilicon HIP12
+ - app/testpmd: fix DCB Tx port
+ - app/testpmd: fix DCB Rx queues
+ - app/testpmd: support specify TCs when DCB forward
+ - app/testpmd: support multi-cores process one TC
+
 * Wed Nov 05 2025 huangdonghua <huangdonghua3@h-partners.com> - 23.11-37
  Fix unrelease VLAN resource and L4 protocol retrieval from L3 header:
  - net/hns3: fix unrelease VLAN resource when init fail
-- 
2.33.0

