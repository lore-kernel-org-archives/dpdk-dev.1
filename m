Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6C4CD98C5
	for <dpdk-dev@archiver.kernel.org>; Sat, 13 Jun 2026 04:23:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2192D435DC;
	Sat, 13 Jun 2026 06:23:32 +0200 (CEST)
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73]) by mails.dpdk.org (Postfix) with ESMTP id AB587435C4
 for <dev@dpdk.org>; Sat, 13 Jun 2026 06:23:28 +0200 (CEST)
Received: by mail-qv1-f73.google.com with SMTP id
 6a1803df08f44-8cceaca5671so33176546d6.0
 for <dev@dpdk.org>; Fri, 12 Jun 2026 21:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781324608; x=1781929408; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=90/fWDrwVrOsCFM3XOktT/G//LlaUUMYNEuWdiknOLM=;
 b=qzlDjVO2B4N4Y6KO/H5xc1Busw1IZhc4vhOtZRRiTKezOpV5VUt1Wni32wRRbCei7f
 9xvYOprLdRgSPHqp1aEdZV4+h0TE0eXRMEktKpB8FTXW3Wz2ffk47+aREVCbWCSx4W2K
 hpHwniS/rrNNOTYJUgy593tuuhClFzCnKEg53ooETU9Mqp34E/xUZHeKn2/DiVBEXVtU
 F1W0E3zYy6uwno9SC2zDIlVtfI0RN4VnFX3Cdm0BsEqtk9VXtuOvKkdPk/N8f7Jnbmwo
 RTls9aVDYMBI5K9np77rMqR/XHeBKnhXfphtx0CXNiwouhdODRGNeWUXKhbkGZZc25X8
 JLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781324608; x=1781929408;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=90/fWDrwVrOsCFM3XOktT/G//LlaUUMYNEuWdiknOLM=;
 b=b9dAb2ZGx030zeZkaa4ei+cDonVacpYURzClT6lcr5/sn85Rm+8mjsJhUwxULfDn5+
 SEv1XJxyp6y82edkCtv8WJPZxC0dCJ+3SUw1ijcZhFGNYrLDi5OXgeolwW6gMVws9PAN
 7Ldq1keShCZzVg0wrYAfwxBBulyHdRxIIHOijPiDUbTT/DZqugtRClQHQPEszcQwSdfU
 Bigxa4lM77diKl3vET6WIctL3M+q4tuVe4TkTzUmCVLoZmOdDo1K80iLilpS9OpVN+UO
 IVu0+CvOG92nxFPlBKCumWyENTSp/GlD0GrlKyG8R+DbWEKDO1rwCKsCPqhRsDYpdq+a
 Kwjw==
X-Gm-Message-State: AOJu0YwS8J8rhrz+w8wbXdNF/tFjHlUrRphtpJ1oOHBNPjy3EqRm8bpq
 vOKljlzdAiS5xr3ZW49f0p53PGXsX3Y/UKm8HqKr+vUTF+Ydhq9oyl1klm+Hfr7mK7zuPTAvT47
 NWH+SFQ==
X-Received: from qkntw4.prod.google.com ([2002:a05:620a:3ec4:b0:915:6c81:1d9b])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1b93:b0:914:b9a2:f29d
 with SMTP id af79cd13be357-9161bcb92e4mr914890385a.37.1781324607761; Fri, 12
 Jun 2026 21:23:27 -0700 (PDT)
Date: Sat, 13 Jun 2026 04:22:38 +0000
In-Reply-To: <20260613042300.3760470-1-blasko@google.com>
Mime-Version: 1.0
References: <20260605213022.2770893-1-blasko@google.com>
 <20260613042300.3760470-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613042300.3760470-6-blasko@google.com>
Subject: [PATCH v4 5/6] net/gve: support read clock ethdev op
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

Implement the read_clock operation in eth_dev_ops. The function calls
the AdminQ command to fetch the current NIC timestamp synchronously,
updates the cached timestamp used for reconstruction, and returns the
full 64-bit value.

Signed-off-by: Mark Blasko <blasko@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
v4:
    - Fix mutex initialization order: initialize nic_ts_lock before
      calling gve_init_priv() (which invokes early setup-time read).
    - Fix mutex teardown order: destroy nic_ts_lock only after the
      background sync thread has been joined and stopped.

v3:
    - Add mutex lock to protect shared NIC timestamp memzone access.
    - Fix missing read_clock assignment to DQO queue ops table
      (accidental omission in v2).

v2:
    - Scoped read_clock ethdev operation strictly to DQO queues.
---
 drivers/net/gve/gve_ethdev.c | 57 +++++++++++++++++++++++++++++++-----
 drivers/net/gve/gve_ethdev.h |  1 +
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index fa91575b3e..111f66efa8 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -463,11 +463,13 @@ gve_read_nic_clock(void *arg)
 	if (!priv || !priv->nic_ts_report_mz)
 		return;
 
+	pthread_mutex_lock(&priv->nic_ts_lock);
 	memset(priv->nic_ts_report, 0, sizeof(struct gve_nic_ts_report));
 
 	err = gve_adminq_report_nic_timestamp(priv, priv->nic_ts_report_mz->iova);
 	if (err == 0) {
 		ts = be64_to_cpu(priv->nic_ts_report->nic_timestamp);
+		pthread_mutex_unlock(&priv->nic_ts_lock);
 		rte_atomic_store_explicit(&priv->last_read_nic_timestamp, ts,
 					  rte_memory_order_relaxed);
 		PMD_DRV_LOG(DEBUG, "Fetched NIC Timestamp: %" PRIu64, ts);
@@ -476,6 +478,7 @@ gve_read_nic_clock(void *arg)
 		rte_atomic_store_explicit(&priv->nic_ts_stale, 0,
 					  rte_memory_order_release);
 	} else {
+		pthread_mutex_unlock(&priv->nic_ts_lock);
 		PMD_DRV_LOG(ERR, "Failed to read NIC clock, AQ err: %d", err);
 		fails = rte_atomic_fetch_add_explicit(&priv->nic_ts_read_fails, 1,
 						      rte_memory_order_relaxed) + 1;
@@ -705,12 +708,13 @@ gve_dev_close(struct rte_eth_dev *dev)
 	if (gve_get_flow_subsystem_ok(priv))
 		gve_teardown_flow_subsystem(priv);
 
-	pthread_mutex_destroy(&priv->flow_rule_lock);
-
 	gve_free_queues(dev);
 	gve_teardown_device_resources(priv);
 	gve_adminq_free(priv);
 
+	pthread_mutex_destroy(&priv->flow_rule_lock);
+	pthread_mutex_destroy(&priv->nic_ts_lock);
+
 	dev->data->mac_addrs = NULL;
 
 	return err;
@@ -1278,6 +1282,38 @@ gve_flow_ops_get(struct rte_eth_dev *dev, const struct rte_flow_ops **ops)
 	return 0;
 }
 
+static int
+gve_read_clock(struct rte_eth_dev *dev, uint64_t *clock)
+{
+	struct gve_priv *priv = dev->data->dev_private;
+	uint64_t ts;
+	int err;
+
+	if (!priv->nic_timestamp_supported)
+		return -EOPNOTSUPP;
+
+	if (!priv->nic_ts_report_mz)
+		return -EIO;
+
+	pthread_mutex_lock(&priv->nic_ts_lock);
+	err = gve_adminq_report_nic_timestamp(priv, priv->nic_ts_report_mz->iova);
+	if (err != 0) {
+		pthread_mutex_unlock(&priv->nic_ts_lock);
+		return err;
+	}
+
+	ts = be64_to_cpu(priv->nic_ts_report->nic_timestamp);
+	pthread_mutex_unlock(&priv->nic_ts_lock);
+	*clock = ts;
+
+	/* Update the cached value */
+	rte_atomic_store_explicit(&priv->last_read_nic_timestamp, ts, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&priv->nic_ts_read_fails, 0, rte_memory_order_relaxed);
+	rte_atomic_store_explicit(&priv->nic_ts_stale, 0, rte_memory_order_release);
+
+	return 0;
+}
+
 static const struct eth_dev_ops gve_eth_dev_ops = {
 	.dev_configure        = gve_dev_configure,
 	.dev_start            = gve_dev_start,
@@ -1332,6 +1368,7 @@ static const struct eth_dev_ops gve_eth_dev_ops_dqo = {
 	.rss_hash_conf_get    = gve_rss_hash_conf_get,
 	.reta_update          = gve_rss_reta_update,
 	.reta_query           = gve_rss_reta_query,
+	.read_clock           = gve_read_clock,
 };
 
 static int
@@ -1640,9 +1677,18 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	priv->max_nb_txq = max_tx_queues;
 	priv->max_nb_rxq = max_rx_queues;
 
+	pthread_mutexattr_init(&mutexattr);
+	pthread_mutexattr_setpshared(&mutexattr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(&priv->flow_rule_lock, &mutexattr);
+	pthread_mutex_init(&priv->nic_ts_lock, &mutexattr);
+	pthread_mutexattr_destroy(&mutexattr);
+
 	err = gve_init_priv(priv, false);
-	if (err)
+	if (err) {
+		pthread_mutex_destroy(&priv->flow_rule_lock);
+		pthread_mutex_destroy(&priv->nic_ts_lock);
 		return err;
+	}
 
 	if (gve_is_gqi(priv)) {
 		eth_dev->dev_ops = &gve_eth_dev_ops;
@@ -1656,11 +1702,6 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 
 	eth_dev->data->mac_addrs = &priv->dev_addr;
 
-	pthread_mutexattr_init(&mutexattr);
-	pthread_mutexattr_setpshared(&mutexattr, PTHREAD_PROCESS_SHARED);
-	pthread_mutex_init(&priv->flow_rule_lock, &mutexattr);
-	pthread_mutexattr_destroy(&mutexattr);
-
 	return 0;
 }
 
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 4dcbaa9971..1e80f3a906 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -366,6 +366,7 @@ struct gve_priv {
 	bool nic_timestamp_supported;
 	const struct rte_memzone *nic_ts_report_mz;
 	struct gve_nic_ts_report *nic_ts_report;
+	pthread_mutex_t nic_ts_lock;
 	RTE_ATOMIC(uint64_t) last_read_nic_timestamp;
 	RTE_ATOMIC(uint32_t) nic_ts_read_fails;
 	RTE_ATOMIC(uint8_t) nic_ts_stale;
-- 
2.54.0.1136.gdb2ca164c4-goog

