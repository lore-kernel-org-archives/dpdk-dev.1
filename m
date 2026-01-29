Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02EFD46C16
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:44:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B44F540B95;
	Thu, 29 Jan 2026 02:43:51 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 3BA7940662
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:49 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so3622705e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651029;
 x=1770255829; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2efeRNrCdrMPbej6VXPI+4qlGPa2dstlpUlX8ye1Us=;
 b=h80RBO9AYE5C+4SWOO+vSOeVRO0riMtTcLtcJQSPNd/FVWwqFdaoTpHVi78y4vS38y
 IJ2/2ckKdRpsvMnsMAXSxEQnByou0jqWpF5VRwLc0N6otu2x2YFSJh4ZJw3AQU+BQ3Ge
 C3IaSim7uKG/vd9nlXHZvFJOf5PnJjmfg7H/bDFwglajNga9f2qIj+UHyhRmyn4vv6g+
 VjIlg1gJqAaUdT5g93Dmac9ipqlpZsckUlOQR1mdtRU6pFRns/PcbKuqNMZeE/XD4Iw/
 PM3zXCK/P/8H/YILC6jB+9AMXXZDyVgnyT0y4RVIvEu02CxAXdtTFAQt9ENNjgb2oOTR
 er8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651029; x=1770255829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k2efeRNrCdrMPbej6VXPI+4qlGPa2dstlpUlX8ye1Us=;
 b=jxZVKEPsSAVTLElGSQFtZr/fWWCwU4WYchQzoowZyJgBt7Tsu9unNnkyCi4aPll8T3
 hR3ntwJPPhkYOkUffp5qDEv4Mc1n8QDzNw6wNm3N3OnnpKYTjRD7xA6kFNP74x8xpHLK
 fnxpBY3dYlbpL6QjuH9UGePtDhhJIhbvJpunBsi12sgq14olc0G9prLwUYLV4Rb3jy8e
 tuujYpFF6a0OaUo1OsaLtZ/6bMO0UfaV10WULM21irJNZv45VeHlx0O/czyNz1w5YegQ
 CnQaxJAeFzOOSFDKTegFT0kJcuZ65pl8TaBcktMEW7qVRYr4D3ZAnT2N98kxALcOS+Or
 KeKA==
X-Gm-Message-State: AOJu0Yxl/EILPGjn9wpST2osz9J4XGoj9KLCZd5I8djKREkGOSHXRbEb
 CusTxRrBR6CPQWPm/BD/N0oSfBt2/nL0m5RSCCRXdPJamHVJq2ZfGnUegCrwjZVaZ4oA4+YZgWZ
 u+Htg
X-Gm-Gg: AZuq6aLk22xmm3qMUU60/I2CRj4EbiIXaEDkrU3B9G/f6QURbMJtElCfseZb4hGM+b1
 88znxEkblJawRyllU1e40PAjBh2lp3I5VRJOtf5sYYvrYSDNIUJcsf7ATSpSJDgjZzlfr4qetrW
 HxxsK28H619Ca2AZMTtUK6oFTkJqOZyY3UknntW2/lfU/j3nRlzNY/7COckifnFvFlhSLUz9Ot4
 KvXMI3rkAkae4V2vumUQvasFwVWGGdB2wpE9y8BIjk6+wWPc3OypdXnViuF3Z4JXfdOAdYzOGpE
 69uP9WtC2MkoUx0JcBBGqmVl3828Q/2sebP7VhjUzhD5cMEv7ANOfWvAfpk51dKpCIbZVAp+b35
 XdYO/axdpZKofBAQTdnhRSkUuj6hMKpqHGZRHHVaWcZy+z7QffdPjFW6WttsyW2cVxrOybEVgps
 N/t3B5F6JTkRQQnkoyIU2BUUPVxebty7JjHeEeYOfqAJu1WlpJow==
X-Received: by 2002:a05:600c:800f:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-48069c6762cmr77631135e9.27.1769651028867; 
 Wed, 28 Jan 2026 17:43:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v14 14/17] ethdev: avoid possible overflow in xstat names
Date: Wed, 28 Jan 2026 17:41:17 -0800
Message-ID: <20260129014313.939831-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
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

