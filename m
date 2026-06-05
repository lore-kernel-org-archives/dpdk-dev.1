Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DADCD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 21:31:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 619C140684;
	Fri,  5 Jun 2026 23:30:57 +0200 (CEST)
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by mails.dpdk.org (Postfix) with ESMTP id 472C640676
 for <dev@dpdk.org>; Fri,  5 Jun 2026 23:30:56 +0200 (CEST)
Received: by mail-qt1-f201.google.com with SMTP id
 d75a77b69052e-5175bf22b1bso35456791cf.3
 for <dev@dpdk.org>; Fri, 05 Jun 2026 14:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780695055; x=1781299855; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=5f1gHhmax83NzMmgMbklOuk1ZfmVQg7/JRqlSO13ilg=;
 b=l3uDVOhEp+3xdmAwB0BIgvOH4vJOyhJIo/OHcBlc+AuHXVg4Xpu6H73TkhC9L74Yu3
 oUEQtr3J8cpciGaOFFi5DI//Jqsr2Y43lvnFxTVv2VJ+d/ej7udCGYL7rnCtMkSEMH9/
 SEHSobs5Btr8U4LINc//sW5dMITPBQVmWNtEqZfCCbsGZYBAiTp2NFqgKzkPksyk2Q0e
 ONNsfbmEW8DoxzssGKlnWkjtL/n0tdG2y3/TsmLsjKptstRMQ2jOUn670DDl25wywPc8
 OCPcHUJ9DjAim0OIEdUdFWLH7uGT4vybXjn0BDRC/P6L6CnjdKs/o8p9XQpY1Vtb7aBU
 c0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780695055; x=1781299855;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5f1gHhmax83NzMmgMbklOuk1ZfmVQg7/JRqlSO13ilg=;
 b=D10DiRUuZ3PJToAymfAAHkwAO62oHsR2Z15E/gM99Odf0anoujdRD1kB0Gk7q8v4It
 yCBw2ny6x5qHageLs57pW1sobZQQBEKE4Pyma+tC5vbfGtjU5QCXRPWCFPrIyKA8YCj1
 Ydij+tHxriNQw4mGrb+JQ3YC072q0Pss2Vu9CKCzs3aAH8rKyAYMUAN1fCBXuvDm6mfW
 FpsBxsQxDIY3tv3vehtVbV4E7Wy0uEwdy1Z4xoXBRiDyf3ZZQCQwr86zlfJ6qxkUWVok
 FAlNfNy44NZbM4oPql/w+ApXeA622m8i3xNeNDkwlLOyb+Ws0fqX54PX/FHH+iMzLyPT
 NqmA==
X-Gm-Message-State: AOJu0YwkA7jktQEXCNroTJyI00uWHrIa44rPVIxJRR92OIGppJsoKcyd
 mFrngUzksmvx2oe4j9+AayxOsvG3D9SbZSJK2eMsPSKY8D+Sq30MhoQPc6SuAyQHyKjOWfzLnRn
 bBeawSA==
X-Received: from qknto20.prod.google.com
 ([2002:a05:620a:4c94:b0:915:8774:8de4])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:260d:b0:516:d955:ea6
 with SMTP id d75a77b69052e-517959f7ca9mr78131561cf.14.1780695055162; Fri, 05
 Jun 2026 14:30:55 -0700 (PDT)
Date: Fri,  5 Jun 2026 21:29:42 +0000
In-Reply-To: <20260605213022.2770893-1-blasko@google.com>
Mime-Version: 1.0
References: <20260515231936.3296603-1-blasko@google.com>
 <20260605213022.2770893-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605213022.2770893-5-blasko@google.com>
Subject: [PATCH v3 4/6] net/gve: add periodic NIC clock synchronization
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
v2:
    - Removed redundant void* casts.
    - Handled alarm reschedule failures by marking timestamp stale.
    - Added transient error logging on memzone allocation failure.
---
 drivers/net/gve/gve_ethdev.c | 106 +++++++++++++++++++++++++++++++++++
 drivers/net/gve/gve_ethdev.h |   9 +++
 2 files changed, 115 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 476b2c311f..5d4f1e4ae8 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -452,6 +452,86 @@ gve_dev_start(struct rte_eth_dev *dev)
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
+
+	/* Reschedule the alarm for the next interval */
+	if (priv->nic_ts_report_mz) {
+		err = rte_eal_alarm_set(GVE_NIC_CLOCK_READ_PERIOD_MS * 1000,
+					gve_read_nic_clock, priv);
+		if (err < 0) {
+			PMD_DRV_LOG(ERR, "Failed to reschedule NIC clock read alarm, ret=%d", err);
+			rte_atomic_store_explicit(&priv->nic_ts_stale, 1,
+						  rte_memory_order_release);
+		}
+	}
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
@@ -576,6 +656,7 @@ static void
 gve_teardown_device_resources(struct gve_priv *priv)
 {
 	int err;
+	int ret;
 
 	/* Tell device its resources are being freed */
 	if (gve_get_device_resources_ok(priv)) {
@@ -586,6 +667,13 @@ gve_teardown_device_resources(struct gve_priv *priv)
 				err);
 	}
 
+	if (priv->nic_ts_report_mz) {
+		ret = rte_eal_alarm_cancel(gve_read_nic_clock, priv);
+		if (ret < 0)
+			PMD_DRV_LOG(ERR, "Failed to cancel NIC clock sync alarm, ret=%d", ret);
+		gve_free_nic_ts_report(priv);
+	}
+
 	gve_free_ptype_lut_dqo(priv);
 	gve_free_counter_array(priv);
 	gve_free_irq_db(priv);
@@ -1252,6 +1340,23 @@ pci_dev_msix_vec_count(struct rte_pci_device *pdev)
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
+	if (err == 0)
+		gve_read_nic_clock(priv);
+	else
+		PMD_DRV_LOG(ERR, "Failed to allocate memory for NIC timestamping subsystem. Please reset device to retry.");
+}
+
 static int
 gve_setup_device_resources(struct gve_priv *priv)
 {
@@ -1307,6 +1412,7 @@ gve_setup_device_resources(struct gve_priv *priv)
 			goto free_ptype_lut;
 		}
 	}
+	gve_setup_nic_timestamp(priv);
 
 	gve_set_device_resources_ok(priv);
 
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index b67f82c263..7e6f24e910 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -12,6 +12,7 @@
 #include <rte_pci.h>
 #include <pthread.h>
 #include <rte_bitmap.h>
+#include <rte_memzone.h>
 
 #include "base/gve.h"
 
@@ -39,6 +40,9 @@
 #define GVE_RSS_HASH_KEY_SIZE 40
 #define GVE_RSS_INDIR_SIZE 128
 
+#define GVE_NIC_CLOCK_READ_PERIOD_MS 250
+#define GVE_NIC_CLOCK_READ_MAX_FAILS 7
+
 #define GVE_TX_CKSUM_OFFLOAD_MASK (		\
 		RTE_MBUF_F_TX_L4_MASK  |	\
 		RTE_MBUF_F_TX_TCP_SEG)
@@ -359,6 +363,11 @@ struct gve_priv {
 
 	/* HW Timestamping Fields */
 	bool nic_timestamp_supported;
+	const struct rte_memzone *nic_ts_report_mz;
+	struct gve_nic_ts_report *nic_ts_report;
+	RTE_ATOMIC(uint64_t) last_read_nic_timestamp;
+	RTE_ATOMIC(uint32_t) nic_ts_read_fails;
+	RTE_ATOMIC(uint8_t) nic_ts_stale;
 };
 
 static inline bool
-- 
2.54.0.1032.g2f8565e1d1-goog

