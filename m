Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D196CD4846
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 00:51:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7A8A4066C;
	Tue, 12 May 2026 02:51:11 +0200 (CEST)
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by mails.dpdk.org (Postfix) with ESMTP id 0083040657
 for <dev@dpdk.org>; Tue, 12 May 2026 02:51:08 +0200 (CEST)
Received: by mail-qt1-f202.google.com with SMTP id
 d75a77b69052e-50b220c72bbso88851671cf.1
 for <dev@dpdk.org>; Mon, 11 May 2026 17:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778547068; x=1779151868; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=oYgU6QxNJNnACp/oMkuQg16zbBDGoRiTUDEq8kcYrME=;
 b=UH8ATi32elvwGY2YS9AYTUET9QGDSVc9wsRZ/IghyUskLEh4PVBDlio3IavR2g3o75
 bNykLCRrWteHA1ifIP21r3Z42lmfLwNxfOpjsWMG0y0nH3mBG3vEt2oNuZAFt8Srm4Lc
 I/SMKuDIluuamWKEyOsA1oZN8zaCVyavRLZBe5ZN4JwTR8lXdaDm+6cTAi9dAOSUyKTW
 cpwtnAZjsm0o/TxtbdbIxIcULl3qes589XR0vGrdiWZN2nS+D87uwk1Qxwnkm0yKDG+F
 Yv4qQyeaT9CmctgwMKTx7sOHF+3odXpzakMFoMzZsMRB/pS6VscjucnG9j7wzmIIiYjN
 h6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778547068; x=1779151868;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oYgU6QxNJNnACp/oMkuQg16zbBDGoRiTUDEq8kcYrME=;
 b=WcDv4VPMfQ+HRHhOx2H5Q+5Uwuk0GUy/lAvWZtfrbL6WU+rsSbWJ05YXgazZHj2ZAT
 ms/YhC28Osz0A7a1iwx4TZKjbdUgkgvkMZnBgi/Nt4SxktLCBz8aUtyGRYLAWG25syNs
 L7SiskhKeIsAnLA9sN/5HJ6ch32ttlunF+B4gLH22dVs+HiN8Rg5oKu+mkSIAiR4DZ/Y
 P4NFvCxC76prIxN0J5kSkTZqRdMhtgtih7jtfvmlTslXhsawqlmNX9szS3IQ1aQrCuv9
 TBY1ir5I/M34Jf8OaHi6vG0Px6Hxr4cbVf22KIqsZSeb0R3yrYyyN7mtRnTF9FjtDM63
 rg6Q==
X-Gm-Message-State: AOJu0YyA1k8WYoyl5GpFRTPWDUrov1ReqyCVTdK6fYQS6nM7In+TXUBg
 /Qq9dTLycAK1AAsh/HmtVLWeSLbBD2pX1HAvMllRLJrCADvSv5Kbl2FwpYtRrXhGn9c00wsluZg
 Wq339jA==
X-Received: from qtod20.prod.google.com ([2002:ac8:5354:0:b0:50f:ae4d:1d48])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2c7:b0:50e:6302:340b
 with SMTP id d75a77b69052e-514d2270321mr13304951cf.53.1778547068032; Mon, 11
 May 2026 17:51:08 -0700 (PDT)
Date: Tue, 12 May 2026 00:50:54 +0000
In-Reply-To: <20260512005057.944672-1-blasko@google.com>
Mime-Version: 1.0
References: <20260512005057.944672-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512005057.944672-6-blasko@google.com>
Subject: [PATCH 5/6] net/gve: support read clock ethdev op
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

