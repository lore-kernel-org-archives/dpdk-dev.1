Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2DC606A320
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RYt3s0gL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9060D40431;
	Mon, 26 Oct 2026 20:09:29 +0100 (CET)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by mails.dpdk.org (Postfix) with ESMTPS id 5E345402B0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 20:09:24 +0100 (CET)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3acb512a7a0so1794036a91.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793041763; x=1793646563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5/rzuryS9f23I6NqCmRWjJwIEVg3eZk+57HCcwa9YzE=;
 b=X45OSjZ+2c3kI2cM+wxeQFWoCrURJZsperGzklJXh+Dy6T4szNw3OBmugXXCV8eozj
 V9aYJ9yZQ0jY34k3BdOyTyQhtPRAVqsvr7h5LvQstxarvTFs0DrYM++QMIiOKdHmEAzL
 eOfMrkMZFSs52bKQZrqP06z/R8eaOhY+zMhCrZZ4vIcg5cPPHlJdTKYpfZXJoUWJWfHM
 JVpMOXBYgKGIzG2LCgmQmzDV2TIrTIfcLJiPNHSuipQrXZEW8V0WtLzG55LLijt5amQa
 LJvCxaDKVOp8Ym8Cq2cjTJNSyMkQmvmW/Udfge6TdUOYAJUyntglwNVYMK3y2aNmiK+2
 CB2w==
X-Gm-Message-State: AFq9FYLp+cbUa6VZTwpzzqn3yDMVXYsrBDZxR6d46JTiEO9+vVXdYvbP
 X8BUs5LfFruK8RL5AnYphSrZtpah3NpT/JvEyEufaYX1jJSp7lpDzIzHQmbnybik8eKfyfUnM1n
 JV/ARH4SPJrRFPsnBCGDhl7514WqqrWz7RARolL2s6zvY6vvQE/VldnxR2IJsSsc+HcmRYfE/kZ
 eSND2+8nAAjwRQ2Cr+XqyhNDRjGo8kb3busvnlY5ePTKcrGuP5B/4vTViAxJHzm4XkOyYdE/nf2
 b2kOFafEreh
X-Gm-Gg: AYBFou1luuPSJbdaEKPX8sGzRCNLVJl1ppKl0BGsElFpEUBq+uJp5gnvcVNYWOZN2A3
 jBx5+s85998olq9veKUZb62ZathiDWRGxavU3N548KjA0XDSHfIdTu2UtUY9HfK6TGvhknPP7/C
 FWdXeCOBd75rXuf1brbkBbJZTk1k/9kdLxa2wm3IiXb55FOiwpJbFf7qWluB+Y8X6HkbJKd0rlx
 68A22t3PNhRVb/eAmAu0o2ntXps0fFTMoJYI2K8RojDEAqliB0DS8ltWMeMCT5CaXwUMGXgjuPl
 czuh8cKBV5PjewqeUo4aSyoWH6FSVkCSorQMlScJWlOQauY8p5oc1lcJcrD3O/bFXOr5/oGbwtt
 Df0ynCgau1Jgrac8a2rJa0WXaYOUiOKAIbsBpdcTQVYk+6Rs5knES38rK1gZ/ozrYQ9p4C43PDr
 uE0OR9n0E8qgSzqhVK5ioEmeDORUyIobe0+Ue4jBmnwcM3IrQWIA==
X-Received: by 2002:a17:90b:4fc2:b0:3ac:9a5e:9ce7 with SMTP id
 98e67ed59e1d1-3adeae70fc6mr6207039a91.49.1793041762599; 
 Mon, 26 Oct 2026 12:09:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3adeb841ed2sm2680771a91.0.2026.10.26.12.09.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2026 12:09:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3692c5b061bso141711eec.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793041761; x=1793646561; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5/rzuryS9f23I6NqCmRWjJwIEVg3eZk+57HCcwa9YzE=;
 b=RYt3s0gLCex80Dfjg2tiAAuvBE7RfJcyJcTruYs9BXJDUFl8cJW6PfLgH50P89nlFd
 2Rksd89inQf2l52zll2U1bddBMEgPDZySPCbbVBUyIq18Dpx7BItUct/4o2bKNR+nT+5
 zSxxCypdc3oAX0tkh29Z5reo4FZxj1POrfOXs=
X-Received: by 2002:a05:693c:66c1:20b0:35e:51d6:9f6f with SMTP id
 5a478bee46e88-369e84f5952mr11541876eec.27.1793041760157; 
 Mon, 26 Oct 2026 12:09:20 -0700 (PDT)
X-Received: by 2002:a05:693c:66c1:20b0:35e:51d6:9f6f with SMTP id
 5a478bee46e88-369e84f5952mr11541813eec.27.1793041758940; 
 Mon, 26 Oct 2026 12:09:18 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm37103906eec.19.2026.10.26.12.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:09:17 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 2/7] net/bnxt: add recovery from function error
Date: Mon, 26 Oct 2026 13:12:46 -0600
Message-ID: <20261026191251.1274062-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026191251.1274062-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
 <20261026191251.1274062-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

When a PCIe DMA transaction fails, firmware places the affected
function into FUNC_ERROR state and rejects all HWRM commands with
HWRM_ERR_CODE_FUNC_RESET_REQUIRED until the driver issues
HWRM_FUNC_RESET. There is no async event; the driver discovers the
condition as a side effect of its next ordinary HWRM command. This is
lighter-weight than Adapter Error Recovery: no core reset, no
blackout, other functions unaffected.

Detection is added to bnxt_hwrm_send_message(), which covers every
HWRM command the driver issues. Recovery is gated on the new
"func-error-support" devarg (default off), since firmware advertises
no capability bit for it. When triggered, a deferred callback
optionally reads diagnostics via HWRM_FUNC_ERROR_QUERY, issues
HWRM_FUNC_RESET, then reuses the existing RESET_NOTIFY reinit chain
(bnxt_dev_reset_and_resume) to rebuild all rings and filters. A
self-rearming one-second alarm bounds discovery time when the
application issues no HWRM traffic of its own.

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 doc/guides/nics/bnxt.rst               |  17 ++
 doc/guides/rel_notes/release_26_11.rst |   4 +
 drivers/net/bnxt/bnxt.h                |   4 +
 drivers/net/bnxt/bnxt_ethdev.c         |  55 +++++-
 drivers/net/bnxt/bnxt_func_error.c     | 228 +++++++++++++++++++++++++
 drivers/net/bnxt/bnxt_func_error.h     |  33 ++++
 drivers/net/bnxt/bnxt_hwrm.c           |  87 ++++++++++
 drivers/net/bnxt/bnxt_hwrm.h           |   2 +
 drivers/net/bnxt/bnxt_stats.c          |  21 +++
 drivers/net/bnxt/bnxt_stats.h          |   2 +-
 drivers/net/bnxt/hsi_struct_def_dpdk.h | 130 ++++++++++++++
 drivers/net/bnxt/meson.build           |   1 +
 12 files changed, 581 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/bnxt/bnxt_func_error.c
 create mode 100644 drivers/net/bnxt/bnxt_func_error.h

diff --git a/doc/guides/nics/bnxt.rst b/doc/guides/nics/bnxt.rst
index 8c36cec1027..76a63368143 100644
--- a/doc/guides/nics/bnxt.rst
+++ b/doc/guides/nics/bnxt.rst
@@ -352,6 +352,23 @@ passed to ``rte_eth_tx_queue_setup()``, rounded up to the nearest power of
 two supported by the hardware (up to 256). A ``wthresh`` of 0 disables Tx
 completion coalescing.
 
+FUNC_ERROR Recovery
+^^^^^^^^^^^^^^^^^^^
+
+When a PCIe DMA transaction fails, the firmware places the affected function
+into FUNC_ERROR state and rejects HWRM commands until the driver resets the
+function. The BNXT PMD can recover from this without a full adapter reset
+by resetting the function and re-creating its rings and filters.
+
+Recovery is disabled by default. It is enabled with the ``func-error-support``
+device argument::
+
+    -a 0000:82:00.0,func-error-support=1
+
+The number of recoveries is reported by the ``func_error_recovery`` extended
+statistic, and DMA faults captured during recovery are reflected in
+``oerrors``.
+
 Checksum Offload
 ^^^^^^^^^^^^^^^^
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index df476005da0..41d22b80226 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -143,6 +143,10 @@ New Features
     from 4096/8192 to 16384 each.
   * Enabled hardware Tx completion coalescing on P7 devices,
     controlled by the existing ``wthresh`` Tx queue configuration field.
+  * Added recovery from a firmware-reported FUNC_ERROR/PXP_ERROR condition
+    (a failed PCIe DMA transaction) without a full adapter reset,
+    gated behind the new ``func-error-support`` devarg (default off).
+    Added a ``func_error_recovery`` xstat to report the recovery count.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 8a5c78080e1..2433a39a65a 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -802,6 +802,8 @@ enum bnxt_session_type {
 #define BNXT_BUF_SPLIT_OFFSET_CAP		1
 #define BNXT_BUF_SPLIT_ALIGN_CAP		0
 
+struct bnxt_func_error_info;
+
 struct bnxt {
 	void				*bar0;
 
@@ -816,6 +818,7 @@ struct bnxt {
 #define BNXT_FLAG_PORT_STATS		BIT(2)
 #define BNXT_FLAG_JUMBO			BIT(3)
 #define BNXT_FLAG_SHORT_CMD		BIT(4)
+#define BNXT_FLAG_PXP_ERROR		BIT(5)
 #define BNXT_FLAG_PTP_SUPPORTED		BIT(6)
 #define BNXT_FLAG_MULTI_HOST    	BIT(7)
 #define BNXT_FLAG_EXT_RX_PORT_STATS	BIT(8)
@@ -1088,6 +1091,7 @@ struct bnxt {
 	struct tf		tfp[BNXT_SESSION_TYPE_LAST];
 	struct tfc		tfcp;
 	struct bnxt_ulp_context	*ulp_ctx;
+	struct bnxt_func_error_info	*func_error_info;
 	struct bnxt_flow_stat_info *flow_stat;
 	uint16_t		max_num_kflows;
 	uint8_t			app_id;
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 23edd944440..55403f68155 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -18,6 +18,7 @@
 
 #include "bnxt.h"
 #include "bnxt_filter.h"
+#include "bnxt_func_error.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_irq.h"
 #include "bnxt_reps.h"
@@ -126,6 +127,7 @@ static const char *const bnxt_dev_args[] = {
 	BNXT_DEVARG_MPC,
 	BNXT_DEVARG_SCALAR_MODE,
 	BNXT_DEVARD_APP_INST_ID,
+	BNXT_DEVARG_FUNC_ERROR_SUPPORT,
 	NULL
 };
 
@@ -1728,6 +1730,7 @@ static int bnxt_dev_stop(struct rte_eth_dev *eth_dev)
 		bnxt_ulp_port_deinit(bp);
 
 	bnxt_cancel_fw_health_check(bp);
+	bnxt_cancel_func_error_poll(bp);
 
 	if (BNXT_P5_PTP_TIMESYNC_ENABLED(bp))
 		bnxt_cancel_ptp_alarm(bp);
@@ -1783,7 +1786,10 @@ int bnxt_dev_stop_op(struct rte_eth_dev *eth_dev)
 	struct bnxt *bp = eth_dev->data->dev_private;
 
 	pthread_mutex_lock(&bp->err_recovery_lock);
-	if (bp->flags & BNXT_FLAG_FW_RESET) {
+	if (bp->flags & BNXT_FLAG_FW_RESET ||
+	    (bp->func_error_info != NULL &&
+	     rte_atomic_load_explicit(&bp->func_error_info->recovery_pending,
+				       rte_memory_order_acquire))) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Adapter recovering from error..Please retry");
 		pthread_mutex_unlock(&bp->err_recovery_lock);
@@ -1895,6 +1901,7 @@ int bnxt_dev_start_op(struct rte_eth_dev *eth_dev)
 	bnxt_update_max_rx_burst(bp, link);
 
 	bnxt_schedule_fw_health_check(bp);
+	bnxt_schedule_func_error_poll(bp);
 
 	if (BNXT_P5_PTP_TIMESYNC_ENABLED(bp))
 		bnxt_schedule_ptp_alarm(bp);
@@ -1969,7 +1976,10 @@ static int bnxt_dev_close_op(struct rte_eth_dev *eth_dev)
 		return 0;
 
 	pthread_mutex_lock(&bp->err_recovery_lock);
-	if (bp->flags & BNXT_FLAG_FW_RESET) {
+	if (bp->flags & BNXT_FLAG_FW_RESET ||
+	    (bp->func_error_info != NULL &&
+	     rte_atomic_load_explicit(&bp->func_error_info->recovery_pending,
+				       rte_memory_order_acquire))) {
 		PMD_DRV_LOG_LINE(ERR,
 			    "Adapter recovering from error...Please retry");
 		pthread_mutex_unlock(&bp->err_recovery_lock);
@@ -1986,6 +1996,17 @@ static int bnxt_dev_close_op(struct rte_eth_dev *eth_dev)
 	if (eth_dev->data->dev_started)
 		ret = bnxt_dev_stop(eth_dev);
 
+	/* Stop FUNC_ERROR detection before the teardown below: a HWRM
+	 * command issued while closing could otherwise schedule a recovery
+	 * that rebuilds resources concurrently with this teardown. Wait for
+	 * any recovery already scheduled or running.
+	 */
+	rte_atomic_store_explicit(&bp->func_error_info->support, 0,
+				  rte_memory_order_relaxed);
+	rte_eal_alarm_cancel(bnxt_func_error_recovery_cb, (void *)bp);
+	rte_eal_alarm_cancel(bnxt_dev_reset_and_resume, (void *)bp);
+	rte_eal_alarm_cancel(bnxt_dev_recover, (void *)bp);
+
 	bnxt_free_prev_ring_stats_ext(bp);
 	bnxt_free_prev_ring_stats(bp);
 	bnxt_uninit_resources(bp, false);
@@ -4664,6 +4685,7 @@ static void bnxt_dev_recover(void *arg)
 	}
 	/* clear reset flag as the device is initialized now */
 	bp->flags &= ~BNXT_FLAG_FW_RESET;
+	bnxt_func_error_clear_pending(bp);
 
 	rc = bnxt_dev_start_op(bp->eth_dev);
 	if (rc) {
@@ -4691,6 +4713,13 @@ static void bnxt_dev_recover(void *arg)
 err_start:
 	bnxt_dev_stop(bp->eth_dev);
 err:
+	/* Whatever failed here, don't leave a FUNC_ERROR recovery attempt
+	 * permanently marked in-flight -- this is a terminal state for this
+	 * attempt (BNXT_FLAG_FATAL_ERROR below takes over from here), and a
+	 * stuck pending flag would silently block every future FUNC_ERROR
+	 * trigger on this port.
+	 */
+	bnxt_func_error_clear_pending(bp);
 	bp->flags |= BNXT_FLAG_FATAL_ERROR;
 	bnxt_uninit_resources(bp, false);
 	rte_eth_dev_callback_process(bp->eth_dev,
@@ -4713,6 +4742,7 @@ void bnxt_dev_reset_and_resume(void *arg)
 	int rc;
 
 	bnxt_dev_cleanup(bp);
+	bp->flags &= ~BNXT_FLAG_PXP_ERROR;
 	PMD_DRV_LOG_LINE(INFO, "Port: %u Finished bnxt_dev_cleanup",
 		    bp->eth_dev->data->port_id);
 
@@ -4737,6 +4767,14 @@ void bnxt_dev_reset_and_resume(void *arg)
 		}
 	}
 
+	/* rte_eal_alarm_set() rejects a zero delay (-EINVAL); fw_reset_min_msecs
+	 * is legitimately 0 for paths with no blackout period (e.g. FUNC_ERROR
+	 * recovery), so clamp to the minimum valid delay instead of skipping
+	 * the alarm -- bnxt_dev_recover() must still run to reinit the port.
+	 */
+	if (us == 0)
+		us = 1;
+
 	rc = rte_eal_alarm_set(us, bnxt_dev_recover, (void *)bp);
 	if (rc)
 		PMD_DRV_LOG_LINE(ERR, "Port %u: Error setting recovery alarm",
@@ -6438,6 +6476,14 @@ bnxt_parse_dev_args(struct bnxt *bp, struct rte_devargs *devargs)
 	rte_kvargs_process(kvlist, BNXT_DEVARD_APP_INST_ID,
 			   bnxt_parse_devarg_app_instance_id, bp);
 
+	/*
+	 * Handler for "func-error-support" devarg.
+	 * Invoked as for ex: "-a 0000:00:0d.0,func-error-support=1"
+	 * Opt-in only; default is off.
+	 */
+	rte_kvargs_process(kvlist, BNXT_DEVARG_FUNC_ERROR_SUPPORT,
+			   bnxt_parse_devarg_func_error_support, bp);
+
 	rte_kvargs_free(kvlist);
 	return ret;
 }
@@ -6562,6 +6608,10 @@ bnxt_dev_init(struct rte_eth_dev *eth_dev, void *params __rte_unused)
 	/* set the default app id */
 	bp->app_id = bnxt_ulp_default_app_id_get();
 
+	rc = bnxt_func_error_info_alloc(bp);
+	if (rc)
+		goto error_free;
+
 	/* Parse dev arguments passed on when starting the DPDK application. */
 	rc = bnxt_parse_dev_args(bp, pci_dev->device.devargs);
 	if (rc)
@@ -6684,6 +6734,7 @@ bnxt_uninit_resources(struct bnxt *bp, bool reconfig_dev)
 		bp->mcast_addr_list = NULL;
 		rte_free(bp->rss_conf.rss_key);
 		bp->rss_conf.rss_key = NULL;
+		bnxt_func_error_info_free(bp);
 	}
 
 	bnxt_uninit_ctx_mem(bp);
diff --git a/drivers/net/bnxt/bnxt_func_error.c b/drivers/net/bnxt/bnxt_func_error.c
new file mode 100644
index 00000000000..4dec2579767
--- /dev/null
+++ b/drivers/net/bnxt/bnxt_func_error.c
@@ -0,0 +1,228 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Broadcom
+ * All rights reserved.
+ */
+
+#include <errno.h>
+#include <limits.h>
+#include <stdlib.h>
+
+#include <rte_alarm.h>
+#include <rte_malloc.h>
+
+#include "bnxt.h"
+#include "bnxt_cpr.h"
+#include "bnxt_func_error.h"
+#include "bnxt_hwrm.h"
+
+static void bnxt_func_error_poll_cb(void *arg);
+
+int bnxt_func_error_info_alloc(struct bnxt *bp)
+{
+	bp->func_error_info = rte_zmalloc("bnxt_func_error_info",
+					   sizeof(struct bnxt_func_error_info), 0);
+	if (bp->func_error_info == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void bnxt_func_error_info_free(struct bnxt *bp)
+{
+	rte_eal_alarm_cancel(bnxt_func_error_recovery_cb, (void *)bp);
+	rte_eal_alarm_cancel(bnxt_func_error_poll_cb, (void *)bp);
+	rte_free(bp->func_error_info);
+	bp->func_error_info = NULL;
+}
+
+void bnxt_func_error_clear_pending(struct bnxt *bp)
+{
+	rte_atomic_store_explicit(&bp->func_error_info->recovery_pending, 0,
+				  rte_memory_order_release);
+}
+
+static bool bnxt_func_error_acquire_pending(struct bnxt *bp)
+{
+	unsigned int expected = 0;
+
+	return rte_atomic_compare_exchange_strong_explicit(&bp->func_error_info->recovery_pending,
+							    &expected, 1,
+							    rte_memory_order_acq_rel,
+							    rte_memory_order_acquire);
+}
+
+void bnxt_func_error_trigger_recovery(struct bnxt *bp)
+{
+	if (!bnxt_func_error_acquire_pending(bp))
+		return;
+
+	PMD_DRV_LOG_LINE(ERR,
+		    "Port %u: HWRM_ERR_CODE_FUNC_RESET_REQUIRED -- function is in "
+		    "FUNC_ERROR state, scheduling recovery",
+		    bp->eth_dev->data->port_id);
+
+	if (rte_eal_alarm_set(US_PER_MS, bnxt_func_error_recovery_cb, (void *)bp)) {
+		PMD_DRV_LOG_LINE(ERR,
+			    "Port %u: Failed to schedule FUNC_ERROR recovery",
+			    bp->eth_dev->data->port_id);
+		bnxt_func_error_clear_pending(bp);
+	}
+}
+
+void bnxt_func_error_recovery_cb(void *arg)
+{
+	struct bnxt *bp = arg;
+	int rc;
+
+	pthread_mutex_lock(&bp->err_recovery_lock);
+	if (bp->flags & BNXT_FLAG_FW_RESET) {
+		pthread_mutex_unlock(&bp->err_recovery_lock);
+		bnxt_func_error_clear_pending(bp);
+		return;
+	}
+	bp->flags |= BNXT_FLAG_FW_RESET;
+
+	rte_atomic_fetch_add_explicit(&bp->func_error_info->recovery_count, 1,
+				      rte_memory_order_relaxed);
+	bp->fw_reset_min_msecs = 0;
+	bp->fw_reset_max_msecs = BNXT_MAX_FW_RESET_TIMEOUT;
+
+	bnxt_stop_rxtx(bp->eth_dev);
+
+	rc = bnxt_hwrm_func_error_query(bp);
+	if (rc)
+		PMD_DRV_LOG_LINE(INFO,
+			    "Port %u: FUNC_ERROR diagnostic query failed rc:%d "
+			    "(no diagnostic data, proceeding with reset anyway)",
+			    bp->eth_dev->data->port_id, rc);
+
+	rc = bnxt_hwrm_func_reset(bp);
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR,
+			    "FUNC_ERROR recovery: HWRM_FUNC_RESET failed");
+		bp->flags &= ~BNXT_FLAG_FW_RESET;
+		pthread_mutex_unlock(&bp->err_recovery_lock);
+		bnxt_func_error_clear_pending(bp);
+		return;
+	}
+
+	/* HWRM_FUNC_RESET just reclaimed every ring/VNIC/stat-ctx for this
+	 * function; bnxt_dev_cleanup()'s own per-resource frees would only
+	 * be rejected as "not allocated". Gate them out until cleanup runs.
+	 */
+	bp->flags |= BNXT_FLAG_PXP_ERROR;
+	pthread_mutex_unlock(&bp->err_recovery_lock);
+
+	if (rte_eal_alarm_set(US_PER_MS, bnxt_dev_reset_and_resume,
+			      (void *)bp)) {
+		PMD_DRV_LOG_LINE(ERR,
+			    "Port %u: Failed to schedule FUNC_ERROR reinit -- "
+			    "HWRM_FUNC_RESET already reclaimed all resources, "
+			    "marking port fatal",
+			    bp->eth_dev->data->port_id);
+		/* Nothing will ever call bnxt_dev_reset_and_resume() to
+		 * rebuild the rings/VNICs HWRM_FUNC_RESET just reclaimed --
+		 * clearing PXP_ERROR/FW_RESET here would leave the driver
+		 * thinking the port is healthy when it has no resources left.
+		 */
+		pthread_mutex_lock(&bp->err_recovery_lock);
+		bp->flags |= BNXT_FLAG_FATAL_ERROR;
+		bp->flags &= ~(BNXT_FLAG_PXP_ERROR | BNXT_FLAG_FW_RESET);
+		pthread_mutex_unlock(&bp->err_recovery_lock);
+		bnxt_func_error_clear_pending(bp);
+	}
+}
+
+static void bnxt_func_error_poll_cb(void *arg)
+{
+	struct bnxt *bp = arg;
+
+	if (!rte_atomic_load_explicit(&bp->func_error_info->support,
+				      rte_memory_order_relaxed))
+		return;
+
+	if (!rte_atomic_load_explicit(&bp->func_error_info->recovery_pending,
+				      rte_memory_order_acquire))
+		bnxt_hwrm_func_error_poll(bp);
+
+	/* bnxt_cancel_func_error_poll() clears poll_scheduled before calling
+	 * rte_eal_alarm_cancel(), which blocks until this callback (if
+	 * already running) returns -- re-check here so a cancel that landed
+	 * while this invocation was in flight isn't outrun by this rearm.
+	 */
+	if (rte_atomic_load_explicit(&bp->func_error_info->poll_scheduled,
+				     rte_memory_order_acquire) &&
+	    rte_eal_alarm_set(US_PER_S, bnxt_func_error_poll_cb, (void *)bp) != 0)
+		rte_atomic_store_explicit(&bp->func_error_info->poll_scheduled, 0,
+					  rte_memory_order_release);
+}
+
+void bnxt_schedule_func_error_poll(struct bnxt *bp)
+{
+	if (!rte_atomic_load_explicit(&bp->func_error_info->support,
+				      rte_memory_order_relaxed) ||
+	    rte_atomic_load_explicit(&bp->func_error_info->poll_scheduled,
+				     rte_memory_order_acquire))
+		return;
+
+	if (rte_eal_alarm_set(US_PER_S, bnxt_func_error_poll_cb, (void *)bp) != 0)
+		return;
+
+	rte_atomic_store_explicit(&bp->func_error_info->poll_scheduled, 1,
+				  rte_memory_order_release);
+}
+
+void bnxt_cancel_func_error_poll(struct bnxt *bp)
+{
+	if (!rte_atomic_load_explicit(&bp->func_error_info->poll_scheduled,
+				      rte_memory_order_acquire))
+		return;
+
+	/* Clear before cancelling: rte_eal_alarm_cancel() blocks until an
+	 * in-flight invocation of the callback returns, and that invocation
+	 * re-checks this flag right before its own rearm -- clearing first
+	 * closes the window where it could rearm after cancel returns.
+	 */
+	rte_atomic_store_explicit(&bp->func_error_info->poll_scheduled, 0,
+				  rte_memory_order_release);
+	rte_eal_alarm_cancel(bnxt_func_error_poll_cb, (void *)bp);
+}
+
+int bnxt_parse_devarg_func_error_support(const char *key __rte_unused,
+					  const char *value, void *opaque_arg)
+{
+	struct bnxt *bp = opaque_arg;
+	unsigned long func_error_support;
+	char *end = NULL;
+
+	if (!value || !opaque_arg) {
+		PMD_DRV_LOG_LINE(ERR,
+			    "Invalid parameter passed to func-error-support "
+			    "devargs.");
+		return -EINVAL;
+	}
+
+	func_error_support = strtoul(value, &end, 10);
+	if (end == NULL || *end != '\0' ||
+	    (func_error_support == ULONG_MAX && errno == ERANGE)) {
+		PMD_DRV_LOG_LINE(ERR,
+			    "Invalid parameter passed to func-error-support "
+			    "devargs.");
+		return -EINVAL;
+	}
+
+	if (BNXT_DEVARG_FUNC_ERROR_SUPPORT_INVALID(func_error_support)) {
+		PMD_DRV_LOG_LINE(ERR, "Invalid func-error-support(%d) devargs.",
+			    (uint8_t)func_error_support);
+		return -EINVAL;
+	}
+
+	rte_atomic_store_explicit(&bp->func_error_info->support,
+				  func_error_support, rte_memory_order_relaxed);
+	if (func_error_support)
+		PMD_DRV_LOG_LINE(INFO,
+			    "func-error-support=1: FUNC_ERROR/PXP_ERROR "
+			    "recovery opted in.");
+
+	return 0;
+}
diff --git a/drivers/net/bnxt/bnxt_func_error.h b/drivers/net/bnxt/bnxt_func_error.h
new file mode 100644
index 00000000000..f0797157bf5
--- /dev/null
+++ b/drivers/net/bnxt/bnxt_func_error.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Broadcom
+ * All rights reserved.
+ */
+
+#ifndef _BNXT_FUNC_ERROR_H_
+#define _BNXT_FUNC_ERROR_H_
+
+#include "bnxt.h"
+
+#define BNXT_DEVARG_FUNC_ERROR_SUPPORT "func-error-support"
+#define BNXT_DEVARG_FUNC_ERROR_SUPPORT_INVALID(val)	((val) > 1)
+
+struct bnxt_func_error_info {
+	uint8_t __rte_atomic support;
+	unsigned int __rte_atomic recovery_pending;
+	uint64_t __rte_atomic recovery_count;
+	uint64_t __rte_atomic oerrors;
+	unsigned int __rte_atomic poll_scheduled;
+};
+
+int bnxt_func_error_info_alloc(struct bnxt *bp);
+void bnxt_func_error_info_free(struct bnxt *bp);
+
+void bnxt_func_error_trigger_recovery(struct bnxt *bp);
+void bnxt_func_error_recovery_cb(void *arg);
+void bnxt_func_error_clear_pending(struct bnxt *bp);
+void bnxt_schedule_func_error_poll(struct bnxt *bp);
+void bnxt_cancel_func_error_poll(struct bnxt *bp);
+int bnxt_parse_devarg_func_error_support(const char *key, const char *value,
+					  void *opaque_arg);
+
+#endif /* _BNXT_FUNC_ERROR_H_ */
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 870411ace90..0226bca6979 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -15,6 +15,7 @@
 
 #include "bnxt.h"
 #include "bnxt_filter.h"
+#include "bnxt_func_error.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_rxq.h"
 #include "bnxt_rxr.h"
@@ -501,6 +502,12 @@ static int bnxt_hwrm_send_message(struct bnxt *bp, void *msg,
 	if (bp->flags & BNXT_FLAG_FATAL_ERROR)
 		return 0;
 
+	/* HWRM_FUNC_RESET already reclaimed every ring/VNIC/stat-ctx for this
+	 * function; skip the redundant per-resource frees during cleanup.
+	 */
+	if (bp->flags & BNXT_FLAG_PXP_ERROR)
+		return 0;
+
 	/* If previous HWRM command timed out, do not send new HWRM command */
 	if (bp->flags & BNXT_FLAG_FW_TIMEDOUT)
 		return 0;
@@ -611,6 +618,15 @@ static int bnxt_hwrm_send_message(struct bnxt *bp, void *msg,
 		bp->flags |= BNXT_FLAG_FW_TIMEDOUT;
 		return -ETIMEDOUT;
 	}
+
+	/* Any HWRM command can be rejected with this once the function
+	 * enters FUNC_ERROR state; it's the only way the driver finds out.
+	 */
+	if (rte_atomic_load_explicit(&bp->func_error_info->support,
+				     rte_memory_order_relaxed) &&
+	    rte_le_to_cpu_16(resp->error_code) == HWRM_ERR_CODE_FUNC_RESET_REQUIRED)
+		bnxt_func_error_trigger_recovery(bp);
+
 	return 0;
 }
 
@@ -1375,6 +1391,9 @@ int bnxt_hwrm_func_driver_register(struct bnxt *bp)
 		flags = HWRM_FUNC_DRV_RGTR_INPUT_FLAGS_HOT_RESET_SUPPORT;
 	if (bp->fw_cap & BNXT_FW_CAP_ERROR_RECOVERY)
 		flags |= HWRM_FUNC_DRV_RGTR_INPUT_FLAGS_ERROR_RECOVERY_SUPPORT;
+	if (rte_atomic_load_explicit(&bp->func_error_info->support,
+				     rte_memory_order_relaxed))
+		flags |= HWRM_FUNC_DRV_RGTR_INPUT_FLAGS_PXP_ERROR_SUPPORT;
 
 	/* PFs and trusted VFs should indicate the support of the
 	 * Master capability on non Stingray platform
@@ -1441,6 +1460,74 @@ int bnxt_hwrm_func_driver_register(struct bnxt *bp)
 	return rc;
 }
 
+int bnxt_hwrm_func_error_poll(struct bnxt *bp)
+{
+	struct hwrm_ver_get_input req = {.req_type = 0 };
+	struct hwrm_ver_get_output *resp = bp->hwrm_cmd_resp_addr;
+	int rc;
+
+	HWRM_PREP(&req, HWRM_VER_GET, BNXT_USE_CHIMP_MB);
+
+	req.hwrm_intf_maj = HWRM_VERSION_MAJOR;
+	req.hwrm_intf_min = HWRM_VERSION_MINOR;
+	req.hwrm_intf_upd = HWRM_VERSION_UPDATE;
+
+	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHIMP_MB);
+	HWRM_CHECK_RESULT_SILENT();
+	HWRM_UNLOCK();
+
+	return rc;
+}
+
+/* Called before BNXT_FLAG_PXP_ERROR is set, so not blocked by the
+ * post-reset HWRM gate, and safe to call before the HWRM_FUNC_RESET
+ * that clears the error state. Failure here is
+ * non-fatal to recovery, so callers only need to log it.
+ */
+int bnxt_hwrm_func_error_query(struct bnxt *bp)
+{
+	struct hwrm_func_error_query_input req = {.req_type = 0 };
+	struct hwrm_func_error_query_output *resp = bp->hwrm_cmd_resp_addr;
+	int rc;
+
+	HWRM_PREP(&req, HWRM_FUNC_ERROR_QUERY, BNXT_USE_CHIMP_MB);
+
+	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHIMP_MB);
+	HWRM_CHECK_RESULT();
+
+	if (resp->func_error_type != HWRM_FUNC_ERROR_QUERY_OUTPUT_FUNC_ERROR_TYPE_PXP_ERROR) {
+		/* Unexpected here -- only called from the recovery path. */
+		PMD_DRV_LOG_LINE(INFO,
+			    "Port %u: FUNC_ERROR diag: function not in FUNC_ERROR "
+			    "state (func_error_type=%u)",
+			    bp->eth_dev->data->port_id, resp->func_error_type);
+	} else if (resp->client_err == 0) {
+		/* Fault was propagated from a parent PF, not captured
+		 * directly on this function.
+		 */
+		PMD_DRV_LOG_LINE(INFO,
+			    "Port %u: FUNC_ERROR diag: no direct fault captured "
+			    "on this function (parent PF fault propagation)",
+			    bp->eth_dev->data->port_id);
+	} else {
+		rte_atomic_fetch_add_explicit(&bp->func_error_info->oerrors, 1,
+					      rte_memory_order_relaxed);
+		PMD_DRV_LOG_LINE(ERR,
+			    "Port %u: FUNC_ERROR diag: client_id=%u client_err=%#x "
+			    "bad_dma_addr=%#" PRIx64 " (valid=%u) req_sig=%#x",
+			    bp->eth_dev->data->port_id, resp->client_id,
+			    rte_le_to_cpu_16(resp->client_err),
+			    rte_le_to_cpu_64(resp->bad_dma_addr),
+			    !!(rte_le_to_cpu_32(resp->flags) &
+			       HWRM_FUNC_ERROR_QUERY_OUTPUT_FLAGS_BAD_DMA_ADDR_VALID),
+			    rte_le_to_cpu_32(resp->client_req_sig));
+	}
+
+	HWRM_UNLOCK();
+
+	return rc;
+}
+
 int bnxt_hwrm_check_vf_rings(struct bnxt *bp)
 {
 	if (!(BNXT_VF(bp) && (bp->flags & BNXT_FLAG_NEW_RM)))
diff --git a/drivers/net/bnxt/bnxt_hwrm.h b/drivers/net/bnxt/bnxt_hwrm.h
index 1dd66710462..9fe0202174e 100644
--- a/drivers/net/bnxt/bnxt_hwrm.h
+++ b/drivers/net/bnxt/bnxt_hwrm.h
@@ -202,6 +202,8 @@ int bnxt_hwrm_fwd_resp(struct bnxt *bp, uint16_t target_id,
 int bnxt_hwrm_func_buf_rgtr(struct bnxt *bp, int num_vfs);
 int bnxt_hwrm_func_buf_unrgtr(struct bnxt *bp);
 int bnxt_hwrm_func_driver_register(struct bnxt *bp);
+int bnxt_hwrm_func_error_query(struct bnxt *bp);
+int bnxt_hwrm_func_error_poll(struct bnxt *bp);
 int bnxt_hwrm_func_qcaps(struct bnxt *bp);
 int bnxt_hwrm_func_reset(struct bnxt *bp);
 int bnxt_hwrm_func_driver_unregister(struct bnxt *bp);
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 1c3c6b209ba..867483a514a 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -11,6 +11,7 @@
 #include "bnxt.h"
 #include "bnxt_cpr.h"
 #include "bnxt_filter.h"
+#include "bnxt_func_error.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_rxq.h"
 #include "bnxt_stats.h"
@@ -653,6 +654,9 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 	struct bnxt *bp = eth_dev->data->dev_private;
 	unsigned int num_q_stats;
 
+	bnxt_stats->oerrors += rte_atomic_load_explicit(&bp->func_error_info->oerrors,
+						     rte_memory_order_relaxed);
+
 	num_q_stats = RTE_MIN(bp->rx_cp_nr_rings, eth_dev->data->nb_rx_queues);
 	for (i = 0; i < bp->rx_cp_nr_rings; i++) {
 		struct bnxt_rx_queue *rxq = bp->rx_queues[i];
@@ -718,6 +722,9 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 	if (BNXT_TPA_V2_P7(bp))
 		return bnxt_stats_get_ext(eth_dev, bnxt_stats, qstats);
 
+	bnxt_stats->oerrors += rte_atomic_load_explicit(&bp->func_error_info->oerrors,
+					     rte_memory_order_relaxed);
+
 	num_q_stats = RTE_MIN(bp->rx_cp_nr_rings, eth_dev->data->nb_rx_queues);
 	for (i = 0; i < bp->rx_cp_nr_rings; i++) {
 		struct bnxt_rx_queue *rxq = bp->rx_queues[i];
@@ -817,6 +824,11 @@ int bnxt_stats_reset_op(struct rte_eth_dev *eth_dev)
 					  rte_memory_order_relaxed);
 	}
 
+	rte_atomic_store_explicit(&bp->func_error_info->recovery_count, 0,
+				  rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&bp->func_error_info->oerrors, 0,
+				  rte_memory_order_relaxed);
+
 	bnxt_clear_prev_stat(bp);
 
 	return ret;
@@ -1049,6 +1061,11 @@ int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
 						 rte_memory_order_relaxed);
 	count++;
 
+	xstats[count].id = count;
+	xstats[count].value = rte_atomic_load_explicit(&bp->func_error_info->recovery_count,
+							rte_memory_order_relaxed);
+	count++;
+
 	if (bp->fw_cap & BNXT_FW_CAP_ADV_FLOW_COUNTERS &&
 	    bp->fw_cap & BNXT_FW_CAP_ADV_FLOW_MGMT &&
 	    BNXT_FLOW_XSTATS_EN(bp)) {
@@ -1182,6 +1199,10 @@ int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
 		sizeof(xstats_names[count].name));
 	count++;
 
+	rte_strscpy(xstats_names[count].name, "func_error_recovery",
+		    sizeof(xstats_names[count].name));
+	count++;
+
 	if (bp->fw_cap & BNXT_FW_CAP_ADV_FLOW_COUNTERS &&
 	    bp->fw_cap & BNXT_FW_CAP_ADV_FLOW_MGMT &&
 	    BNXT_FLOW_XSTATS_EN(bp)) {
diff --git a/drivers/net/bnxt/bnxt_stats.h b/drivers/net/bnxt/bnxt_stats.h
index 534b9af5e80..f3df6d988d1 100644
--- a/drivers/net/bnxt/bnxt_stats.h
+++ b/drivers/net/bnxt/bnxt_stats.h
@@ -9,7 +9,7 @@
 #include <ethdev_driver.h>
 
 /* Number of software (non-HWRM) xstats appended after the FW-reported ones. */
-#define BNXT_NUM_SW_XSTATS		1
+#define BNXT_NUM_SW_XSTATS		2
 
 void bnxt_free_stats(struct bnxt *bp);
 int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
diff --git a/drivers/net/bnxt/hsi_struct_def_dpdk.h b/drivers/net/bnxt/hsi_struct_def_dpdk.h
index 1a8874f5b62..335b8dbc3ae 100644
--- a/drivers/net/bnxt/hsi_struct_def_dpdk.h
+++ b/drivers/net/bnxt/hsi_struct_def_dpdk.h
@@ -293,6 +293,11 @@ struct __rte_packed_begin cmd_nums {
 	#define HWRM_FUNC_VF_RESC_FREE                    UINT32_C(0x1b)
 	#define HWRM_FUNC_VF_VNIC_IDS_QUERY               UINT32_C(0x1c)
 	#define HWRM_FUNC_DRV_RGTR                        UINT32_C(0x1d)
+	/*
+	 * This command is used to query detailed diagnostic data when a
+	 * function is in the FUNC_ERROR state.
+	 */
+	#define HWRM_FUNC_ERROR_QUERY                     UINT32_C(0x1cb)
 	#define HWRM_FUNC_DRV_QVER                        UINT32_C(0x1e)
 	#define HWRM_FUNC_BUF_RGTR                        UINT32_C(0x1f)
 	#define HWRM_PORT_PHY_CFG                         UINT32_C(0x20)
@@ -1174,6 +1179,14 @@ struct __rte_packed_begin ret_codes {
 	 * requested by the host is not present or does not exist.
 	 */
 	#define HWRM_ERR_CODE_ENTITY_NOT_PRESENT           UINT32_C(0x13)
+	/*
+	 * This error code is reported by Firmware when a command cannot be
+	 * processed because the function is in the FUNC_ERROR state. The
+	 * driver must issue HWRM_FUNC_RESET to clear the error state before
+	 * resubmitting any gated commands. This code is returned for both PF
+	 * and VF functions in the FUNC_ERROR state.
+	 */
+	#define HWRM_ERR_CODE_FUNC_RESET_REQUIRED          UINT32_C(0x15)
 	/*
 	 * This value indicates that the HWRM response is in TLV format and
 	 * should be interpreted as one or more TLVs starting with the
@@ -18343,6 +18356,17 @@ struct __rte_packed_begin hwrm_func_drv_rgtr_input {
 	 */
 	#define HWRM_FUNC_DRV_RGTR_INPUT_FLAGS_TF_INGRESS_NIC_FLOW_MODE \
 		UINT32_C(0x800)
+	/*
+	 * When this bit is '1', the function driver is indicating support
+	 * for the FUNC_ERROR state machine. If a hardware error (like a PXP
+	 * DMA error) occurs, firmware will leave the function blocked and
+	 * reject subsequent HWRM commands with
+	 * HWRM_ERR_CODE_FUNC_RESET_REQUIRED until the driver issues
+	 * HWRM_FUNC_RESET. If '0', firmware falls back to legacy
+	 * silent-clear behavior.
+	 */
+	#define HWRM_FUNC_DRV_RGTR_INPUT_FLAGS_PXP_ERROR_SUPPORT \
+		UINT32_C(0x4000)
 	uint32_t	enables;
 	/*
 	 * This bit must be '1' for the os_type field to be
@@ -26677,6 +26701,112 @@ struct __rte_packed_begin hwrm_func_vlan_qcfg_output {
 	uint8_t	valid;
 } __rte_packed_end;
 
+/*************************
+ * hwrm_func_error_query *
+ *************************/
+
+
+/* hwrm_func_error_query_input (size:192b/24B) */
+struct __rte_packed_begin hwrm_func_error_query_input {
+	/* The HWRM command request type. */
+	uint16_t	req_type;
+	/*
+	 * The completion ring to send the completion event on. This should
+	 * be the NQ ID returned from the `nq_alloc` HWRM command.
+	 */
+	uint16_t	cmpl_ring;
+	/*
+	 * The sequence ID is used by the driver for tracking multiple
+	 * commands. This ID is treated as opaque data by the firmware and
+	 * the value is returned in the `hwrm_resp_hdr` upon completion.
+	 */
+	uint16_t	seq_id;
+	/*
+	 * The target ID of the command:
+	 * * 0x0-0xFFF8 - The function ID
+	 * * 0xFFF8-0xFFFC, 0xFFFE - Reserved for internal processors
+	 * * 0xFFFD - Reserved for user-space HWRM interface
+	 * * 0xFFFF - HWRM
+	 */
+	uint16_t	target_id;
+	/*
+	 * A physical address pointer pointing to a host buffer that the
+	 * command's response data will be written. This can be either a host
+	 * physical address (HPA) or a guest physical address (GPA) and must
+	 * point to a physically contiguous block of memory.
+	 */
+	uint64_t	resp_addr;
+	uint8_t	unused_0[8];
+} __rte_packed_end;
+
+/* hwrm_func_error_query_output (size:256b/32B) */
+struct __rte_packed_begin hwrm_func_error_query_output {
+	/* The specific error status for the command. */
+	uint16_t	error_code;
+	/* The HWRM command request type. */
+	uint16_t	req_type;
+	/* The sequence ID from the original command. */
+	uint16_t	seq_id;
+	/* The length of the response data in number of bytes. */
+	uint16_t	resp_len;
+	/*
+	 * The type of error that caused the FUNC_ERROR state. If the function
+	 * is not currently in FUNC_ERROR state, this field is set to none (0)
+	 * and all other error fields are zeroed.
+	 */
+	uint8_t	func_error_type;
+	/* No FUNC_ERROR is active. The function is operating normally. */
+	#define HWRM_FUNC_ERROR_QUERY_OUTPUT_FUNC_ERROR_TYPE_NONE \
+		UINT32_C(0x0)
+	/* A PXP error occurred (e.g., PCIe transaction error). */
+	#define HWRM_FUNC_ERROR_QUERY_OUTPUT_FUNC_ERROR_TYPE_PXP_ERROR \
+		UINT32_C(0x1)
+	#define HWRM_FUNC_ERROR_QUERY_OUTPUT_FUNC_ERROR_TYPE_LAST \
+		HWRM_FUNC_ERROR_QUERY_OUTPUT_FUNC_ERROR_TYPE_PXP_ERROR
+	/*
+	 * The internal hardware client ID that caused the error
+	 * (e.g., TX engine, RX engine).
+	 */
+	uint8_t	client_id;
+	/*
+	 * The specific hardware error code (e.g., 4K boundary violation,
+	 * poison TLP). A value of 0 indicates no direct fault was captured
+	 * on this function; the function was placed into FUNC_ERROR by
+	 * parent PF fault propagation.
+	 */
+	uint16_t	client_err;
+	uint32_t	flags;
+	/*
+	 * If set to 1, the bad_dma_addr field contains a validly
+	 * captured host memory address that is bad and triggered
+	 * the fault.
+	 */
+	#define HWRM_FUNC_ERROR_QUERY_OUTPUT_FLAGS_BAD_DMA_ADDR_VALID \
+		UINT32_C(0x1)
+	/*
+	 * The 64-bit host memory address that triggered the fault (stashed
+	 * by firmware at the time of the error). Check bad_dma_addr_valid
+	 * before using this field.
+	 */
+	uint64_t	bad_dma_addr;
+	/*
+	 * The hardware-captured signature of the client request that
+	 * triggered the fault. This is an opaque value stashed by firmware
+	 * at the time of the error; log verbatim for offline diagnostic
+	 * correlation. Valid when func_error_type is pxp_error.
+	 */
+	uint32_t	client_req_sig;
+	uint8_t	unused_1[3];
+	/*
+	 * This field is used in output records to indicate that the output
+	 * is completely written to host memory. This field should be read as
+	 * '1' to indicate that the output has been completely written. When
+	 * writing a command completion or response to an internal processor,
+	 * the order of writes has to be such that this field is written last.
+	 */
+	uint8_t	valid;
+} __rte_packed_end;
+
 /**********************
  * hwrm_func_vlan_cfg *
  **********************/
diff --git a/drivers/net/bnxt/meson.build b/drivers/net/bnxt/meson.build
index dc122fb3dff..67bfd3f79b6 100644
--- a/drivers/net/bnxt/meson.build
+++ b/drivers/net/bnxt/meson.build
@@ -35,6 +35,7 @@ sources = files(
         'bnxt_ethdev.c',
         'bnxt_filter.c',
         'bnxt_flow.c',
+        'bnxt_func_error.c',
         'bnxt_hwrm.c',
         'bnxt_irq.c',
         'bnxt_mpc.c',
