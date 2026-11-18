Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49FA606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H7ayVi6I
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 630F44042C;
	Wed, 18 Nov 2026 01:19:42 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mails.dpdk.org (Postfix) with ESMTPS id A265F402F0
 for <dev@dpdk.org>; Wed, 18 Nov 2026 01:19:40 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so4211985e9.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794961180; x=1795565980; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PErsaTz8OK6TptbXTRjcl8IaLU4IXyiycl6NLv0g14Q=;
 b=H7ayVi6I+BmzebdXNSAYZyb0dGEyfGLgQlC5Vrjp5DbSayB119JGsA6R3qsaPkm32/
 nWoMPbWYC2XACf0wFN922I4o18IYNIspmPAJl3kQ1Hx8TnNdZ9oHdFwM2jC4G/iB8mfd
 bsdo7S6guNTrm+2LB+WZyq2Z2ln6G+M39whKzjQK8vEsA2kSw0HVW2X4OnizRl8G3vY/
 U052flUSuWZmWIsyMW6BiCFsK9yJk1pH39vZVCHrLmJBSYPGRffgbqVYWRVGHCXPCGI7
 fObPSSuEEsGu8W6SuuCX/BlqosTU7DTzCoT7klAcVym7OouGzmENwQ5yGZ1IJTqVlQ6i
 qcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794961180; x=1795565980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PErsaTz8OK6TptbXTRjcl8IaLU4IXyiycl6NLv0g14Q=;
 b=ZABRh6a2aXoGDptHUKyVQETa4rXQ22Tk7p62OdD9CL6X7cnLY44KyU0NWRQlrG+plQ
 kge0G7d7qPXdo0wRWOUoxt3vPxALfY+4qywixc06ljmq0A2BGHta6FshFGixoy6AEvFd
 9P28disyRduAv7Qo8ExDa6822mehrTWPvFL0vkbc5li0NFdRWuw9TpQQnTeM5Y2amz9w
 4jHBXdEdjhb/aNHivQhMZXQnMZV+SAp+KmcL+dDdxVTQZQzZJYPd1gH5smG/shDgWL5v
 OsRyMM4YLV/S0YsoNCuNaYOsWFxNFyNlfd1JL21A/bSwctXsst8fiV08DBHT/GJkMRVG
 9hfQ==
X-Gm-Message-State: APuU4Z+h7HK02iZsjvFrlFvnWzVPeThGfnXagmQ2xh2DeOFUnrblULJY
 RZoocIRPinAnIG1Xmd4O89V5Y6YGKqFT4WrkOp1jHXkMrvVUtBQNr6yf
X-Gm-Gg: AYBFou1TjGY9Huq5vgtsf0ekySBmWvB8hgJjLKH/jVitS/opCkS6IbTayBN05lcusmu
 VZqyI/1XrE3LNdWnO6MVQSs8PYtyXZ0ADrTfw7i4xesTVEECrKSZHUCcw6WEnFTS8hTZepdAr2k
 7meClA7JRu0oC7IsBj5ECNGqnrLyU6LQ2j5sUi4c0NcWXdshEdVo/EPTp6tARBhhDhUvj6KuOd8
 BK0szYPj8iq+IDr3W+u5mO/2OZ5CwMHqljvwDfbZ/PHzkQWbPG6BXW95fuKPyFncmDGyIHCnXrO
 sukaVma2Y93F0mjsae33H3e1RI7sfofmJRU7YwC6NONrvkesb2ba0eKGcOEyM7fsJ4fRB/KBBrn
 tenYGvxA7RVN/5s5D/Nx7VU1bMQlIC7x+5fpnhS7p2Zo0pXEM49BoUzkfriPhkDvKzzOVme3aOX
 +EM88tjohu1nlLiW6LNVon/PDPV6aWe5d8tMzGvLZH8gPcox0I/cKaf3iUuzBy8rY+R+etz3wSY
 1p0UtfYia8lWJiJEIpL0bvZHzYPSIoiqwaA358jr6yuoyJd0jKX/GTvehQFe0mz4B9uisiTr8Y1
 r5961g7v/nSiBCrTFrGb
X-Received: by 2002:a05:600c:c176:b0:4bb:7571:5743 with SMTP id
 5b1f17b1804b1-4bb7da39687mr16741665e9.27.1794961179932; 
 Tue, 17 Nov 2026 16:19:39 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e50e992sm4655025e9.0.2026.11.17.16.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 16:19:39 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v3 3/7] test/virtio_user: add unit test of unused queue pairs
Date: Wed, 18 Nov 2026 02:19:14 +0200
Message-ID: <20261118001918.990884-4-iboukris@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118001918.990884-1-iboukris@gmail.com>
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261118001918.990884-1-iboukris@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a test suite for the virtio PMD on a virtio-user port backed by
vhost-net and a TAP interface, modeled on the test suite of the TAP
PMD. It needs no VM and no PCI device. It is skipped where the port
cannot be created (no root, no /dev/vhost-net).

The port has two queue pairs and the test configures one Rx queue.
The first case sends frames of 16 flows from the kernel, through a
packet socket on the TAP interface. All of them must arrive on the Rx
queue. Without the fix of the unused queue pairs, the kernel sends
about half of the flows to the TAP queue of the second queue pair,
and they are lost.

  DPDK_TEST=virtio_user_pmd_autotest ./build/app/dpdk-test --no-huge

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
v3: new patch. It has the test suite and the kernel socket that patch 2 of v2 added.

 MAINTAINERS                     |   1 +
 app/test/meson.build            |   1 +
 app/test/test_pmd_virtio_user.c | 266 ++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)
 create mode 100644 app/test/test_pmd_virtio_user.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8fcb4ef5fa..36dd253f36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1106,6 +1106,7 @@ T: git://dpdk.org/next/dpdk-next-virtio
 F: drivers/net/virtio/
 F: doc/guides/nics/virtio.rst
 F: doc/guides/nics/features/virtio*.ini
+F: app/test/test_pmd_virtio_user.c
 
 Wind River AVP
 M: Steven Webster <steven.webster@windriver.com>
diff --git a/app/test/meson.build b/app/test/meson.build
index 2f1cd817cd..e480353885 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -155,6 +155,7 @@ source_file_deps = {
     'test_pmd_ring.c': ['net_ring', 'ethdev', 'bus_vdev'],
     'test_pmd_ring_perf.c': ['ethdev', 'net_ring', 'bus_vdev'],
     'test_pmd_tap.c': ['ethdev', 'net_tap', 'bus_vdev'],
+    'test_pmd_virtio_user.c': ['ethdev', 'net_virtio', 'bus_vdev'],
     'test_pmu.c': ['pmu'],
     'test_power.c': ['power', 'power_acpi', 'power_kvm_vm', 'power_intel_pstate',
         'power_amd_pstate', 'power_cppc'],
diff --git a/app/test/test_pmd_virtio_user.c b/app/test/test_pmd_virtio_user.c
new file mode 100644
index 0000000000..d8cf4f6a5d
--- /dev/null
+++ b/app/test/test_pmd_virtio_user.c
@@ -0,0 +1,266 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Isaac Boukris
+ */
+
+/*
+ * Tests of the virtio PMD on a virtio-user port backed by vhost-net and a TAP
+ * interface. They need no VM and no PCI device. The kernel's end is a packet
+ * socket on the TAP interface.
+ */
+
+#include "test.h"
+
+#include <stdio.h>
+
+#ifndef RTE_EXEC_ENV_LINUX
+
+static int
+test_pmd_virtio_user(void)
+{
+	printf("virtio-user with vhost-net is only available on Linux, skipping test\n");
+	return TEST_SKIPPED;
+}
+
+#else /* RTE_EXEC_ENV_LINUX */
+
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <net/if.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <linux/if_packet.h>
+#include <linux/virtio_net.h>
+
+#include <rte_bus_vdev.h>
+#include <rte_cycles.h>
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_mbuf.h>
+
+#define VDEV_NAME "net_virtio_user_test"
+#define TAP_NAME "dtap_vu_test"
+#define RING_SIZE 256
+#define NB_MBUF 1024
+#define BURST 32
+#define WAIT_MS 1000
+/* The test frames' IP protocol (experimental, RFC 3692) */
+#define TEST_IP_PROTO 253
+#define NB_FLOWS 16
+
+static struct rte_mempool *mp;
+static uint16_t port_id = RTE_MAX_ETHPORTS;
+static int ksock = -1; /* the kernel's end, each frame follows a virtio_net_hdr */
+static bool started;
+
+static int
+port_stop(void)
+{
+	int ret;
+
+	if (!started)
+		return TEST_SUCCESS;
+	started = false;
+	ret = rte_eth_dev_stop(port_id);
+	TEST_ASSERT_SUCCESS(ret, "stop failed: %s", rte_strerror(-ret));
+
+	return TEST_SUCCESS;
+}
+
+/* Configure the port and start it. A failed case may have left it started. */
+static int
+port_start(const struct rte_eth_conf *conf)
+{
+	int ret;
+
+	TEST_ASSERT_SUCCESS(port_stop(), "port stop failed");
+	ret = rte_eth_dev_configure(port_id, 1, 1, conf);
+	TEST_ASSERT_SUCCESS(ret, "configure failed: %s", rte_strerror(-ret));
+	ret = rte_eth_rx_queue_setup(port_id, 0, RING_SIZE, SOCKET_ID_ANY, NULL, mp);
+	TEST_ASSERT_SUCCESS(ret, "Rx queue setup failed: %s", rte_strerror(-ret));
+	ret = rte_eth_tx_queue_setup(port_id, 0, RING_SIZE, SOCKET_ID_ANY, NULL);
+	TEST_ASSERT_SUCCESS(ret, "Tx queue setup failed: %s", rte_strerror(-ret));
+	ret = rte_eth_dev_start(port_id);
+	TEST_ASSERT_SUCCESS(ret, "start failed: %s", rte_strerror(-ret));
+	started = true;
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * A frame from the kernel's end to the port. The kernel picks a queue of the
+ * TAP interface by a hash of the frame's addresses, so the source address
+ * makes the flow.
+ */
+static int
+kernel_send(uint8_t flow)
+{
+	struct {
+		struct virtio_net_hdr vnet; /* no offload */
+		struct rte_ether_hdr eth;
+		struct rte_ipv4_hdr ip;
+		uint8_t payload[RTE_ETHER_MIN_LEN];
+	} frame;
+	ssize_t n;
+
+	memset(&frame, 0, sizeof(frame));
+	memset(&frame.eth.dst_addr, 0xff, RTE_ETHER_ADDR_LEN);
+	frame.eth.src_addr.addr_bytes[0] = RTE_ETHER_LOCAL_ADMIN_ADDR;
+	frame.eth.ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+	frame.ip.version_ihl = RTE_IPV4_VHL_DEF;
+	frame.ip.total_length = rte_cpu_to_be_16(sizeof(frame.ip) + sizeof(frame.payload));
+	frame.ip.time_to_live = 64;
+	frame.ip.next_proto_id = TEST_IP_PROTO;
+	frame.ip.src_addr = rte_cpu_to_be_32(RTE_IPV4(192, 0, 2, flow));
+	frame.ip.dst_addr = rte_cpu_to_be_32(RTE_IPV4(198, 51, 100, 1));
+	frame.ip.hdr_checksum = rte_ipv4_cksum(&frame.ip);
+	n = send(ksock, &frame, sizeof(frame), 0);
+	TEST_ASSERT(n == (ssize_t)sizeof(frame), "send on %s failed: %s", TAP_NAME,
+		    strerror(errno));
+
+	return TEST_SUCCESS;
+}
+
+/* Receive what the queue holds. Return the flows of the frames of kernel_send(), a bit each. */
+static uint32_t
+port_receive(void)
+{
+	struct rte_mbuf *pkts[BURST];
+	uint32_t flows = 0;
+	uint16_t i, n;
+
+	while ((n = rte_eth_rx_burst(port_id, 0, pkts, BURST)) != 0) {
+		for (i = 0; i < n; i++) {
+			const struct rte_ether_hdr *eth =
+				rte_pktmbuf_mtod(pkts[i], const struct rte_ether_hdr *);
+			const struct rte_ipv4_hdr *ip = (const struct rte_ipv4_hdr *)(eth + 1);
+
+			if (rte_pktmbuf_data_len(pkts[i]) >= sizeof(*eth) + sizeof(*ip) &&
+			    eth->ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4) &&
+			    ip->next_proto_id == TEST_IP_PROTO)
+				flows |= UINT32_C(1) << (rte_be_to_cpu_32(ip->src_addr) & 0xff);
+		}
+		rte_pktmbuf_free_bulk(pkts, n);
+	}
+
+	return flows;
+}
+
+/*
+ * The port has two queue pairs and the test configures one Rx queue. The
+ * kernel picks a queue for each flow, so send frames of several flows. All of
+ * them must arrive on the one Rx queue.
+ */
+static int
+test_virtio_user_rx_flows(void)
+{
+	const uint32_t all = RTE_LEN2MASK(NB_FLOWS, uint32_t);
+	struct rte_eth_conf conf = { 0 };
+	uint32_t flows = 0;
+	uint64_t deadline;
+	uint8_t flow;
+
+	TEST_ASSERT_SUCCESS(port_start(&conf), "port start failed");
+	for (flow = 0; flow < NB_FLOWS; flow++)
+		TEST_ASSERT_SUCCESS(kernel_send(flow), "kernel send failed");
+	deadline = rte_get_timer_cycles() + rte_get_timer_hz() * WAIT_MS / 1000;
+	while (flows != all && rte_get_timer_cycles() < deadline)
+		flows |= port_receive();
+	TEST_ASSERT(flows == all, "received the flows 0x%x of 0x%x", flows, all);
+	TEST_ASSERT_SUCCESS(port_stop(), "port stop failed");
+
+	return TEST_SUCCESS;
+}
+
+static void
+test_virtio_user_cleanup(void)
+{
+	if (ksock >= 0)
+		close(ksock);
+	ksock = -1;
+	if (port_id != RTE_MAX_ETHPORTS) {
+		port_stop();
+		rte_eth_dev_close(port_id);
+		rte_vdev_uninit(VDEV_NAME);
+	}
+	port_id = RTE_MAX_ETHPORTS;
+	rte_mempool_free(mp);
+	mp = NULL;
+}
+
+/* Open the kernel's end. Set the TAP interface up and bind a packet socket to it. */
+static int
+kernel_open(void)
+{
+	struct sockaddr_ll addr = {
+		.sll_family = AF_PACKET,
+		.sll_protocol = htons(ETH_P_ALL),
+	};
+	struct ifreq ifr;
+	int one = 1;
+
+	ksock = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	if (ksock < 0)
+		return -1;
+	memset(&ifr, 0, sizeof(ifr));
+	strlcpy(ifr.ifr_name, TAP_NAME, sizeof(ifr.ifr_name));
+	if (ioctl(ksock, SIOCGIFFLAGS, &ifr) < 0)
+		return -1;
+	ifr.ifr_flags |= IFF_UP;
+	if (ioctl(ksock, SIOCSIFFLAGS, &ifr) < 0)
+		return -1;
+	addr.sll_ifindex = if_nametoindex(TAP_NAME);
+	if (addr.sll_ifindex == 0 ||
+	    bind(ksock, (const struct sockaddr *)&addr, sizeof(addr)) < 0 ||
+	    setsockopt(ksock, SOL_PACKET, PACKET_VNET_HDR, &one, sizeof(one)) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int
+test_virtio_user_setup(void)
+{
+	mp = rte_pktmbuf_pool_create("virtio_user_test", NB_MBUF, 32, 0,
+				     RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
+	TEST_ASSERT_NOT_NULL(mp, "mempool creation failed: %s", rte_strerror(rte_errno));
+
+	/*
+	 * The port has two queue pairs and the tests configure one Rx queue.
+	 * vhost-net creates the TAP interface, which takes root or CAP_NET_ADMIN.
+	 */
+	if (rte_vdev_init(VDEV_NAME, "path=/dev/vhost-net,iface=" TAP_NAME ",queues=2") < 0 ||
+	    rte_eth_dev_get_port_by_name(VDEV_NAME, &port_id) != 0) {
+		printf("No virtio-user port on /dev/vhost-net, skipping test\n");
+		test_virtio_user_cleanup();
+		return TEST_SKIPPED;
+	}
+	if (kernel_open() < 0) {
+		printf("No packet socket on %s (%s), skipping test\n", TAP_NAME, strerror(errno));
+		test_virtio_user_cleanup();
+		return TEST_SKIPPED;
+	}
+
+	return TEST_SUCCESS;
+}
+
+static struct unit_test_suite test_pmd_virtio_user_suite = {
+	.setup = test_virtio_user_setup,
+	.teardown = test_virtio_user_cleanup,
+	.suite_name = "virtio-user PMD Unit Test Suite",
+	.unit_test_cases = {
+		TEST_CASE(test_virtio_user_rx_flows),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_pmd_virtio_user(void)
+{
+	return unit_test_suite_runner(&test_pmd_virtio_user_suite);
+}
+
+#endif /* RTE_EXEC_ENV_LINUX */
+
+REGISTER_FAST_TEST(virtio_user_pmd_autotest, NOHUGE_OK, ASAN_OK, test_pmd_virtio_user);
-- 
2.56.1

