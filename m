Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6A5CD4855
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 07:56:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DF0540695;
	Tue, 12 May 2026 09:55:59 +0200 (CEST)
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by mails.dpdk.org (Postfix) with ESMTP id 83B3140278
 for <dev@dpdk.org>; Tue, 12 May 2026 00:23:50 +0200 (CEST)
Received: by mail-qt1-f202.google.com with SMTP id
 d75a77b69052e-50edf01172bso122705851cf.2
 for <dev@dpdk.org>; Mon, 11 May 2026 15:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778538230; x=1779143030; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=oYgU6QxNJNnACp/oMkuQg16zbBDGoRiTUDEq8kcYrME=;
 b=MyZ8SK6hgJndPKhp12x96l4xAhBFFn3jEBFc5KctdX9oEZHOhp/KGxgrMf8vYhwwEo
 ELchSC4WNZssosxURM9hGY25ygdsywjuJnvhYMH0m9b74grv7DEuTjxpdmdNtWPcVctm
 RT4rTpFmsi/7tSpTPc0I+aA1Z1yqxUYH6w9jAKt8ndyohbRRaNtTE2w6npgF2bAxAe0I
 k0HIrkPAL72RLwGJP+fw35Dq4E4uPa8UIAjCY2vfxeTG5BHi7OewKDY4NcVvuVpH1+wO
 Ubd/0RgTs64CSJLhnbFzcT6brQh6YEBeIIYDzCdd8PHysLweC7PvhqRpPwr7LS1NdTUm
 7lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778538230; x=1779143030;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oYgU6QxNJNnACp/oMkuQg16zbBDGoRiTUDEq8kcYrME=;
 b=c4xyX97w4VcbBQOYGD34bI1m5cxliv6ENySbAhMJglb8gpYEGctJqZGecc273sTEqf
 Q6fQHDYivzcJCpivAL+IsRj+M9td4Li3IXYzy34lqJksiMSYQuBPsmMNw4oiHYifFdjl
 Gs39HMqSm5KByJrmfma9fyJi07P6WyaabQmPWT9SiaIuKMMf2TGoQDaBU5eNNynWmiK6
 nfxZaC9ZzjB53y/V8R7q2T5v5m7CbJhablQMxQN7wTeX68avaWugWLq3MeytfIHkmC7x
 O7u6gD6F0kr20gFai/HuEtrcdf6eIGbHsl0L1v4FOijZ3eeppwftulq8e1Xj+pCT1tRO
 ahOQ==
X-Gm-Message-State: AOJu0Yx0vuJE7dqS3x3ZYuZrE6dsFoXeyejQUIy+UNtsx76J1zm4B6zf
 wv2JlBy6Ok7F23xnKumTCsOExvRlvUp4nAyZ/UDxylXnyrcLD7N9RvpF6LWlsRK3Hkl21CGwdqQ
 cFwQOfg==
X-Received: from qtdd18.prod.google.com ([2002:ac8:5ad2:0:b0:50f:f0be:dbd4])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7dd0:0:b0:50b:5146:8803
 with SMTP id d75a77b69052e-51461c0284fmr376890231cf.21.1778538229565; Mon, 11
 May 2026 15:23:49 -0700 (PDT)
Date: Mon, 11 May 2026 22:22:59 +0000
In-Reply-To: <20260511222301.862880-1-blasko@google.com>
Mime-Version: 1.0
References: <20260511222301.862880-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511222301.862880-6-blasko@google.com>
Subject: [PATCH 5/6] net/gve: support read clock ethdev op
From: mark-blasko <blasko@google.com>
To: jeroendb@google.com, joshwash@google.com
Cc: dev@dpdk.org, jtranoleary@google.com, Mark Blasko <blasko@google.com>
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

