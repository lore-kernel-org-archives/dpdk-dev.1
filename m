Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42240606A32A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dk3QNkty
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7FFC402C3;
	Tue, 17 Nov 2026 23:00:37 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mails.dpdk.org (Postfix) with ESMTPS id 4CEEF402D5
 for <dev@dpdk.org>; Tue, 17 Nov 2026 23:00:36 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so137211f8f.1
 for <dev@dpdk.org>; Tue, 17 Nov 2026 14:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794952836; x=1795557636; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bnLgR4F5s+8it+qYWRfSMF7Gu2s7FGVM+f+lQCN4gzc=;
 b=dk3QNktyoGmDWhE2aOVl8Au2GMIH8F+7KEKGj8ztzoQ8pdhmP03k0u13bj5Yg6IcZB
 h/F0GQTfv7d1OcJdH0Ll0Is4UZCU7cYCDnr2BcfCV/UZMhVf3ZJkGH8egEZF9Vbp9x9O
 N9kLPP7qnka/uy0u20qZF5KwbWni8SLjIk7+HGgeZyhT4e25xgkUSrUAab4BVeA+93zM
 XcJ8kq7Ztj6Rl0reoejY/M+Zbl/jPB1adkH7jH9UtSHF/+UvSDs0zaN3HrH6Rf5ffs/l
 2DLF99bD4eijjUPHl+Ow7pE6b8iqq3RebiOayUyywcMD+d1SQvb2evsr2guqfh+qV/82
 fmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794952836; x=1795557636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bnLgR4F5s+8it+qYWRfSMF7Gu2s7FGVM+f+lQCN4gzc=;
 b=HSovAdCJ2Km4hpFBfUEoDeNl5YonmJKE2Bf48jT20yuH/R0+B5U+MLGmpUe6do+jTL
 PA17YxkpinUcJZGK2AS0wGJ3GachDDSYt9uFqinK5i1QQ8Si4swywP6Pl9ZLjHd0M4gJ
 APfIrWkagF0g77E0jsHf9AOQcDG1bkexhCXGPOiqAr6Vj1jV0wzNRroP4fyoviRQWaZW
 GJVSrW1NuyC1n3N+QI85vMQDokqeGrS/Z0Pas0vCF086bVswVJ+f7GqOXP7nAQ5QbV0W
 4a9T2nz24SeO/NmD1lvvnOSElqh5ioiFEVy53xLq6regeCKdFaaWqBks9LUCUuUefshx
 Xy5A==
X-Gm-Message-State: APuU4Z/gUOnMiu0NpNFOYUSP8t9AikJ4eTLDJ9O+bZXCPDlvQq13jkge
 FC3GgFqNNlgyLyoZv7ydI/Ym+ysrTKuAcmCC8honoyGRTC33CNcUTpZS
X-Gm-Gg: AZFdTZeO0eKQ0jcVBPkQA9kanKzdzK1WkPU782FGB0IrR9Pjwrl3vNIIZh5nYDgOoIN
 zYN7y+D2xWVzEREpsnavKo24m0EJ1dmCOrYVBleo4GOpfUBWAAKqr/ABoUB5w20WEg96wx/W87e
 psb3vKesLBLhjziWVWzynHb9bJYNal7XnavwvprXP6gCGPkYp0HdBKM8lN1OOVZI9RL9RKwWXZ4
 /hoGkeeipmC/un8zeLvz91Nl026W5m0kBGojihJMAXysbF5ZVbLOjhURLAT0f7zajZvKo9hfHHo
 MDglMQ3dt2F/st3EwF8+rO6Qg4209gutTMzYAjR1S2jQAuZzizpgUWD1NSIgT4mB5ARRprs2doU
 x25R+Qx/jXzJdGtp28zZv9O6LH4cZY8ppR0X3Gx5NH0WBhuB8h6qqVRuLhKMvRarC+hDxTMqHeE
 oAxjqgZ0AizRXKqgbmV6WxVc7mTzYMiu7lR1iAUs2CWyeGH4rWCaJFGLNECIOK1TuOi+xQyVBd0
 xEI+/J+KzXwxdEvSdj1Xevz73y4niSI4Wts/t94uJjX3X+pMSqR0rBkyfyko2YhN0sVZKt/ipnS
 QUOpBRZAdTVFd9zLJIKh
X-Received: by 2002:a5d:5f85:0:b0:48e:3647:c35d with SMTP id
 ffacd0b85a97d-4a639476334mr1730220f8f.21.1794952835741; 
 Tue, 17 Nov 2026 14:00:35 -0800 (PST)
Received: from fedora ([46.210.208.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm1011390f8f.18.2026.11.17.14.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 14:00:34 -0800 (PST)
From: Isaac Boukris <iboukris@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>,
 Aman Singh <aman.deep.singh@intel.com>,
 Luca Vizzarro <luca.vizzarro@arm.com>,
 Patrick Robb <patrickrobb1997@gmail.com>,
 Isaac Boukris <iboukris@gmail.com>
Subject: [PATCH v2 3/5] app/testpmd: add Rx queue interrupts option
Date: Tue, 17 Nov 2026 23:59:59 +0200
Message-ID: <20261117220001.965310-4-iboukris@gmail.com>
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

testpmd cannot test the Rx queue interrupts of a driver, because it
never asks for them.

With --rxq-interrupt, the ports are configured with Rx queue
interrupts, and a forwarding lcore whose Rx queues are all empty
sleeps until a packet arrives on one of them, 10 ms at most, as
l3fwd-power does. The forward statistics show the number of sleeps
that an interrupt ended.

Signed-off-by: Isaac Boukris <iboukris@gmail.com>
---
 app/test-pmd/parameters.c             |  8 +++
 app/test-pmd/testpmd.c                | 86 ++++++++++++++++++++++++++-
 app/test-pmd/testpmd.h                |  2 +
 doc/guides/testpmd_app_ug/run_app.rst |  7 +++
 4 files changed, 101 insertions(+), 2 deletions(-)

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
index d6211a9a8a..0de7cdbeb6 100644
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
@@ -2409,11 +2469,31 @@ lcore_usage_callback(unsigned int lcore_id, struct rte_lcore_usage *usage)
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
+
+	for (sm_id = 0; sm_id < fc->stream_nb; sm_id++)
+		rte_eth_dev_rx_intr_ctl_q(fsm[sm_id]->rx_port, fsm[sm_id]->rx_queue,
+					  RTE_EPOLL_PER_THREAD, op, NULL);
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
 
@@ -4203,6 +4283,8 @@ init_port_config(void)
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
index e34e414ce2..7956672e9d 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -462,6 +462,13 @@ The command line options are:
 
     Disable RMV interrupts for all ports, even those supporting it.
 
+*   ``--rxq-interrupt``
+
+    Enable Rx queue interrupts for all ports.
+    A forwarding lcore whose Rx queues are all empty sleeps
+    until a packet arrives on one of them, 10 ms at most.
+    The forward statistics show the number of sleeps that an interrupt ended (``RX-wakeups``).
+
 *   ``--bitrate-stats=N``
 
     Set the logical core N to perform bitrate calculation.
-- 
2.56.1

