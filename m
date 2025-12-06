Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50F9D3B7E0
	for <dpdk-dev@archiver.kernel.org>; Sat,  6 Dec 2025 18:45:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E5F040685;
	Sat,  6 Dec 2025 19:44:44 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id ED5C940667
 for <dev@dpdk.org>; Sat,  6 Dec 2025 19:44:42 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso27178425e9.3
 for <dev@dpdk.org>; Sat, 06 Dec 2025 10:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765046682;
 x=1765651482; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=Cz1LvxFSnsfa+6fYqu8dx3Sv7pQ146qsVh3FNPUhlN3c/xiru3zRFbB1WsROzDPw5e
 9VdZdoW3SyGr6MrPedPZr78phE19VBWYexlwVQLCzADQ3Q3C6NCpgNyjq5Rn3rnYyMWK
 7RrfqQj59qbht/3R1GwuXvZ2KwERl98nQlEhzY0k4gsQQBblifLSLTrEnBOIH3j5z6Qc
 +sI75BH/PapUbYuc8UwNUti9Iqy+q+kFsr3knsq1TqLzCnKT6SdkKIVhp1kbJk2YiIOp
 qyACATTPLrLwyiir+KDw984tVKDSRFFxRrH7T7DAoqm+6166iii4ITqdrGF0Su7CaOSG
 l3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765046682; x=1765651482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ckPcxqjACKxECZIs8TWH87xa+KWpqiOYhGfkjwzJf+A=;
 b=ueAJyxPNSiEypq62hDUfQVymHaydApR5kRlXOLh8BIwB+vPTdCzF9pum2udtLd+fnr
 0CbVaccBKs6v9/m8/h3jsCius9Ua8D7jIlKb8Y+VXC97tWbuIZzDz4HXcNVsgqhlJ1pE
 xMrg1Q4nbLW32WbUpc8guQlCgU9YdXxsK+Qt4Z7ls6h30SFVKzy0zaBa5b8cCewaYaVK
 jZH1JMsvzDwAF7BmR/XFIQiPer5EYgmePfKlkD7ZzsJdset7itXE04IQah4neuDNk4AT
 dEdrWlx3tOLat4E0owstDx6HJkdMqelaxxadCych+Hwt8L3GWAQKmR3LurXNZ4rXO5nW
 TUmg==
X-Gm-Message-State: AOJu0Yw1uy3MdVn7rwdMICegpkGZiejJkePzSA/6RQGQZNwjFYHK74C7
 KsqbrHPkylZ4ovT3/IZRTTn8M139XTsPzUC1FukH+pI8Sv4V4kzdOsDn/U+l4VKMKhgQ4k+wRFX
 N6346
X-Gm-Gg: ASbGncsyDavqEntmm++Q6oqTNPImz93x7jLJUD0TfHdpga6Qbvz5HwbafRlZuEWNn1n
 cr3JF0QEMJIqK3ok28mS1Fc6l3o2ne2KxBmlDfUpU/wN+2As4pIDQck1nfhRSVV/2uqH2EnlRe5
 XKHTH7CQbziV2G3Z0siEaF6d3K0MF6Fx7J4/PotVtsTdlKC264BQeRjfe6EIPApsUYZWv2f+CS4
 izeoCPotoaZ1rX+B2tN+eCXbVTN9Tk8wHDf+y1iYF9K4P6g5EJTPMXZ3Gds0chyNYt0YzrjedzG
 anwkXzLdm1cjrcKRx9MLxG0jzFZwwsynK509BHGK0t1ZLHEtjnchKApjy5RtzhLHj/5Mkp7aQX0
 oX66a+Uab+4S2+aV4QwU6GP9wsERVXiSy897oU070h0UhtlsjarQwPBbIO/ow51Rvo9FkDYcxAV
 8KxUei1YyDuLynci5gmLBvyvEmXLtXia9r4usiAO24L8GD5eTjWA==
X-Google-Smtp-Source: AGHT+IFV0k19DLlrh/W2lDkwUH42oCa87FE1lF+GhD4tnZkU9Bxfhq/GV4qnNs1m47tfrG90CJ4GMQ==
X-Received: by 2002:a05:600c:1913:b0:479:2a09:9262 with SMTP id
 5b1f17b1804b1-47939dfa564mr31264745e9.9.1765046682545; 
 Sat, 06 Dec 2025 10:44:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe90fdsm15281616f8f.3.2025.12.06.10.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 10:44:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v4 14/16] ethdev: avoid possible overflow in xstat names
Date: Sat,  6 Dec 2025 10:43:15 -0800
Message-ID: <20251206184410.542725-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206184410.542725-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251206184410.542725-1-stephen@networkplumber.org>
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

