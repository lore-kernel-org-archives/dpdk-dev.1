Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D03C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 04:55:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37FE9402C6;
	Mon, 29 Jun 2026 06:55:27 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 14E5D4021E
 for <dev@dpdk.org>; Mon, 29 Jun 2026 06:55:25 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c85a297d2d2so1986861a12.0
 for <dev@dpdk.org>; Sun, 28 Jun 2026 21:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782708924; x=1783313724; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ttw+W5530vzN4WkE9M94+XTv2Rmv6g9TlEX4+Iq5UW0=;
 b=jAj/kLy3OOtx42K5/AouWaP61bU5YRx8A2SiI8YGJsmcn9BGzi3y8G2JXZ2lkstrCO
 xHUgzXPTkysbPmTO4I1U+l1zIruGuWGoGr5Vu21EV6K7E0pWNYQHe7EENidOaGpfysVa
 2E2YpsYizbmLTosUH4j7jpY0XqTImqo4BMiYHZhv1VoakGYK6XzzHnjMCMRm14DdPbaS
 W4yftmmQe4QL6YlVcDO3oGQke8SIYUzwcArl+AkUrebs8Uu3OEv1BjfCvXzh+hRUyDMi
 ArNfx5u7Vle36cv4D9QqY0GDD9B/opwUN7Tblm/niZiQIjVxb/KJMxcTJKIN1IB00OYw
 vy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782708924; x=1783313724;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ttw+W5530vzN4WkE9M94+XTv2Rmv6g9TlEX4+Iq5UW0=;
 b=e1K58O0dLmEBEZdQlTFJuhzkuij4H1TKCj3q2daZ+KoIdB1kJRfYUDu5CYeXlx+/xA
 Cnl2QAfYPaVTOihoPKXclMTMCqEn+G3/J366YisCYQmW8mmmhHbKULE7Um6qu8I5YA6g
 5+BLBWxlj6eWqnEaVMOY5bXLfQC4Jh8vmBKFpSf1U5dRYti8wiP3Gi5F1Dk4WuCgXEjL
 uEnGA6wF8qrYxCR0J28Q8TJrd/FxdDS6zXKPuw5OIVWKeSQCdljJUlrYKsjZ1FYnCQLu
 et1sbtiaNSrCFVZ3N9ref7ok2wFPX68WVll9MEoyJHE9orb+J3m2ALo7UWMs9LUnvrth
 s0pA==
X-Gm-Message-State: AOJu0YxxWzUnbJJDiKVfW52SxJ1KblA/lw8+AYNybwIwEGJA00au1zIp
 jdLwB78ht6THYuUfdfqKVV96aGBkIUHws2aUSeOwbLSLYJWUNV+WqpM4
X-Gm-Gg: AfdE7cko96R9FrJ0BGUbez1l443k0J+4zaDrhmFkJo0rXW1qiXp9FsZz9JUQL6GZ+bP
 MhzNEAbesqLYCyYLDlIIxkEwo7Z+XcX70gozZ/9Mi+ck0Q7+80vsqMv2l8IID4dxo9qeE/4GGfl
 phSYgXzPuoqEHMqZ4x+F27HohZAouG3wqLx0c8HxlukCPasfrMOi3Sapx5ZNooKqhbWgf+3b890
 9xtPTl5yJOgzZ4m2+UdvLbXUS5LIr0hQOma9cY6SianeU4PCmSwj7oJiCC08ckPUgVsMoKZmZ9l
 x8TqrqvWxQFJ8hg9ECAX4gh+akZnw3GnMI9J6V2CRL7PGSVUP69YHbcyrG3auz+LbCYdJEVHen6
 4ZzEsxcdOMXCXru6/EaQv2J3Lqzy4LyXOjDjgZ3HQRrvRuT/unEVcfxNRmO1CkfSQu1i0BCwp2j
 NSaiesOv3N4g==
X-Received: by 2002:a05:6a20:d049:b0:39c:126c:93b5 with SMTP id
 adf61e73a8af0-3bd4ae9f2bemr15174779637.21.1782708923812; 
 Sun, 28 Jun 2026 21:55:23 -0700 (PDT)
Received: from peach.. ([240f:6d:285c:1:c9e8:4a97:ed9d:4714])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c99f2905e76sm1079533a12.10.2026.06.28.21.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:55:23 -0700 (PDT)
From: Shuzo Ichiyoshi <deadcafe.beef@gmail.com>
To: Ferruh Yigit <ferruh.yigit@amd.com>, Alvin Zhang <alvinx.zhang@intel.com>
Cc: dev@dpdk.org, Shuzo Ichiyoshi <deadcafe.beef@gmail.com>, stable@dpdk.org
Subject: [PATCH 1/2] net/e1000: fix igc RSS redirection table
Date: Mon, 29 Jun 2026 13:51:13 +0900
Message-ID: <20260629045511.473850-1-deadcafe.beef@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The IGC RETA register stores four 8-bit queue indexes.
igc_rss_configure() and igc_add_rss_filter() used a fresh
uninitialized union for each table entry and wrote the register only
every fourth entry. As a result, three bytes of each RETA register
came from stack garbage.

Build the register a word at a time and initialize all four queue
indexes before writing it.

Fixes: a5aeb2b9e225 ("net/igc: support Rx and Tx")
Fixes: 746664d546fb ("net/igc: support flow API")
Cc: stable@dpdk.org
Signed-off-by: Shuzo Ichiyoshi <deadcafe.beef@gmail.com>
---
 drivers/net/intel/e1000/igc_txrx.c | 49 ++++++++++++++++--------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/net/intel/e1000/igc_txrx.c b/drivers/net/intel/e1000/igc_txrx.c
index c13460f381..1ab8f2079d 100644
--- a/drivers/net/intel/e1000/igc_txrx.c
+++ b/drivers/net/intel/e1000/igc_txrx.c
@@ -828,17 +828,20 @@ igc_rss_configure(struct rte_eth_dev *dev)
 	uint16_t i;
 
 	/* Fill in redirection table. */
-	for (i = 0; i < IGC_RSS_RDT_SIZD; i++) {
-		union igc_rss_reta_reg reta;
-		uint16_t q_idx, reta_idx;
-
-		q_idx = (uint8_t)((dev->data->nb_rx_queues > 1) ?
-				   i % dev->data->nb_rx_queues : 0);
-		reta_idx = i % sizeof(reta);
-		reta.bytes[reta_idx] = q_idx;
-		if (reta_idx == sizeof(reta) - 1)
-			E1000_WRITE_REG_LE_VALUE(hw,
-				E1000_RETA(i / sizeof(reta)), reta.dword);
+	for (i = 0; i < IGC_RSS_RDT_SIZD; i += IGC_RSS_RDT_REG_SIZE) {
+		union igc_rss_reta_reg reta = { .dword = 0 };
+		uint16_t reta_idx;
+
+		RTE_BUILD_BUG_ON(sizeof(reta.bytes) != IGC_RSS_RDT_REG_SIZE);
+		for (reta_idx = 0; reta_idx < IGC_RSS_RDT_REG_SIZE; reta_idx++) {
+			uint16_t q_idx;
+
+			q_idx = (uint8_t)((dev->data->nb_rx_queues > 1) ?
+				(i + reta_idx) % dev->data->nb_rx_queues : 0);
+			reta.bytes[reta_idx] = q_idx;
+		}
+		E1000_WRITE_REG_LE_VALUE(hw,
+			E1000_RETA(i / IGC_RSS_RDT_REG_SIZE), reta.dword);
 	}
 
 	/*
@@ -944,18 +947,18 @@ igc_add_rss_filter(struct rte_eth_dev *dev, struct igc_rss_filter *rss)
 	igc_rss_conf_set(rss_filter, &rss->conf);
 
 	/* Fill in redirection table. */
-	for (i = 0, j = 0; i < IGC_RSS_RDT_SIZD; i++, j++) {
-		union igc_rss_reta_reg reta;
-		uint16_t q_idx, reta_idx;
-
-		if (j == rss->conf.queue_num)
-			j = 0;
-		q_idx = rss->conf.queue[j];
-		reta_idx = i % sizeof(reta);
-		reta.bytes[reta_idx] = q_idx;
-		if (reta_idx == sizeof(reta) - 1)
-			E1000_WRITE_REG_LE_VALUE(hw,
-				E1000_RETA(i / sizeof(reta)), reta.dword);
+	for (i = 0, j = 0; i < IGC_RSS_RDT_SIZD; i += IGC_RSS_RDT_REG_SIZE) {
+		union igc_rss_reta_reg reta = { .dword = 0 };
+		uint16_t reta_idx;
+
+		RTE_BUILD_BUG_ON(sizeof(reta.bytes) != IGC_RSS_RDT_REG_SIZE);
+		for (reta_idx = 0; reta_idx < IGC_RSS_RDT_REG_SIZE; reta_idx++, j++) {
+			if (j == rss->conf.queue_num)
+				j = 0;
+			reta.bytes[reta_idx] = rss->conf.queue[j];
+		}
+		E1000_WRITE_REG_LE_VALUE(hw,
+			E1000_RETA(i / IGC_RSS_RDT_REG_SIZE), reta.dword);
 	}
 
 	if (rss_conf.rss_key == NULL)
-- 
2.43.0

