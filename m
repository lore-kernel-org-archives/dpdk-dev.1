Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58C2C02198
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 11:44:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F137E402C4;
	Tue, 18 Feb 2025 12:44:21 +0100 (CET)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by mails.dpdk.org (Postfix) with ESMTP id 247B3402A0
 for <dev@dpdk.org>; Tue, 18 Feb 2025 12:44:19 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YxyHL5Jbbz1V7C1;
 Tue, 18 Feb 2025 19:39:42 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
 by mail.maildlp.com (Postfix) with ESMTPS id 8BAD01402C1;
 Tue, 18 Feb 2025 19:44:17 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Feb 2025 19:44:17 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Feb 2025 19:44:16 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <songx.jiale@intel.com>,
 <liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH] app/testpmd: fix fail to set queue number when attach device
Date: Tue, 18 Feb 2025 19:31:56 +0800
Message-ID: <20250218113156.7174-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.28.79.22]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Testpmd doesn't modify the Rx/Tx queue number of all ports after attach a
new device. The root cause is that "port config all rxq <value>" would
check if all ports are stopped and the status of this port is still in
'RTE_PORT_HANDLING'. This status is changed to 'RTE_PORT_STOPPED' in
setup_attached_port() when start port.

In addition, this new port needs to be initialized in advance because these
information are depanded on many commands. Otherwise other commands like
"port config xxx" may also encounter similar issue. But the initialization
can't be in new event callback as discussed in following commit. So this
patch moves setup_attached_port() to the time point 100ms after received
the new event.

Bugzilla ID: 1663
Fixes: 994635edb2c0 ("app/testpmd: add port attach/detach for multiple process")

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 app/test-pmd/testpmd.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index 19e2e37c11..b0ee39db52 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -705,7 +705,7 @@ eth_dev_set_mtu_mp(uint16_t port_id, uint16_t mtu)
 }
 
 /* Forward function declarations */
-static void setup_attached_port(portid_t pi);
+static void setup_attached_port(void *arg);
 static void check_all_ports_link_status(uint32_t port_mask);
 static int eth_event_callback(portid_t port_id,
 			      enum rte_eth_event_type type,
@@ -2906,8 +2906,6 @@ start_port(portid_t pid)
 		at_least_one_port_exist = true;
 
 		port = &ports[pi];
-		if (port->need_setup)
-			setup_attached_port(pi);
 
 		if (port->port_status == RTE_PORT_STOPPED) {
 			port->port_status = RTE_PORT_HANDLING;
@@ -3441,7 +3439,7 @@ attach_port(char *identifier)
 		/* setup ports matching the devargs used for probing */
 		if (port_is_forwarding(pi))
 			continue; /* port was already attached before */
-		setup_attached_port(pi);
+		setup_attached_port((void *)(intptr_t)pi);
 	}
 out:
 	printf("Port %s is attached.\n", identifier);
@@ -3449,8 +3447,9 @@ attach_port(char *identifier)
 }
 
 static void
-setup_attached_port(portid_t pi)
+setup_attached_port(void *arg)
 {
+	portid_t pi = (intptr_t)arg;
 	unsigned int socket_id;
 	int ret;
 
@@ -3786,6 +3785,10 @@ eth_event_callback(portid_t port_id, enum rte_eth_event_type type, void *param,
 			ports[port_id].need_setup = 1;
 			ports[port_id].port_status = RTE_PORT_HANDLING;
 		}
+		/* Can't initialize port directly in new event. */
+		if (rte_eal_alarm_set(100000, setup_attached_port,
+				      (void *)(intptr_t)port_id))
+			fprintf(stderr, "Could not set up deferred task to setup this attached port.\n");
 		break;
 	case RTE_ETH_EVENT_INTR_RMV:
 		if (port_id_is_invalid(port_id, DISABLED_WARN))
-- 
2.22.0

