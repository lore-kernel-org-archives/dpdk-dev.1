Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F521CD98CF
	for <dpdk-dev@archiver.kernel.org>; Sat, 13 Jun 2026 04:23:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DCE5435D9;
	Sat, 13 Jun 2026 06:23:31 +0200 (CEST)
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com
 [74.125.224.74]) by mails.dpdk.org (Postfix) with ESMTP id AD1D4435C4
 for <dev@dpdk.org>; Sat, 13 Jun 2026 06:23:27 +0200 (CEST)
Received: by mail-yx1-f74.google.com with SMTP id
 956f58d0204a3-660e9ff05c1so2265125d50.3
 for <dev@dpdk.org>; Fri, 12 Jun 2026 21:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781324607; x=1781929407; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ciuFenAhAPLgo0cdrWXDGl27BMY9L62iO+Vq5WdTzHw=;
 b=Clt74mQzCiIjzjEwraDWMy7Kwatvva2/QDnmSdBp5aGu8cZ3exX4XDYFruIDEXc1ii
 hXTSEl5cwda9ZBZkeLUleniHXNoydxEXXxeVv8ZAkDm7zvTotW+EoHZNPlzOiT7CfYGg
 cNA6l+A/b9nFeDXEzZrQUCfuE5b2lk7cNW15gMz3dRSWrnjZhGQDaxeIspQWonXGWBmx
 4sBvSplu4+9qaSYH7LpDwwPiXx53oICsbf+jhv+/gM6F2MQXU9jfABgMatPLrB5UIq2h
 /u7tFIzOUPZYLl/l2m9ByzYNW1ppCYAe6HngXL/cPdDuMjI2p/cCkSFK9vFmgk6s7Syw
 BAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781324607; x=1781929407;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ciuFenAhAPLgo0cdrWXDGl27BMY9L62iO+Vq5WdTzHw=;
 b=OcCoq718hnekjhP96kz9yr5OLrpTDnMefOqWLRkZXuL9uckiK0b806yRdYEUeyWYlw
 QUH2OjVPTGVmojHANf0CPFCsUYYuqwtmDWZlSz7FEusaXUDxvzisuUxStt2sy04aYoYS
 mNfTt6pOjWg6RzVLBlucybuHVY1iFCSTkrTZDbXwA2e6ElnBNYZMPflBIjF6HSQun4hd
 QzfPkjTQDgIGwRijYb6PLQ3DGZb8mJ085MV8zGwGUMRBuS6RZEP+FTSx6AmTR6t7gExg
 WOSQdWS8Xj1ooPnAn9o/NYE071lD6h8UpZ5/Aj5YutLbfL2v4fHb/XXjK3SrjljAj+Eq
 hrdw==
X-Gm-Message-State: AOJu0YzgQ3qD1Vpy2X2DpFLatDidqTBADb6W8CWLqemP+eGbXIQNg9gt
 9/mgl+8tkYJV2KPgoLBATojuV1h5vEJBtsucGxnRWVSnSZ+3C10CVK1FMFZtazYSyVAOIvYqQeZ
 hkEU8jQ==
X-Received: from yxab13-n2.prod.google.com
 ([2002:a05:690e:158d:20b0:65c:3250:7837])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1407:b0:660:6a0c:c734
 with SMTP id 956f58d0204a3-66277f63899mr4676242d50.17.1781324606615; Fri, 12
 Jun 2026 21:23:26 -0700 (PDT)
Date: Sat, 13 Jun 2026 04:22:37 +0000
In-Reply-To: <20260613042300.3760470-1-blasko@google.com>
Mime-Version: 1.0
References: <20260605213022.2770893-1-blasko@google.com>
 <20260613042300.3760470-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613042300.3760470-5-blasko@google.com>
Subject: [PATCH v4 4/6] net/gve: add periodic NIC clock synchronization
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
synchronization runs every 250ms using rte_alarm. If the read fails,
the alarm is still rescheduled. After 7 consecutive failures, the
timestamp is marked as stale, indicating to the RX path that
reconstructed timestamps may be unreliable.

Atomics exist because of the potential for async callers (introduced
here) and async callers (introduced later in the RX datapath) accessing
the cached state.

Signed-off-by: Mark Blasko <blasko@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
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
2.54.0.1136.gdb2ca164c4-goog

