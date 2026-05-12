Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C07CD37BE
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 00:51:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80C4D40661;
	Tue, 12 May 2026 02:51:10 +0200 (CEST)
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73]) by mails.dpdk.org (Postfix) with ESMTP id 060AD40650
 for <dev@dpdk.org>; Tue, 12 May 2026 02:51:08 +0200 (CEST)
Received: by mail-qv1-f73.google.com with SMTP id
 6a1803df08f44-8b5f089a5c3so92541776d6.3
 for <dev@dpdk.org>; Mon, 11 May 2026 17:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778547067; x=1779151867; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=z+ERSDPviOhwumluKUUc8xTS63n2y3xmcAb/m6Xul6c=;
 b=Fkd28N2KcOEObrWt6bay1Miciy0DpZUr0U3RfH5Vxe6jSMk4K5NQynp+bx/efFLDOq
 5/fXitHNzvsNqe1tn+ZTWF3kYHkzv+uaSuP5Vu2sLbg3dErBUZ6LhfOdrlYCHa0RQz12
 U5EryNbk06IG9Gxi1Lovj5ioTHLljbSJ8DmKHVVr60AZhZJK1pqr44+a477vlz6zFPoP
 xvN88pUffjmAV6hNj4D9bppldMdsmPNz31vlC8BqLJcsxzStLcAS/Uo/y2a8hiMZsDf6
 tqJ8mapgx1DmZjyDF8nFNHx2e1PoPIAvCRUbQbvQm4SLDXY1BefYkMKs4/sPfvyI5Jx8
 7cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778547067; x=1779151867;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z+ERSDPviOhwumluKUUc8xTS63n2y3xmcAb/m6Xul6c=;
 b=IU+u6xz+iNYd81CZ0hTLNJ4nDOUB76+wVQWeU+EWHTHiuRW5YRtFBAHviFpAGN0LoF
 DstgN10VCf8QHrLQGfe0rfKELdXOgcCfHu2/hAK0+E4bRSeADRGXF9s1PU75izUtNhED
 mRKPdudA5+ZIJU0RtjlGYraKWBX9ZSHUaaXW8VUo+hGVxm3/oyCWoHfsF8MFwX8UowVm
 jbgcMHPio6+IU36g5YxXQz54Nfh+Q/SQrfAkgibH8XvB1QL8KkYOoWXUNSJrFlkI3kO+
 hIwbm7ROpxNcTqig6WW614DnEuAU6lXgJT87EueChE6smLpgfkm+Ge4MNKnjdmwmsJyX
 HC2A==
X-Gm-Message-State: AOJu0YwvpP744J8lKUcNVdgdQ0pI857j9RNmT+cf5jGsih91Dg/fT52S
 QmwW8A6PAKjrv8fJTKwI3ISbak+dNWeUdJyJW0pYQOlDZab9T6zgMCvAZvo7SPdFaGmXbneJgx6
 8K0jnMw==
X-Received: from qvvv9.prod.google.com ([2002:a05:6214:8089:b0:897:30d6:404d])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:6118:b0:89c:4fab:3783
 with SMTP id 6a1803df08f44-8c18808f5afmr152709946d6.0.1778547067077; Mon, 11
 May 2026 17:51:07 -0700 (PDT)
Date: Tue, 12 May 2026 00:50:53 +0000
In-Reply-To: <20260512005057.944672-1-blasko@google.com>
Mime-Version: 1.0
References: <20260512005057.944672-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512005057.944672-5-blasko@google.com>
Subject: [PATCH 4/6] net/gve: add periodic NIC clock synchronization
From: mark-blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>, 
 Joshua Washington <joshwash@google.com>,
 "Jasper Tran O'Leary" <jtranoleary@google.com>
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

From: Mark Blasko <blasko@google.com>

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
 drivers/net/gve/gve_ethdev.c | 104 +++++++++++++++++++++++++++++++++++
 drivers/net/gve/gve_ethdev.h |   9 +++
 2 files changed, 113 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index a9e2063dda..b36bc7266e 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -452,6 +452,86 @@ gve_dev_start(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static void
+gve_read_nic_clock(void *arg)
+{
+	struct gve_priv *priv = (struct gve_priv *)arg;
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
+		if (err < 0)
+			PMD_DRV_LOG(ERR, "Failed to reschedule NIC clock read alarm, ret=%d", err);
+	}
+}
+
+static int
+gve_alloc_nic_ts_report(struct gve_priv *priv)
+{
+	char z_name[RTE_MEMZONE_NAMESIZE];
+
+	if (!priv->nic_timestamp_supported)
+		return -EOPNOTSUPP;
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
+	priv->nic_ts_report = (struct gve_nic_ts_report *)priv->nic_ts_report_mz->addr;
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
@@ -1252,6 +1340,21 @@ pci_dev_msix_vec_count(struct rte_pci_device *pdev)
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
+}
+
 static int
 gve_setup_device_resources(struct gve_priv *priv)
 {
@@ -1307,6 +1410,7 @@ gve_setup_device_resources(struct gve_priv *priv)
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
2.54.0.563.g4f69b47b94-goog

