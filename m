Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2731EF8D766
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:52:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41BF440B9B;
	Thu, 16 Apr 2026 20:51:59 +0200 (CEST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171]) by mails.dpdk.org (Postfix) with ESMTP id 7A0FD40A73
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:51:55 +0200 (CEST)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2d96243c91fso2129114eec.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365514;
 x=1776970314; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2IAAvJb3zpF2Z6UDKwXKbitwWL/xVV3UzHz2Uf/5xMQ=;
 b=N8WqHstVWd0E6wR0YQff/60v0BdULshBYUNDUhQrQl7bEjS6952YEzlpIRWCUm0X95
 skitjg2+Bi+tw+rtL4JTeHpExDXa9hZJrmGe/lXjLwb88FKqT0IVLyyjFJh2TvdOEDNB
 gIehHa5urusLYoGE05dUPjnt5FIlWbosgg7n8+M5+1EilDrw2lO3Vek7McVHAdF7kX7h
 j5+AcwdE70nrOkT4arqoEwCdbhbd3LJyOC5xJPL2Dv962befxLqbdlJCVf/3L859I/yK
 yC7iP3cmWonZIIcfZbQ2GMGDrNlH5ypgqM98smNXJ7eO/V0nQOzFJwPZC1V6p1Ny3vfc
 tqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365514; x=1776970314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2IAAvJb3zpF2Z6UDKwXKbitwWL/xVV3UzHz2Uf/5xMQ=;
 b=AkuKY8Zo5cRseCEdEpdq9CfA6BAv58dwkX79YIC6uAS9a2ecSGxk9SVCML7an7R99X
 qthtK8pVyWWPeQcEBk0lOaaa5FLJrGVDDFMpwlD9f9y0q0b1VD94L/pTh9yfk7Y9709p
 /QUYT2hYN92DLL7PqTqjkrb3T+h8394TA3fKhbshMRqua+qPHNMj+l8C6jxslQluLGJb
 p2/ptya72yLkbDLp//I/vbETKBAp284RdBIgHMdXgKDqvlzZ9VcGW4x/kNYju4gP1MnQ
 RP6nYoFGCcs9RPrtwIlUQQtyS+QfkwM3ft+ssIMOq4ugD4vrR2uMWvQs+8V8FN7KOd65
 sW5Q==
X-Gm-Message-State: AOJu0YyrmnCyvydM07jNGOXkMaotx+vvkka6qnh2ZowvO+67sG+9ej4m
 lacAp1ZZ39EMwbp0/LT2tW0fLKWlIDV43rh/wqmZgC92nMEUiRsKBOX6lH4Rp23B/IjdfxM8Iy7
 +5iGk
X-Gm-Gg: AeBDievk4BGwj3MQRN28vUTlmuGFhaJNRlNaFAfGvyeJYCtmI5ogPXWGZjwIkq6OfM4
 l7vCi63RS4m9vGoVGBHIwrr9TJvbnCjMyZdp8RwgBLc1pQksGtveUNAgEJobiwWbBcNo3bzdltX
 V2qYG8Nxgpg3iDMotD7aetpz07WzqlU99djFunXr7xKIWv2o7K8Xvi8xn07Z44/eM2F7FhuUMfU
 /dbBDfdUmroiTXlj33lmUA7cOrIfc8W4PHDyIPbk1wYVyNd5IXmPoFykaByfG/FU8V4+TtCwzmu
 PLqUChb0TDO+rsG0zG72XYc8nLRH/1QmGUnuF3pSQbmL5sqx8IhMdukKMxIhQDpWTOMe1FxQtBX
 EzKBOsBGMVuJeIqyQXxR/D5sggcuN+TKb11OxKtPXQOWXvTT0lYBAEIVaoGyp4zfFr2KMnsTWRa
 5DmDu4QVFZvBHP12PlUQktN6C9+gjW/fLUTvGx6c+HQc0=
X-Received: by 2002:a05:7301:4092:b0:2d9:6373:ace9 with SMTP id
 5a478bee46e88-2e2e435620dmr271341eec.8.1776365514477; 
 Thu, 16 Apr 2026 11:51:54 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:51:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 David Marchand <david.marchand@redhat.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v24 07/24] net/pcap: advertise Tx multi segment
Date: Thu, 16 Apr 2026 11:48:24 -0700
Message-ID: <20260416185144.1359260-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/pcap/pcap_ethdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 724b7a9038..ebc96fafe5 100644
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
2.53.0

