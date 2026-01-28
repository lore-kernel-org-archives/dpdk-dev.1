Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C24D46BE1
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 17:31:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A243840613;
	Wed, 28 Jan 2026 18:31:45 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id DC91240395
 for <dev@dpdk.org>; Wed, 28 Jan 2026 18:31:44 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so981655e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 09:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769621504;
 x=1770226304; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ZAMsrmCk6u8KUm5lk3/IcGr6wu10K9h5YurbCpAPgo=;
 b=CyZ8OIwSvZO6/Q0Lms2xJTx0uOGsqXYBYQzcgoh6nkM3HFhXsNLQlea8ltEVSChZ7m
 lFGw6jjQC1NaPOQMB9PVIWDZF5uperbD6cgwbmF+a8aJ4cNJp59edQGCvK2CanqX6w6x
 GQ1fd5wnPoECAA5yXQEz9qjSG6NAkzpExdm+bpoS2RSQeT0JLrokvSTNh2Dpu5anELgq
 V5r4TJw2qW5+Pr4hmps69xPgOTWX4dqXQV+H/4n2IDCg1O4c+1GVZ/oCwRoB14PlZLRq
 8PoEXZk7RV9c38qMb2H4kdkZMi1nqZ5ZDmj5G7GVQSIhxL2rG8MCsBdNvnrayTZy9JKS
 G97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769621504; x=1770226304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+ZAMsrmCk6u8KUm5lk3/IcGr6wu10K9h5YurbCpAPgo=;
 b=ryYuLetUIzIpoAUYY1lf+J3R/l9Jyrjq9kU0ZW/5KSsX8qXzgBJfLy4mRzMJF6mgJz
 Rytn2N9J/cFfa+U+jGNRPUMl6YKhAi5W4FgO6O1SD1XgPDkcEVURxIqC4QRVaIeI5Ml5
 rMAGRO3RVcHF48mXydvTKXfTigSIanPZ7qrDKq7ztN3MqtQ/MpYaFuxcCbhxmLpK+941
 02Zt1Yz0Pn29WItLb3yVn6IqBE1nV4nwwbU9Z+aZDWdWiuzujEO9CPBouNnLkHQnuK7i
 bDudR1iadfB6BeqZY1ekxdeN1yK9wfQYrXFsl1I3TWEC0KRXu7OdFy/VHputcYkjfXXk
 tOow==
X-Gm-Message-State: AOJu0YxqE5REBFObCaXiMMjo6aKDm2xNQpQTLYRRDY3maadVNO0UZkqz
 n1ILHhGqOI4b3aB0muq4bOF3nVs6TIW58o2Xxwou9m3pNQ+48q2CRJRMAqPgvMgegqfVsg36ERF
 MSqmZ
X-Gm-Gg: AZuq6aJN1Vat95gASRm6lH28eVQM5oFrhDVzMul6g7VbPaLD7PVxK/ghCQ1oYw66ks3
 lNAk2WeREdOfSU5K9MSxtPhAAVRCrp49nC0nZCe2evderPQORYen1AsNPeuAWxIwcfYnSJOHck+
 OhaFsma/eInW4D+xZe881uuPH4VcknNhS7BjNLW57P9nWcFwU/jZNJW9kH4mIrqEu16xnmvW/K1
 39FBs8R6JKLTxYVotVAsSQelkXwNozo0+EqHgwSbKqRTwxwgSIyWk8EuBpgRI+9lfBKzd8bmSZf
 HVFDug7R3PB6j+teSSeKBhmW0z8QLY3HUSHmwu0IKuPyiI4XuvoHEnSxHYBzNcUjc8RCxTxfNB4
 9R17v4bZDJWNjoRmMsAJwUDL3cCjWGIgvdiYoj8ZSMrr18HVpcaAnh36hT4yiY3OWtvYbH8NsQN
 1Ivni95RfrJxPDciCWIfE1EgtTg/cDnL9VYqB4tneuE7PJB7SvSQ==
X-Received: by 2002:a05:600c:3e85:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-48069c557a6mr90363375e9.17.1769621504300; 
 Wed, 28 Jan 2026 09:31:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bfb59asm133732875e9.7.2026.01.28.09.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 09:31:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 "John W. Linville" <linville@tuxdriver.com>
Subject: [RFC 1/4] net/af_packet: remove volatile from statistics
Date: Wed, 28 Jan 2026 09:30:17 -0800
Message-ID: <20260128173138.151837-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128173138.151837-1-stephen@networkplumber.org>
References: <20260128173138.151837-1-stephen@networkplumber.org>
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

Statistics are only updated from a single thread at a time and
the compiler should not have to worry about optimizing them.
The statistics returned are 64 bit so use uint64_t instead
of arch specific unsigned long.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index ef11b8fb6b..158393dd70 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -57,10 +57,10 @@ struct __rte_cache_aligned pkt_rx_queue {
 	uint8_t vlan_strip;
 	uint8_t timestamp_offloading;
 
-	volatile unsigned long rx_pkts;
-	volatile unsigned long rx_bytes;
-	volatile unsigned long rx_nombuf;
-	volatile unsigned long rx_dropped_pkts;
+	uint64_t rx_pkts;
+	uint64_t rx_bytes;
+	uint64_t rx_nombuf;
+	uint64_t rx_dropped_pkts;
 };
 
 struct __rte_cache_aligned pkt_tx_queue {
@@ -72,9 +72,9 @@ struct __rte_cache_aligned pkt_tx_queue {
 	unsigned int framecount;
 	unsigned int framenum;
 
-	volatile unsigned long tx_pkts;
-	volatile unsigned long err_pkts;
-	volatile unsigned long tx_bytes;
+	uint64_t tx_pkts;
+	uint64_t tx_bytes;
+	uint64_t err_pkts;
 };
 
 struct pmd_internals {
-- 
2.51.0

