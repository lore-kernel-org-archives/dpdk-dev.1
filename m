Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6119BCD4851
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 23:20:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3DA240665;
	Sat, 16 May 2026 01:19:49 +0200 (CEST)
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73]) by mails.dpdk.org (Postfix) with ESMTP id 8FBCE4065C
 for <dev@dpdk.org>; Sat, 16 May 2026 01:19:45 +0200 (CEST)
Received: by mail-qv1-f73.google.com with SMTP id
 6a1803df08f44-8b640ede74bso7157346d6.1
 for <dev@dpdk.org>; Fri, 15 May 2026 16:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778887185; x=1779491985; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=7JZMfiVHQ2ZosEJXLHaad5v21mfNtEJYN/1GHDrW6rI=;
 b=g/RxrWMs9fAvwZfi34yvNyW/ZvagcpoNJIbg5vO+kMc2DhlRV/06qrmMEN9fNfT16d
 Jx6fuzUgiCsACAivJJHR/YLIyK859Pf3RK68rguu2imfe+tXEgxNi/vktG7prm8sX81i
 PTVPClpLUktQjwk59TN7c3nxGbK/ufnHKpTAAKxFdd6PvoK+OWJWoeeCbR0sHdl/xJge
 1HVfF0IrERmocW+36HiWR7TynEg4X2kFsiQ5H7vnGswWPJRBbr/qedUXiyvcXLVyt/Kn
 9/2rAvPvVj0ewPts1TwrFOOhKFoVtelpk/7BNCXKfzVujUisROjSP1G4AsyZBlBLgHLa
 bK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778887185; x=1779491985;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7JZMfiVHQ2ZosEJXLHaad5v21mfNtEJYN/1GHDrW6rI=;
 b=gJabC+elnl2EW6x5dyT8N6zExfYqzOLPPf/85UTTm1hUW11Ogcby3DtsdgufJtDYT7
 sBlm8t7fw5b/gvJ/g+lUhJdMDX2xMTocwXisUjgu3F/obhX9ASmD2KV2JQh3vTftNXBp
 K8i0K7KJe2ROu+j1QGEQGjfzcF0IArvEpP94a6jgfyJMKRHF6Y/9OzvrLc973kY3FV3M
 YPUakHtiIf4zqJHPgFVwgTOhTEUrJKHH0YH8mn34WWWuk+odPi4AJgfiOaew844w7P7Q
 zeZ/+ys48hLR9phY7HqLBQEPmqU4NxCK2pKtRcKo1lCvcWumSVVeGDORbeKxYcK6Sr3H
 cOLA==
X-Gm-Message-State: AOJu0YwxxgdgpKDTHvOQdMnJjAHVRFs9H33Jp/JA5Xx/i4FxfWYuwZ3Z
 lSvqipQJzQgyxb3oR1m1ODHtxkBFVE82Ia1koxIML81jLIx+/NeiQOl4QnF5f9MzKxSZgFr3UlG
 oYSaXhw==
X-Received: from qvbkd21.prod.google.com
 ([2002:a05:6214:4015:b0:8b4:eeca:74de])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:808c:b0:8ac:b264:65ed
 with SMTP id 6a1803df08f44-8ca0f5e88ddmr91848416d6.6.1778887184748; Fri, 15
 May 2026 16:19:44 -0700 (PDT)
Date: Fri, 15 May 2026 23:19:34 +0000
In-Reply-To: <20260515231936.3296603-1-blasko@google.com>
Mime-Version: 1.0
References: <20260511224354.872997-1-blasko@google.com>
 <20260515231936.3296603-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515231936.3296603-6-blasko@google.com>
Subject: [PATCH v2 5/6] net/gve: support read clock ethdev op
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
v2:
    - Scoped read_clock ethdev operation strictly to DQO queues.
---
 drivers/net/gve/gve_ethdev.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index ee21fb3ec4..c600062faf 100644
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
-- 
2.54.0.563.g4f69b47b94-goog

