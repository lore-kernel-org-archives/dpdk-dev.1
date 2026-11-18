Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5CA606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ueY5CEph
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8D2340659;
	Wed, 18 Nov 2026 09:28:24 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mails.dpdk.org (Postfix) with ESMTPS id 007734042C
 for <dev@dpdk.org>; Wed, 18 Nov 2026 09:28:22 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso6601125e9.3
 for <dev@dpdk.org>; Wed, 18 Nov 2026 00:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794990502; x=1795595302; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3+1dV8fGXdiravRFMediDYm+vcux664br3W72jQnJEA=;
 b=ueY5CEph0E2qnR0TI0T9jz9UITHBpYOgJ2ZSlsUkXXjk3Bx/lV3kO//Ik5feg4p1Ae
 +blSzn0GGB2qIPF2WDsaRrsZQfH/p7b/ZNejoE43vNN6082mqG8u0+2os0zgXL+z0ylE
 1KQm3d9Y1nRvT/FqfjOEP1v/m++VY2ybAhubOSlvboEV0w6L8aveYQMOtkfm5TCbAHNH
 ZDBSI3o6X0DClY0Y2T9qyT6IWaE+LToVfFg/+OMzgUJb6rxbe06LGo/hbxNOm1ptQ27K
 VM6O38/MRhzZful6zWco8Ko6SsP/e1UEq8Cd2TwWd/icz2akDDNyGbzpYGHkSLGnA6dO
 jGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794990502; x=1795595302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3+1dV8fGXdiravRFMediDYm+vcux664br3W72jQnJEA=;
 b=wtJ7dqdTXZDrQ+XTjgaNNmJ/y81T2qTkO9utP5yO9e66y/2xFzXiRi+yoZqKCGssst
 jvUsVMQvBASwB+5MmCGg9jOulAZ2Jmk9lLzTJebNGzIaiN0DH2zI6IFKd38KuhEgHdSI
 Avp8Bd5LI+b2uP2/p/gfYdZV1dAYXeYcEbpZtVSkl1zes4tQijWW7rkUGrynyEAo00Kk
 o5Tr5Qnpii83HCJFyIUaPMN3JydfbmDoBbOtlcYbE8iiRrQaooRS6iZHPmlnMVEqTR1j
 b21zJYLPNknIDpeJLMvexVAwMfM650ulaJp+DtjDCJ0AyUrGZO8XZnxjxdnQQv59XZcQ
 n84A==
X-Gm-Message-State: APuU4Z9yme980FeC67F6mHmijtJmXEfQbJ12LHteMbCPgyYH/KZ4duqZ
 5MKYw0dOhvHLcpAspSGbK1M+dx73o7IQOhAPtF5FOV1TLwIKtEEj1a80
X-Gm-Gg: AYBFou0p2PR6qsxpT5S2zqxcgC0iV97PBMPzAob38cI58DWVS64PLMlpK1XiVURmqxm
 sp5uNaRj5IWJQ8TLvXOEQmrrQD3NxOvXdctatR7aVmxSDTpliMZhJu+FpugFOD3g5idQy8fDN9y
 pgHtxZYZfSJRcH74aZGZAhQ5IwfMdaRWMCeTLRCUzumLIyfVsRl8XMXIP/OWB4L7tX7bNF6/KXZ
 HUyYaLYqvzMvSJUfgyJpdihln1rysoMbJG2MgmXAmW8ntk90Ez2bc7ZGZjNNDoARgdhVEYo3NF6
 U8fXIXClofK8M3NThoQuK4y2SY4eU/hKPGALVjTsUwVuAL9K8efkrcvzFTp9I+50L0mcp9vtMV4
 L7qYQzVnsIWP31fTtq5iuc4qpRsW8VVG8xNXAcdcOTUMLR4DKzAhL12J83SS57qoUCj/3d1pk4R
 ZhggwAuW0hUlI5CzeTp2wee5NGiO3BryohrkBn/N5uVnuZe4UoTf637i8jtOG5rD8tg7haUGMFB
 TKF8Tc2EVcjjpf/+jBmYWe5btoSLVp3ZFV7Ji60Wm/7gZ3J51JUyLNiL9SqJkMDdR3vUvVggXKR
 VbMAIrGpwDY9/2PKU6LH
X-Received: by 2002:a05:600c:5008:b0:4b1:4017:c4f4 with SMTP id
 5b1f17b1804b1-4bb7da2709fmr32753725e9.20.1794990502409; 
 Wed, 18 Nov 2026 00:28:22 -0800 (PST)
Received: from fedora ([46.210.233.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2cfb3esm55097605e9.15.2026.11.18.00.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 00:28:21 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v4 5/8] test/virtio_user: add unit test of Rx interrupts
Date: Wed, 18 Nov 2026 10:27:49 +0200
Message-ID: <20261118082752.1043794-6-iboukris@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Configure the port with Rx interrupts and an Rx offload, enable the
interrupt of the Rx queue, send a frame from the kernel and sleep on
the interrupt. The frame must end the sleep. Do the same after a
second configure.

The port has two queue pairs and one Rx queue, so it has more
interrupt eventfds than Rx queues. They are the backend's call fds.
If the driver releases them when it initializes the device again,
the test fails.

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
v4: ask for the Rx offload without checking the capability first. Shorter comments.
v3: on top of the previous patch. The test frame is now an IPv4 one.

 app/test/test_pmd_virtio_user.c | 63 +++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/app/test/test_pmd_virtio_user.c b/app/test/test_pmd_virtio_user.c
index c47d5a833b..f70f0c3d7f 100644
--- a/app/test/test_pmd_virtio_user.c
+++ b/app/test/test_pmd_virtio_user.c
@@ -34,6 +34,7 @@ test_pmd_virtio_user(void)
 
 #include <rte_bus_vdev.h>
 #include <rte_cycles.h>
+#include <rte_epoll.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_ip.h>
@@ -174,6 +175,67 @@ test_virtio_user_rx_flows(void)
 	return TEST_SUCCESS;
 }
 
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
+		/* From here on a frame raises the interrupt, also before the sleep below. */
+		ret = rte_eth_dev_rx_intr_enable(port_id, 0);
+		TEST_ASSERT_SUCCESS(ret, "Rx interrupt enable failed: %s", rte_strerror(-ret));
+		/* Drop the frames that the kernel sent earlier, and their event. */
+		port_receive();
+		rte_epoll_wait(RTE_EPOLL_PER_THREAD, &event, 1, 0);
+
+		TEST_ASSERT_SUCCESS(kernel_send(0), "kernel send failed");
+		ret = rte_epoll_wait(RTE_EPOLL_PER_THREAD, &event, 1, WAIT_MS);
+		TEST_ASSERT(ret == 1, "no Rx interrupt within %d ms", WAIT_MS);
+		ret = rte_eth_dev_rx_intr_disable(port_id, 0);
+		TEST_ASSERT_SUCCESS(ret, "Rx interrupt disable failed: %s", rte_strerror(-ret));
+		/* If another frame of the kernel raised the interrupt, send again. */
+		found = port_receive() != 0;
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
+ * Configure with Rx interrupts and an offload, which initializes the device
+ * twice, then configure again. The port has more interrupt eventfds than Rx
+ * queues. They are the backend's, so the driver must not release them.
+ */
+static int
+test_virtio_user_rx_intr(void)
+{
+	struct rte_eth_conf conf = {
+		.intr_conf.rxq = 1,
+		.rxmode.offloads = RTE_ETH_RX_OFFLOAD_UDP_CKSUM | RTE_ETH_RX_OFFLOAD_TCP_CKSUM,
+	};
+	int round;
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
 static void
 test_virtio_user_cleanup(void)
 {
@@ -249,6 +311,7 @@ static struct unit_test_suite test_pmd_virtio_user_suite = {
 	.suite_name = "virtio-user PMD Unit Test Suite",
 	.unit_test_cases = {
 		TEST_CASE(test_virtio_user_rx_flows),
+		TEST_CASE(test_virtio_user_rx_intr),
 		TEST_CASES_END()
 	}
 };
-- 
2.56.1

