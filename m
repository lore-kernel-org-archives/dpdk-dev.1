Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAEC606A333
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j294ek1v
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69E304064F;
	Wed, 18 Nov 2026 01:19:45 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by mails.dpdk.org (Postfix) with ESMTPS id 872DC402DD
 for <dev@dpdk.org>; Wed, 18 Nov 2026 01:19:44 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb64c99d2fso4659405e9.3
 for <dev@dpdk.org>; Tue, 17 Nov 2026 16:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794961184; x=1795565984; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Zy1KYN4SqnQwzWjJGvnnmn7aZZG7z6y5vhWFg+Hc7o=;
 b=j294ek1vYMTk47jqIv6uKCZ3nPMAsFjOrwiwgi/etH9ItnASV7m60jHzZ/CN1H1FHb
 h0mv2WZZc70Hf9P7Cpv8Vt6/RAE/HyUIAHpYQeg3yj9FaEx3PxGztnrzGKgERkuf2F1K
 v1Q6Eeh9irwUn3fObPR54tZL+XkN+GqEF/Tp+Rp5pblr1cKhydChJ4ynfB2BZmehNBa6
 AuKdb9EosL0B1mBsgG5JWb/+SJlPRmMNwscSTBFfU89AFyXFg+dt3oBo44f/hx0bxzxu
 5uw6IFHH9wh69nc0CmQveu+Dntg3xj+pC4cYZnaKXZelYYbNzufQsP8pvkGkvXKZP3ke
 q8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794961184; x=1795565984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1Zy1KYN4SqnQwzWjJGvnnmn7aZZG7z6y5vhWFg+Hc7o=;
 b=l8Ob6Hps57EyxuifZb+Cwx0jEbShHdYGMsm8+xErRRylNshj5HZjdlnq9P/Vzxu1Q3
 BcQkA87xJUswJHMqj2ULRb5aM6f0E+e9R3Eh6fT5AYFCp7DYZamlGIT7dawxJ8Ps9fpQ
 6AhdQobXcwMdULfajcLJ1NWfVc12AwvdQemFXI68IfDOuzogjAQqJB7cTLiqO0mCWTrW
 7kETT2HCvgbHzyU+hbHwDwSyVavVbzNMErreRaMw6DyhY9eJcZpIa7y2vQJQWTSA0x2V
 YA8u7Msov8pZLxXao9qSIHeQ2dwpKN3pOr9KULLE7HaH3SyMjnaILqnzJbitMSMyxbY2
 jDkg==
X-Gm-Message-State: APuU4Z+umOGsP4qgHKEQlUWlYRiiuXJIhmtOoP/vVQtCaaVB0APlfi3r
 gWlyl4QY69tKOOFOcz8mnUppWJqrkbtWh97fF/Ry+yQDE0Y9b2QQDi7Q
X-Gm-Gg: AYBFou2+ai3R4/9QOtFybS3ikvNO3dhkmVuYHcGJ1GY+y+C2kPmEoit6dCSxd6XRADB
 XEOiVra1U+3yhemZruXfoOdE9tm4mP43VMTmk0htYuUJzicG3Arygdma0UuMhpWUcYKlCHdhSR7
 sQ2c83UMD0580bKNyQWmtocuf20Jw544980BMXI5o2bxsrj9jd19+4SFy6HyqZY64sGOi67Es0U
 jEhzq3BnXcp1AST954BzZ553LuMr00X9YD/ZKwwnLbUJQEntzTqt/nKOUnb/7T7A5UrxZIfF12v
 S+n5ThdE/w4GpJT3OJ8nsuVxUGV1hHb5RfxrbPaK9s81rqOxPN0h1aS/S3bzdeK+LHFXz3nX4vm
 sY2JX4cRkau3eYz7ktI9C8lJ3DA0CFfDlfQdV4c01Xea56uDl2qitQUKgKwN4rd19DKQlUHmwHI
 YpEvVgFIRRw72CjiNcVguQu7Jb954Bas+kzLoHJROLPkCJwmnpwZr75w+vACceGfBObG7D7jnyf
 4orVlhwXlQt8IUoxG326ET5olYYo2lqw4tPZWFTlBuUXinLZqHDiXY94ceJd2/oUe68uqBVqaLJ
 4TDtXRZnw2OCGzYIDFzm
X-Received: by 2002:a05:600c:4e11:b0:4bb:6a2d:b438 with SMTP id
 5b1f17b1804b1-4bb7d578be5mr19174285e9.0.1794961184021; 
 Tue, 17 Nov 2026 16:19:44 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e50e992sm4655025e9.0.2026.11.17.16.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 16:19:43 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v3 5/7] app/testpmd: add Rx queue interrupts option
Date: Wed, 18 Nov 2026 02:19:16 +0200
Message-ID: <20261118001918.990884-6-iboukris@gmail.com>
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

testpmd cannot test the Rx queue interrupts of a driver, because it
never asks for them.

With --rxq-interrupt, the ports are configured with Rx queue
interrupts, and a forwarding lcore whose Rx queues are all empty
sleeps until a packet arrives on one of them, 10 ms at most, as
l3fwd-power does. The forward statistics show the number of sleeps
that an interrupt ended.

If the interrupt of an Rx queue cannot be registered, an error is
logged with the port and the queue.

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
v3: log an error when the interrupt of an Rx queue cannot be registered.

 app/test-pmd/parameters.c             |  8 +++
 app/test-pmd/testpmd.c                | 93 ++++++++++++++++++++++++++-
 app/test-pmd/testpmd.h                |  2 +
 doc/guides/testpmd_app_ug/run_app.rst |  8 +++
 4 files changed, 109 insertions(+), 2 deletions(-)

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
index d6211a9a8a..52c511a85f 100644
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
@@ -2323,6 +2341,42 @@ flush_fwd_rx_queues(void)
 	}
 }
 
+/*
+ * Rx queue interrupts work as in the l3fwd-power example. An lcore whose Rx
+ * queues are all empty enables their interrupts, sleeps until one of them
+ * is raised, 10 ms at most, and disables them.
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
@@ -2330,6 +2384,7 @@ run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
 	uint64_t prev_tsc;
 	streamid_t nb_fs;
 	streamid_t sm_id;
+	bool idle;
 #ifdef RTE_LIB_BITRATESTATS
 	uint64_t tics_per_1sec;
 	uint64_t tics_datum;
@@ -2344,6 +2399,7 @@ run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
 	nb_fs = fc->stream_nb;
 	prev_tsc = rte_rdtsc();
 	do {
+		idle = true;
 		for (sm_id = 0; sm_id < nb_fs; sm_id++) {
 			struct fwd_stream *fs = fsm[sm_id];
 			uint64_t start_fs_tsc = 0;
@@ -2354,9 +2410,13 @@ run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
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
@@ -2409,11 +2469,38 @@ lcore_usage_callback(unsigned int lcore_id, struct rte_lcore_usage *usage)
 	return 0;
 }
 
+/*
+ * Add the Rx interrupts of the queues of an lcore to the epoll instance of
+ * its thread, or delete them from it.
+ */
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
 
@@ -4203,6 +4290,8 @@ init_port_config(void)
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
index e34e414ce2..7396293c64 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -462,6 +462,14 @@ The command line options are:
 
     Disable RMV interrupts for all ports, even those supporting it.
 
+*   ``--rxq-interrupt``
+
+    Enable Rx queue interrupts for all ports.
+    A forwarding lcore whose Rx queues are all empty sleeps
+    until a packet arrives on one of them, 10 ms at most.
+    The forward statistics show the number of sleeps that an interrupt ended (``RX-wakeups``).
+    An error is logged for an Rx queue whose interrupt cannot be registered.
+
 *   ``--bitrate-stats=N``
 
     Set the logical core N to perform bitrate calculation.
-- 
2.56.1

