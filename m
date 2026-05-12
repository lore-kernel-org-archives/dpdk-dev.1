Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAF4CD4846
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 00:54:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5688640693;
	Tue, 12 May 2026 02:54:14 +0200 (CEST)
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by mails.dpdk.org (Postfix) with ESMTP id 1A9BB40665
 for <dev@dpdk.org>; Tue, 12 May 2026 02:54:12 +0200 (CEST)
Received: by mail-qt1-f202.google.com with SMTP id
 d75a77b69052e-514ae0e3ad6so57404411cf.0
 for <dev@dpdk.org>; Mon, 11 May 2026 17:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778547251; x=1779152051; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=X/Zwctbk0tuH7lyn0md6UO3wTBllP3rc+U24AQp+GkQ=;
 b=v50KrWX87vbXfgmI4pMyw3baBx1/rTzgOZZEZHL3e6V7Uflh6SCvTXY9rv45HFPMI/
 fR5Jcn95murOdbKe3dc9nMDvRP724T7QIHvjV1NgpPxLC9PxeY+PZ6h0VsJ/SDc73gSr
 /a4NTv51pgATbM0rjIEtIOaXIOUjwFdV9JzvXkpoi+iqEf2zFma1GUSUEM/wenKOEQEY
 r50Nmvd/kooixaXYnZPcS3szY4jPsZo+QVy2+ygvZuof/P/Gl66II6SgKQ8OnrqrQgGX
 JDJtqS7sGg7C2p0zwqAUjD+wfPd2mzkAW+ndTNYXI2XCH9/j91jGCyw+JKK/XewvawKx
 S+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778547251; x=1779152051;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X/Zwctbk0tuH7lyn0md6UO3wTBllP3rc+U24AQp+GkQ=;
 b=F2fMdbQvGV0kHwuY4l7En1D37q6uN2pINsSZi/cK2ygvhh/cFOQWAt6fJmWKTGUqi6
 PLDZPNxROxt+c8MeldSk3VhIWM7cn74nR4G8P6k44tnN8Ncj1SnmRcXeOoPgAQa7fD3t
 +8qXgQ1DdX958/qt1Mvx8MHdoo1IelB1QrhwWiwjWqvEG3gRKJb0QWDkr0fVi70xgxh0
 svt1cZTvbwhpXIubsS6qkQSIf44WWHP+/A6shmvdwrP+OotV7Ej7nxUizFxxTKhuQRDs
 7zzneKvtS5Z2MkJnhzXFPngu86782SbonYBYpBC68qWXA0kUbbYxUJz8Nl2ltd2R2Dc/
 7ksw==
X-Gm-Message-State: AOJu0YyXPPSahrnuPeyKUPlaQwYjzKpWI8o2jnok5Te/Av36DKdn/J9u
 Jpr5BtOtO91UsKcsj8Ax8mLILpREJaLQQwCw+LILX6XvhaSGzaxZIudtCO/nW6CT6e9BuMMHD43
 UUVP2pw==
X-Received: from qtbjz13.prod.google.com
 ([2002:a05:622a:81cd:b0:508:fe4c:e5ba])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5c9:b0:50f:340f:ff35
 with SMTP id d75a77b69052e-514ceff82d5mr23414071cf.26.1778547251120; Mon, 11
 May 2026 17:54:11 -0700 (PDT)
Date: Tue, 12 May 2026 00:53:52 +0000
In-Reply-To: <20260512005404.946979-1-blasko@google.com>
Mime-Version: 1.0
References: <20260512005404.946979-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512005404.946979-6-blasko@google.com>
Subject: [PATCH 5/6] net/gve: support read clock ethdev op
From: Mark Blasko <blasko@google.com>
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

