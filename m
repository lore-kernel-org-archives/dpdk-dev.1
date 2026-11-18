Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965B606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aHnPGVl9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CBB24402DF;
	Wed, 18 Nov 2026 09:28:26 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mails.dpdk.org (Postfix) with ESMTPS id A7C174066C
 for <dev@dpdk.org>; Wed, 18 Nov 2026 09:28:25 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso6381795e9.1
 for <dev@dpdk.org>; Wed, 18 Nov 2026 00:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794990505; x=1795595305; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1mqmt3J8JUngbwH9fILds4vh70lcd52fZnSTGEHK54M=;
 b=aHnPGVl9dFwS5GoOVFWMiwOOhro+PrV2lE+l4+iOAMtT55x0CLCbPkHM80s0VYkY2/
 7vBhHop3j5WGN12XgtmAIbbmXyDyShrNnUtd0IkaNUbgsV5JvncEujF1veg69wcFIlBf
 3axeL+G9sPBb3OnAka+nBVaVJzgvcp8tPrH1Biw7mO0vUYtu7rcC+7XJqmmR9jvd/Jc6
 UkDRuG3k0J3275uGeR9816foedgMltVa+KAQfG3j5wxuZiKlgEOZJVWz+jPlWTzp3lyy
 BKfF4J4FjVdDS/guaF/fZIKThoiBFqSaGF2g8TshQGsX6fg63oFEdVECd9vHtnwjt8Ij
 8Asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794990505; x=1795595305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1mqmt3J8JUngbwH9fILds4vh70lcd52fZnSTGEHK54M=;
 b=dKz5QGCW+6eN5QJf0e8ZMKBav4FQVsJyGTViXAX2wZutCtUg1nutwtJc0uT3gX/guI
 O6JxwHl/4K0o+FCNUlEbmv7uKWOr3PXxEK3kWK2EvbmxpRBcy11odulzSqiNCJL/QIYC
 r+3ePqe8a7WayaaCgBM4wGfQr91J/NQ/fucwpKQXz7KmrLHav/PAFB8YLynjJvn+0B7d
 q5oXv86efB4CI7mM431YmAg4QxbTXHR8OlZImEKJSZdvxCgdv8WcFrpaL4/vlxHtECVQ
 E1ZZe+ZM+JYAvoOVeMcGneuUJ1WCbj8WQphtsdoqB9Lo5IQzcQ6ZkGROgsAfXwM14Pvg
 RHpQ==
X-Gm-Message-State: APuU4Z8hKdA/UYOmXQQaRu9IocYy9+bCxKnQUCX5sDc+mD31V3TxuF1q
 9yQm6dtyPoZ+1TQOBv0tat31+F4l3qmdnk7D8eEcBKncaSC4wmzua0FH
X-Gm-Gg: AYBFou1IKx6vazqhVlXofCaBh7TsZ/oeZ7XwElFcAyI4d5Uw76ZdlbAuDvqykpkZA0t
 5mahzXPIzosylBSc8nLVNKdMGMOZQBGR4+Yzd2UuKYl1xA/TfLYkJ9RGrwpts9NUijDeELVD4wO
 Sjd7mt6ZFRQqulgEE0KWeBG6pubdE2fkQbxM8q1ENHSLvMPN8kVT5xfildUJOozu3+w6M8fzsBZ
 szJt164CnTeI1SI3LRMR1rOg1JLjY7O5lTlN/AnpFx4WnQ0f5yBnifL1QKRgdF3xuZl9QciPUEI
 0wiDINiVFESbbCfhls+bGW0OL0CV/dV3GLAhpJ/KBMMyLd/O/pD/Xfx0gJVfj4bC9Chc5DhsQ8s
 Ad0CuRB/ehnAyFoNbAZyVriOBxnMSghUyHg6AOANTwuuV4k1CRhIGNZy3kbtFiBFSsIohbpPyy5
 H8MuklZOkFt/p0iBYPqPwPLwFmKqmqyB3ojWAy77jNolFzumI6Yc957WCqEE/0e71yglKSQj6x1
 DRNKEOz+jGFh46q7ovqk30cxcFRDNRyrzLcJTsVwJmyIcsFMQ32y0vyW/dbdOzIQg91/m2D6x38
 /psr04x+zwPxYRye3sRo
X-Received: by 2002:a05:600c:3b91:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4bb7da4647dmr37588595e9.32.1794990505099; 
 Wed, 18 Nov 2026 00:28:25 -0800 (PST)
Received: from fedora ([46.210.233.16]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2cfb3esm55097605e9.15.2026.11.18.00.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 00:28:24 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v4 6/8] app/testpmd: add Rx queue interrupts option
Date: Wed, 18 Nov 2026 10:27:50 +0200
Message-ID: <20261118082752.1043794-7-iboukris@gmail.com>
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

testpmd never asks for Rx queue interrupts, so it cannot test them.

With --rxq-interrupt, the ports are configured with Rx queue
interrupts, and a forwarding lcore whose Rx queues are all empty
sleeps until a packet arrives, 10 ms at most, as l3fwd-power does.
The forward statistics count the sleeps that an interrupt ended. An
error is logged for an Rx queue whose interrupt cannot be registered.

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
v4: shorter comments and option description, no code change.
v3: log an error when the interrupt of an Rx queue cannot be registered.

 app/test-pmd/parameters.c             |  8 +++
 app/test-pmd/testpmd.c                | 89 ++++++++++++++++++++++++++-
 app/test-pmd/testpmd.h                |  2 +
 doc/guides/testpmd_app_ug/run_app.rst |  7 +++
 4 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 34a4f74e63..f958104f47 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -207,6 +207,8 @@ enum {
 	TESTPMD_OPT_NO_LSC_INTERRUPT_NUM,
 #define TESTPMD_OPT_NO_RMV_INTERRUPT "no-rmv-interrupt"
 	TESTPMD_OPT_NO_RMV_INTERRUPT_NUM,
+#define TESTPMD_OPT_RXQ_INTERRUPT "rxq-interrupt"
+	TESTPMD_OPT_RXQ_INTERRUPT_NUM,
 #define TESTPMD_OPT_PRINT_EVENT "print-event"
 	TESTPMD_OPT_PRINT_EVENT_NUM,
 #define TESTPMD_OPT_MASK_EVENT "mask-event"
@@ -357,6 +359,7 @@ static const struct option long_options[] = {
 	NO_ARG(TESTPMD_OPT_DISABLE_DEVICE_START),
 	NO_ARG(TESTPMD_OPT_NO_LSC_INTERRUPT),
 	NO_ARG(TESTPMD_OPT_NO_RMV_INTERRUPT),
+	NO_ARG(TESTPMD_OPT_RXQ_INTERRUPT),
 	REQUIRED_ARG(TESTPMD_OPT_PRINT_EVENT),
 	REQUIRED_ARG(TESTPMD_OPT_MASK_EVENT),
 	REQUIRED_ARG(TESTPMD_OPT_TX_OFFLOADS),
@@ -515,6 +518,8 @@ usage(char* progname)
 	printf("  --disable-device-start: do not automatically start port\n");
 	printf("  --no-lsc-interrupt: disable link status change interrupt.\n");
 	printf("  --no-rmv-interrupt: disable device removal interrupt.\n");
+	printf("  --rxq-interrupt: enable Rx queue interrupts, "
+	       "idle forwarding lcores sleep.\n");
 #ifdef RTE_LIB_BITRATESTATS
 	printf("  --bitrate-stats=N: set the logical core N to perform "
 		"bit-rate calculation.\n");
@@ -1638,6 +1643,9 @@ launch_args_parse(int argc, char** argv)
 		case TESTPMD_OPT_NO_RMV_INTERRUPT_NUM:
 			rmv_interrupt = 0;
 			break;
+		case TESTPMD_OPT_RXQ_INTERRUPT_NUM:
+			rxq_interrupt = 1;
+			break;
 		case TESTPMD_OPT_FLOW_ISOLATE_ALL_NUM:
 			flow_isolate_all = 1;
 			break;
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index d6211a9a8a..cd68b0a15a 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -43,6 +43,8 @@
 #include <rte_mbuf.h>
 #include <rte_mbuf_pool_ops.h>
 #include <rte_interrupts.h>
+#include <rte_epoll.h>
+#include <rte_spinlock.h>
 #include <rte_ether.h>
 #include <rte_ethdev.h>
 #include <rte_dev.h>
@@ -446,6 +448,11 @@ uint8_t lsc_interrupt = 1; /* enabled by default */
  */
 uint8_t rmv_interrupt = 1; /* enabled by default */
 
+/*
+ * Enable Rx queue interrupts. A forwarding lcore then sleeps when it is idle.
+ */
+uint8_t rxq_interrupt;
+
 uint8_t hot_plug = 0; /**< hotplug disabled by default. */
 
 /* After attach, port setup is called on event or by iterator */
@@ -2213,6 +2220,14 @@ fwd_stats_display(void)
 	       total_xmit, total_tx_dropped, total_xmit + total_tx_dropped);
 	if (total_rx_nombuf > 0)
 		printf("  RX-nombufs: %-14"PRIu64"\n", total_rx_nombuf);
+	if (rxq_interrupt) {
+		uint64_t rx_wakeups = 0;
+		lcoreid_t lc_id;
+
+		for (lc_id = 0; lc_id < cur_fwd_config.nb_fwd_lcores; lc_id++)
+			rx_wakeups += fwd_lcores[lc_id]->rx_wakeups;
+		printf("  RX-wakeups: %-14"PRIu64"\n", rx_wakeups);
+	}
 	printf("  %s++++++++++++++++++++++++++++++++++++++++++++++"
 	       "%s\n",
 	       acc_stats_border, acc_stats_border);
@@ -2240,6 +2255,7 @@ void
 fwd_stats_reset(void)
 {
 	streamid_t sm_id;
+	lcoreid_t lc_id;
 	portid_t pt_id;
 	int ret;
 	int i;
@@ -2267,6 +2283,8 @@ fwd_stats_reset(void)
 		memset(&fs->tx_burst_stats, 0, sizeof(fs->tx_burst_stats));
 		fs->busy_cycles = 0;
 	}
+	for (lc_id = 0; lc_id < cur_fwd_config.nb_fwd_lcores; lc_id++)
+		fwd_lcores[lc_id]->rx_wakeups = 0;
 }
 
 static void
@@ -2323,6 +2341,41 @@ flush_fwd_rx_queues(void)
 	}
 }
 
+/*
+ * As in l3fwd-power, an lcore whose Rx queues are all empty enables their
+ * interrupts, sleeps until one is raised, 10 ms at most, and disables them.
+ */
+static rte_spinlock_t rxq_interrupt_locks[RTE_MAX_ETHPORTS];
+
+static void
+rxq_interrupt_turn(struct fwd_lcore *fc, bool on)
+{
+	struct fwd_stream **fsm = &fwd_streams[fc->stream_idx];
+	streamid_t sm_id;
+
+	for (sm_id = 0; sm_id < fc->stream_nb; sm_id++) {
+		struct fwd_stream *fs = fsm[sm_id];
+
+		rte_spinlock_lock(&rxq_interrupt_locks[fs->rx_port]);
+		if (on)
+			rte_eth_dev_rx_intr_enable(fs->rx_port, fs->rx_queue);
+		else
+			rte_eth_dev_rx_intr_disable(fs->rx_port, fs->rx_queue);
+		rte_spinlock_unlock(&rxq_interrupt_locks[fs->rx_port]);
+	}
+}
+
+static void
+rxq_interrupt_sleep(struct fwd_lcore *fc)
+{
+	struct rte_epoll_event event;
+
+	rxq_interrupt_turn(fc, true);
+	if (rte_epoll_wait(RTE_EPOLL_PER_THREAD, &event, 1, 10) > 0)
+		fc->rx_wakeups++;
+	rxq_interrupt_turn(fc, false);
+}
+
 static void
 run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
 {
@@ -2330,6 +2383,7 @@ run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
 	uint64_t prev_tsc;
 	streamid_t nb_fs;
 	streamid_t sm_id;
+	bool idle;
 #ifdef RTE_LIB_BITRATESTATS
 	uint64_t tics_per_1sec;
 	uint64_t tics_datum;
@@ -2344,6 +2398,7 @@ run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
 	nb_fs = fc->stream_nb;
 	prev_tsc = rte_rdtsc();
 	do {
+		idle = true;
 		for (sm_id = 0; sm_id < nb_fs; sm_id++) {
 			struct fwd_stream *fs = fsm[sm_id];
 			uint64_t start_fs_tsc = 0;
@@ -2354,9 +2409,13 @@ run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
 			if (record_core_cycles)
 				start_fs_tsc = rte_rdtsc();
 			busy = (*pkt_fwd)(fs);
+			if (busy)
+				idle = false;
 			if (record_core_cycles && busy)
 				fs->busy_cycles += rte_rdtsc() - start_fs_tsc;
 		}
+		if (rxq_interrupt && idle && !fc->stopped)
+			rxq_interrupt_sleep(fc);
 #ifdef RTE_LIB_BITRATESTATS
 		if (bitrate_enabled != 0 &&
 				bitrate_lcore_id == rte_lcore_id()) {
@@ -2409,11 +2468,35 @@ lcore_usage_callback(unsigned int lcore_id, struct rte_lcore_usage *usage)
 	return 0;
 }
 
+/* Add the Rx queue interrupts of an lcore to its thread's epoll instance, or delete them. */
+static void
+rxq_interrupt_register(struct fwd_lcore *fc, int op)
+{
+	struct fwd_stream **fsm = &fwd_streams[fc->stream_idx];
+	streamid_t sm_id;
+	int ret;
+
+	for (sm_id = 0; sm_id < fc->stream_nb; sm_id++) {
+		struct fwd_stream *fs = fsm[sm_id];
+
+		ret = rte_eth_dev_rx_intr_ctl_q(fs->rx_port, fs->rx_queue,
+						RTE_EPOLL_PER_THREAD, op, NULL);
+		if (ret != 0 && op == RTE_INTR_EVENT_ADD)
+			TESTPMD_LOG(ERR, "Port %u Rx queue %u: cannot register the interrupt: %s\n",
+				    fs->rx_port, fs->rx_queue, rte_strerror(-ret));
+	}
+}
+
 static int
 start_pkt_forward_on_core(void *fwd_arg)
 {
-	run_pkt_fwd_on_lcore((struct fwd_lcore *) fwd_arg,
-			     cur_fwd_config.fwd_eng->packet_fwd);
+	struct fwd_lcore *fc = fwd_arg;
+
+	if (rxq_interrupt)
+		rxq_interrupt_register(fc, RTE_INTR_EVENT_ADD);
+	run_pkt_fwd_on_lcore(fc, cur_fwd_config.fwd_eng->packet_fwd);
+	if (rxq_interrupt)
+		rxq_interrupt_register(fc, RTE_INTR_EVENT_DEL);
 	return 0;
 }
 
@@ -4203,6 +4286,8 @@ init_port_config(void)
 			port->dev_conf.intr_conf.lsc = 1;
 		if (rmv_interrupt && (*port->dev_info.dev_flags & RTE_ETH_DEV_INTR_RMV))
 			port->dev_conf.intr_conf.rmv = 1;
+		if (rxq_interrupt)
+			port->dev_conf.intr_conf.rxq = 1;
 	}
 }
 
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 2ca4aaf086..6d3f258263 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -405,6 +405,7 @@ struct fwd_lcore {
 	lcoreid_t  cpuid_idx;    /**< index of logical core in CPU id table */
 	volatile char stopped;   /**< stop forwarding when set */
 	uint64_t total_cycles;   /**< used with --record-core-cycles */
+	uint64_t rx_wakeups;     /**< used with --rxq-interrupt */
 };
 
 /*
@@ -541,6 +542,7 @@ extern uint8_t no_device_start; /**<set by "--disable-device-start" parameter */
 extern volatile int test_done; /* stop packet forwarding when set to 1. */
 extern uint8_t lsc_interrupt; /**< disabled by "--no-lsc-interrupt" parameter */
 extern uint8_t rmv_interrupt; /**< disabled by "--no-rmv-interrupt" parameter */
+extern uint8_t rxq_interrupt; /**< enabled by "--rxq-interrupt" parameter */
 extern uint32_t event_print_mask;
 /**< set by "--print-event xxxx" and "--mask-event xxxx parameters */
 extern bool setup_on_probe_event; /**< disabled by port setup-on iterator */
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index e34e414ce2..bfc95be937 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -462,6 +462,13 @@ The command line options are:
 
     Disable RMV interrupts for all ports, even those supporting it.
 
+*   ``--rxq-interrupt``
+
+    Enable Rx queue interrupts for all ports.
+    A forwarding lcore whose Rx queues are all empty sleeps until a packet arrives, 10 ms at most.
+    The forward statistics count the sleeps that an interrupt ended (``RX-wakeups``).
+    An error is logged for an Rx queue whose interrupt cannot be registered.
+
 *   ``--bitrate-stats=N``
 
     Set the logical core N to perform bitrate calculation.
-- 
2.56.1

