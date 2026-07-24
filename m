Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F868C531F9
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Jul 2026 21:23:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B1CE406B6;
	Fri, 24 Jul 2026 23:22:48 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id BA27A402DA
 for <dev@dpdk.org>; Fri, 24 Jul 2026 23:22:45 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso577397a12.1
 for <dev@dpdk.org>; Fri, 24 Jul 2026 14:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784928165;
 x=1785532965; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+8dTQqjWaGzvVn/47GvJDEZdZjJs9mQn+AudmDBF4Q0=;
 b=Hz+7ykyX7YrT8zEky6Bl1AIZpxkkylPS/6XlBRsDZYv5V8DW5+gyxgD6G2YW6EmGAK
 jhB5j2iv5Cw6P2mw8iKo6WSuzeU7W8tBmw6UVmdc7hu+DJ04u68C5zHLAoVfhGtC5wKK
 PQa90MSiNMWCFMyvLGYeZg3BmewcDdi+xyNdYk+0+oFM10z00ZWWA7yCV7fFjdfLEMtW
 Dtey4GPff+Xqj2kMFpD4iCn09D5d9J7BdA2cZw4BFgQLBf/xwB1s2y8Nf4/rggtPYj4k
 Xq5vpzh+flhwAB1xaZfpmM4SQFQvxwEFOgHRjIgBSkxa3MvHw06Zzz6VpVeKKpicslev
 OcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784928165; x=1785532965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+8dTQqjWaGzvVn/47GvJDEZdZjJs9mQn+AudmDBF4Q0=;
 b=MRocUwK82lIfiztUsep+Phs31NS3k2IkW9RFkUmMAb32n+2AmXxOWEGdTituNrISZW
 1wnQextkBrBMroNtV7eVaETy+8+rfBH4CesvjKPRmXM9YIw3/t9qDMSlImQt2IEXNBUf
 KhNnZpDh7vQKXmFAG58px1WqZWDpHcLCEUbYFFKsGB4H6MSxTYSsHoW4g6/kxyWPQx8p
 uctabEdkyqljYMbomaU3bSmtKzUTSbreSdQUoc91ETdrdsVfodsas6aenQ3LdCztIqO7
 wuold5B7zE73LItEBMclM3NTsXOQDKAeDp7LSSArq6/7Rg+watf8P9kHHYJbxrUbbnPs
 8xuA==
X-Gm-Message-State: AOJu0YzBLXjsM2wP1mxF5kztCDQn1iOmuP9/ex7dkJ9XYD70naQj9eB+
 QuLyxzvcf6lZ13mtF1dCSbsKyJcNoY8/MIHZyAtF3JoCLAcuAQ9PKlDhrq1cFn1+ws5l2pNmkff
 czC1J
X-Gm-Gg: AR+sD11Kwf/mXWIJ2QpQY09KMU/bHIKui26+ljOR37Qi7xchZ5A/DRKA8y7FIE2O+Jh
 w4X59zin96PiuQIqdng7j0NhZLdoKgkgzNX0uyCxRbMOZw9wuIhko3qXUyiP/ssXArrDR4hHM+g
 1lw5ewJMWbKitDtMG4BU4cixl1VAYJXIlc8p6z/+iw0LxucBVs295zFH5P51qLyTgw3c2mnEjEc
 oaCaGVS0oP6dSaDEDz6Sr6RZDIpTENuAmlOFVNUCYbzk7a1CbRN8g8lBCcEhJIeNVU5GngvqpYY
 8CxFUSgjsTOidoemSD+omYAa8a8cOQekC0nGds14DNPbgZDyJbEANXSUxV+AKgysMdWilehk0a8
 qDQplfJ1qllthhaHAAQ/HUMa0cBUWLZGDahUYX6rAbJrUcgCU7buSRRlwIofeYgsAqogfvSHRAf
 l/kF6Le9CaSopVKbrun4+i81Z2JSe6W3Ac5h4DCOmi
X-Received: by 2002:a05:6a21:a05:b0:3c3:388d:70e6 with SMTP id
 adf61e73a8af0-3c67e0f163bmr28274637.60.1784928164555; 
 Fri, 24 Jul 2026 14:22:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc548efesm2612725eec.14.2026.07.24.14.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 14:22:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 2/5] capture: infrastructure wireshark packet capture
Date: Fri, 24 Jul 2026 14:11:54 -0700
Message-ID: <20260724212238.864798-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724212238.864798-1-stephen@networkplumber.org>
References: <20260724212238.864798-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This provides a telemetry extension to provide packet capture.
It is intended to be used with a front end script to provide
external packet capture for wireshark.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                            |    1 +
 doc/guides/rel_notes/release_26_11.rst |    4 +
 lib/capture/capture.c                  | 1032 ++++++++++++++++++++++++
 lib/capture/capture_impl.h             |   56 ++
 lib/capture/filter.c                   |  108 +++
 lib/capture/meson.build                |   19 +
 lib/meson.build                        |    1 +
 7 files changed, 1221 insertions(+)
 create mode 100644 lib/capture/capture.c
 create mode 100644 lib/capture/capture_impl.h
 create mode 100644 lib/capture/filter.c
 create mode 100644 lib/capture/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..fcd350ad94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1720,6 +1720,7 @@ F: doc/guides/sample_app_ug/qos_scheduler.rst
 Packet capture
 M: Reshma Pattan <reshma.pattan@intel.com>
 M: Stephen Hemminger <stephen@networkplumber.org>
+F: lib/capture/
 F: lib/pdump/
 F: doc/guides/prog_guide/pdump_lib.rst
 F: app/test/test_pdump.*
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index b27494fee7..8291c2c4e5 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added wireshark capture support.**
+
+  * Added ``capture`` library for packet capture via telemetry API.
+
 
 Removed Items
 -------------
diff --git a/lib/capture/capture.c b/lib/capture/capture.c
new file mode 100644
index 0000000000..1b115ccf4a
--- /dev/null
+++ b/lib/capture/capture.c
@@ -0,0 +1,1032 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <net/if.h>
+#include <poll.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/queue.h>
+#include <sys/stat.h>
+#include <sys/utsname.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <rte_branch_prediction.h>
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_debug.h>
+#include <rte_ethdev.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_memory.h>
+#include <rte_mempool.h>
+#include <rte_mbuf.h>
+#include <rte_pcapng.h>
+#include <rte_pause.h>
+#include <rte_ring.h>
+#include <rte_spinlock.h>
+#include <rte_stdatomic.h>
+#include <rte_string_fns.h>
+#include <rte_telemetry.h>
+#include <rte_thread.h>
+#include <rte_version.h>
+
+#include "capture_impl.h"
+
+#define CAPTURE_EXTCAP_PREFIX	"dpdk"
+#define CAP_CMD_MAX		1024
+#define DEFAULT_SNAPLEN		262144u	/* from tcpdump et.al. */
+#define CAPTURE_BURST_SIZE	32u
+#define MBUF_POOL_CACHE_SIZE	32
+#define CAPTURE_RING_SIZE	256
+#define CAPTURE_POOL_SIZE	1024
+#define SLEEP_THRESHOLD		100
+#define SLEEP_US		100
+
+#define ALL_QUEUES		-1
+
+RTE_LOG_REGISTER_DEFAULT(rte_capture_logtype, NOTICE);
+
+/*
+ * List of active captures.
+ *
+ * This is a control-plane only structure: it is created, walked and torn down
+ * from the telemetry handler thread and from the per-capture drain threads,
+ * never from the dataplane. A plain spinlock is therefore enough; the EAL
+ * shared tailq (rte_tailq) is not used because captures are not visible to
+ * secondary processes in this design.
+ */
+TAILQ_HEAD(capture_list, capture);
+static struct capture_list capture_list = TAILQ_HEAD_INITIALIZER(capture_list);
+static rte_spinlock_t capture_lock = RTE_SPINLOCK_INITIALIZER;
+
+/* Parameter values: only used on stack inside parsing */
+struct capture_config {
+	uint16_t port_id;
+	uint32_t snaplen;
+	int queue;
+	const char *filter_str;
+	const char *output;
+};
+
+/*
+ * Data used by callback
+ * This per-queue to avoid cache thrashing
+ */
+struct __rte_cache_aligned capture_rxtx_cb {
+	RTE_ATOMIC(uint32_t) use_count;
+	const struct rte_eth_rxtx_callback *cb;
+
+	struct capture_stats {
+		RTE_ATOMIC(uint64_t) accepted; /**< Number of packets accepted by filter. */
+		RTE_ATOMIC(uint64_t) filtered; /**< Number of packets rejected by filter. */
+		RTE_ATOMIC(uint64_t) nombuf;   /**< Number of mbuf allocation failures. */
+		RTE_ATOMIC(uint64_t) ringfull; /**< Number of missed packets due to ring full. */
+	} stats;
+};
+
+/*
+ * Per-capture instance state.
+ */
+struct capture {
+	RTE_ATOMIC(bool) running;
+	struct rte_capture_filter *filter;
+	struct rte_ring *ring;		/* ring from dataplane to capture thread */
+	struct rte_mempool *mp;		/* mempool for capture mbufs */
+
+	uint32_t snaplen;		/* amount of data to copy */
+	int queue;
+	uint16_t tx_queues;
+	uint16_t rx_queues;
+	uint16_t port_id;
+
+	unsigned int idx;
+	char *output;			/* filename of out */
+
+	TAILQ_ENTRY(capture) next;	/* links into capture_list */
+
+	/* per-queue data sized to max(tx_queue, rx_queues) */
+	struct capture_cbs {
+		struct capture_rxtx_cb tx_cb;
+		struct capture_rxtx_cb rx_cb;
+	} cbs[];
+};
+
+/* Wait for callbacks to be idle before free */
+static void
+capture_cb_wait(struct capture_rxtx_cb *cbs)
+{
+	/* make sure all previous loads and stores are completed */
+	rte_atomic_thread_fence(rte_memory_order_seq_cst);
+	uint32_t puse = rte_atomic_load_explicit(&cbs->use_count,
+						 rte_memory_order_acquire);
+
+	/* in use, busy wait till current RX/TX iteration is finished */
+	if (puse & 1)
+		RTE_WAIT_UNTIL_MASKED(&cbs->use_count, UINT32_MAX, !=, puse,
+				      rte_memory_order_acquire);
+}
+
+/* Mark datapath iteration in progress: count becomes odd. */
+static inline __rte_hot void
+capture_cb_hold(struct capture_rxtx_cb *cbs)
+{
+	rte_atomic_fetch_add_explicit(&cbs->use_count, 1, rte_memory_order_seq_cst);
+}
+
+/* Iteration finished: count becomes even again. */
+static inline __rte_hot void
+capture_cb_release(struct capture_rxtx_cb *cbs)
+{
+	rte_atomic_fetch_add_explicit(&cbs->use_count, 1, rte_memory_order_release);
+}
+
+/* Create a clone of mbuf to be placed into ring. */
+static inline __rte_hot void
+capture_copy_burst(uint16_t port_id, uint16_t queue_id,
+		   enum rte_pcapng_direction direction,
+		   struct rte_mbuf **pkts, unsigned int nb_pkts,
+		   const struct capture *cap,
+		   struct capture_stats *stats)
+{
+	unsigned int i, ring_enq, d_pkts = 0;
+	struct rte_mbuf *dup_bufs[CAPTURE_BURST_SIZE]; /* duplicated packets */
+	struct rte_ring *ring = cap->ring;
+	struct rte_mempool *mp = cap->mp;
+	uint32_t snaplen = cap->snaplen;
+	struct rte_mbuf *p;
+
+	RTE_ASSERT(nb_pkts <= CAPTURE_BURST_SIZE);
+
+	for (i = 0; i < nb_pkts; i++) {
+		/*
+		 * This uses same BPF return value convention as socket filter
+		 * and pcap_offline_filter. If program returns zero then packet
+		 * doesn't match the filter (will be ignored).
+		 */
+		if (cap->filter) {
+			if (__rte_capture_filter(cap->filter, pkts[i]) == 0) {
+				rte_atomic_fetch_add_explicit(&stats->filtered, 1,
+							      rte_memory_order_relaxed);
+				continue;
+			}
+		}
+
+		p = rte_pcapng_copy(port_id, queue_id, pkts[i], mp, snaplen, direction, NULL);
+		if (unlikely(p == NULL))
+			rte_atomic_fetch_add_explicit(&stats->nombuf, 1, rte_memory_order_relaxed);
+		else
+			dup_bufs[d_pkts++] = p;
+	}
+
+	if (d_pkts == 0)
+		return;
+
+	rte_atomic_fetch_add_explicit(&stats->accepted, d_pkts, rte_memory_order_relaxed);
+
+	ring_enq = rte_ring_enqueue_burst(ring, (void *)&dup_bufs[0], d_pkts, NULL);
+	if (unlikely(ring_enq < d_pkts)) {
+		unsigned int drops = d_pkts - ring_enq;
+
+		rte_atomic_fetch_add_explicit(&stats->ringfull, drops, rte_memory_order_relaxed);
+		rte_pktmbuf_free_bulk(&dup_bufs[ring_enq], drops);
+	}
+}
+
+/* Create a clone of mbuf to be placed into ring. */
+static __rte_hot inline void
+capture_copy(uint16_t port_id, uint16_t queue_id,
+	     enum rte_pcapng_direction direction,
+	     struct rte_mbuf **pkts, uint16_t nb_pkts,
+	     const struct capture *cap,
+	     struct capture_stats *stats)
+{
+	unsigned int offs = 0;
+
+	do {
+		unsigned int n = RTE_MIN(nb_pkts - offs, CAPTURE_BURST_SIZE);
+
+		capture_copy_burst(port_id, queue_id, direction, &pkts[offs], n, cap, stats);
+		offs += n;
+	} while (offs < nb_pkts);
+}
+
+static __rte_hot uint16_t
+capture_rx(uint16_t port, uint16_t queue,
+	struct rte_mbuf **pkts, uint16_t nb_pkts,
+	uint16_t max_pkts __rte_unused, void *user_params)
+{
+	struct capture *cap = user_params;
+	struct capture_rxtx_cb *cbs = &cap->cbs[queue].rx_cb;
+
+	capture_cb_hold(cbs);
+	capture_copy(port, queue, RTE_PCAPNG_DIRECTION_IN, pkts, nb_pkts, cap, &cbs->stats);
+	capture_cb_release(cbs);
+
+	return nb_pkts;
+}
+
+static __rte_hot uint16_t
+capture_tx(uint16_t port, uint16_t queue,
+	   struct rte_mbuf **pkts, uint16_t nb_pkts, void *user_params)
+{
+	struct capture *capture = user_params;
+	struct capture_rxtx_cb *cbs = &capture->cbs[queue].tx_cb;
+
+	capture_cb_hold(cbs);
+	capture_copy(port, queue, RTE_PCAPNG_DIRECTION_OUT, pkts, nb_pkts, capture, &cbs->stats);
+	capture_cb_release(cbs);
+
+	return nb_pkts;
+}
+
+
+/* Install callbacks */
+static int
+capture_add_callbacks(struct capture *cap)
+{
+	for (unsigned int q = 0; q < cap->tx_queues; q++) {
+		struct capture_rxtx_cb *tx_cb = &cap->cbs[q].tx_cb;
+
+		if (cap->queue >= 0 && (unsigned int)cap->queue != q)
+			continue;
+
+		tx_cb->cb = rte_eth_add_tx_callback(cap->port_id, q, capture_tx, cap);
+		if (tx_cb->cb == NULL) {
+			CAPTURE_LOG(ERR, "Register tx callback for %u:%u failed",
+				    cap->port_id, q);
+			return -1;
+		}
+	}
+
+	for (unsigned int q = 0; q < cap->rx_queues; q++) {
+		struct capture_rxtx_cb *rx_cb = &cap->cbs[q].rx_cb;
+
+		if (cap->queue >= 0 && (unsigned int)cap->queue != q)
+			continue;
+
+		rx_cb->cb = rte_eth_add_rx_callback(cap->port_id, q, capture_rx, cap);
+		if (rx_cb->cb == NULL) {
+			CAPTURE_LOG(ERR, "Register rx callback for %u:%u failed",
+				    cap->port_id, q);
+			return -1;
+		}
+	}
+	return 0;
+}
+
+/* Cleanup call backs */
+static void
+capture_remove_callbacks(struct capture *cap)
+{
+	for (unsigned int q = 0; q < cap->tx_queues; q++) {
+		struct capture_rxtx_cb *tx_cb = &cap->cbs[q].tx_cb;
+		if (tx_cb->cb) {
+			rte_eth_remove_tx_callback(cap->port_id, q, tx_cb->cb);
+			capture_cb_wait(tx_cb);
+			tx_cb->cb = NULL;
+		}
+	}
+
+	for (unsigned int q = 0; q < cap->rx_queues; q++) {
+		struct capture_rxtx_cb *rx_cb = &cap->cbs[q].rx_cb;
+		if (rx_cb->cb) {
+			rte_eth_remove_rx_callback(cap->port_id, q, rx_cb->cb);
+			capture_cb_wait(rx_cb);
+			rx_cb->cb = NULL;
+		}
+	}
+}
+
+/* Helper that returns error to telemetry and logs it */
+static void __rte_format_printf(2, 3)
+capture_err(struct rte_tel_data *d, const char *format, ...)
+{
+	va_list ap;
+	char msg[1024];
+
+	va_start(ap, format);
+	vsnprintf(msg, sizeof(msg), format, ap);
+	va_end(ap);
+
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_string(d, "error", msg);
+	rte_log(RTE_LOG_NOTICE, RTE_LOGTYPE_CAPTURE, "CAPTURE: %s\n", msg);
+}
+
+/*
+ * Break the comma separated parameter string into tokens
+ * and fill in the capture config structure.
+ *
+ * Does not use rte_kvargs because that would mangle [] etc in filter expression.
+ */
+static int
+parse_params(char *str, struct capture_config *cfg, struct rte_tel_data *d)
+{
+	uint32_t snaplen = DEFAULT_SNAPLEN;
+	char *args[8];
+	int nargs;
+
+	/* Need at least the port id */
+	nargs = rte_strsplit(str, strlen(str), args, RTE_DIM(args), ',');
+	if (nargs < 1) {
+		capture_err(d, "missing parameters '%s'", str);
+		return -1;
+	}
+
+	/* Parse port id (required) */
+	char *endp;
+	errno = 0;
+	unsigned long port_id = strtoul(args[0], &endp, 10);
+	if (errno != 0 || *endp != '\0' || port_id >= RTE_MAX_ETHPORTS) {
+		capture_err(d, "invalid port_id='%s'", args[0]);
+		return -1;
+	}
+
+	/* parse remainder as name=value parameters */
+	for (int i = 1; i < nargs; i++) {
+		char *key = args[i];
+
+		/* split at the = */
+		char *eq = strchr(args[i], '=');
+
+		/* all current options require argument after = */
+		if (eq == NULL || eq[1] == '\0') {
+			capture_err(d,  "missing value for '%s'", key);
+			return -1;
+		}
+		*eq = '\0';
+		char *value = eq + 1;
+
+		if (strcmp(key, "out") == 0) {
+			cfg->output = value;
+		} else if (strcmp(key, "filter") == 0) {
+			cfg->filter_str = value;
+		} else if (strcmp(key, "queue") == 0) {
+			errno = 0;
+			unsigned long q = strtoul(value, &endp, 10);
+			if (errno != 0 || *endp != '\0' || q >= RTE_MAX_QUEUES_PER_PORT) {
+				capture_err(d, "invalid queue '%lu'", q);
+				return -1;
+			}
+			cfg->queue = q;
+		} else if (strcmp(key, "snaplen") == 0) {
+			errno = 0;
+			unsigned long len = strtoul(value, &endp, 10);
+			if (errno != 0 || *endp != '\0' || len >= UINT32_MAX) {
+				capture_err(d, "invalid snaplen '%lu'", len);
+				return -1;
+			}
+			snaplen = len;
+		} else {
+			capture_err(d, "unknown parameter '%s'", key);
+			return -1;
+		}
+	}
+
+	if (cfg->output == NULL) {
+		capture_err(d, "missing output parameter");
+		return -1;
+	}
+
+	cfg->port_id = port_id;
+
+	/*
+	 * Default is 256K from tcpdump legacy
+	 * using snaplen=0 means everything.
+	 */
+	cfg->snaplen = snaplen > 0 ? snaplen : UINT32_MAX;
+	return 0;
+}
+
+static bool is_empty_or_fifo(const struct stat *stb)
+{
+	if (S_ISFIFO(stb->st_mode))
+		return true;
+	else if (S_ISREG(stb->st_mode))
+		return stb->st_size == 0;
+	else
+		return false; /* not a FIFO or regular file */
+}
+
+
+/*
+ * Create the file handle for pcapng output
+ * Note: can't really tell wireshark about errors since this in an
+ * independent thread.
+ */
+static __rte_cold rte_pcapng_t *
+capture_pcapng_open(const char *path, int *fd, uint16_t port_id, const char *filter )
+{
+	rte_pcapng_t *pcapng = NULL;
+	char port_name[RTE_ETH_NAME_MAX_LEN];
+	char appname[128];
+	char ifname[IFNAMSIZ];
+	char *ifdescr = NULL;
+	struct utsname uts;
+	char *osname = NULL;
+
+	/* OS name is optional, just keep going if not found */
+	if (uname(&uts) == 0 && asprintf(&osname, "%s %s", uts.sysname, uts.release) < 0)
+		osname = NULL;
+
+	/* add DPDK internal name */
+	if (rte_eth_dev_get_name_by_port(port_id, port_name) != 0) {
+		CAPTURE_LOG(NOTICE, "Could not find port name for %u", port_id);
+		return NULL;
+	}
+
+	/* match name convention used by dpdk-wireshark-extcap.py */
+	snprintf(ifname, sizeof(ifname), CAPTURE_EXTCAP_PREFIX ":%u", port_id);
+	if (asprintf(&ifdescr, "DPDK %s", port_name) < 0)
+		ifdescr = NULL;
+
+	/* mirror what other applications do for name */
+	snprintf(appname, sizeof(appname), CAPTURE_EXTCAP_PREFIX " (%s)", rte_version());
+
+	/*
+	 * Open the output in non-block mode in case it is a FIFO
+	 * without a reader. Wireshark must open the read end before
+	 * asking us to capture.
+	 */
+	*fd = open(path, O_WRONLY | O_CLOEXEC | O_NOFOLLOW | O_NONBLOCK);
+	if (*fd < 0) {
+		CAPTURE_LOG(ERR, "Could not open %s: %s", path, strerror(errno));
+		return NULL;
+	}
+
+	/* recheck that it is ok to use */
+	struct stat sb;
+	if (fstat(*fd, &sb) < 0 || !is_empty_or_fifo(&sb)) {
+		CAPTURE_LOG(ERR, "Not safe to use %s", path);
+		goto close_fd;
+	}
+
+	/* writes in the drain loop should block normally */
+	int flags = fcntl(*fd, F_GETFL, 0);
+	if (flags < 0 || fcntl(*fd, F_SETFL, flags & ~O_NONBLOCK) < 0) {
+		CAPTURE_LOG(ERR, "fcntl %s: %s",  path,  strerror(errno));
+		goto close_fd;
+	}
+
+	/* put pcapng header on and setup */
+	pcapng = rte_pcapng_fdopen(*fd, osname, NULL, appname, NULL);
+	if (pcapng == NULL) {
+		CAPTURE_LOG(ERR, "Add section block failed");
+		goto close_fd;
+	}
+
+	if (rte_pcapng_add_interface(pcapng, port_id, DLT_EN10MB, ifname, ifdescr, filter) < 0) {
+		CAPTURE_LOG(ERR, "Add interface for port %u:%s failed", port_id, ifname);
+		rte_pcapng_close(pcapng);  /* closes fd */
+		pcapng = NULL;
+	}
+	goto cleanup;
+
+close_fd:
+	close(*fd);
+cleanup:
+	free(osname);
+	free(ifdescr);
+	return pcapng;
+}
+
+static void
+capture_link(struct capture *cap)
+{
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_INSERT_TAIL(&capture_list, cap, next);
+	rte_spinlock_unlock(&capture_lock);
+}
+
+static void
+capture_unlink(struct capture *cap)
+{
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_REMOVE(&capture_list, cap, next);
+	rte_spinlock_unlock(&capture_lock);
+}
+
+static void
+capture_free(struct capture *cap)
+{
+	if (cap == NULL)
+		return;
+
+	free(cap->output);
+	__rte_capture_filter_free(cap->filter);
+	rte_ring_free(cap->ring);
+	rte_mempool_free(cap->mp);
+	rte_free(cap);
+}
+
+/* Generate unique id for naming and telemetry */
+static unsigned int
+get_unique_id(void)
+{
+	static RTE_ATOMIC(unsigned int) capture_instance;
+
+	return rte_atomic_fetch_add_explicit(&capture_instance, 1, rte_memory_order_relaxed);
+}
+
+/*
+ * Convert configuration into running state
+ */
+static struct capture *
+capture_alloc(const struct capture_config *cfg,
+	      const struct rte_eth_dev_info *dev_info,
+	      struct rte_tel_data *d)
+{
+	struct capture *cap;
+	char ring_name[RTE_RING_NAMESIZE];
+	uint16_t mbuf_size;
+
+	/* try and put capture data struct on same node as device. */
+	int socket_id = rte_eth_dev_socket_id(cfg->port_id);
+	if (socket_id < 0)
+		socket_id = SOCKET_ID_ANY;
+
+	uint16_t num_queues = RTE_MAX(dev_info->nb_tx_queues, dev_info->nb_rx_queues);
+	size_t cb_size = sizeof(*cap) + num_queues * sizeof(cap->cbs[0]);
+	cap = rte_zmalloc_socket("capture", cb_size, RTE_CACHE_LINE_SIZE, socket_id);
+	if (cap == NULL) {
+		capture_err(d, "Could not allocate capture struct");
+		goto error;
+	}
+
+	cap->idx = get_unique_id();
+	snprintf(ring_name, sizeof(ring_name), "capture-%u", cap->idx);
+	cap->ring = rte_ring_create(ring_name, CAPTURE_RING_SIZE, socket_id, 0);
+	if (cap->ring == NULL) {
+		capture_err(d, "Could not create ring");
+		goto error;
+	}
+
+	/*
+	 * If snapshot length is smaller than one mbuf segment then pool
+	 * element size can be reduced; otherwise can just use the default
+	 * and rte_pktmbuf_copy handle multiple segments.
+	 */
+	if (cfg->snaplen < RTE_MBUF_DEFAULT_BUF_SIZE)
+		mbuf_size = rte_pcapng_mbuf_size(cfg->snaplen);
+	else
+		mbuf_size = RTE_MBUF_DEFAULT_BUF_SIZE;
+
+	cap->mp = rte_pktmbuf_pool_create_by_ops(ring_name, CAPTURE_POOL_SIZE,
+						 MBUF_POOL_CACHE_SIZE, 0, mbuf_size,
+						 socket_id, "ring_mp_mc");
+	if (cap->mp == NULL) {
+		capture_err(d,  "Could not create mempool");
+		goto error;
+	}
+
+	if (cfg->filter_str) {
+		cap->filter = __rte_capture_filter_create(cfg->filter_str);
+		if (cap->filter == NULL) {
+			capture_err(d,  "Could not compile filter: %s", cfg->filter_str);
+			goto error;
+		}
+	}
+
+	cap->port_id = cfg->port_id;
+	cap->output = strdup(cfg->output);
+	if (cap->output == NULL) {
+		capture_err(d, "Could not strdup '%s'", cfg->output);
+		goto error;
+	}
+	rte_atomic_store_explicit(&cap->running, true, rte_memory_order_relaxed);
+	cap->snaplen = cfg->snaplen;
+	cap->queue = cfg->queue;
+	cap->tx_queues = dev_info->nb_tx_queues;
+	cap->rx_queues = dev_info->nb_rx_queues;
+
+	return cap;
+
+error:
+	capture_free(cap);
+	return NULL;
+}
+
+/* Aggregate per-queue counters of a capture instance. */
+struct capture_total {
+	uint64_t accepted;
+	uint64_t filtered;
+	uint64_t nombuf;
+	uint64_t ringfull;
+};
+
+static void
+capture_sum_one(struct capture_total *t, const struct capture_stats *s)
+{
+	t->accepted += rte_atomic_load_explicit(&s->accepted, rte_memory_order_relaxed);
+	t->filtered += rte_atomic_load_explicit(&s->filtered, rte_memory_order_relaxed);
+	t->nombuf   += rte_atomic_load_explicit(&s->nombuf, rte_memory_order_relaxed);
+	t->ringfull += rte_atomic_load_explicit(&s->ringfull, rte_memory_order_relaxed);
+}
+
+/* Sum the rx and tx counters across all queues. Caller holds capture_lock. */
+static void
+capture_sum_stats(const struct capture *cap, struct capture_total *t)
+{
+	*t = (struct capture_total){ };
+
+	for (unsigned int q = 0; q < cap->rx_queues; q++)
+		capture_sum_one(t, &cap->cbs[q].rx_cb.stats);
+	for (unsigned int q = 0; q < cap->tx_queues; q++)
+		capture_sum_one(t, &cap->cbs[q].tx_cb.stats);
+}
+
+static void
+capture_write_stats(rte_pcapng_t *pcapng, const struct capture *cap)
+{
+	struct capture_total t;
+	struct rte_pcapng_interface_stats isb;
+
+	capture_sum_stats(cap, &t);
+
+	/* Unlike libpcap the ifrecv is the total number of packets
+	 * and filteraccept is the subset that passed.
+	 */
+	isb.ifrecv = t.accepted + t.filtered + t.nombuf;
+	isb.filteraccept = t.accepted + t.nombuf;
+	isb.ifdrop = t.nombuf + t.ringfull;
+
+	rte_pcapng_write_stats(pcapng, cap->port_id, &isb, sizeof(isb), NULL);
+}
+
+/*
+ * Check that output file is still ok to write (i.e FIFO not closed)
+ * Also block for up to SLEEP_US to wait for wireshark to catch up
+ */
+static int
+check_fifo_status(int fd)
+{
+	struct pollfd pfd = { .fd = fd };
+
+	if (poll(&pfd, 1, 0) < 0) {
+		CAPTURE_LOG(ERR, "poll failed: %s", strerror(errno));
+		return -1;
+	}
+	if (pfd.revents & (POLLERR | POLLHUP | POLLNVAL)) {
+		CAPTURE_LOG(NOTICE, "fifo reader closed");
+		return -1;
+	}
+	return 0;
+}
+
+static ssize_t
+capture_process_ring(struct rte_ring *ring, rte_pcapng_t *pcapng,
+		     unsigned int *available)
+{
+	struct rte_mbuf *pkts[CAPTURE_BURST_SIZE];
+	unsigned int n;
+	ssize_t written;
+
+	n = rte_ring_sc_dequeue_burst(ring, (void **) pkts,
+				      CAPTURE_BURST_SIZE, available);
+	if (n == 0)
+		return 0;
+
+	written = rte_pcapng_write_packets(pcapng, pkts, n);
+	rte_pktmbuf_free_bulk(pkts, n);
+
+	return written;
+}
+
+static void
+capture_flush_ring(struct rte_ring *ring)
+{
+	for (;;) {
+		struct rte_mbuf *pkts[CAPTURE_BURST_SIZE];
+		unsigned int n;
+
+		n = rte_ring_sc_dequeue_burst(ring, (void **) pkts,
+					      CAPTURE_BURST_SIZE, NULL);
+		if (n == 0)
+			break;
+
+		rte_pktmbuf_free_bulk(pkts, n);
+	}
+}
+
+/* The capture thread that moves packets from ring to the pcapng out */
+static uint32_t __rte_hot
+capture_thread(void *arg)
+{
+	struct capture *cap = arg;
+	unsigned int empty_count = 0;
+	bool reader_gone = false;
+	int fd = -1;
+
+	CAPTURE_LOG(INFO, "capture thread starting");
+
+	char name[RTE_THREAD_NAME_SIZE];
+	snprintf(name, sizeof(name), "dpdk-cap-%u", cap->idx);
+	rte_thread_set_name(rte_thread_self(), name);
+
+	/* This thread wants to detect when file gets closed (for FIFO) */
+	sigset_t set;
+	sigemptyset(&set);
+	sigaddset(&set, SIGPIPE);
+	pthread_sigmask(SIG_BLOCK, &set, NULL);
+
+	rte_pcapng_t *pcapng = capture_pcapng_open(cap->output, &fd, cap->port_id,
+						   __rte_capture_filter_string(cap->filter));
+	if (pcapng == NULL) {
+		capture_remove_callbacks(cap);
+		goto error;
+	}
+
+	while (rte_atomic_load_explicit(&cap->running, rte_memory_order_relaxed)) {
+		ssize_t written;
+		unsigned int avail;
+
+		written = capture_process_ring(cap->ring, pcapng, &avail);
+		if (written < 0) {
+			CAPTURE_LOG(NOTICE, "write to file failed: %s",
+				    strerror(errno));
+			reader_gone = true;
+			break;
+		}
+
+		if (written > 0) {
+			/* are there more packets? */
+			empty_count = (avail == 0);
+		} else if (empty_count < SLEEP_THRESHOLD) {
+			/* spin a few times before checking */
+			++empty_count;
+			rte_pause();
+		} else if (check_fifo_status(fd) != 0) {
+			/* output FIFO has closed */
+			reader_gone = true;
+			break;
+		} else {
+			/* avoid consuming 100% CPU polling */
+			rte_delay_us_sleep(SLEEP_US);
+		}
+	}
+
+	/* Capture exiting */
+	CAPTURE_LOG(INFO, "capture thread stopping");
+	capture_remove_callbacks(cap);
+
+	/* Process residual */
+	if (reader_gone)
+		capture_flush_ring(cap->ring);
+	else {
+		while (capture_process_ring(cap->ring, pcapng, NULL) > 0)
+			continue;
+
+		capture_write_stats(pcapng, cap);
+	}
+
+	rte_pcapng_close(pcapng);
+
+error:
+	capture_unlink(cap);
+	capture_free(cap);
+
+	return 0;
+}
+
+/*
+ * Callback handler for telemetry library to start capture.
+ *
+ * Need to handle: <iface>,snaplen=<n>,filter=<str>
+ */
+static int
+capture_start_req(const char *cmd, const char *params, struct rte_tel_data *d)
+{
+	struct capture *cap = NULL;
+	struct capture_config cfg = { .queue = ALL_QUEUES };
+	struct rte_eth_dev_info dev_info;
+
+	if (params == NULL || *params == '\0') {
+		CAPTURE_LOG(ERR, "missing parameters");
+		return -1;
+	}
+
+	CAPTURE_LOG(DEBUG, "telemetry: %s %s", cmd, params);
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		CAPTURE_LOG(ERR, "capture can only be started from primary");
+		return -1;
+	}
+
+	/* Note: params is const so need non-const copy for parsing
+	 * Alternative would be to change telemetry to allow this.
+	 */
+	char tmp[CAP_CMD_MAX];
+	if (strlcpy(tmp, params, CAP_CMD_MAX) >= CAP_CMD_MAX) {
+		CAPTURE_LOG(ERR, "params too long");
+		return -1;
+	}
+
+	if (parse_params(tmp, &cfg, d) < 0)
+		return 0;
+
+	/* Lookup number of queues etc, also validates port_id */
+	if (rte_eth_dev_info_get(cfg.port_id, &dev_info) < 0) {
+		capture_err(d, "can not get info for port %u", cfg.port_id);
+		return 0;
+	}
+
+	if (cfg.queue != ALL_QUEUES &&
+	    cfg.queue >= RTE_MAX(dev_info.nb_rx_queues, dev_info.nb_tx_queues)) {
+		capture_err(d, "queue %d out of range", cfg.queue);
+		return 0;
+	}
+
+	struct stat sb;
+	if (stat(cfg.output, &sb) < 0) {
+		capture_err(d, "output %s:%s", cfg.output, strerror(errno));
+		return 0;
+	}
+
+	if (!is_empty_or_fifo(&sb)) {
+		capture_err(d, "output %s is not empty", cfg.output);
+		return 0;
+	}
+
+	cap = capture_alloc(&cfg, &dev_info, d);
+	if (cap == NULL)
+		return 0;
+
+	if (capture_add_callbacks(cap) < 0) {
+		capture_err(d, "can not register callbacks");
+		goto error_callback_remove;
+	}
+
+	/*
+	 * Publish into the active list before starting the drain thread so the
+	 * thread is guaranteed to find itself there when it removes itself on
+	 * exit (it may exit immediately, e.g. if the FIFO reader is already
+	 * gone). On thread-create failure we undo the insertion here.
+	 */
+	unsigned int idx = cap->idx;
+	capture_link(cap);
+
+	/*
+	 * Make a new thread to do the capture work
+	 * Thread will inherit affinity from the telemetry handler that calls us
+	 */
+	rte_thread_t thread_id;
+	int ret = rte_thread_create(&thread_id, NULL, capture_thread, cap);
+	if (ret != 0) {
+		capture_err(d, "thread start failed: %s", strerror(ret));
+		goto error_unlink;
+	}
+
+	rte_thread_detach(thread_id);
+
+	/* Return id back for later use. */
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_uint(d, "id", idx);
+	rte_tel_data_add_dict_string(d, "status", "running");
+	return 0;
+
+error_unlink:
+	capture_unlink(cap);
+error_callback_remove:
+	capture_remove_callbacks(cap);
+	capture_free(cap);
+
+	/* return 0 since error reported "error":"XXX" in respons */
+	return 0;
+}
+
+/* Telemetry: stop active capture. */
+static int
+capture_stop_req(const char *cmd, const char *params, struct rte_tel_data *d)
+{
+	if (params == NULL || *params == '\0') {
+		CAPTURE_LOG(ERR, "missing parameters");
+		return -1;
+	}
+
+	CAPTURE_LOG(DEBUG, "telemetry %s %s", cmd, params);
+
+	errno = 0;
+	char *endp;
+	unsigned long idx = strtoul(params, &endp, 10);
+	if (errno != 0 || *endp != '\0') {
+		capture_err(d, "invalid capture index '%s'", params);
+		return 0;
+	}
+
+	rte_spinlock_lock(&capture_lock);
+	struct capture *cap;
+	TAILQ_FOREACH(cap, &capture_list, next) {
+		if (cap->idx == idx)
+			break;
+	}
+	if (cap == NULL) {
+		rte_spinlock_unlock(&capture_lock);
+		capture_err(d, "capture index %lu not found", idx);
+		return 0;
+	}
+
+	rte_atomic_store_explicit(&cap->running, false, rte_memory_order_relaxed);
+	rte_spinlock_unlock(&capture_lock);
+
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_string(d, "status", "stopped");
+	return 0;
+}
+
+/* Telemetry: list the ids of all active captures. */
+static int
+capture_list_req(const char *cmd __rte_unused, const char *params __rte_unused,
+		 struct rte_tel_data *d)
+{
+	struct capture *cap;
+
+	CAPTURE_LOG(DEBUG, "telemetry %s", cmd);
+	rte_tel_data_start_array(d, RTE_TEL_UINT_VAL);
+
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_FOREACH(cap, &capture_list, next)
+		rte_tel_data_add_array_uint(d, cap->idx);
+	rte_spinlock_unlock(&capture_lock);
+
+	return 0;
+}
+
+
+/* Telemetry: report configuration and counters for one capture. */
+static int
+capture_stats_req(const char *cmd, const char *params,
+		  struct rte_tel_data *d)
+{
+	struct capture *cap;
+	struct capture_total t;
+	char *endp;
+
+	if (params == NULL || *params == '\0') {
+		CAPTURE_LOG(ERR, "missing parameters");
+		return -1;
+	}
+
+	CAPTURE_LOG(DEBUG, "telemetry %s %s", cmd, params);
+
+	errno = 0;
+	unsigned long idx = strtoul(params, &endp, 10);
+	if (errno != 0 || *endp != '\0') {
+		capture_err(d, "invalid capture index '%s'", params);
+		return 0;
+	}
+
+	/* Find the instance and snapshot what we need while holding the lock. */
+	rte_spinlock_lock(&capture_lock);
+	TAILQ_FOREACH(cap, &capture_list, next) {
+		if (cap->idx == idx)
+			break;
+	}
+	if (cap == NULL) {
+		rte_spinlock_unlock(&capture_lock);
+		capture_err(d, "capture index %lu not found", idx);
+		return 0;
+	}
+
+	rte_tel_data_start_dict(d);
+	rte_tel_data_add_dict_uint(d, "port_id", cap->port_id);
+	if (cap->filter)
+		rte_tel_data_add_dict_string(d, "filter",
+					     __rte_capture_filter_string(cap->filter));
+	rte_tel_data_add_dict_int(d, "running",
+				  rte_atomic_load_explicit(&cap->running,
+							   rte_memory_order_relaxed));
+	rte_tel_data_add_dict_uint(d, "snaplen", cap->snaplen);
+	rte_tel_data_add_dict_uint(d, "rx_queues", cap->rx_queues);
+	rte_tel_data_add_dict_uint(d, "tx_queues", cap->tx_queues);
+	capture_sum_stats(cap, &t);
+	rte_spinlock_unlock(&capture_lock);
+
+	rte_tel_data_add_dict_uint(d, "accepted", t.accepted);
+	rte_tel_data_add_dict_uint(d, "filtered", t.filtered);
+	rte_tel_data_add_dict_uint(d, "nombuf", t.nombuf);
+	rte_tel_data_add_dict_uint(d, "ringfull", t.ringfull);
+
+	return 0;
+}
+
+RTE_INIT(capture_telemetry)
+{
+	rte_telemetry_register_cmd("/ethdev/capture/list", capture_list_req,
+		"List ids of active captures. Takes no parameters.");
+	rte_telemetry_register_cmd("/ethdev/capture/stats", capture_stats_req,
+		"Report configuration and counters for a capture. Parameters: id");
+	rte_telemetry_register_cmd("/ethdev/capture/start", capture_start_req,
+		"Start capture. Parameters: "
+		"port_id,out=<path>,snaplen=N(optional),queue=N(optional),filter=string(optional)");
+	rte_telemetry_register_cmd("/ethdev/capture/stop", capture_stop_req,
+				   "Stop an active capture. Parameters: id");
+}
diff --git a/lib/capture/capture_impl.h b/lib/capture/capture_impl.h
new file mode 100644
index 0000000000..adee734b6c
--- /dev/null
+++ b/lib/capture/capture_impl.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+#ifndef CAPTURE_IMPL_H
+#define CAPTURE_IMPL_H
+
+#define RTE_LOGTYPE_CAPTURE rte_capture_logtype
+extern int rte_capture_logtype;
+#define CAPTURE_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, CAPTURE, "%s(): ", __func__, __VA_ARGS__)
+
+struct rte_capture_filter;
+
+#ifdef RTE_HAS_LIBPCAP
+struct rte_capture_filter *__rte_capture_filter_create(const char *str);
+const char *__rte_capture_filter_string(struct rte_capture_filter *filter);
+void __rte_capture_filter_free(struct rte_capture_filter *filter);
+uint64_t __rte_capture_filter(const struct rte_capture_filter *filter, struct rte_mbuf *mb);
+
+#else /* !RTE_HAS_LIBPCAP */
+
+/* Stub version if pcap is not available */
+static inline struct rte_capture_filter *
+__rte_capture_filter_create(const char *str)
+{
+	RTE_SET_USED(str);
+	return NULL; /* not supported */
+}
+
+static inline const char *
+__rte_capture_filter_string(struct rte_capture_filter *filter)
+{
+	RTE_SET_USED(filter);
+	return NULL;
+}
+
+static inline void
+__rte_capture_filter_free(struct rte_capture_filter *filter)
+{
+	RTE_SET_USED(filter);
+}
+
+/*
+ * This will  be zero if the packet doesn't match the filter and non-zero if
+ * the packet matches the filter.
+ */
+static inline uint64_t
+__rte_capture_filter(const struct rte_capture_filter *filter, struct rte_mbuf *mb)
+{
+	RTE_SET_USED(filter);
+	RTE_SET_USED(mb);
+	return 1;
+}
+
+#endif  /* !RTE_HAS_LIBPCAP */
+#endif /* CAPTURE_IMPL_H */
diff --git a/lib/capture/filter.c b/lib/capture/filter.c
new file mode 100644
index 0000000000..ecb5e8a765
--- /dev/null
+++ b/lib/capture/filter.c
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <pcap/pcap.h>
+
+#include <rte_bpf.h>
+#include <rte_errno.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_mbuf.h>
+
+#include "capture_impl.h"
+
+struct rte_capture_filter {
+	struct rte_bpf *bpf;
+	struct rte_bpf_jit jit;
+	char expr[];	/* original filter text */
+};
+
+/*
+ * Convert text string into an eBPF program
+ */
+struct rte_capture_filter *
+__rte_capture_filter_create(const char *filter)
+{
+	struct rte_capture_filter *flt = NULL;
+	struct rte_bpf_prm *prm = NULL;
+
+	/* libpcap needs a handle */
+	pcap_t *pcap = pcap_open_dead(DLT_EN10MB, UINT16_MAX);
+	if (!pcap) {
+		CAPTURE_LOG(ERR, "pcap: can not open handle");
+		return NULL;
+	}
+
+	flt = rte_zmalloc("capture_filter", sizeof(*flt) + strlen(filter) + 1, 0);
+	if (flt == NULL) {
+		CAPTURE_LOG(ERR, "capture filter alloc failed");
+		goto error;
+	}
+
+	/* convert string to cBPF program */
+	struct bpf_program bf;
+	if (pcap_compile(pcap, &bf, filter, 1, PCAP_NETMASK_UNKNOWN) != 0) {
+		CAPTURE_LOG(ERR, "pcap: can not compile filter: %s",
+			    pcap_geterr(pcap));
+		goto error;
+	}
+	strcpy(flt->expr, filter);
+
+	/* convert cBPF to eBPF */
+	prm = rte_bpf_convert(&bf);
+	pcap_freecode(&bf); /* drop the cBPF program */
+
+	if (prm == NULL)  {
+		CAPTURE_LOG(ERR, "BPF convert interface %s(%d)",
+			    rte_strerror(rte_errno), rte_errno);
+		goto error;
+	}
+
+	flt->bpf = rte_bpf_load(prm);
+	if (flt->bpf == NULL) {
+		CAPTURE_LOG(ERR, "BPF load failed: %s(%d)",
+			    rte_strerror(rte_errno), rte_errno);
+		goto error;
+	}
+
+	rte_bpf_get_jit(flt->bpf, &flt->jit);
+	if (flt->jit.func == NULL)
+		CAPTURE_LOG(NOTICE, "No JIT available for filter");
+
+	pcap_close(pcap);
+	rte_free(prm);
+	return flt;
+
+error:
+	pcap_close(pcap);
+	rte_free(prm);
+	rte_free(flt);
+	return NULL;
+}
+
+const char *__rte_capture_filter_string(struct rte_capture_filter *filter)
+{
+	return filter ? filter->expr : NULL;
+}
+
+void __rte_capture_filter_free(struct rte_capture_filter *filter)
+{
+	if (filter == NULL)
+		return;
+
+	rte_bpf_destroy(filter->bpf);
+	rte_free(filter);
+}
+
+uint64_t __rte_capture_filter(const struct rte_capture_filter *filter, struct rte_mbuf *mb)
+{
+	if (filter->jit.func)
+		return filter->jit.func(mb);
+	else
+		return rte_bpf_exec(filter->bpf, mb);
+}
diff --git a/lib/capture/meson.build b/lib/capture/meson.build
new file mode 100644
index 0000000000..4dbe0d1a78
--- /dev/null
+++ b/lib/capture/meson.build
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+if is_windows
+    build = false
+    reason = 'not supported on Windows'
+    subdir_done()
+endif
+
+sources = files('capture.c')
+
+deps += ['ethdev', 'pcapng', 'bpf']
+
+if dpdk_conf.has('RTE_HAS_LIBPCAP')
+    sources += files('filter.c')
+    ext_deps += pcap_dep
+else
+    warning('libpcap is missing, capture filtering will be disabled')
+endif
diff --git a/lib/meson.build b/lib/meson.build
index af5c160cb8..6d9992f61f 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -49,6 +49,7 @@ libraries = [
         'lpm',
         'member',
         'pcapng',
+        'capture', # depends on pcapng and bpf
         'power',
         'rawdev',
         'regexdev',
-- 
2.53.0

