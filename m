Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B538606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPp5wW0Z
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BF984064F;
	Wed, 18 Nov 2026 09:28:22 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by mails.dpdk.org (Postfix) with ESMTPS id 4E5814064C
 for <dev@dpdk.org>; Wed, 18 Nov 2026 09:28:20 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso4825575e9.2
 for <dev@dpdk.org>; Wed, 18 Nov 2026 00:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794990500; x=1795595300; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U75rl+vQbgeB++Hjv+0FTIzr6BVKt3xHspGQ1crJPJw=;
 b=lPp5wW0ZaKWM+OCvpaZcvsFsMgJwetFvAtAgPTEhOaxAvBAdm+QuXpLGCETYQ3FwYz
 Jw4noXsmBnDXRRH5EWzdDRJ622OV3gZ+tCn89QDZQNv4coCvq/2pRSiwuZoTFh+YPiH2
 ZVZfMKT1xxIko/qN2SrMp8ptduJ58uIufUoaEiPE8ZQYMZM4iMwkzl8rC6k/VfCxMRGE
 CrfZHM74uGy+PNyVdHGEgF3mmh9BnOlp/m8ytfkk5FBaKMSEq5o63KwUWZcDpBEPv364
 nA+uuiMKO7L2zNk8u7xkr34ErN5kd8Jf6xjjmvT8+DD7955eCRhgenPk7gd/HRm+K9hx
 01Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794990500; x=1795595300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U75rl+vQbgeB++Hjv+0FTIzr6BVKt3xHspGQ1crJPJw=;
 b=A6dSAYHfdUB5l3S88t0/EZ6g3H7Zq7VS7nfoR0UsNc+WVwwGITtnWnHiFzndRH8Q0m
 lMHMSB8CGDVZTKWxCxWAYBgcmok9YtRlf9mGZPs4ajy1+A9dkz4RpBq5dRY1EJejBnH5
 jqDi124rhMtZsg1mVLXWY2WJWJT/Z6rOj9AdwR4gLXgopyRCzM+9TCXHwOFtXrmX8GIQ
 sfpPLgb3WeW/3J/TVYGYk0R9r4PvluQvBkXBUVx1v++jV2Yhc6m6tcnocS5FCHoSXYJl
 G99oIGy1lpvSiM5SXzDRdJk1gY2/Lce/Oq+NBE0kw1u50YMGw5dlRWLrgKxg1P3EY89q
 Ks9Q==
X-Gm-Message-State: APuU4Z/OFofHin4THk7Li/RIXg3veNiaBOxS5lTQu8Oi8ht/EdYdKCvW
 dAe2X9El4lz2yOXYuAi8lzWM7bw9QEIYAJ1xavYjtABEWQqVJKZa+7kz
X-Gm-Gg: AYBFou2uoRDhkAExSkMFH7YzpTVrk0yanz02dziOkaAiNKj8CBgkDkSQqFqhRaJQ6P/
 2iaKyGUeNca2yBg/fySZinXsrKcbhdr1HMZvs+2AaELVrDF8N475Wu9Yf4zM3D9Ixay7cGd67Bp
 qfH0ri/wqTW7Us+PFtSlXa5qc9gKFcoSSpv2JZVGgrec9NNvLCzv79vANp/43R72EGFisZMEe2c
 oKehPyn5nLjl+io2UjmmG3ITCRdvoP4dMGBx3TsvfKPbGQ0w92jXjXa0/U6nj0YiljT8iO8AQmS
 Gxvz3eiRPQ1o3um4lkn6hxj1ORuwFA+lSsvh/HFC4NdrXegaikZC4g2+AoJiXtACn3jWrQ1V8aN
 w6BzCPb8nDz6kXZhRZymTjGQRvMknhpdhcluUd6MABK45deaumWdpqOubnS8LW51bQCzMTytnMF
 R56JZBtS1eZuliSGuhqpmzS6oxIP/Dw+2nEVoy/0w0+PaPqz77szvaxB34LYKc/YDeKQFXKOLVa
 sqq3MWDapg+67cZ0Rk8T+bNN/HLaZa1sUoujmc0A2yaFrcQYC6p/1O8yfUvzgdva8mWy6KA/64B
 5aKnjHlB/JXcpn07qFyyyYje161+NpAFkUeyWuOUNA==
X-Received: by 2002:a05:600c:83ca:b0:4bb:68f1:5bc0 with SMTP id
 5b1f17b1804b1-4bb7da4bef8mr28842365e9.33.1794990499750; 
 Wed, 18 Nov 2026 00:28:19 -0800 (PST)
Received: from fedora ([46.210.233.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2cfb3esm55097605e9.15.2026.11.18.00.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 00:28:19 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v4 4/8] test/virtio_user: add unit test of unused queue pairs
Date: Wed, 18 Nov 2026 10:27:48 +0200
Message-ID: <20261118082752.1043794-5-iboukris@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118082752.1043794-1-iboukris@gmail.com>
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261118082752.1043794-1-iboukris@gmail.com>
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

Add a test suite for the virtio PMD on a virtio-user port with
vhost-net, modeled on the TAP PMD's. It needs no VM and no PCI
device. It is skipped where the port cannot be created (no root, no
/dev/vhost-net).

The port has two queue pairs and the test configures one Rx queue.
The kernel sends frames of 16 flows through a packet socket on the
TAP interface, and all must arrive. Without the fix of the unused
queue pairs, about half of them go to the TAP queue of the second
queue pair and are lost.

  DPDK_TEST=virtio_user_pmd_autotest ./build/app/dpdk-test --no-huge

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
v4: ignore a flow number that is out of range. Shorter comments.
v3: new patch. It has the test suite and the kernel socket that patch 2 of v2 added.

 MAINTAINERS                     |   1 +
 app/test/meson.build            |   1 +
 app/test/test_pmd_virtio_user.c | 264 ++++++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)
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
index 0000000000..c47d5a833b
--- /dev/null
+++ b/app/test/test_pmd_virtio_user.c
@@ -0,0 +1,264 @@
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
+ * Send a frame from the kernel's end. The kernel picks the TAP queue by a hash
+ * of the frame's addresses, so the source address makes the flow.
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
+			uint8_t flow = NB_FLOWS;
+
+			if (rte_pktmbuf_data_len(pkts[i]) >= sizeof(*eth) + sizeof(*ip) &&
+			    eth->ether_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4) &&
+			    ip->next_proto_id == TEST_IP_PROTO)
+				flow = rte_be_to_cpu_32(ip->src_addr) & 0xff;
+			if (flow < NB_FLOWS)
+				flows |= UINT32_C(1) << flow;
+		}
+		rte_pktmbuf_free_bulk(pkts, n);
+	}
+
+	return flows;
+}
+
+/*
+ * The port has two queue pairs and one Rx queue. The frames of all the flows
+ * that the kernel sends must arrive on it.
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
+/* Set the TAP interface up and bind a packet socket to it. */
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
+	/* The tests use one of the two queue pairs. The TAP interface takes CAP_NET_ADMIN. */
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

