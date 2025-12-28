Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA55DD3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:20:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E842E40A7A;
	Sun, 28 Dec 2025 21:20:05 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 8C16740B8D
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:20:02 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso77772485e9.2
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953202;
 x=1767558002; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=jXGjSWYCkscfOWz1aiioMrdRvwkOI5ahPNbnrdbNWD/DH/8f/PJapRWGIGcmeMDpYl
 4Ht/2x5wB/qly1+VUNzRCujVveCyXSPTzwsVIVudfkdLFjNcgv2fFnFGpTm1sUAaQFnY
 IlFPXrw72b3bP6Ldczn5KdLfW6RKQg1KUsRgnUTn+7r+TAjHfUUDSZn0oI4VnuRzqkr/
 g//CUmOC+NuFFlnNF9jhCi+M7ZxRYI8M15ohgey6Xp5px0WeNZnPnqPZAVHxX3mn7fg+
 jZ7y52sfUxPyFkI1c1ggEPG2370R05RRJSpiImrji8XjeCjDFNlgGgVgzJRsC0uXzkyi
 iAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953202; x=1767558002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=alxosj+zKJMKdkcUjzn8lUwkBMsIHEPpHoQluKaFzeTGC4hzOtsATpWUk+rSiedHsH
 waiktlzxuheeOCIpvjK1WAuUJhl/sPIN7sheKTuRNAxwYLUUD3KqKE2UdE3sYj/jMia7
 arb8KDO09dXDTPHCXbEtezk59NMUYPuSSuF9j/5yYObtUfsijHT5zW3aoZVwpvk1TijN
 nrhNqfjHXQ8VL4HxLr9X85F2JxgYQq4OapoKa633T63ujKYs1tRaOYwp030+mdkcePwL
 IqFOK6puHPP9rXPM8ThidTouUU0F2SUyP83B6ZDmhMijdGUMCYCIQoFBzj/EcNMlGJOm
 +eeQ==
X-Gm-Message-State: AOJu0YzgLaOzS1ERuX2chDMqdM48yaJqcn91SygQXvxESHvh7tOsnhkn
 cpoBH0JRa4MDSyJhRjXTjIZr9vdcwDt3MngBbVp1+39rv6/rFr/GxoA4QeSFFFT6VnVHSj6bWxP
 xC31WGiI=
X-Gm-Gg: AY/fxX7Rf+eVyeBCZxSmEhyfavz8rBbdZUUB3JXqt3UG+fdG04Vigi8OnfDn+iAhZL7
 nu3eSV9VIB8ykIvysvXD/RWIzPL3zpaNyz3Vrm0NGHdrNv4gonnadoIcSt6s2pfbtNK58LsDC+i
 zRFMNJmYnlZjh74W3C0RV+fYSN0+q0zl1ezXwF4YNog7ltNMYJblLhFPaN+6rnM5GnKzev8LITJ
 AMSMXH19DM8aL+4BSnInQP64nKxeFnS1PJp/080K9J+LznctpRk5Nr56SPItrQQs2ankucjvLRd
 mdi5rinGYAMkjUOWMkVgGBm3x8d1YIKzEoU2qk0XJ+a8TLkxF+11TaQV1Qem2OgQJZtI9nXq5rz
 JAMEMYoeQiGF5n737ARiRZSYo2Lf9cb5flufsdSCn6RDt0yD08BCBS9yWtvMiowzD6Qvu6mUJ+W
 X0rPE8UdvlWXHjU/ZOGh5hl86MrnKCydiJN6Q7Q1xvPNqffzOmPw==
X-Google-Smtp-Source: AGHT+IEPgy42uINc5+pNEhd+v5DmTtKtpHnNLTK5nsMC04i43aycTDfKNMtpoHs2pCwlceRVUttjmw==
X-Received: by 2002:a05:600c:858e:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-47d1c629902mr254028095e9.4.1766953202129; 
 Sun, 28 Dec 2025 12:20:02 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:20:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v8 15/18] ethdev: avoid possible overflow in xstat names
Date: Sun, 28 Dec 2025 10:56:18 -0800
Message-ID: <20251228201236.547268-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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
index c6fe0d5165..05de3335e5 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3489,9 +3489,10 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
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
 
@@ -3501,10 +3502,17 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
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
 
@@ -3512,10 +3520,15 @@ eth_basic_stats_get_names(struct rte_eth_dev *dev,
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

