Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC46C606A339
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jCkqEwX1
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D42E402DE;
	Wed, 18 Nov 2026 01:19:43 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mails.dpdk.org (Postfix) with ESMTPS id 937ED40609
 for <dev@dpdk.org>; Wed, 18 Nov 2026 01:19:42 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso2986675e9.2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794961182; x=1795565982; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mNNirwodDPOLOzaVYJaCLC4h3kYVArgr6lF1ds1dx+I=;
 b=jCkqEwX1MTqP/1Ij3r8snH6zU8ZtxzzhzZA9ESIBkqNWflQza1J95NrwW7KgzWXo0l
 Pc8C4dzwx3AnJSQ6Ii+IM7VG/h4XxNOHiwcLZjdcMzI4WH9DCONE4pB6Eo/Ouv4Yzlid
 ou3hcmcLlTX+d3AINF7KZmSTLc1ksnkiX9WfCHxm54lz1QCFkEbyq0NCSL/1ZdntavlJ
 KYPDaaz0NFqJ9MiAr/RFkVsa6E+kDm09qASBXGqSCQFj6NwizYOPh5v89VGUyqc4p+Tr
 1ZyGxPNmsH5WP/2qch8U+7JKBHB673qRdzvAk76s8UEXx9+4dABQK2cv1VZB+ETWLZGZ
 ry5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794961182; x=1795565982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mNNirwodDPOLOzaVYJaCLC4h3kYVArgr6lF1ds1dx+I=;
 b=B6wUn7dNVL7EEJn2VZMWvhLKCQzfsAzLDy78McgDC3yHA145ZsTfwEc6ke212YwmL8
 7enaVlPKGa7j7zYZ/iGg7BE3o0M9Sk0ec4fCx/hQ//JmZRLTMwcldXDIXq0hHKf6VNiH
 rsp2YaHF06GfWhaeF8jVjX9NT2zxx1YLxnUuvVce9J4EE0WQDJhVeMmKMW6kmmYHUK8v
 3m2u0jrOt/P7GuGv707N8wklYa44620octg7LtpQ9jyN3qInaFUzXJb3pcjUTlcATq/i
 jCjwtinAsrWTuyVnJNmbTN4E1KvYCMZpTV9zl6NmXXlnQ6Q5BIGtZPYMpNJJ9ULdqD/2
 IOwQ==
X-Gm-Message-State: APuU4Z/YIscqovs+aNqXe7LODdeVCv93CweX0t9bX8EEw4CX1K2Sgdcq
 Z6MkYbmdE/SUxaYFyQmUxvzGdBNizkWq49yyfZS+hZvk2Vnviz1B6YW8
X-Gm-Gg: AYBFou2sJgJJGae+vP6Kln1/Ka9kCiyMZWjwN9ipIfxGetmOu4LlOJ5EzgA9gE6zzq/
 EysaqoKigKMCSU69xYZHbpjWnmp9X4tiDcWHLAxfRbpG3rF1MRlQMN/Pwb7Azh1UV7OlPZe1Q6q
 muAaqdVJP9jFxqgkZ5HtzI3f//KnApW4bDK87Yon1bqGKsA8QL7XX2zmHEXwCVMFL9qtNZ+H1zQ
 QSuDaJkaPEQ83TYOURmpmaBgAFYaSsd8vbCoGjsYxnW3QY6tT4Ex8XuSgmsYIUTmj4g3ncRnt/X
 kU4H39nYTpqCcJphh6SyaYcELJ6tPJFyPZvaRHPTVt1HgCu8YdlylyNTDbvkTOXccWgsVhF73LF
 K8iwxaGR393qU8IvG0RQmmnapTJ1l6wXC/62by4HQJJ5RWlOMw8bnlQH5kHAgRRWMyOMzUBu8IC
 ifxNFUX1aKXyxi7P6yA4CnTNy+6yqb6CD34BKRx+sXzHPk6Bw2kH+12wslT40YsW5C51/UAdIFu
 LH0d7hvh9zo0tSCxYZaIG7qVBlX8TOQFMk0EG/ltB/zgaXAAIPOEmZNu5wp1tCghOjRC63AJdr3
 hyafshssESQl/YV5h1azCABszyiCyFF0RGo4dGL5fA==
X-Received: by 2002:a05:600c:3107:b0:4ba:eb:eb9b with SMTP id
 5b1f17b1804b1-4bb7da1272cmr16363975e9.8.1794961182038; 
 Tue, 17 Nov 2026 16:19:42 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e50e992sm4655025e9.0.2026.11.17.16.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 16:19:41 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v3 4/7] test/virtio_user: add unit test of Rx interrupts
Date: Wed, 18 Nov 2026 02:19:15 +0200
Message-ID: <20261118001918.990884-5-iboukris@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a case that configures the port with Rx interrupts and an Rx
offload. It enables the interrupt of the Rx queue, sends a frame from
the kernel and sleeps on the interrupt. The frame must end the sleep.
Then it does the same after a second configure.

The port has two queue pairs and the test configures one Rx queue, so
the port has more interrupt eventfds than Rx queues. These eventfds
are the backend's call fds, and the driver must not release them. If
it does when it initializes the device again, the test fails.

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
v3: on top of the previous patch. The test frame is now an IPv4 one.

 app/test/test_pmd_virtio_user.c | 73 +++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/app/test/test_pmd_virtio_user.c b/app/test/test_pmd_virtio_user.c
index d8cf4f6a5d..3b60b268ba 100644
--- a/app/test/test_pmd_virtio_user.c
+++ b/app/test/test_pmd_virtio_user.c
@@ -34,6 +34,7 @@ test_pmd_virtio_user(void)
 
 #include <rte_bus_vdev.h>
 #include <rte_cycles.h>
+#include <rte_epoll.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
 #include <rte_ip.h>
@@ -173,6 +174,77 @@ test_virtio_user_rx_flows(void)
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
+ * Rx interrupts with an offload, which makes configure initialize the device
+ * twice. Then a second configure. The port has more interrupt eventfds than
+ * Rx queues. They belong to the backend, so the driver must not release them
+ * when it initializes the device again.
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
 static void
 test_virtio_user_cleanup(void)
 {
@@ -251,6 +323,7 @@ static struct unit_test_suite test_pmd_virtio_user_suite = {
 	.suite_name = "virtio-user PMD Unit Test Suite",
 	.unit_test_cases = {
 		TEST_CASE(test_virtio_user_rx_flows),
+		TEST_CASE(test_virtio_user_rx_intr),
 		TEST_CASES_END()
 	}
 };
-- 
2.56.1

