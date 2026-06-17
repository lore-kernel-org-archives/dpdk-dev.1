Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A151CD98D2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 00:07:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1826940DD7;
	Wed, 17 Jun 2026 02:07:26 +0200 (CEST)
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com
 [209.85.222.202])
 by mails.dpdk.org (Postfix) with ESMTP id D40C24068A
 for <dev@dpdk.org>; Wed, 17 Jun 2026 02:07:21 +0200 (CEST)
Received: by mail-qk1-f202.google.com with SMTP id
 af79cd13be357-915757be497so743467885a.2
 for <dev@dpdk.org>; Tue, 16 Jun 2026 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781654841; x=1782259641; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=JBdnc9k1S/K7rNRhboxwccxZrgmoLnNWQJIuKw/sUjU=;
 b=qgUo4d6qmpw3gf+KncgzwtbK0JaaLeW7pECTpqrLVsSddhkAP3Yxxv+SwkFGIUHLl5
 pbk288qRskBDvPB1lb5jaawih932na7OW8skjdl7NSy6Th9sZ0+jOM/G0e8zTeu+AXbv
 D220c+JvY8gtbbjAWbxUAnwuYXOEqHMtvbWoPbkBYyaFMBtzLToH1b8D7hs7t+T0O5V3
 dYaOBmjKg9/KVZ+LaTLNWWB4/wFyMVuWFzzj47NZxLHZOwV76Bt7zVB+i7fGUk8PGiLp
 Pk/pkxv98Kxwo6gXw01LlEFPKfgZVPICoL3w1rZbo5ilxg3qqV0Ez2LtNPs92yS/KbgU
 9jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781654841; x=1782259641;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JBdnc9k1S/K7rNRhboxwccxZrgmoLnNWQJIuKw/sUjU=;
 b=HnqUctXLQsz+jQEc6GOIqW/0DLsEW3jhzKJgQqdbJKUPYjKmXN6rwmYKGrHLqP2PNW
 MZSGmZJ801mxqMZ6+I8DNXqUC2qv7TeBAJbAZWBocGHzZXDviVsWCXoQEsHwmDDxwpDU
 J5vS12ERmnDdomQ/GTmg2Wl7dy4YqFpU9J4oiOqjT1ZgicayVsKfK2hoVnNrnjQQ4gIu
 q+1eOE0pVNbD6kxNGIqdYorOmMSso2C4FAHlSvdKPDCNNc4Sr7mThIUsBmjqR651vAvv
 3BuSXW6OOEzLJ6lHVfWEAIbQliLnR/1qVO56cfwMZvkDNO9RxYDE8KHNgIbDi5vYlWyU
 Rvqg==
X-Gm-Message-State: AOJu0YwyvDkZC9SMTtRhGiR5IMz2DmrKbP+q/URCT/olaw7TWSterJ4X
 gomh5XdZJcHiQFseQA/o7MMn2m7lHNusS+eQHbXJ3NFug4N56UAU6piztNUwkEoxzTRZ7dZr8EM
 19SrExg==
X-Received: from qkkk23.prod.google.com ([2002:a05:620a:7f7:b0:915:74f2:62ac])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7106:b0:915:cf88:1e41
 with SMTP id af79cd13be357-91dbc52dc18mr205348185a.45.1781654840713; Tue, 16
 Jun 2026 17:07:20 -0700 (PDT)
Date: Wed, 17 Jun 2026 00:07:08 +0000
In-Reply-To: <20260617000712.2195506-1-blasko@google.com>
Mime-Version: 1.0
References: <20260613042300.3760470-1-blasko@google.com>
 <20260617000712.2195506-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260617000712.2195506-5-blasko@google.com>
Subject: [PATCH v5 4/6] net/gve: add periodic NIC clock synchronization
From: Mark Blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, joshwash@google.com, jtranoleary@google.com, 
 blasko@google.com
Content-Type: text/plain; charset="UTF-8"
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

Introduce a mechanism to periodically fetch the NIC hardware timestamp
using the GVE_ADMINQ_REPORT_NIC_TIMESTAMP AdminQ command. The
synchronization runs every 250ms via a dedicated background control thread
(gve_nic_ts_thread). The thread polls using an incremental sleep loop
checking a stop flag to ensure fast termination during driver teardown.
After 7 consecutive clock read failures, the timestamp is marked as stale,
indicating to the RX path that reconstructed timestamps may be unreliable.

Atomics exist because of the potential for async callers (introduced
here) and async callers (introduced later in the RX datapath) accessing
the cached state.

Signed-off-by: Mark Blasko <blasko@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
v5:
    - Reword commit message body to accurately describe the dedicated control
      thread polling mechanism instead of obsolete rte_alarm.

v4:
    - Replace EAL alarm thread with a dedicated control thread to
      prevent blocking shared EAL interrupt thread for up to 2s
      on GVE AdminQ timeouts.
    - Implement incremental sleep loop to support fast termination.

v2:
    - Removed redundant void* casts.
    - Handled alarm reschedule failures by marking timestamp stale.
    - Added transient error logging on memzone allocation failure.
---
 drivers/net/gve/gve_ethdev.c | 122 +++++++++++++++++++++++++++++++++++
 drivers/net/gve/gve_ethdev.h |  12 ++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 476b2c311f..fa91575b3e 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -452,6 +452,94 @@ gve_dev_start(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static void
+gve_read_nic_clock(void *arg)
+{
+	struct gve_priv *priv = arg;
+	uint32_t fails;
+	uint64_t ts;
+	int err;
+
+	if (!priv || !priv->nic_ts_report_mz)
+		return;
+
+	memset(priv->nic_ts_report, 0, sizeof(struct gve_nic_ts_report));
+
+	err = gve_adminq_report_nic_timestamp(priv, priv->nic_ts_report_mz->iova);
+	if (err == 0) {
+		ts = be64_to_cpu(priv->nic_ts_report->nic_timestamp);
+		rte_atomic_store_explicit(&priv->last_read_nic_timestamp, ts,
+					  rte_memory_order_relaxed);
+		PMD_DRV_LOG(DEBUG, "Fetched NIC Timestamp: %" PRIu64, ts);
+		rte_atomic_store_explicit(&priv->nic_ts_read_fails, 0,
+					  rte_memory_order_relaxed);
+		rte_atomic_store_explicit(&priv->nic_ts_stale, 0,
+					  rte_memory_order_release);
+	} else {
+		PMD_DRV_LOG(ERR, "Failed to read NIC clock, AQ err: %d", err);
+		fails = rte_atomic_fetch_add_explicit(&priv->nic_ts_read_fails, 1,
+						      rte_memory_order_relaxed) + 1;
+		if (fails >= GVE_NIC_CLOCK_READ_MAX_FAILS) {
+			if (!rte_atomic_load_explicit(&priv->nic_ts_stale,
+						      rte_memory_order_relaxed))
+				PMD_DRV_LOG(ERR,
+					"NIC timestamping marked as stale after %u consecutive failures",
+					GVE_NIC_CLOCK_READ_MAX_FAILS);
+			rte_atomic_store_explicit(&priv->nic_ts_stale, 1,
+						  rte_memory_order_release);
+		}
+	}
+}
+
+static uint32_t
+gve_nic_ts_thread(void *arg)
+{
+	struct gve_priv *priv = arg;
+	unsigned int sleep_cnt;
+
+	while (!rte_atomic_load_explicit(&priv->nic_ts_thread_should_stop,
+					 rte_memory_order_relaxed)) {
+		gve_read_nic_clock(priv);
+		for (sleep_cnt = 0; sleep_cnt < GVE_NIC_CLOCK_READ_PERIOD_MS / 10; sleep_cnt++) {
+			if (rte_atomic_load_explicit(&priv->nic_ts_thread_should_stop,
+						     rte_memory_order_relaxed))
+				break;
+			rte_delay_us_sleep(10000);
+		}
+	}
+	return 0;
+}
+
+static int
+gve_alloc_nic_ts_report(struct gve_priv *priv)
+{
+	char z_name[RTE_MEMZONE_NAMESIZE];
+
+	snprintf(z_name, sizeof(z_name), "gve_%s_nic_ts_report",
+		 priv->pci_dev->device.name);
+	priv->nic_ts_report_mz = rte_memzone_reserve_aligned(z_name,
+			sizeof(struct gve_nic_ts_report), rte_socket_id(),
+			RTE_MEMZONE_IOVA_CONTIG, PAGE_SIZE);
+
+	if (!priv->nic_ts_report_mz) {
+		PMD_DRV_LOG(ERR, "Failed to allocate memzone for NIC TS report");
+		return -ENOMEM;
+	}
+	priv->nic_ts_report = priv->nic_ts_report_mz->addr;
+	rte_atomic_store_explicit(&priv->nic_ts_read_fails, 0, rte_memory_order_relaxed);
+	return 0;
+}
+
+static void
+gve_free_nic_ts_report(struct gve_priv *priv)
+{
+	if (priv->nic_ts_report_mz) {
+		rte_memzone_free(priv->nic_ts_report_mz);
+		priv->nic_ts_report_mz = NULL;
+		priv->nic_ts_report = NULL;
+	}
+}
+
 static int
 gve_dev_stop(struct rte_eth_dev *dev)
 {
@@ -586,6 +674,13 @@ gve_teardown_device_resources(struct gve_priv *priv)
 				err);
 	}
 
+	if (priv->nic_ts_report_mz) {
+		rte_atomic_store_explicit(&priv->nic_ts_thread_should_stop, 1,
+					  rte_memory_order_relaxed);
+		rte_thread_join(priv->nic_ts_thread_id, NULL);
+		gve_free_nic_ts_report(priv);
+	}
+
 	gve_free_ptype_lut_dqo(priv);
 	gve_free_counter_array(priv);
 	gve_free_irq_db(priv);
@@ -1252,6 +1347,32 @@ pci_dev_msix_vec_count(struct rte_pci_device *pdev)
 	return 0;
 }
 
+static void
+gve_setup_nic_timestamp(struct gve_priv *priv)
+{
+	int err;
+
+	if (!priv->nic_timestamp_supported)
+		return;
+
+	rte_atomic_store_explicit(&priv->nic_ts_read_fails, 0, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&priv->nic_ts_stale, 1, rte_memory_order_relaxed);
+	err = gve_alloc_nic_ts_report(priv);
+	if (err == 0) {
+		gve_read_nic_clock(priv);
+		rte_atomic_store_explicit(&priv->nic_ts_thread_should_stop, 0,
+					  rte_memory_order_relaxed);
+		err = rte_thread_create_internal_control(&priv->nic_ts_thread_id, "gve-ts",
+							 gve_nic_ts_thread, priv);
+		if (err != 0) {
+			PMD_DRV_LOG(ERR, "Failed to create NIC clock sync thread, err=%d", err);
+			gve_free_nic_ts_report(priv);
+		}
+	} else {
+		PMD_DRV_LOG(ERR, "Failed to allocate memory for NIC timestamping subsystem. Please reset device to retry.");
+	}
+}
+
 static int
 gve_setup_device_resources(struct gve_priv *priv)
 {
@@ -1307,6 +1428,7 @@ gve_setup_device_resources(struct gve_priv *priv)
 			goto free_ptype_lut;
 		}
 	}
+	gve_setup_nic_timestamp(priv);
 
 	gve_set_device_resources_ok(priv);
 
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index b67f82c263..4dcbaa9971 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -12,6 +12,8 @@
 #include <rte_pci.h>
 #include <pthread.h>
 #include <rte_bitmap.h>
+#include <rte_memzone.h>
+#include <rte_thread.h>
 
 #include "base/gve.h"
 
@@ -39,6 +41,9 @@
 #define GVE_RSS_HASH_KEY_SIZE 40
 #define GVE_RSS_INDIR_SIZE 128
 
+#define GVE_NIC_CLOCK_READ_PERIOD_MS 250
+#define GVE_NIC_CLOCK_READ_MAX_FAILS 7
+
 #define GVE_TX_CKSUM_OFFLOAD_MASK (		\
 		RTE_MBUF_F_TX_L4_MASK  |	\
 		RTE_MBUF_F_TX_TCP_SEG)
@@ -359,6 +364,13 @@ struct gve_priv {
 
 	/* HW Timestamping Fields */
 	bool nic_timestamp_supported;
+	const struct rte_memzone *nic_ts_report_mz;
+	struct gve_nic_ts_report *nic_ts_report;
+	RTE_ATOMIC(uint64_t) last_read_nic_timestamp;
+	RTE_ATOMIC(uint32_t) nic_ts_read_fails;
+	RTE_ATOMIC(uint8_t) nic_ts_stale;
+	rte_thread_t nic_ts_thread_id;
+	RTE_ATOMIC(uint8_t) nic_ts_thread_should_stop;
 };
 
 static inline bool
-- 
2.54.0.1189.g8c84645362-goog

