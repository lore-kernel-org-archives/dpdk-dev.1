Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98295D6CFC1
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 04:31:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 522D940691;
	Fri, 23 Jan 2026 05:30:27 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id E782640696
 for <dev@dpdk.org>; Fri, 23 Jan 2026 05:30:24 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so15703735e9.2
 for <dev@dpdk.org>; Thu, 22 Jan 2026 20:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769142624;
 x=1769747424; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2efeRNrCdrMPbej6VXPI+4qlGPa2dstlpUlX8ye1Us=;
 b=ORJW357IdxZgES8ppvpVfklTY6QQhoiMQG8U6+NNVDtEDFq+OQoNbtzgNXpmrVYDWE
 mED3zcfaVeQpTkzAqi2rYxz65hVGwhWMKk180cjCIFNomiGsDR+Wd7NqgWuR1Ng74r96
 mZoNoDqzxnkkBJ+p0FhECZPltey93tFdc3MdxuD9U/GKxGalUDWmnlJdKk8aG48se70T
 2yYsR2Gqh7y3Wu6DKVc64GIpyym/NmWnX8DynNVpu+lxKJpOZLYX4TsjikxJwfwps4qQ
 TdRcybJZMDEPi2HYgDVMS+UjgpxLtusGKthFWBVP8zQoz+xORn1U12Ts58e6KfH5S/yA
 fnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769142624; x=1769747424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k2efeRNrCdrMPbej6VXPI+4qlGPa2dstlpUlX8ye1Us=;
 b=J862tWbCOr3Q6feHwJhdETHQtj3Tz+dgv8JgpU8kSucUZUStnje1D/zVZg2HQsVnYc
 rvjXLNpAnwxi2MQTZGC8wwuoKjZmUOHH9cHJxAwTVX65J1Qb+73ihZp+aEnDl18skAMj
 7xPzbC9Ynr4Lzx1QxOslNDh1q6VvT8+FVFHBpMhro8pb2TiNCQuUiK0GUPynmdeOldnx
 KLWk6QjW623OB3TZqS8h4Kz4+4i6sNDX9kpzjeNpHGXusVhVAi3n5D5KiHsAti3o5C34
 UDnJY3kCuG1tfnab+A2usIg7BQfx/ThC1FkzPyos3V8Ip7b4sLBrJQxo/r/FVhy61jlt
 y+DQ==
X-Gm-Message-State: AOJu0YzQsxAFq40rHchuWhz9+8lz8jsO1ehP1t8/ZjYOCL7Lb4yGIs1v
 CWBeAXv0MgT5+Vr8f2dXlX5Brh2eR+WnuQ4pI0BKuBtDBl9R8gr2reQxf2Jv4eM3y1y+77QKr2Y
 11ca+
X-Gm-Gg: AZuq6aIkq5zGhZ9mXp8EJ9pV8yDzz5iluWuU4DV0x8Bhadd2El2ryPFOkSb6LPPwDqN
 aVK+I6yYMF3evjy8o4Mz6Xup8ZM3JSrrwHV37eqPvJU+KEBT/l9UKckQlg1ozwFxlfgPGYwAJbf
 9etIgcUKUEDCpObO4XqPZnTZquEpCwBkBxdgd6GfxRSPuM8Y2G2MuE1qdEavnPTj/QOcIjRxpcd
 gEWyom0YBrxIZj4VugWVGPJrXCX0072PEyKP+Ju1DxTF+RK8ZlBRGBfhFTgjNaN4CmBYs4h16rn
 37Do39qxOnV6VdXMsMb4VyreIQ9F8pg1uDqctEdTj7GhZhVPrmkG8ql/qIHp6wP7J5Y/fuDjBS/
 ZHh9L8xiwTgCODMOyiuLyn0QSUBRWpkbcJ5ER431Ku3XSEcgqxR79R5ZCaPRuUXJ+jwDp70WLXK
 u9AjLWZ4rU1yHGguNFJyj+9lTkqApeMDRh3+b4Hgk6MsFvwo9CGg==
X-Received: by 2002:a05:600c:638e:b0:479:3a86:dc1c with SMTP id
 5b1f17b1804b1-4804c9c900amr26912125e9.36.1769142624482; 
 Thu, 22 Jan 2026 20:30:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b41asm3603771f8f.39.2026.01.22.20.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 20:30:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v11 15/18] ethdev: avoid possible overflow in xstat names
Date: Thu, 22 Jan 2026 20:28:13 -0800
Message-ID: <20260123042945.159075-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123042945.159075-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260123042945.159075-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The compiler doesn't know that all the elements in the table
of queue stats are short enough to avoid overflowing the snprintf.
Add a condition to warn if it ever does;
maybe some day a new long named queue stat could be added.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/ethdev/rte_ethdev.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 2659e8d9eb..8026e7adb4 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3488,9 +3488,10 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 	uint16_t num_q;
 
 	for (idx = 0; idx < RTE_NB_STATS; idx++) {
-		strlcpy(xstats_names[cnt_used_entries].name,
-			eth_dev_stats_strings[idx].name,
-			sizeof(xstats_names[0].name));
+		if (strlcpy(xstats_names[cnt_used_entries].name, eth_dev_stats_strings[idx].name,
+			    sizeof(xstats_names[0].name)) >= sizeof(xstats_names[0].name))
+			RTE_ETHDEV_LOG_LINE(ERR, "statistic name '%s' will be truncated",
+					    xstats_names[cnt_used_entries].name);
 		cnt_used_entries++;
 	}
 
@@ -3500,10 +3501,17 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 	num_q = RTE_MIN(dev->data->nb_rx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
 	for (id_queue = 0; id_queue < num_q; id_queue++) {
 		for (idx = 0; idx < RTE_NB_RXQ_STATS; idx++) {
-			snprintf(xstats_names[cnt_used_entries].name,
-				sizeof(xstats_names[0].name),
-				"rx_q%u_%s",
-				id_queue, eth_dev_rxq_stats_strings[idx].name);
+			unsigned int cc;
+
+			cc = snprintf(xstats_names[cnt_used_entries].name,
+				      sizeof(xstats_names[0].name),
+				      "rx_q%u_%s",
+				      id_queue, eth_dev_rxq_stats_strings[idx].name);
+
+			/* could only happen if a long string was added */
+			if (cc >= sizeof(xstats_names[0].name))
+				RTE_ETHDEV_LOG_LINE(ERR, "truncated rxq stat string '%s'",
+						    eth_dev_rxq_stats_strings[idx].name);
 			cnt_used_entries++;
 		}
 
@@ -3511,10 +3519,15 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
 	num_q = RTE_MIN(dev->data->nb_tx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
 	for (id_queue = 0; id_queue < num_q; id_queue++) {
 		for (idx = 0; idx < RTE_NB_TXQ_STATS; idx++) {
-			snprintf(xstats_names[cnt_used_entries].name,
-				sizeof(xstats_names[0].name),
-				"tx_q%u_%s",
-				id_queue, eth_dev_txq_stats_strings[idx].name);
+			unsigned int cc;
+
+			cc = snprintf(xstats_names[cnt_used_entries].name,
+				      sizeof(xstats_names[0].name),
+				      "tx_q%u_%s",
+				      id_queue, eth_dev_txq_stats_strings[idx].name);
+			if (cc >= sizeof(xstats_names[0].name))
+				RTE_ETHDEV_LOG_LINE(ERR, "truncated txq stat string '%s'",
+						    eth_dev_txq_stats_strings[idx].name);
 			cnt_used_entries++;
 		}
 	}
-- 
2.51.0

