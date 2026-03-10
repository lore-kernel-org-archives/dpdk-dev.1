Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D54FCC9AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:50:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60E9D40A7A;
	Tue, 10 Mar 2026 03:49:40 +0100 (CET)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52]) by mails.dpdk.org (Postfix) with ESMTP id 05E8440A6E
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:37 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7d75e74f5adso57961a34.3
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110976;
 x=1773715776; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsZUQf7xFcuhfRxCgyvdKClsn03gmCq61Jm0Lq6UINs=;
 b=hQiq0SAtYKIthYUjRwcT4Xi5Yf5/JunFFn6TmH2jz2tepAJUhXfybhe3hQsk6b6cES
 TRy8Z8zabulD/akGLHIFmqtlsD6/y24kV+ENiU9enjnEolsgSSa7ys7RWp5tIELv2c1r
 iirR5GeWVuWHCElkNHE1ThnRkKIMTuVk/5g5njfGR/OKmOYdNySaDUOZnRVbzxNwV/3f
 /3WORElLKV56mRdqgrdPrBfgNJOEknMZGWPndZ9Qs0i0iYThvl7ueclUa3uhGvH1Xw4M
 iF6xGW7RcjHHHqsAL+CvhCF0vWwUxYdPlYLVtcG5cbo7ixbifOa9SGjJb4dlNfBEBkxQ
 M02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110976; x=1773715776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vsZUQf7xFcuhfRxCgyvdKClsn03gmCq61Jm0Lq6UINs=;
 b=jyPTCLTuOswORz1PDMgV8Ch4GgtHxiC2C98F/2gWit5Vyqx4gQEJs0SfymcZts3Cp7
 /YsS2Vzm4gEGqOKmcG8OqK/b966MDsl8n1VwUxI1to8aAjv98PgKNV9Pq4UHBK/JIEKj
 fxEiOphGCAmZKIybtWDbc4wbVPtVtDCkWEmzSmOgpDNSkZ8+LF15Z3BK1B63RJbqKXR/
 VkBYIdPaNoGi49HZoXApBqW8Ra4+bvzGCYbNM4/aZen9WJE4+j6iO11XKdkwMmI2XX0o
 xfn8Sc47ADVBgFr2AU3iRwmS7bZWuEdF/M0PMyein7vQYfAiLwr0O15SvScvXYDXJa/v
 dX8Q==
X-Gm-Message-State: AOJu0Yx6LDhyT/+mBGrhGBLwtRkw7BqwsdeFo6w55qLJd3PxlsMn05sE
 X9tN13+cmHkQJocaQxRjCLi32qTxB3pmcjNOJjCiIQ+L+fP2OfcYPLSSk5Yze6oDeJJrSlcKPA5
 R8hcc8T4=
X-Gm-Gg: ATEYQzyJ5TK4zFh9bwFcCelQEXs+2Aiv7wOSeye9v8RE/b1UO+Hx1zGyNPCWDMGTBxX
 vHQ82BtRSkv6+vfXbCaOxhBxIuoDWY2xbb4qpdNz5anB6T5QdlB+GZ6v0h09TuzM2gpJFnhlmFt
 8i1cxCRLpFS5lCvLYJNkuCGTzNiTkMR4YC8tqXV4yiQVcVTHoxaLzEEP7A/CDSZqyYQ7CetZXOs
 4ZhQm04tsU+pYzt4hqX9+pi3s8cCqPdkG+3Px2O0g73osgVt4EkKJ/RJqy03WJQJzTz8i4Fv+ym
 2vDG7X0ckez4ziNU2ACWPhVVa8Lioa1/rpcErl9n+c22Gbcgox1eBKBKHEB9FDGqM5yas9fJrgq
 DMKuAGQ14M6xGeEXcjDYGmnzWIVilHac3NA4pAujLeNsXj2Be8N0VJreVf7yRbBd3wdhFKlIYUg
 GFFf9w+sXu0IbfRXpXau39fKtaPnlqFrQD
X-Received: by 2002:a05:6830:2aa0:b0:7cf:dc3f:6b34 with SMTP id
 46e09a7af769-7d726f8b89amr9332034a34.20.1773110976307; 
 Mon, 09 Mar 2026 19:49:36 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 David Marchand <david.marchand@redhat.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v19 07/25] net/pcap: advertise Tx multi segment
Date: Mon,  9 Mar 2026 19:47:42 -0700
Message-ID: <20260310024925.476543-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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

The driver supports multi-segment transmit, but the did not set
the offload flag. Therefore applications would not know about
that capability.

Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 806451dc99..fedf461be4 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -753,6 +753,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
 }
-- 
2.51.0

