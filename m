Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82088606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mTJLySrO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9210E402DF;
	Tue, 17 Nov 2026 23:00:32 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mails.dpdk.org (Postfix) with ESMTPS id B2003400D5
 for <dev@dpdk.org>; Tue, 17 Nov 2026 23:00:31 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so137180f8f.1
 for <dev@dpdk.org>; Tue, 17 Nov 2026 14:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794952831; x=1795557631; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yTxQWNateC9VUG1cbIchPq/S6Y0EBlhsW8VVRDT3aOg=;
 b=mTJLySrOxMJWE2KVqZXd+m8+3jpXFRDfNArsPuZZFURt0wO+95iaWbRnZHwrP1dgHb
 GZqJcjeM965lTn5SfZ6L0kGk7pIC24MAKGOvgIr8+ohksfgcCMDHraDRoyUVhtWJVeiS
 aYpWxcPz/u6uebqVBGhDzpBQLHjplIbKxSzG7TEMufXBPiL8lmcRjfVqfyFt+xk3NXim
 7JmIzEDGwxnC6oOPPntQkZqF09VDmT6mPLasI47x/7GfskfaMiB9srgjGv1IITILn3EQ
 LCY8QDBleTtN3MpC7cYZ3hAFPnAls2pX/+Jpz41t3AewRu/urTneRJMnNIE/QZdyD38Z
 EHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794952831; x=1795557631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yTxQWNateC9VUG1cbIchPq/S6Y0EBlhsW8VVRDT3aOg=;
 b=owuHx7YNWuV9jmuqYMSMjfmZKV8zQQOZZWEhDY3gvgFMzdQ5EZkUWrLZej0o4tyVUa
 Xi/WP4wVxRG+qHrJvVUvwnHI4gDdL7mDQ3BlrxffjEYGqVgXBo5y6upEFBdiZFeunKUO
 aV8zOCGXsx3PYp1gpT3cJTESwuBd2PYXwH7fEN3AXm2iQ1e7YS+iZVvBoK3FSybZUabT
 nH13q0qz/ddC1cgXlAT1pniqEAm8moU0OzeOQ9YQ+8tQZjmU1Pj8COI9mLHko3K6fguN
 wiYEWDhOGBgsNEM3ZoHsp/b/3oEKwBydg5Ms/2xHIc11g/zKdwWYrmzKDIvXXXHkC+XR
 5Ymw==
X-Gm-Message-State: APuU4Z+jmjobJkowhbT1fJ6BxUwU2FA+qNsjA1xa2QmSmcBv2rvBzsdw
 sDKrlfvzokDPmawPS9BbPAJdA1ma3pPLuReIYm2YTcXJL01rlODCZ9nt
X-Gm-Gg: AZFdTZdrvw2e7Ps3EQ9YqpqDy4Gts/x1g6KnoyM1R1+/XEpCcwulXqMJIqkuEnRrq+l
 L55mR3ePagrJ1DbpxRl31X0smsxu/gEemxkCVgoRhIbTJ2zFuIpsrdQnwg8fnov12Wedah/wPs3
 CiuaPC9eqxWwcPD26f5+Z1Ql/qka4Db0RYnU5LIvOISjbP5/PBZtjei+mnLC7uKaBSpZGL2zgC3
 fusW4johJdgzXNR4XbhwZse5efq+rddB2tnm6ofW/JwatrIohPdImAszj/esWmWbPKIqTry+Kd/
 1NGr/o1IMPLwouH2x8juHBCAEQdE/pWLzcb6t4/BDiZ6tC7cZK32785VDq+Iz8gAYFkz4VlgaxV
 Fc5qzO6EuEFMAF5EcHCvXymrGqHLQRcm5J6LzBz+THDxcF1Bp90oucPDYwPJioq/UfqSOy3OPOO
 wjTWCXY3+e7Y1GPHBR5CTZVjfSv4jzA4L837Xop9D8r30cWE8ikvKgi6j+WbANzQfQY2aI7Juy7
 z8d3j9UFERXxKNnycJexVyu1/xhu6mz3c3/kr8miqMZOM6gzpAbwlznlD/wM/lX2MCOqquzG8qd
 0Uwe6Zqcez1koVo/XeK6
X-Received: by 2002:a5d:5888:0:b0:498:88f:14c8 with SMTP id
 ffacd0b85a97d-4a6389ec6f0mr1694587f8f.9.1794952830901; 
 Tue, 17 Nov 2026 14:00:30 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm1011390f8f.18.2026.11.17.14.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 14:00:29 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v2 2/5] test/virtio_user: add unit test of Rx interrupts
Date: Tue, 17 Nov 2026 23:59:58 +0200
Message-ID: <20261117220001.965310-3-iboukris@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117220001.965310-1-iboukris@gmail.com>
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261117220001.965310-1-iboukris@gmail.com>
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
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a test suite for the virtio PMD on a virtio-user port backed by
vhost-net and a TAP interface, modeled on the test suite of the TAP
PMD. It needs no VM and no PCI device. It is skipped where the port
cannot be created (no root, no /dev/vhost-net).

The first case configures the port with Rx interrupts and an Rx
offload. It enables the interrupt of the Rx queue, sends a frame from
the kernel and sleeps on the interrupt. The frame must end the sleep.
Then it does the same after a second configure.

The port has two queue pairs and the test configures one Rx queue, so
the port has more interrupt eventfds than Rx queues. These eventfds
are the backend's call fds, and the driver must not release them. If
it does when it initializes the device again, the test fails.

  DPDK_TEST=virtio_user_pmd_autotest ./build/app/dpdk-test --no-huge

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
 MAINTAINERS                     |   1 +
 app/test/meson.build            |   1 +
 app/test/test_pmd_virtio_user.c | 296 ++++++++++++++++++++++++++++++++
 3 files changed, 298 insertions(+)
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
index 0000000000..d62ce000fb
--- /dev/null
+++ b/app/test/test_pmd_virtio_user.c
@@ -0,0 +1,296 @@
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
+#include <rte_epoll.h>
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_mbuf.h>
+
+#define VDEV_NAME "net_virtio_user_test"
+#define TAP_NAME "dtap_vu_test"
+#define RING_SIZE 256
+#define NB_MBUF 1024
+#define BURST 32
+#define WAIT_MS 1000
+/* The test frames' EtherType (IEEE 802 local experimental) */
+#define TEST_ETHER_TYPE 0x88b5
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
+/* A frame from the kernel's end to the port, recognized by its EtherType. */
+static int
+kernel_send(void)
+{
+	struct {
+		struct virtio_net_hdr vnet; /* no offload */
+		struct rte_ether_hdr eth;
+		uint8_t payload[RTE_ETHER_MIN_LEN];
+	} frame;
+	ssize_t n;
+
+	memset(&frame, 0, sizeof(frame));
+	memset(&frame.eth.dst_addr, 0xff, RTE_ETHER_ADDR_LEN);
+	frame.eth.src_addr.addr_bytes[0] = RTE_ETHER_LOCAL_ADMIN_ADDR;
+	frame.eth.ether_type = rte_cpu_to_be_16(TEST_ETHER_TYPE);
+	n = send(ksock, &frame, sizeof(frame), 0);
+	TEST_ASSERT(n == (ssize_t)sizeof(frame), "send on %s failed: %s", TAP_NAME,
+		    strerror(errno));
+
+	return TEST_SUCCESS;
+}
+
+/* Receive what the queue holds. Return true if it holds the frame of kernel_send(). */
+static bool
+port_receive(void)
+{
+	struct rte_mbuf *pkts[BURST];
+	bool found = false;
+	uint16_t i, n;
+
+	while ((n = rte_eth_rx_burst(port_id, 0, pkts, BURST)) != 0) {
+		for (i = 0; i < n; i++) {
+			const struct rte_ether_hdr *eth =
+				rte_pktmbuf_mtod(pkts[i], const struct rte_ether_hdr *);
+
+			if (eth->ether_type == rte_cpu_to_be_16(TEST_ETHER_TYPE))
+				found = true;
+		}
+		rte_pktmbuf_free_bulk(pkts, n);
+	}
+
+	return found;
+}
+
+/* Sleep on the Rx queue's interrupt. A frame from the kernel must end the sleep. */
+static int
+rx_intr_wakes(void)
+{
+	uint64_t deadline = rte_get_timer_cycles() + rte_get_timer_hz() * WAIT_MS / 1000;
+	struct rte_epoll_event event;
+	bool found;
+	int ret;
+
+	ret = rte_eth_dev_rx_intr_ctl_q(port_id, 0, RTE_EPOLL_PER_THREAD, RTE_INTR_EVENT_ADD,
+					NULL);
+	TEST_ASSERT_SUCCESS(ret, "no interrupt for the Rx queue: %s", rte_strerror(-ret));
+
+	do {
+		/*
+		 * Enable the interrupt before the kernel sends. A frame that
+		 * arrives from now on raises it, also before the sleep below.
+		 */
+		ret = rte_eth_dev_rx_intr_enable(port_id, 0);
+		TEST_ASSERT_SUCCESS(ret, "Rx interrupt enable failed: %s", rte_strerror(-ret));
+		/* Drop the frames that the kernel sent earlier, and their event. */
+		port_receive();
+		rte_epoll_wait(RTE_EPOLL_PER_THREAD, &event, 1, 0);
+
+		TEST_ASSERT_SUCCESS(kernel_send(), "kernel send failed");
+		ret = rte_epoll_wait(RTE_EPOLL_PER_THREAD, &event, 1, WAIT_MS);
+		TEST_ASSERT(ret == 1, "no Rx interrupt within %d ms", WAIT_MS);
+		ret = rte_eth_dev_rx_intr_disable(port_id, 0);
+		TEST_ASSERT_SUCCESS(ret, "Rx interrupt disable failed: %s", rte_strerror(-ret));
+		/* If another frame of the kernel raised the interrupt, send again. */
+		found = port_receive();
+	} while (!found && rte_get_timer_cycles() < deadline);
+	TEST_ASSERT(found, "frame from the kernel not received");
+
+	ret = rte_eth_dev_rx_intr_ctl_q(port_id, 0, RTE_EPOLL_PER_THREAD, RTE_INTR_EVENT_DEL,
+					NULL);
+	TEST_ASSERT_SUCCESS(ret, "Rx interrupt removal failed: %s", rte_strerror(-ret));
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Rx interrupts with an offload, which makes configure initialize the device
+ * twice. Then a second configure. The interrupt eventfds belong to the
+ * backend, so the driver must not release them when it initializes the
+ * device again.
+ */
+static int
+test_virtio_user_rx_intr(void)
+{
+	struct rte_eth_conf conf = {
+		.intr_conf.rxq = 1,
+		.rxmode.offloads = RTE_ETH_RX_OFFLOAD_UDP_CKSUM | RTE_ETH_RX_OFFLOAD_TCP_CKSUM,
+	};
+	struct rte_eth_dev_info info;
+	int round, ret;
+
+	ret = rte_eth_dev_info_get(port_id, &info);
+	TEST_ASSERT_SUCCESS(ret, "dev_info failed: %s", rte_strerror(-ret));
+	conf.rxmode.offloads &= info.rx_offload_capa;
+	TEST_ASSERT(conf.rxmode.offloads != 0, "no Rx checksum offload to request");
+
+	for (round = 0; round < 2; round++) {
+		TEST_ASSERT_SUCCESS(port_start(&conf), "round %d: port start failed", round);
+		TEST_ASSERT_SUCCESS(rx_intr_wakes(), "round %d: Rx interrupt failed", round);
+		TEST_ASSERT_SUCCESS(port_stop(), "round %d: port stop failed", round);
+	}
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
+	 * The port has two queue pairs and the tests configure one Rx queue,
+	 * so the port has more interrupt eventfds than Rx queues.
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
+		TEST_CASE(test_virtio_user_rx_intr),
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

