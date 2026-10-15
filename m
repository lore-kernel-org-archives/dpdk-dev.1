Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC012CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 14:40:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D91B40A8B;
	Thu, 15 Oct 2026 16:40:26 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
 by mails.dpdk.org (Postfix) with ESMTP id A31E240A7D;
 Thu, 15 Oct 2026 16:40:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqOSAhMYsvJU2FhJjaK1HfAI+UkznK6nEHoAb/vjFQY0fxrDOVXBdrI8kZ1l9tFW2Vp/wPK/UhbIVw2orF8kHMpaaCnNO3gz/kVGez2gYER+xCVPu3oxA8uLsrrUVx5KII9i4t/gMsMuXmrErOQ6Z4as1uvLBle3iUo6PwxGnzUOUDgqQyVPPLymWsZlk4xdiYVIm9S6hHsXIipMJFk5dlUp/jjftREYHci6o7JicY5sKaGFbU28AKTPgcT6/chFNu3z9AHhcfb6iOVGvS+B3oMidOH4AMuvGRrV1roxmCrzxJSKcLFIpzeTYoSDC1mmDYJKONMOyP1t3FssnvH5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9b4ZpdwNsWsuMBALzGXIGN7HfdRnJjAEkMHnnAG62Y=;
 b=tEiMpf8NX9nytSXKAsvUOKseVO7HQI8KQ+z7NGPmGrpQYKghYIHAoK+4m8bHtGhggF9I/is/nD5QI3JNn9ajV83m3plxztKLGm6WjsNDjFevimvpe7vD0pNOSzfrQaFAVszE79jPvJX+eQK1HP8JDIt8GBfZIx0g37R8bUhlS+FtGd+sIRtjSjC51d+YBwr7mXeuRbPG0LJnWs6vJICTt7H1L/yutn85iGWw9kLrHst70IFX+/4MbHXMrYqDSM1Cui4bJJhNdeKEvnMDzTt8cigiRQeNuK2vIwg0Ubxn/7OLWmjdRGohKAr4HlGVjte7qsOidDgTOms3ZWAIR9c3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9b4ZpdwNsWsuMBALzGXIGN7HfdRnJjAEkMHnnAG62Y=;
 b=OASZy9bhJnukRfO148NFX9gb44k3+DYJ3k2eWC4Egw2/Mv9rVo2cFbXWTYrvXnr0Xit9ZmXcaWVgpQ6OMVxxkCxmnJPgZO9AExhfvbWCPREKxA2LC88VSdgCNk9TY4wwdSANPd6Ojansy3cxpbgCRbfm8eej168rTn0CzOKwGm/im0pn7TShNwuZi8NtcJkd5ksPVw81z76zDMcHbs5QdgPc+oFYKA8XYOLBcRX9g3B9TnHmc3d5PfnsXWkzKWbL3FQ5xMowRADX8r01/ljEgxI9TAqUI0uomTokZXcebZiKp86ACYzQIWg2kN5folnwIxOkKo8vlClM74V3R40TaQ==
Received: from AS9PR05CA0229.eurprd05.prod.outlook.com (2603:10a6:20b:494::18)
 by AS1PR07MB8568.eurprd07.prod.outlook.com (2603:10a6:20b:470::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:40:23 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:20b:494:cafe::72) by AS9PR05CA0229.outlook.office365.com
 (2603:10a6:20b:494::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 14:40:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 14:40:23 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 15 Oct 2026 16:39:47 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id 3083C4020B7E;
 Thu, 15 Oct 2026 16:39:46 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 75CC660B0355; Thu, 15 Oct 2026 16:39:45 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH v2 8/8] test/memif: add memif PMD unit test
Date: Thu, 15 Oct 2026 16:39:45 +0200
Message-ID: <20261015143945.2150772-9-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
References: <20261015143945.2150772-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|AS1PR07MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: e5907c99-cde9-48b1-3cf7-08df2aca3eca
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|260925021311599003|260925021911599003|260925022911599003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: u364kHpCzoYLzRH5Af7l01vQFbZOYIqDEt9Yv0MclK7og0B42uPcZYwKM4mXyXNiL7fWHP6GLF6ccLGuWdCWOF0UT4X4SHqwXUcD4VPkiO75wsdX1fg+WPytWok9O5/8f9ePJPMGJNpikDzmWw4pUDWTCuHQLUplL0zt58Wa+F0kcckf5g9SPpVIe2n8GN4DiW7OMj3JlOO/wDNjtKfHHL+UUNXX2Ej6RzMy+uJY7SryF9dbeaF8nK9+AcESxl5mm1ETJX2WP5dMIbaz3RQiS0AKHw8iPmur5AVFNc8dBUtbZu6x9hQ9AnFZnta+fd8/rBRzH31Oi+epoxFtcn72RM+x0dp+IzEuM+PsEcO2Jk7orrN3jKXpj5GlEy8NNHdOt7AoPDV/7rj+pF3Xxg5ExGJrZVbukx3TkNk/Wsq61JgB6C81RgCy7iHeGZad3iH1bTU9bVOCcA3jjVNKx+Xoxxil8lyqGvUwImbFzcxnsy9h7zbS0ulbQLWsrDYrgE7QHZcpoAHZPg4qC+aWg0/GsyCk/w55GdP9zIN+Iy2McPSCSoH1GJm7HfGXHMJu5yJrr/n2uFzKC8moasAYaTvSDWJzMptxbSRXGCnPG4mTcxpYPk5Vml8YBavCk5tfaBf8g6x60OatZY4vSRYzSWZTw6Xexm7FGbp3T8RgFqAnMoPA55ATf6gPdXiaf95XkSNBAsJqDrr0yR+WouME8+TMjw==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(260925021311599003)(260925021911599003)(260925022911599003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VKEciBC0x48zmszMr1UhOOpvqU6COjeNjQ8bGBQIqMdQNLz11VQ/R5uOlH3T85afckBq1proOnFrT9qVE9F3KLtcrAPEhx1aKeHRqfTwRAAARbWLWALKV6MGXAtCGrZdH18wUUL0BAZENuer85UvKXS4zmv0kmfo1DBp6QzQg5/vWxl2h8EdoJ10UftezeHWMrHP3sGhzPoIHiA1RUmbSMkgiCKpWmOgNxHSCRL56uk8MCz5L348TEv9xSsc2JPiH7E2FPYM5UMsw3vlNwA4Y2NGJgq+LuaMO1CcFb+JWuGfdgI9Fwu1NmomgKq5zH7ldQSB+3uOzES67pQ1KkdZUDoiaqhpU3TlY7KlAGxV+Z4yyQfu2c7ErUvA0XhoSEDrvca7q3nJy/Jnk/39s7SSTQ5wglmgP2lamMX70wY1o7GxQTp/ykXgMxRWlnuQFK27
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:40:23.4266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5907c99-cde9-48b1-3cf7-08df2aca3eca
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8568
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

Add a memif_pmd_autotest unit test, modelled on the TAP PMD test. memif
differs from TAP in that a port is only usable once a peer connects, so
the test creates a server and a client memif port in the same process,
connected over an abstract-namespace socket (the loopback setup from the
memif documentation), and waits for the asynchronous control-channel
handshake to bring both ports up.

The suite checks dev_info reports the memif driver, that the pair reaches
link up, statistics get and reset, a client-to-server loopback burst with
payload verification, multi-segment loopback across a ring wrap with
payload verification (general coverage for the chained-descriptor Rx and
Tx paths), that the pair reconnects after a port restart, that a
zero-length Tx burst is handled, and that a configured-but-not-started
port can be closed without crashing. It is a fast test, runs without
hugepages and under ASan.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 MAINTAINERS               |   1 +
 app/test/meson.build      |   1 +
 app/test/test_pmd_memif.c | 693 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 695 insertions(+)
 create mode 100644 app/test/test_pmd_memif.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3560b3fd53..8a21bcb946 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1164,6 +1164,7 @@ F: drivers/net/memif/
 F: doc/guides/nics/memif.rst
 F: doc/guides/nics/features/memif.ini
 F: devtools/test-memif.sh
+F: app/test/test_pmd_memif.c
 
 
 Crypto Drivers
diff --git a/app/test/meson.build b/app/test/meson.build
index 9805cf5bee..5ef1ced7ce 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -148,6 +148,7 @@ source_file_deps = {
     'test_pflock.c': [],
     'test_pie.c': ['sched'],
     'test_pmd_af_packet.c': ['net_af_packet', 'ethdev', 'bus_vdev'],
+    'test_pmd_memif.c': ['ethdev', 'net_memif', 'bus_vdev'],
     'test_pmd_pcap.c': ['net_pcap', 'ethdev', 'bus_vdev']  + packet_burst_generator_deps,
     'test_pmd_perf.c': ['ethdev', 'net'] + packet_burst_generator_deps,
     'test_pmd_ring.c': ['net_ring', 'ethdev', 'bus_vdev'],
diff --git a/app/test/test_pmd_memif.c b/app/test/test_pmd_memif.c
new file mode 100644
index 0000000000..f3b951baa3
--- /dev/null
+++ b/app/test/test_pmd_memif.c
@@ -0,0 +1,693 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Ericsson AB
+ */
+
+/*
+ * Basic test of memif PMD functionality.
+ * Based off of the TAP PMD test (test_pmd_tap.c).
+ *
+ * memif connects two endpoints over shared memory. Unlike a NIC or TAP
+ * device, a memif port is only usable once its peer connects, so the test
+ * creates a server and a client memif port in this one process, connected
+ * over an abstract-namespace socket (the loopback setup documented in
+ * doc/guides/nics/memif.rst). The control-channel handshake is asynchronous,
+ * so the test waits for both ports to report link up before exercising the
+ * data path.
+ */
+
+#include "test.h"
+
+#include <stdio.h>
+
+#ifndef RTE_EXEC_ENV_LINUX
+
+/* memif PMD is only available on Linux */
+static int
+test_pmd_memif(void)
+{
+	printf("memif PMD not supported on this platform, skipping test\n");
+	return TEST_SKIPPED;
+}
+
+#else /* RTE_EXEC_ENV_LINUX */
+
+#include <string.h>
+#include <unistd.h>
+
+#include <rte_ethdev.h>
+#include <rte_bus_vdev.h>
+#include <rte_mbuf.h>
+#include <rte_ether.h>
+
+#define SOCKET0 0
+#define RING_SIZE 256
+#define NB_MBUF 4096
+#define MAX_PKT_BURST 32
+#define PKT_LEN 64
+
+/* memif ignores nb_tx_desc; the ring size is set via the rsize arg. */
+#define MEMIF_LOG2_RING 8
+
+/*
+ * Same socket name and id on both ports makes them a connected pair.
+ * The small-bsize pair forces chained descriptors; the default-bsize pair
+ * exercises the single-pool Tx fast path.
+ */
+#define MEMIF_SRV_NAME "net_memif_test_srv"
+#define MEMIF_CLI_NAME "net_memif_test_cli"
+#define MEMIF_SRV_ARGS "role=server,id=0,bsize=512,rsize=8,socket-abstract=yes,socket=memif-autotest"
+#define MEMIF_CLI_ARGS "role=client,id=0,bsize=512,rsize=8,socket-abstract=yes,socket=memif-autotest"
+#define MEMIF_FP_SRV_NAME "net_memif_test_fsrv"
+#define MEMIF_FP_CLI_NAME "net_memif_test_fcli"
+#define MEMIF_FP_SRV_ARGS "role=server,id=2,socket-abstract=yes,socket=memif-autotest-fp"
+#define MEMIF_FP_CLI_ARGS "role=client,id=2,socket-abstract=yes,socket=memif-autotest-fp"
+
+/* Time to wait for the asynchronous control-channel handshake. */
+#define CONNECT_TRIES 50
+#define CONNECT_DELAY_US 100000
+
+static struct rte_mempool *mp;
+static int memif_srv_port = -1;
+static int memif_cli_port = -1;
+static int memif_fp_srv_port = -1;
+static int memif_fp_cli_port = -1;
+
+static int
+find_port(const char *frag)
+{
+	uint16_t port_id;
+	char name[RTE_ETH_NAME_MAX_LEN];
+
+	RTE_ETH_FOREACH_DEV(port_id) {
+		if (rte_eth_dev_get_name_by_port(port_id, name) == 0 &&
+		    strstr(name, frag) != NULL)
+			return port_id;
+	}
+	return -1;
+}
+
+static int
+configure_port(int port)
+{
+	struct rte_eth_conf port_conf;
+	int ret;
+
+	memset(&port_conf, 0, sizeof(port_conf));
+
+	ret = rte_eth_dev_configure(port, 1, 1, &port_conf);
+	if (ret < 0) {
+		printf("Configure failed for port %d: %s\n",
+		       port, rte_strerror(-ret));
+		return -1;
+	}
+
+	ret = rte_eth_tx_queue_setup(port, 0, RING_SIZE, SOCKET0, NULL);
+	if (ret < 0) {
+		printf("TX queue setup failed for port %d: %s\n",
+		       port, rte_strerror(-ret));
+		return -1;
+	}
+
+	ret = rte_eth_rx_queue_setup(port, 0, RING_SIZE, SOCKET0, NULL, mp);
+	if (ret < 0) {
+		printf("RX queue setup failed for port %d: %s\n",
+		       port, rte_strerror(-ret));
+		return -1;
+	}
+
+	ret = rte_eth_dev_start(port);
+	if (ret < 0) {
+		printf("Error starting port %d: %s\n",
+		       port, rte_strerror(-ret));
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Wait until both ports report link up, i.e. the peers have connected. */
+static int
+wait_for_link_pair(int p0, int p1)
+{
+	struct rte_eth_link l0, l1;
+	int i;
+
+	for (i = 0; i < CONNECT_TRIES; i++) {
+		if (rte_eth_link_get_nowait(p0, &l0) == 0 &&
+		    rte_eth_link_get_nowait(p1, &l1) == 0 &&
+		    l0.link_status == RTE_ETH_LINK_UP &&
+		    l1.link_status == RTE_ETH_LINK_UP)
+			return 0;
+		usleep(CONNECT_DELAY_US);
+	}
+	return -1;
+}
+
+static int
+wait_for_link(void)
+{
+	return wait_for_link_pair(memif_srv_port, memif_cli_port);
+}
+
+static struct rte_mbuf *
+create_test_packet(uint16_t pkt_len, uint8_t seed)
+{
+	struct rte_mbuf *mbuf;
+	struct rte_ether_hdr *eth_hdr;
+	uint8_t *payload;
+	uint16_t i;
+
+	mbuf = rte_pktmbuf_alloc(mp);
+	if (mbuf == NULL)
+		return NULL;
+
+	if (pkt_len < RTE_ETHER_MIN_LEN)
+		pkt_len = RTE_ETHER_MIN_LEN;
+
+	eth_hdr = (struct rte_ether_hdr *)rte_pktmbuf_append(mbuf, pkt_len);
+	if (eth_hdr == NULL) {
+		rte_pktmbuf_free(mbuf);
+		return NULL;
+	}
+
+	memset(&eth_hdr->dst_addr, 0xFF, RTE_ETHER_ADDR_LEN);
+	memset(&eth_hdr->src_addr, 0x02, RTE_ETHER_ADDR_LEN);
+	eth_hdr->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+
+	payload = (uint8_t *)(eth_hdr + 1);
+	for (i = 0; i < pkt_len - sizeof(*eth_hdr); i++)
+		payload[i] = (uint8_t)(seed + i);
+
+	return mbuf;
+}
+
+static int
+test_memif_dev_info(void)
+{
+	struct rte_eth_dev_info dev_info;
+	int ret;
+
+	ret = rte_eth_dev_info_get(memif_srv_port, &dev_info);
+	TEST_ASSERT(ret == 0, "dev_info_get failed: %s", rte_strerror(-ret));
+	TEST_ASSERT(strcmp(dev_info.driver_name, "net_memif") == 0,
+		    "unexpected driver name: %s", dev_info.driver_name);
+	return TEST_SUCCESS;
+}
+
+static int
+test_memif_link_up(void)
+{
+	/* The pair must have connected during setup. */
+	TEST_ASSERT(wait_for_link() == 0,
+		    "memif server/client did not reach link up");
+	return TEST_SUCCESS;
+}
+
+static int
+test_memif_stats_get(void)
+{
+	struct rte_eth_stats stats;
+
+	TEST_ASSERT(rte_eth_stats_get(memif_srv_port, &stats) == 0,
+		    "stats_get failed for server port");
+	TEST_ASSERT(rte_eth_stats_get(memif_cli_port, &stats) == 0,
+		    "stats_get failed for client port");
+	return TEST_SUCCESS;
+}
+
+static int
+test_memif_stats_reset(void)
+{
+	struct rte_eth_stats stats;
+
+	TEST_ASSERT(rte_eth_stats_reset(memif_srv_port) == 0,
+		    "stats_reset failed");
+	TEST_ASSERT(rte_eth_stats_get(memif_srv_port, &stats) == 0,
+		    "stats_get after reset failed");
+	TEST_ASSERT(stats.ipackets == 0 && stats.opackets == 0 &&
+		    stats.ibytes == 0 && stats.obytes == 0,
+		    "stats not zero after reset");
+	return TEST_SUCCESS;
+}
+
+/*
+ * Send a burst from the client and receive it on the server, verifying the
+ * payload is delivered intact. This exercises the Rx/Tx data path over the
+ * connected memif pair.
+ */
+static int
+test_memif_send_receive(void)
+{
+	struct rte_mbuf *tx[MAX_PKT_BURST];
+	struct rte_mbuf *rx[MAX_PKT_BURST];
+	const uint16_t nb = MAX_PKT_BURST / 2;
+	uint16_t nb_tx, nb_rx, got;
+	int i, tries;
+
+	TEST_ASSERT(wait_for_link() == 0, "link not up before send/receive");
+
+	for (i = 0; i < nb; i++) {
+		tx[i] = create_test_packet(PKT_LEN, (uint8_t)i);
+		if (tx[i] == NULL) {
+			while (--i >= 0)
+				rte_pktmbuf_free(tx[i]);
+			TEST_ASSERT(0, "failed to build test packet");
+		}
+	}
+
+	nb_tx = rte_eth_tx_burst(memif_cli_port, 0, tx, nb);
+	for (i = nb_tx; i < nb; i++)
+		rte_pktmbuf_free(tx[i]);
+	TEST_ASSERT(nb_tx > 0, "client transmitted no packets");
+
+	/* Receive may take a moment; poll a few times. */
+	got = 0;
+	for (tries = 0; tries < 10 && got < nb_tx; tries++) {
+		nb_rx = rte_eth_rx_burst(memif_srv_port, 0, rx, MAX_PKT_BURST);
+		for (i = 0; i < nb_rx; i++) {
+			/* Payload must match the position-dependent pattern. */
+			uint8_t *p = rte_pktmbuf_mtod_offset(rx[i], uint8_t *,
+					sizeof(struct rte_ether_hdr));
+			uint16_t plen = PKT_LEN -
+					sizeof(struct rte_ether_hdr);
+			uint16_t k;
+			int bad = rte_pktmbuf_pkt_len(rx[i]) != PKT_LEN;
+
+			for (k = 0; !bad && k < plen; k++)
+				if (p[k] != (uint8_t)(got + k))
+					bad = 1;
+			if (bad) {
+				for (k = i; k < nb_rx; k++)
+					rte_pktmbuf_free(rx[k]);
+				TEST_ASSERT(0,
+					    "packet %u payload/length mismatch",
+					    got);
+			}
+			rte_pktmbuf_free(rx[i]);
+			got++;
+		}
+		if (got < nb_tx)
+			usleep(10000);
+	}
+
+	TEST_ASSERT(got == nb_tx,
+		    "received %u packets, expected %u", got, nb_tx);
+	return TEST_SUCCESS;
+}
+
+/*
+ * Single-segment loopback on the default-bsize pair, where bsize exceeds
+ * the mbuf data room so eth_memif_tx() takes the single-pool fast path.
+ */
+static int
+test_memif_fastpath(void)
+{
+	struct rte_mbuf *tx[MAX_PKT_BURST];
+	struct rte_mbuf *rx[MAX_PKT_BURST];
+	const uint16_t nb = MAX_PKT_BURST / 2;
+	uint16_t nb_tx, got;
+	int i, tries;
+
+	TEST_ASSERT(wait_for_link_pair(memif_fp_srv_port, memif_fp_cli_port)
+		    == 0, "fast-path pair not up");
+
+	for (i = 0; i < nb; i++) {
+		tx[i] = create_test_packet(PKT_LEN, (uint8_t)i);
+		if (tx[i] == NULL) {
+			while (--i >= 0)
+				rte_pktmbuf_free(tx[i]);
+			TEST_ASSERT(0, "failed to build test packet");
+		}
+	}
+
+	nb_tx = rte_eth_tx_burst(memif_fp_cli_port, 0, tx, nb);
+	for (i = nb_tx; i < nb; i++)
+		rte_pktmbuf_free(tx[i]);
+	TEST_ASSERT(nb_tx > 0, "fast-path client transmitted no packets");
+
+	got = 0;
+	for (tries = 0; tries < 10 && got < nb_tx; tries++) {
+		uint16_t nb_rx = rte_eth_rx_burst(memif_fp_srv_port, 0, rx,
+						  MAX_PKT_BURST);
+		for (i = 0; i < nb_rx; i++) {
+			TEST_ASSERT(rte_pktmbuf_pkt_len(rx[i]) == PKT_LEN,
+				    "fast-path packet wrong length");
+			rte_pktmbuf_free(rx[i]);
+			got++;
+		}
+		if (got < nb_tx)
+			usleep(10000);
+	}
+
+	TEST_ASSERT(got == nb_tx, "fast-path received %u expected %u",
+		    got, nb_tx);
+	return TEST_SUCCESS;
+}
+
+static int
+test_memif_stop_start(void)
+{
+	TEST_ASSERT(rte_eth_dev_stop(memif_cli_port) == 0,
+		    "stop client failed");
+	TEST_ASSERT(rte_eth_dev_start(memif_cli_port) == 0,
+		    "restart client failed");
+	/* After a restart the pair must reconnect. */
+	TEST_ASSERT(wait_for_link() == 0, "link did not recover after restart");
+	return TEST_SUCCESS;
+}
+
+/*
+ * A zero-length Tx burst must be accepted and return 0 without touching
+ * the (empty) mbuf array. Regression test for the empty-burst guard in
+ * eth_memif_tx().
+ */
+static int
+test_memif_tx_empty_burst(void)
+{
+	struct rte_mbuf *dummy = NULL;
+
+	TEST_ASSERT(wait_for_link() == 0, "link not up before empty burst");
+	TEST_ASSERT(rte_eth_tx_burst(memif_cli_port, 0, &dummy, 0) == 0,
+		    "zero-length Tx burst did not return 0");
+	return TEST_SUCCESS;
+}
+
+/*
+ * A server port that accepted a peer while stopped (or never started) must
+ * tear down its control channel on close. memif_msg_receive_init() binds
+ * pmd->cc without checking dev_started, so a client is connected to the
+ * unstarted throwaway server to make its cc live. Regression test for the
+ * disconnect-on-close fix; uses throwaway devices so the suite pair stays
+ * intact.
+ */
+static int
+test_memif_close_without_stop(void)
+{
+	int sport, cport, ret;
+	struct rte_eth_conf port_conf;
+
+	ret = rte_vdev_init("net_memif_test_tmps",
+			    "role=server,id=1,socket-abstract=yes,socket=memif-autotest-tmp");
+	if (ret < 0) {
+		printf("could not create throwaway server: %s\n",
+		       rte_strerror(-ret));
+		return TEST_FAILED;
+	}
+
+	sport = find_port("net_memif_test_tmps");
+	if (sport < 0) {
+		rte_vdev_uninit("net_memif_test_tmps");
+		TEST_ASSERT(0, "throwaway server port not found");
+	}
+
+	/* Configure but do not start: close is rejected on a started port. */
+	memset(&port_conf, 0, sizeof(port_conf));
+	ret = rte_eth_dev_configure(sport, 1, 1, &port_conf);
+	if (ret < 0) {
+		rte_vdev_uninit("net_memif_test_tmps");
+		TEST_ASSERT(0, "configure of throwaway server failed: %s",
+			    rte_strerror(-ret));
+	}
+
+	/* Client connects, so the stopped server binds pmd->cc. */
+	ret = rte_vdev_init("net_memif_test_tmpc",
+			    "role=client,id=1,socket-abstract=yes,socket=memif-autotest-tmp");
+	if (ret < 0) {
+		rte_vdev_uninit("net_memif_test_tmps");
+		TEST_ASSERT(0, "could not create throwaway client: %s",
+			    rte_strerror(-ret));
+	}
+	cport = find_port("net_memif_test_tmpc");
+	if (cport < 0 || configure_port(cport) < 0) {
+		rte_vdev_uninit("net_memif_test_tmpc");
+		rte_vdev_uninit("net_memif_test_tmps");
+		TEST_ASSERT(0, "throwaway client setup failed");
+	}
+	usleep(CONNECT_DELAY_US);	/* let the server accept and bind cc */
+
+	/* Close the stopped server with a live cc; must not crash or leak. */
+	ret = rte_eth_dev_close(sport);
+	rte_eth_dev_stop(cport);
+	rte_eth_dev_close(cport);
+	rte_vdev_uninit("net_memif_test_tmpc");
+	rte_vdev_uninit("net_memif_test_tmps");
+	TEST_ASSERT(ret == 0, "close without stop failed: %s",
+		    rte_strerror(-ret));
+
+	return TEST_SUCCESS;
+}
+
+#define BIG_PKT_LEN 4000	/* > bsize (512) => chained descriptors */
+#define BIG_SEG_LEN 1000	/* each mbuf segment carries this many bytes */
+/* ~8 descriptors per packet; enough to wrap the 2^MEMIF_LOG2_RING ring */
+#define WRAP_PKTS ((1 << MEMIF_LOG2_RING) / 8 + 8)
+
+/*
+ * Build a multi-segment mbuf of pkt_len bytes, chaining as many pool mbufs
+ * as needed (BIG_SEG_LEN bytes each) with a position-dependent pattern.
+ */
+static struct rte_mbuf *
+create_big_packet(uint16_t pkt_len, uint8_t seed)
+{
+	struct rte_mbuf *head = NULL, *tail = NULL;
+	uint16_t done = 0;
+
+	while (done < pkt_len) {
+		struct rte_mbuf *seg = rte_pktmbuf_alloc(mp);
+		uint16_t seg_len = RTE_MIN((uint16_t)BIG_SEG_LEN,
+					   (uint16_t)(pkt_len - done));
+		uint8_t *data;
+		uint16_t i;
+
+		if (seg == NULL) {
+			rte_pktmbuf_free(head);
+			return NULL;
+		}
+		data = (uint8_t *)rte_pktmbuf_append(seg, seg_len);
+		for (i = 0; i < seg_len; i++)
+			data[i] = (uint8_t)(seed + done + i);
+
+		if (head == NULL) {
+			head = seg;
+			tail = seg;
+		} else {
+			tail->next = seg;
+			tail = seg;
+			head->nb_segs++;
+			head->pkt_len += seg_len;
+		}
+		done += seg_len;
+	}
+	return head;
+}
+
+/* Verify a received packet's payload, walking its segment chain. */
+static int
+check_big_packet(struct rte_mbuf *m, uint16_t pkt_len, uint8_t seed)
+{
+	uint16_t off = 0;
+	struct rte_mbuf *seg;
+
+	if (rte_pktmbuf_pkt_len(m) != pkt_len)
+		return -1;
+	for (seg = m; seg != NULL; seg = seg->next) {
+		const uint8_t *data = rte_pktmbuf_mtod(seg, const uint8_t *);
+		uint16_t i;
+
+		for (i = 0; i < rte_pktmbuf_data_len(seg); i++, off++)
+			if (data[i] != (uint8_t)(seed + off))
+				return -1;
+	}
+	return off == pkt_len ? 0 : -1;
+}
+
+/*
+ * Send multi-segment packets larger than the memif buffer size, repeated
+ * enough to wrap the ring, and verify each is delivered intact. Exercises
+ * the chained-descriptor Rx and Tx paths across a ring wrap.
+ */
+static int
+test_memif_multiseg(void)
+{
+	unsigned int sent = 0, recv = 0;
+	unsigned int iter;
+
+	TEST_ASSERT(wait_for_link() == 0, "link not up before multiseg test");
+
+	for (iter = 0; iter < WRAP_PKTS; iter++) {
+		struct rte_mbuf *tx, *rx[MAX_PKT_BURST];
+		uint16_t n, j;
+		int tries;
+
+		tx = create_big_packet(BIG_PKT_LEN, (uint8_t)iter);
+		TEST_ASSERT(tx != NULL, "failed to build big packet %u", iter);
+		if (tx->nb_segs <= 1) {
+			rte_pktmbuf_free(tx);
+			TEST_ASSERT(0, "test packet is not multi-segment");
+		}
+
+		if (rte_eth_tx_burst(memif_cli_port, 0, &tx, 1) != 1) {
+			rte_pktmbuf_free(tx);
+			continue;
+		}
+		sent++;
+
+		for (tries = 0; tries < 10; tries++) {
+			n = rte_eth_rx_burst(memif_srv_port, 0, rx,
+					     MAX_PKT_BURST);
+			for (j = 0; j < n; j++) {
+				if (check_big_packet(rx[j], BIG_PKT_LEN,
+						(uint8_t)recv) != 0) {
+					uint16_t k;
+					for (k = j; k < n; k++)
+						rte_pktmbuf_free(rx[k]);
+					TEST_ASSERT(0,
+						"multi-seg payload corrupted at pkt %u",
+						recv);
+				}
+				rte_pktmbuf_free(rx[j]);
+				recv++;
+			}
+			if (recv >= sent)
+				break;
+			usleep(2000);
+		}
+	}
+
+	TEST_ASSERT(recv == sent,
+		    "multi-seg: sent %u received %u", sent, recv);
+	return TEST_SUCCESS;
+}
+
+static void
+test_memif_cleanup(void)
+{
+	if (memif_srv_port >= 0) {
+		rte_eth_dev_stop(memif_srv_port);
+		rte_eth_dev_close(memif_srv_port);
+	}
+	if (memif_cli_port >= 0) {
+		rte_eth_dev_stop(memif_cli_port);
+		rte_eth_dev_close(memif_cli_port);
+	}
+	if (memif_fp_srv_port >= 0) {
+		rte_eth_dev_stop(memif_fp_srv_port);
+		rte_eth_dev_close(memif_fp_srv_port);
+	}
+	if (memif_fp_cli_port >= 0) {
+		rte_eth_dev_stop(memif_fp_cli_port);
+		rte_eth_dev_close(memif_fp_cli_port);
+	}
+	rte_vdev_uninit(MEMIF_SRV_NAME);
+	rte_vdev_uninit(MEMIF_CLI_NAME);
+	rte_vdev_uninit(MEMIF_FP_SRV_NAME);
+	rte_vdev_uninit(MEMIF_FP_CLI_NAME);
+	if (mp != NULL) {
+		rte_mempool_free(mp);
+		mp = NULL;
+	}
+	memif_srv_port = -1;
+	memif_cli_port = -1;
+	memif_fp_srv_port = -1;
+	memif_fp_cli_port = -1;
+}
+
+static int
+test_memif_setup(void)
+{
+	int ret;
+
+	mp = rte_pktmbuf_pool_create("memif_test_pool", NB_MBUF, 32, 0,
+				     RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+	if (mp == NULL) {
+		printf("Error: failed to create mempool: %s\n",
+		       rte_strerror(rte_errno));
+		return -1;
+	}
+
+	ret = rte_vdev_init(MEMIF_SRV_NAME, MEMIF_SRV_ARGS);
+	if (ret < 0) {
+		printf("Error: failed to create memif server: %s\n",
+		       rte_strerror(-ret));
+		rte_mempool_free(mp);
+		mp = NULL;
+		return TEST_FAILED;
+	}
+
+	ret = rte_vdev_init(MEMIF_CLI_NAME, MEMIF_CLI_ARGS);
+	if (ret < 0) {
+		printf("Error: failed to create memif client: %s\n",
+		       rte_strerror(-ret));
+		rte_vdev_uninit(MEMIF_SRV_NAME);
+		rte_mempool_free(mp);
+		mp = NULL;
+		return -1;
+	}
+
+	memif_srv_port = find_port(MEMIF_SRV_NAME);
+	memif_cli_port = find_port(MEMIF_CLI_NAME);
+	if (memif_srv_port < 0 || memif_cli_port < 0) {
+		printf("Error: failed to find memif ports\n");
+		test_memif_cleanup();
+		return -1;
+	}
+
+	if (configure_port(memif_srv_port) < 0 ||
+	    configure_port(memif_cli_port) < 0) {
+		test_memif_cleanup();
+		return -1;
+	}
+
+	/* Second pair with default bsize to exercise the Tx fast path. */
+	if (rte_vdev_init(MEMIF_FP_SRV_NAME, MEMIF_FP_SRV_ARGS) < 0 ||
+	    rte_vdev_init(MEMIF_FP_CLI_NAME, MEMIF_FP_CLI_ARGS) < 0) {
+		printf("Error: failed to create fast-path memif pair\n");
+		test_memif_cleanup();
+		return TEST_FAILED;
+	}
+
+	memif_fp_srv_port = find_port(MEMIF_FP_SRV_NAME);
+	memif_fp_cli_port = find_port(MEMIF_FP_CLI_NAME);
+	if (memif_fp_srv_port < 0 || memif_fp_cli_port < 0) {
+		printf("Error: failed to find fast-path memif ports\n");
+		test_memif_cleanup();
+		return TEST_FAILED;
+	}
+
+	if (configure_port(memif_fp_srv_port) < 0 ||
+	    configure_port(memif_fp_cli_port) < 0) {
+		test_memif_cleanup();
+		return -1;
+	}
+
+	return 0;
+}
+
+static struct unit_test_suite test_pmd_memif_suite = {
+	.setup = test_memif_setup,
+	.teardown = test_memif_cleanup,
+	.suite_name = "memif PMD Unit Test Suite",
+	.unit_test_cases = {
+		TEST_CASE(test_memif_dev_info),
+		TEST_CASE(test_memif_link_up),
+		TEST_CASE(test_memif_stats_get),
+		TEST_CASE(test_memif_send_receive),
+		TEST_CASE(test_memif_fastpath),
+		TEST_CASE(test_memif_multiseg),
+		TEST_CASE(test_memif_stats_reset),
+		TEST_CASE(test_memif_stop_start),
+		TEST_CASE(test_memif_tx_empty_burst),
+		TEST_CASE(test_memif_close_without_stop),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_pmd_memif(void)
+{
+	return unit_test_suite_runner(&test_pmd_memif_suite);
+}
+
+#endif /* RTE_EXEC_ENV_LINUX */
+
+REGISTER_FAST_TEST(memif_pmd_autotest, NOHUGE_OK, ASAN_OK, test_pmd_memif);
-- 
2.43.7

