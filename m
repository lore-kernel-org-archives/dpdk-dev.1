Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BE2C3600E
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 21:36:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01E2B4065B;
	Wed, 26 Mar 2025 22:36:24 +0100 (CET)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 6933A4021F
 for <dev@dpdk.org>; Wed, 26 Mar 2025 22:36:21 +0100 (CET)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-224100e9a5cso7341365ad.2
 for <dev@dpdk.org>; Wed, 26 Mar 2025 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743024980;
 x=1743629780; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6J6DysNUnnGi9MkUHUglhonRpV2SCzlrKwcN46JF2CE=;
 b=SRmAZCqQKd+CYuCtqhG0LjhUxJ1ZTYz8OQbRc7UqfthiU1MYomIzOqU92oG1dSCQqa
 fwE9B4zQwaGNqxfdDFQEbf+4UwLjXFeqqbkgnX1uir/FAL/gyShBpNd1nBy4zPH+bKVU
 BzjhnxOS0gx4NI5bzKixhZPKW5FUPph6ysos5JCVB3k66ivLJCBd77LuxyLrjN631a0m
 H/9YBS21eOHCINWY4gOjs8BW3VchdQNAPuzKG7gFM0rmANEDdRBFmGOnIAb5rcFNtdGG
 124aUqv+DTXDIB/ylfbkiS3H41u92mQUYmUShs3MR6+EqZeGRkk3xrVB7zUDYWhLvRoG
 87Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743024980; x=1743629780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6J6DysNUnnGi9MkUHUglhonRpV2SCzlrKwcN46JF2CE=;
 b=E0cuWbImhbCAzMu5Y3pl19xB7FNFlHtKlEsE+Y+yR65jc+LSsnEB3qtUtHLYFEUv37
 LtAwJcinz3AzEDnXlAyPNb+fv/Vff+wuBIFOJHgyuRC8SnWiPq886aEMkUUHTSzEXLtT
 bMeDBqICU/HSRlNnjjTmfIXnx8/My2zjwmz98C6Rs3HZPHqDbESVJtChTrufdL4okOP8
 WH0NlOUy34348zsQHf0TlAYYnOlS6dZ4al2EQgutlSAbMrBt+QEZnZits/fXbGd3CPyt
 HqAaXOOy1YiGMxbkYI2M1xk6EhwNoZ63TUhKxRHu2Cp/9U0qjEDs2HPJJx5XF0+AmeGF
 S5dA==
X-Gm-Message-State: AOJu0Yy7qLknV+vKzIN28K/YEQKqA1sMt05WbGUTobhZOwHnvEwdOdRN
 tqMk5oXMpCcacFeKpnr683U3OTWMLLeEXggUK+O7VtywKxSeSTusyrXIMgV2MK1ib74jULTg2hS
 E
X-Gm-Gg: ASbGncuVztrFEClGJ2j4/jGHb1hFDG9TjMovahw4YqYD1l6j6MztioPa+/aAKFTah8J
 1avzQyA7nE4PL3PqYSmDSuZQdHqUqkP+bxbskQkd1MW0cqiZA8uRa/chmGLqVWSHF+4JkzTBqHr
 KyNrEoiN0dkDvNKrDd3Vc6TkjOg2ovMJ0Gz53H0Av+z9wZhnf77+VjTRWf3FZsz14a0DzOuQ+u4
 /Prphsl/VO/2YyxLZp1n4+j38Y0C9gPIz9twcjtKmI2Fa4QWrSyktjSkG4s1T9p1HllNz5FdXGK
 brYIuc+xWilktUMSW8FNYR3qb5Em1PwlYbSkPs2fS6bXPrSrsOBtPEhMXGIXUGnRLyhsNCGPJES
 3odQxn8Hd5JDsCHaBAtrk
X-Google-Smtp-Source: AGHT+IHMh2npbyHSJ57KRw83RQ3c/YL6QHw96jBw9uFkVR6dZ/dPKx1If04ovpRYaHeiluy+r/z5Eg==
X-Received: by 2002:a17:903:298b:b0:224:3c9:19ae with SMTP id
 d9443c01a7336-228048f0487mr18673385ad.34.1743024980313; 
 Wed, 26 Mar 2025 14:36:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4597csm115807525ad.75.2025.03.26.14.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 14:36:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, mukawa@igel.co.jp,
 stable@dpdk.org, Tetsuya Mukawa <mtetsuyah@gmail.com>,
 Bernard Iremonger <bernard.iremonger@intel.com>
Subject: [PATCH 2/4] net/null: fix packet copy
Date: Wed, 26 Mar 2025 14:35:26 -0700
Message-ID: <20250326213608.581345-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250326213608.581345-1-stephen@networkplumber.org>
References: <20250326213608.581345-1-stephen@networkplumber.org>
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

If doing copy on transmit, can potentially copy past the data
in the mbuf. Change to only copy data from that segment.

Fixes: c743e50c475f ("null: new poll mode driver")
Cc: mukawa@igel.co.jp
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/rte_eth_null.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 3a05af2e32..baae81c572 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -35,7 +35,7 @@ struct null_queue {
 	struct pmd_internals *internals;
 
 	struct rte_mempool *mb_pool;
-	struct rte_mbuf *dummy_packet;
+	void *dummy_packet;
 
 	RTE_ATOMIC(uint64_t) rx_pkts;
 	RTE_ATOMIC(uint64_t) tx_pkts;
@@ -156,14 +156,14 @@ eth_null_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 static uint16_t
 eth_null_copy_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 {
-	int i;
 	struct null_queue *h = q;
-	unsigned int packet_size;
+	unsigned int i;
 
-	packet_size = h->internals->packet_size;
 	for (i = 0; i < nb_bufs; i++) {
-		rte_memcpy(h->dummy_packet, rte_pktmbuf_mtod(bufs[i], void *),
-					packet_size);
+		struct rte_mbuf *m = bufs[i];
+		unsigned int len = RTE_MIN(h->internals->packet_size, m->data_len);
+
+		rte_memcpy(h->dummy_packet, rte_pktmbuf_mtod(m, void *), len);
 		rte_pktmbuf_free(bufs[i]);
 	}
 
-- 
2.47.2

