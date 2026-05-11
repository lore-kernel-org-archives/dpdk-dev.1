Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A5ECD4855
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 07:57:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27DFB40A82;
	Tue, 12 May 2026 09:56:06 +0200 (CEST)
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by mails.dpdk.org (Postfix) with ESMTP id 5AD9040278
 for <dev@dpdk.org>; Tue, 12 May 2026 00:44:06 +0200 (CEST)
Received: by mail-qt1-f201.google.com with SMTP id
 d75a77b69052e-514551d5f2aso131482511cf.2
 for <dev@dpdk.org>; Mon, 11 May 2026 15:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778539446; x=1779144246; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=oYgU6QxNJNnACp/oMkuQg16zbBDGoRiTUDEq8kcYrME=;
 b=dgkEc/PiY2t9Sou5m58099OrS7xOdHrqqbD/XQkHk6c7lkL2m8To26Spf0LTSIvGW/
 ZupbYr4cz4WAX6X+expO+vFJ4Gaz6WS/j+bnVgKxKzVrslxfLOsVcDSNMSOPu7Os6zX/
 SwZjniFvsqCRDw88ob2a6zXqgtVG6rVH1nA6bcSa9SXyQzKzVtu7gZk0pFVA0+LBSFH4
 HtJ5ZDNqtBQRNA16zcHmuZ5poWzfG3v+h9qVgvIY2uykaL769fSJR2+EhWhUAxxRhmI8
 z+F0OTxuOuFz4wnoxbxXzTa5kDGBjWGaubunSNy2SXNFu4kzFWbVlxCoofUaiBumzCwN
 Yhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778539446; x=1779144246;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oYgU6QxNJNnACp/oMkuQg16zbBDGoRiTUDEq8kcYrME=;
 b=TuDrfzEyhyIhnhnfAgbUe3sZoNDvEDJ3bevjMnYEHblsnD+eXyc3xxvC/TqIfgctl3
 +5qmleQ1nz6RXckeLXcfZPFJmYrbYe6OXm+fEYO+p9EeK3BR5zi6aKzseEGKhewrXgke
 Wm/1iC6lCkwJ0dAPpVhPyYVyoaw7M/0VzRgUsOH+V4v3nP/hId7hqwb+nSFmvOjEzkt1
 7c0drc4zMhgvpDwJISeLVZVLywGkUZn+hpmAKkJvS5uKhgXpnJQE1wdG5yd4ncWVWiOL
 qke+Gh5iwE1++HfTlhs749lrXn/Yh4GdBGBw0DlQeAZTNVjyAledeJZ7kmNcaInlLUtv
 nVmg==
X-Gm-Message-State: AOJu0YyiPUmLzrvcIYpcWCERE1fJLTmCkVwZUix8rTsSrDXsbGj0yqg3
 VB77KqYG/mrdJBvQveYwnIhR4AUhJ6ua4P88TG1lkLO8/AteVjJ1wxh3Q3RNurBp5nuNb2eVVcj
 o+Wnilw==
X-Received: from qtgu5.prod.google.com ([2002:ac8:505:0:b0:50b:3c2a:bdb3])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:578f:0:b0:510:2506:1ba9
 with SMTP id d75a77b69052e-514d2222c77mr9647321cf.49.1778539445513; Mon, 11
 May 2026 15:44:05 -0700 (PDT)
Date: Mon, 11 May 2026 22:43:53 +0000
In-Reply-To: <20260511224354.872997-1-blasko@google.com>
Mime-Version: 1.0
References: <20260511224354.872997-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511224354.872997-6-blasko@google.com>
Subject: [PATCH 5/6] net/gve: support read clock ethdev op
From: mark-blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>, 
 Joshua Washington <joshwash@google.com>,
 "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 12 May 2026 09:55:49 +0200
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

Implement the read_clock operation in eth_dev_ops. The function calls
the AdminQ command to fetch the current NIC timestamp synchronously,
updates the cached timestamp used for reconstruction, and returns the
full 64-bit value.

Signed-off-by: Mark Blasko <blasko@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/gve_ethdev.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index b36bc7266e..e1f2585ede 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1271,6 +1271,34 @@ gve_flow_ops_get(struct rte_eth_dev *dev, const struct rte_flow_ops **ops)
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
+	err = gve_adminq_report_nic_timestamp(priv, priv->nic_ts_report_mz->iova);
+	if (err != 0)
+		return err;
+
+	ts = be64_to_cpu(priv->nic_ts_report->nic_timestamp);
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
@@ -1297,6 +1325,7 @@ static const struct eth_dev_ops gve_eth_dev_ops = {
 	.rss_hash_conf_get    = gve_rss_hash_conf_get,
 	.reta_update          = gve_rss_reta_update,
 	.reta_query           = gve_rss_reta_query,
+	.read_clock           = gve_read_clock,
 };
 
 static const struct eth_dev_ops gve_eth_dev_ops_dqo = {
@@ -1325,6 +1354,7 @@ static const struct eth_dev_ops gve_eth_dev_ops_dqo = {
 	.rss_hash_conf_get    = gve_rss_hash_conf_get,
 	.reta_update          = gve_rss_reta_update,
 	.reta_query           = gve_rss_reta_query,
+	.read_clock           = gve_read_clock,
 };
 
 static int
-- 
2.54.0.563.g4f69b47b94-goog

