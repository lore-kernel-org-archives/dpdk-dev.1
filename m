Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF8ACD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 21:31:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 529D640670;
	Fri,  5 Jun 2026 23:31:00 +0200 (CEST)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74]) by mails.dpdk.org (Postfix) with ESMTP id 42FC040667
 for <dev@dpdk.org>; Fri,  5 Jun 2026 23:30:57 +0200 (CEST)
Received: by mail-qv1-f74.google.com with SMTP id
 6a1803df08f44-8ceba6ec0ccso51586d6.1
 for <dev@dpdk.org>; Fri, 05 Jun 2026 14:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780695056; x=1781299856; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=r0Z5y2KhutpYO3HwF5kdN1MYMqMbW73dAabNVmIgwIU=;
 b=dzEhDtslpX13Q1Htl9IAHs07lZ52EwdUOqUWtc72Bk/x55kgEBSXeObFdFky9x8dhJ
 V8JzB2NXuAbH9yJDg4jd1vE5QUIm3mJWJY896/hPVUcBBMLwwkK3eXW4+r+4LwdN9yYK
 rTamX7nLNA5G31XGOK9243D7TD8LI9I6jTqHs7mEO5AfxnN9ec8SJn1MKUgDYUM2uh4B
 AU97AoUgse8OFTEiP5r+A2HejL8gio+bLtuHuevnJh7JicaUz9OfTOWJIkcsVo+jJypG
 m3oCP4GoCmuWoBvPlBQpncRQNr7jZpFN1LBhNVoCEF0cyEp9W3SRg5eCXipgxvxNwVMt
 uleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780695056; x=1781299856;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r0Z5y2KhutpYO3HwF5kdN1MYMqMbW73dAabNVmIgwIU=;
 b=mJ7NKd8DV8r5zqZVJKHUXth8QituL0cumaZarTdsvn04S5wPVl1D/rO3NFIz50EP8u
 AZd0UtxtibEjBCsVV/z9EG+NGwvuVd+qJ42qLp5EiL67jZ2tNdogqYo/FEBNMOt3ylww
 KSiY++ayCrSi2jgBKMScWLcNBbtIht+3DZDKBMvW8lgaB5cqiZBMNrptGR3+HkICuVkC
 K8SAIw5onzOc2J713CGvI/G++h6u99kI2HmqLLnc2hCptWqSp8rttIE70z7rZeAj7SSg
 FhmTHOChtffK288ygPlKKuJYv4/1EFbrhn4IMmMJAx8oJa0EPPh4+ubQwotTtUPsfyD6
 uAlw==
X-Gm-Message-State: AOJu0YzpQURMQnEITCRLHHVvSYnRN6b2gtFa2jnFro09vrwS1DGYZSeb
 l2J53Bgy15NRQD4hZpLABbEG+pP/iJdPNGj2wQTqv8j6TqBy/NBd7+VDfDcNWWZ77fni6ICpmx/
 VajFfbw==
X-Received: from qknop54.prod.google.com
 ([2002:a05:620a:5376:b0:915:84c9:9d03])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:460b:b0:915:a217:a96b
 with SMTP id af79cd13be357-915a9a43541mr1007930685a.0.1780695056344; Fri, 05
 Jun 2026 14:30:56 -0700 (PDT)
Date: Fri,  5 Jun 2026 21:29:43 +0000
In-Reply-To: <20260605213022.2770893-1-blasko@google.com>
Mime-Version: 1.0
References: <20260515231936.3296603-1-blasko@google.com>
 <20260605213022.2770893-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605213022.2770893-6-blasko@google.com>
Subject: [PATCH v3 5/6] net/gve: support read clock ethdev op
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
v3:
    - Add mutex lock to protect shared NIC timestamp memzone access.
    - Fix missing read_clock assignment to DQO queue ops table
      (accidental omission in v2).

v2:
    - Scoped read_clock ethdev operation strictly to DQO queues.
---
 drivers/net/gve/gve_ethdev.c | 38 ++++++++++++++++++++++++++++++++++++
 drivers/net/gve/gve_ethdev.h |  1 +
 2 files changed, 39 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 5d4f1e4ae8..ec9f511a00 100644
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
@@ -699,6 +702,7 @@ gve_dev_close(struct rte_eth_dev *dev)
 		gve_teardown_flow_subsystem(priv);
 
 	pthread_mutex_destroy(&priv->flow_rule_lock);
+	pthread_mutex_destroy(&priv->nic_ts_lock);
 
 	gve_free_queues(dev);
 	gve_teardown_device_resources(priv);
@@ -1271,6 +1275,38 @@ gve_flow_ops_get(struct rte_eth_dev *dev, const struct rte_flow_ops **ops)
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
@@ -1325,6 +1361,7 @@ static const struct eth_dev_ops gve_eth_dev_ops_dqo = {
 	.rss_hash_conf_get    = gve_rss_hash_conf_get,
 	.reta_update          = gve_rss_reta_update,
 	.reta_query           = gve_rss_reta_query,
+	.read_clock           = gve_read_clock,
 };
 
 static int
@@ -1643,6 +1680,7 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	pthread_mutexattr_init(&mutexattr);
 	pthread_mutexattr_setpshared(&mutexattr, PTHREAD_PROCESS_SHARED);
 	pthread_mutex_init(&priv->flow_rule_lock, &mutexattr);
+	pthread_mutex_init(&priv->nic_ts_lock, &mutexattr);
 	pthread_mutexattr_destroy(&mutexattr);
 
 	return 0;
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 7e6f24e910..114531a481 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -365,6 +365,7 @@ struct gve_priv {
 	bool nic_timestamp_supported;
 	const struct rte_memzone *nic_ts_report_mz;
 	struct gve_nic_ts_report *nic_ts_report;
+	pthread_mutex_t nic_ts_lock;
 	RTE_ATOMIC(uint64_t) last_read_nic_timestamp;
 	RTE_ATOMIC(uint32_t) nic_ts_read_fails;
 	RTE_ATOMIC(uint8_t) nic_ts_stale;
-- 
2.54.0.1032.g2f8565e1d1-goog

